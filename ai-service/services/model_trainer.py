"""
Service d'entraînement des modèles ML
- Entraînement du Random Forest / Gradient Boosting
- Validation croisée
- Évaluation des performances
- Optimisation des hyperparamètres
- Analyse des résidus
- Support pour features d'interaction
"""

import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor, GradientBoostingRegressor, GradientBoostingClassifier
from sklearn.model_selection import train_test_split, cross_val_score, StratifiedKFold
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, mean_squared_error, r2_score, confusion_matrix, mean_absolute_error
from sklearn.preprocessing import StandardScaler
import joblib
import os
from typing import Dict, List, Any, Tuple
import logging

logger = logging.getLogger(__name__)


class ModelTrainer:
    """Classe pour entraîner et gérer les modèles ML"""
    
    def __init__(self):
        """Initialiser le trainer"""
        self.models_dir = 'models'
        self.scaler = StandardScaler()
        self.rf_classifier = None
        self.rf_regressor = None
        self.gb_regressor = None
        self.feature_names = None
        self.training_history = []
        self.model_metrics = {}
        self.regressor_type = 'random_forest'

        self._ensure_models_dir()
    
    def _ensure_models_dir(self):
        """Créer le répertoire des modèles s'il n'existe pas"""
        if not os.path.exists(self.models_dir):
            os.makedirs(self.models_dir)
    
    # ────────────────────────────────────────────────────────────────────────
    # ENTRAÎNEMENT DES MODÈLES
    # ────────────────────────────────────────────────────────────────────────
    
    def train_models(self, training_data: List[Dict[str, Any]], optimization_config: Dict[str, Any] = None) -> Dict[str, Any]:
        """
        Entraîner les modèles Random Forest ou Gradient Boosting

        Input:
        [
            {
                "profil_features": [liste des features],
                "feature_names": ["nom1", "nom2", ...],  # Optionnel
                "filiere_id": 1,
                "accepted": True,
                "success": True,
                "compatibility_score": 75,
                "engagement": 0.8
            }
        ]

        optimization_config:
        {
            "regressor_type": "gradient_boosting",
            "hyperparameters": {...},
            "feature_engineering": {"normalize": true, "interaction_features": true}
        }
        """
        try:
            if not training_data or len(training_data) < 10:
                logger.warning("Pas assez de données pour l'entraînement")
                return {'error': 'Données insuffisantes'}

            # IMPORTANT: Réinitialiser les modèles et feature_names pour éviter les anciens paramètres
            self.rf_classifier = None
            self.rf_regressor = None
            self.gb_regressor = None
            self.feature_names = None
            logger.info("Modèles précédents réinitialisés")

            # Préparer les données
            X, y_accept, y_success, y_engagement, feature_names = self._prepare_training_data(training_data)

            if X.shape[0] == 0:
                return {'error': 'Impossible de préparer les données'}

            self.feature_names = feature_names
            logger.info(f"✓ Features reçues: {len(self.feature_names)} noms, {X.shape[1]} colonnes")
            logger.info(f"  Noms: {self.feature_names}")

            # Normaliser les features
            X_scaled = self.scaler.fit_transform(X)

            # Diviser en train/test (avec stratification pour équilibrer)
            X_train, X_test, y_train_c, y_test_c, y_train_e, y_test_e = train_test_split(
                X_scaled, y_accept, y_engagement,
                test_size=0.2, random_state=42, stratify=y_accept
            )

            # Analyser l'équilibre des classes
            logger.info(f"Distribution classes train: {sum(y_train_c)}/{len(y_train_c)} acceptés ({100*sum(y_train_c)/len(y_train_c):.1f}%)")
            logger.info(f"Distribution classes test: {sum(y_test_c)}/{len(y_test_c)} acceptés ({100*sum(y_test_c)/len(y_test_c):.1f}%)")

            # Entraîner le classificateur
            logger.info("Entraînement du classificateur...")
            self.rf_classifier = RandomForestClassifier(
                n_estimators=100,
                max_depth=6,
                min_samples_split=20,
                min_samples_leaf=10,
                max_features='sqrt',
                max_samples=0.8,
                class_weight='balanced',
                random_state=42,
                n_jobs=-1,
                verbose=1
            )
            self.rf_classifier.fit(X_train, y_train_c)

            classifier_metrics = self._evaluate_classifier(
                self.rf_classifier,
                X_train, y_train_c,
                X_test, y_test_c
            )

            # Convertir l'engagement (0-1) en score (0-100)
            y_train_score = y_train_e * 100
            y_test_score = y_test_e * 100

            # Déterminer le type de régresseur à utiliser
            regressor_type = 'random_forest'
            if optimization_config and optimization_config.get('regressor_type') == 'gradient_boosting':
                regressor_type = 'gradient_boosting'

            self.regressor_type = regressor_type

            # Entraîner le régresseur
            logger.info(f"Entraînement du régresseur ({regressor_type})...")

            if regressor_type == 'gradient_boosting':
                params = optimization_config.get('hyperparameters', {}) if optimization_config else {}
                self.gb_regressor = GradientBoostingRegressor(
                    n_estimators=params.get('n_estimators', 200),
                    learning_rate=params.get('learning_rate', 0.05),
                    max_depth=params.get('max_depth', 7),
                    min_samples_split=params.get('min_samples_split', 5),
                    min_samples_leaf=params.get('min_samples_leaf', 2),
                    subsample=params.get('subsample', 0.8),
                    random_state=42,
                    verbose=1
                )
                self.gb_regressor.fit(X_train, y_train_score)
                regressor = self.gb_regressor
            else:
                self.rf_regressor = RandomForestRegressor(
                    n_estimators=100,
                    max_depth=6,
                    min_samples_split=20,
                    min_samples_leaf=10,
                    max_features='sqrt',
                    max_samples=0.8,
                    random_state=42,
                    n_jobs=-1,
                    verbose=1
                )
                self.rf_regressor.fit(X_train, y_train_score)
                regressor = self.rf_regressor

            # Évaluer le régresseur avec analyse des résidus
            regressor_metrics = self._evaluate_regressor(
                regressor,
                X_train, y_train_score,
                X_test, y_test_score
            )

            # Analyser les résidus
            y_pred_test = regressor.predict(X_test)
            residuals = y_test_score - y_pred_test
            residuals_analysis = {
                'mean': float(np.mean(residuals)),
                'std': float(np.std(residuals)),
                'max_error': float(np.max(np.abs(residuals))),
                'min_error': float(np.min(np.abs(residuals)))
            }

            # Validation croisée avec StratifiedKFold
            logger.info("Validation croisée (5-fold)...")
            skf = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)
            cv_scores = {
                'classifier_cv_score': cross_val_score(
                    self.rf_classifier, X_scaled, y_accept,
                    cv=skf, scoring='f1_weighted'
                ).mean(),
                'regressor_cv_score': cross_val_score(
                    regressor, X_scaled, y_engagement * 100,
                    cv=5, scoring='r2'
                ).mean()
            }

            # Sauvegarder les modèles
            self.save_models()

            # Log des features pour debug
            logger.info(f"Features utilisées ({len(self.feature_names)}): {self.feature_names}")

            logger.info("Modèles entraînés avec succès")

            # Récupérer les importances avec tous les features
            feature_importance = self._get_feature_importance()
            logger.info(f"Features importance retournées: {len(feature_importance)} features")

            return {
                'success': True,
                'classifier_metrics': classifier_metrics,
                'regressor_metrics': regressor_metrics,
                'residuals_analysis': residuals_analysis,
                'cross_val_scores': cv_scores,
                'feature_importance': feature_importance,
                'feature_count': len(self.feature_names),
                'samples_trained': len(training_data),
                'regressor_type': regressor_type
            }

        except Exception as e:
            logger.error(f"Erreur lors de l'entraînement: {str(e)}")
            import traceback
            traceback.print_exc()
            return {'error': str(e)}
    
    # ────────────────────────────────────────────────────────────────────────
    # ÉVALUATION DES MODÈLES
    # ────────────────────────────────────────────────────────────────────────
    
    def evaluate_models(self, test_data: List[Dict[str, Any]]) -> Dict[str, Any]:
        """
        Évaluer les performances des modèles sur des données de test
        """
        try:
            X, y_accept, y_success, y_engagement = self._prepare_training_data(test_data)
            
            if X.shape[0] == 0:
                return {'error': 'Impossible de préparer les données'}
            
            X_scaled = self.scaler.transform(X)
            
            results = {}
            
            if self.rf_classifier:
                results['classifier'] = self._evaluate_classifier(
                    self.rf_classifier,
                    X_scaled, y_accept,
                    X_scaled, y_accept
                )
            
            if self.rf_regressor:
                y_score = y_engagement * 100
                results['regressor'] = self._evaluate_regressor(
                    self.rf_regressor,
                    X_scaled, y_score,
                    X_scaled, y_score
                )
            
            return {
                'success': True,
                'metrics': results,
                'samples_evaluated': len(test_data)
            }
            
        except Exception as e:
            logger.error(f"Erreur lors de l'évaluation: {str(e)}")
            return {'error': str(e)}
    
    def _evaluate_classifier(
        self,
        model: RandomForestClassifier,
        X_train: np.ndarray,
        y_train: np.ndarray,
        X_test: np.ndarray,
        y_test: np.ndarray
    ) -> Dict[str, float]:
        """Évaluer un classificateur"""
        try:
            y_pred = model.predict(X_test)
            y_pred_train = model.predict(X_train)

            # Matrice de confusion pour diagnostiquer
            tn, fp, fn, tp = confusion_matrix(y_test, y_pred).ravel() if len(np.unique(y_test)) > 1 else (0, 0, 0, 0)

            logger.info(f"Matrice de confusion: TP={tp}, FP={fp}, FN={fn}, TN={tn}")
            logger.info(f"Classe 0 (rejeté): {sum(1-y_test)} samples, Classe 1 (accepté): {sum(y_test)} samples")

            return {
                'accuracy': accuracy_score(y_test, y_pred),
                'precision': precision_score(y_test, y_pred, zero_division=0),
                'recall': recall_score(y_test, y_pred, zero_division=0),
                'f1': f1_score(y_test, y_pred, zero_division=0),
                'train_accuracy': accuracy_score(y_train, y_pred_train),
                'confusion_matrix': {
                    'true_positives': int(tp),
                    'false_positives': int(fp),
                    'false_negatives': int(fn),
                    'true_negatives': int(tn)
                }
            }

        except Exception as e:
            logger.error(f"Erreur lors de l'évaluation du classificateur: {str(e)}")
            return {}
    
    def _evaluate_regressor(
        self,
        model: RandomForestRegressor,
        X_train: np.ndarray,
        y_train: np.ndarray,
        X_test: np.ndarray,
        y_test: np.ndarray
    ) -> Dict[str, float]:
        """Évaluer un régresseur"""
        try:
            y_pred = model.predict(X_test)
            y_pred_train = model.predict(X_train)
            
            return {
                'mse': mean_squared_error(y_test, y_pred),
                'rmse': np.sqrt(mean_squared_error(y_test, y_pred)),
                'mae': np.mean(np.abs(y_test - y_pred)),
                'r2': r2_score(y_test, y_pred),
                'train_r2': r2_score(y_train, y_pred_train)
            }
            
        except Exception as e:
            logger.error(f"Erreur lors de l'évaluation du régresseur: {str(e)}")
            return {}
    
    # ────────────────────────────────────────────────────────────────────────
    # HYPERPARAMÈTRES
    # ────────────────────────────────────────────────────────────────────────
    
    def optimize_hyperparameters(self, training_data: List[Dict[str, Any]]) -> Dict[str, Any]:
        """
        Optimiser les hyperparamètres avec recherche en grille
        (Simplifié pour la démo, utiliser GridSearchCV en prod)
        """
        try:
            X, y_accept, _, y_engagement = self._prepare_training_data(training_data)
            X_scaled = self.scaler.fit_transform(X)
            y_score = y_engagement * 100
            
            best_params = {}
            best_score = -np.inf
            
            # Tester différentes profondeurs
            for max_depth in [5, 10, 15, 20]:
                for n_estimators in [50, 100, 150]:
                    model = RandomForestRegressor(
                        n_estimators=n_estimators,
                        max_depth=max_depth,
                        random_state=42,
                        n_jobs=-1
                    )
                    
                    cv_scores = cross_val_score(
                        model, X_scaled, y_score,
                        cv=3, scoring='r2'
                    )
                    
                    mean_score = cv_scores.mean()
                    
                    if mean_score > best_score:
                        best_score = mean_score
                        best_params = {
                            'max_depth': max_depth,
                            'n_estimators': n_estimators,
                            'cv_score': mean_score
                        }
            
            logger.info(f"Meilleurs hyperparamètres: {best_params}")
            
            return {
                'success': True,
                'best_params': best_params
            }
            
        except Exception as e:
            logger.error(f"Erreur lors de l'optimisation: {str(e)}")
            return {'error': str(e)}
    
    # ────────────────────────────────────────────────────────────────────────
    # FEATURE IMPORTANCE
    # ────────────────────────────────────────────────────────────────────────
    
    def _get_feature_importance(self) -> Dict[str, float]:
        """Récupérer l'importance des features"""
        try:
            if not self.rf_regressor or not self.feature_names:
                return {}
            
            importances = self.rf_regressor.feature_importances_
            
            importance_dict = {}
            for name, importance in zip(self.feature_names, importances):
                importance_dict[name] = round(float(importance), 4)
            
            return importance_dict
            
        except Exception as e:
            logger.error(f"Erreur lors de la récupération de l'importance: {str(e)}")
            return {}
    
    # ────────────────────────────────────────────────────────────────────────
    # SAUVEGARDE/CHARGEMENT
    # ────────────────────────────────────────────────────────────────────────
    
    def save_models(self):
        """Sauvegarder les modèles entraînés"""
        try:
            joblib.dump(
                self.rf_classifier,
                os.path.join(self.models_dir, 'rf_classifier.pkl')
            )
            joblib.dump(
                self.rf_regressor,
                os.path.join(self.models_dir, 'rf_regressor.pkl')
            )
            joblib.dump(
                self.scaler,
                os.path.join(self.models_dir, 'scaler.pkl')
            )
            joblib.dump(
                self.feature_names,
                os.path.join(self.models_dir, 'feature_names.pkl')
            )
            
            logger.info("Modèles sauvegardés")
            
        except Exception as e:
            logger.error(f"Erreur lors de la sauvegarde: {str(e)}")
    
    def load_models(self):
        """Charger les modèles entraînés"""
        try:
            classifier_path = os.path.join(self.models_dir, 'rf_classifier.pkl')
            regressor_path = os.path.join(self.models_dir, 'rf_regressor.pkl')
            scaler_path = os.path.join(self.models_dir, 'scaler.pkl')
            features_path = os.path.join(self.models_dir, 'feature_names.pkl')
            
            if os.path.exists(classifier_path):
                self.rf_classifier = joblib.load(classifier_path)
            if os.path.exists(regressor_path):
                self.rf_regressor = joblib.load(regressor_path)
            if os.path.exists(scaler_path):
                self.scaler = joblib.load(scaler_path)
            if os.path.exists(features_path):
                self.feature_names = joblib.load(features_path)
            
            logger.info("Modèles chargés")
            
        except Exception as e:
            logger.error(f"Erreur lors du chargement: {str(e)}")
    
    # ────────────────────────────────────────────────────────────────────────
    # UTILITAIRES
    # ────────────────────────────────────────────────────────────────────────
    
    def _prepare_training_data(
        self,
        training_data: List[Dict[str, Any]]
    ) -> Tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray, List[str]]:
        """Préparer les données d'entraînement"""
        try:
            X = []
            y_accept = []
            y_success = []
            y_engagement = []
            feature_names = None

            for example in training_data:
                features = example.get('profil_features', [])

                if not features:
                    continue

                # Récupérer les noms des features si fournis
                if 'feature_names' in example and feature_names is None:
                    feature_names = example.get('feature_names', [])

                # Assurer que c'est une liste
                if isinstance(features, dict):
                    feature_vector = [
                        features.get('moyenne_score', 50),
                        features.get('centres_interet_match', 0.5),
                        features.get('competences_score', 50),
                        features.get('budget_max_mensuel', 500),
                        features.get('duree_max_etudes', 3),
                    ]
                else:
                    feature_vector = list(features)

                X.append(feature_vector)
                y_accept.append(1 if example.get('accepted', False) else 0)
                y_success.append(1 if example.get('success', False) else 0)

                # Utiliser compatibility_score s'il existe, sinon engagement
                if 'compatibility_score' in example:
                    y_engagement.append(example.get('compatibility_score', 50) / 100)
                else:
                    y_engagement.append(example.get('engagement', 0.5))

            # Si pas de noms fournis, générer des noms génériques
            if feature_names is None or len(feature_names) == 0:
                n_features = len(X[0]) if X else 5
                feature_names = [f'feature_{i}' for i in range(n_features)]
            else:
                # IMPORTANT: Vérifier que le nombre de noms correspond aux features
                n_features = len(X[0]) if X else 0
                if len(feature_names) != n_features:
                    logger.warning(f"Mismatch: {len(feature_names)} noms fournis pour {n_features} features")
                    # Padronner les noms si besoin
                    if len(feature_names) < n_features:
                        feature_names = list(feature_names) + [f'feature_{i}' for i in range(len(feature_names), n_features)]
                    else:
                        feature_names = feature_names[:n_features]

            logger.info(f"Données préparées: {n_features} features, noms: {feature_names}")

            return (
                np.array(X),
                np.array(y_accept),
                np.array(y_success),
                np.array(y_engagement),
                feature_names
            )

        except Exception as e:
            logger.error(f"Erreur lors de la préparation: {str(e)}")
            return np.array([]), np.array([]), np.array([]), np.array([]), []
    
    def get_training_history(self) -> List[Dict[str, Any]]:
        """Récupérer l'historique des entraînements"""
        return self.training_history
    
    def get_model_metrics(self) -> Dict[str, Any]:
        """Récupérer les métriques des modèles"""
        return self.model_metrics
