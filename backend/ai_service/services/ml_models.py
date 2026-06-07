"""
MODÈLES MACHINE LEARNING
=======================
Entraînement et utilisation de Random Forest pour prédiction du succès académique.
"""

import logging
import json
import pickle
import numpy as np
from typing import List, Dict, Optional
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor
from sklearn.preprocessing import LabelEncoder
from pathlib import Path

logger = logging.getLogger(__name__)


class MLModels:
    """Gestion des modèles ML"""
    
    def __init__(self):
        self.models_dir = Path('models')
        self.models_dir.mkdir(exist_ok=True)
        
        self.rf_classifier = None  # Classification: succès/échec
        self.rf_regressor = None   # Régression: score de succès (0-100)
        self.feature_encoder = None
        self.feature_importance = None
        self.is_trained = False
        
        self._load_models()
        logger.info("✓ MLModels initialisé")
    
    
    def is_ready(self) -> bool:
        """Vérifier si les modèles sont prêts à utiliser"""
        return self.is_trained and self.rf_regressor is not None
    
    
    def train(self, training_data: List[Dict]) -> Dict:
        """
        Entraîner les modèles ML avec les données historiques.
        
        Format attendu pour chaque exemple:
        {
            'profil_features': {...},
            'filiere_id': int,
            'accepted': bool,
            'success': bool,  # A reçu la filière et a réussi
            'engagement': float (0-1)  # Niveau de satisfaction
        }
        """
        logger.info(f"🎓 Entraînement avec {len(training_data)} exemples")
        
        if len(training_data) < 10:
            logger.warning("Trop peu d'exemples pour entraîner les modèles")
            return {'success': False, 'message': 'Données insuffisantes'}
        
        try:
            # Extraire les features et labels
            X, y_success, y_engagement = self._prepare_training_data(training_data)
            
            if X is None or len(X) == 0:
                logger.warning("Données d'entraînement vides après préparation")
                return {'success': False, 'message': 'Erreur préparation données'}
            
            logger.info(f"Features shape: {X.shape}")
            
            # Entraîner le classifieur (succès/échec)
            self.rf_classifier = RandomForestClassifier(
                n_estimators=100,
                max_depth=10,
                random_state=42,
                n_jobs=-1
            )
            self.rf_classifier.fit(X, y_success)
            
            # Entraîner le régresseur (score de succès 0-100)
            self.rf_regressor = RandomForestRegressor(
                n_estimators=100,
                max_depth=10,
                random_state=42,
                n_jobs=-1
            )
            self.rf_regressor.fit(X, y_engagement)
            
            # Sauvegarder les modèles
            self._save_models()
            
            # Calculer l'importance des features
            self.feature_importance = self._calculate_feature_importance(X)
            
            self.is_trained = True
            
            # Évaluation basique
            train_score = self.rf_classifier.score(X, y_success)
            
            logger.info(f"✓ Entraînement réussi - Accuracy: {train_score:.3f}")
            
            return {
                'success': True,
                'message': 'Modèles entraînés avec succès',
                'metrics': {
                    'training_examples': len(training_data),
                    'accuracy': round(train_score, 3),
                    'feature_importance': self.feature_importance
                }
            }
            
        except Exception as e:
            logger.error(f"Erreur entraînement: {str(e)}")
            return {'success': False, 'error': str(e)}
    
    
    def evaluate(self, test_data: List[Dict]) -> Dict:
        """Évaluer les performances des modèles"""
        if not self.is_trained:
            return {'success': False, 'error': 'Modèles non entraînés'}
        
        try:
            X, y_success, y_engagement = self._prepare_training_data(test_data)
            
            if X is None or len(X) == 0:
                return {'success': False, 'error': 'Données vides'}
            
            accuracy = self.rf_classifier.score(X, y_success)
            r2_score = self.rf_regressor.score(X, y_engagement)
            
            logger.info(f"Évaluation - Accuracy: {accuracy:.3f}, R²: {r2_score:.3f}")
            
            return {
                'success': True,
                'metrics': {
                    'accuracy': round(accuracy, 3),
                    'r2_score': round(r2_score, 3),
                    'test_examples': len(test_data)
                }
            }
            
        except Exception as e:
            logger.error(f"Erreur évaluation: {str(e)}")
            return {'success': False, 'error': str(e)}
    
    
    def predict_success(self, profil: Dict, filiere: Dict) -> float:
        """
        Prédire le score de succès pour un profil + filière (0-100).
        Demande un entraînement préalable.
        """
        if not self.is_trained or self.rf_regressor is None:
            logger.warning("Modèles non entraînés, retour score par défaut")
            return 50.0
        
        try:
            features = self._extract_features(profil, filiere)
            
            if features is None:
                return 50.0
            
            features = np.array(features).reshape(1, -1)
            prediction = self.rf_regressor.predict(features)[0]
            
            # Clamp entre 0 et 100
            return float(max(0, min(100, prediction)))
            
        except Exception as e:
            logger.warning(f"Erreur prédiction: {str(e)}")
            return 50.0
    
    
    def get_feature_importance(self) -> Optional[Dict]:
        """Retourner l'importance des features"""
        return self.feature_importance
    
    
    # ─── UTILITAIRES PRIVÉS ──────────────────────────────────────────────
    
    def _prepare_training_data(self, training_data: List[Dict]) -> tuple:
        """Préparer les données d'entraînement"""
        X_list = []
        y_success = []
        y_engagement = []
        
        for example in training_data:
            try:
                features = self._extract_features(
                    example.get('profil_features', {}),
                    {'id': example.get('filiere_id')},
                    example
                )
                
                if features is not None:
                    X_list.append(features)
                    y_success.append(1 if example.get('success', False) else 0)
                    y_engagement.append(example.get('engagement', 0.5) * 100)
                    
            except Exception as e:
                logger.debug(f"Erreur préparation exemple: {str(e)}")
                continue
        
        if not X_list:
            return None, None, None
        
        return np.array(X_list, dtype=np.float32), np.array(y_success), np.array(y_engagement)
    
    
    def _extract_features(self, profil: Dict, filiere: Dict, 
                         context: Optional[Dict] = None) -> Optional[List]:
        """
        Extraire les features numériques d'un profil + filière
        """
        try:
            features = []
            
            # Features du profil
            features.append(float(profil.get('moyenne_generale', 10.0)) / 20.0)
            
            competences = profil.get('competences', {})
            comp_scores = [v for v in competences.values() if isinstance(v, (int, float))]
            comp_mean = sum(comp_scores) / len(comp_scores) / 5.0 if comp_scores else 0.5
            features.append(comp_mean)
            
            interests = profil.get('centres_interet', [])
            features.append(min(len(interests) / 5.0, 1.0))

            duree = float(profil.get('duree_max_etudes', 3.0))
            features.append(min(duree / 6.0, 1.0))
            
            # Features du contexte/historique
            if context:
                features.append(int(context.get('accepted', False)))
            
            # Filière basique
            features.append(float(filiere.get('id', 0)) / 1000.0)  # Normaliser ID
            
            return features
            
        except Exception as e:
            logger.warning(f"Erreur extraction features: {str(e)}")
            return None
    
    
    def _calculate_feature_importance(self, X: np.ndarray) -> Dict:
        """Calculer l'importance des features"""
        if self.rf_regressor is None or not hasattr(self.rf_regressor, 'feature_importances_'):
            return {}
        
        importances = self.rf_regressor.feature_importances_
        feature_names = [
            'moyenne_generale',
            'competences',
            'centres_interet',
            'duree_etudes',
            'accepted_historique',
            'filiere_id'
        ]
        
        importance_dict = {}
        for name, importance in zip(feature_names, importances):
            if importance > 0.01:  # Seuil minimum
                importance_dict[name] = round(float(importance), 4)
        
        return importance_dict
    
    
    def _save_models(self):
        """Sauvegarder les modèles sur disque"""
        try:
            if self.rf_classifier:
                with open(self.models_dir / 'rf_classifier.pkl', 'wb') as f:
                    pickle.dump(self.rf_classifier, f)
            
            if self.rf_regressor:
                with open(self.models_dir / 'rf_regressor.pkl', 'wb') as f:
                    pickle.dump(self.rf_regressor, f)
            
            logger.info("✓ Modèles sauvegardés")
            
        except Exception as e:
            logger.error(f"Erreur sauvegarde modèles: {str(e)}")
    
    
    def _load_models(self):
        """Charger les modèles depuis le disque"""
        try:
            clf_path = self.models_dir / 'rf_classifier.pkl'
            reg_path = self.models_dir / 'rf_regressor.pkl'
            
            if clf_path.exists():
                with open(clf_path, 'rb') as f:
                    self.rf_classifier = pickle.load(f)
                logger.info("✓ Classifieur chargé")
            
            if reg_path.exists():
                with open(reg_path, 'rb') as f:
                    self.rf_regressor = pickle.load(f)
                self.is_trained = True
                logger.info("✓ Régresseur chargé - Modèles prêts")
            
        except Exception as e:
            logger.warning(f"Pas de modèles sauvegardés: {str(e)}")
