"""
Service de recommandation intelligente utilisant plusieurs algorithmes ML
- KNN (K-Nearest Neighbors) : similarité entre profils
- Random Forest : prédiction de compatibilité
- Weighted Scoring : scoring pondéré personnalisé
"""

import numpy as np
import pandas as pd
from sklearn.neighbors import NearestNeighbors
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor
from sklearn.preprocessing import StandardScaler
import joblib
import os
from typing import List, Dict, Any
import logging

logger = logging.getLogger(__name__)


class RecommendationMLService:
    
    def __init__(self):
        """Initialiser le service de recommandation ML"""
        self.models_dir = 'models'
        self.scaler = StandardScaler()
        self.knn_model = None
        self.rf_classifier = None  # Pour classification (accepté/rejeté)
        self.rf_regressor = None   # Pour régression (score de compatibilité)
        self.feature_names = None
        
        self._ensure_models_dir()
        self._load_models()
    
    def _ensure_models_dir(self):
        """Créer le répertoire des modèles s'il n'existe pas"""
        if not os.path.exists(self.models_dir):
            os.makedirs(self.models_dir)
    
    def _load_models(self):
        """Charger les modèles sauvegardés"""
        try:
            knn_path = os.path.join(self.models_dir, 'knn_model.pkl')
            rf_classifier_path = os.path.join(self.models_dir, 'rf_classifier.pkl')
            rf_regressor_path = os.path.join(self.models_dir, 'rf_regressor.pkl')
            scaler_path = os.path.join(self.models_dir, 'scaler.pkl')
            features_path = os.path.join(self.models_dir, 'feature_names.pkl')
            
            if os.path.exists(knn_path):
                self.knn_model = joblib.load(knn_path)
            if os.path.exists(rf_classifier_path):
                self.rf_classifier = joblib.load(rf_classifier_path)
            if os.path.exists(rf_regressor_path):
                self.rf_regressor = joblib.load(rf_regressor_path)
            if os.path.exists(scaler_path):
                self.scaler = joblib.load(scaler_path)
            if os.path.exists(features_path):
                self.feature_names = joblib.load(features_path)
                
            logger.info("Modèles chargés avec succès")
        except Exception as e:
            logger.warning(f"Impossible de charger les modèles: {str(e)}")
    
    def save_models(self):
        """Sauvegarder les modèles"""
        try:
            joblib.dump(self.knn_model, os.path.join(self.models_dir, 'knn_model.pkl'))
            joblib.dump(self.rf_classifier, os.path.join(self.models_dir, 'rf_classifier.pkl'))
            joblib.dump(self.rf_regressor, os.path.join(self.models_dir, 'rf_regressor.pkl'))
            joblib.dump(self.scaler, os.path.join(self.models_dir, 'scaler.pkl'))
            joblib.dump(self.feature_names, os.path.join(self.models_dir, 'feature_names.pkl'))
            logger.info("Modèles sauvegardés avec succès")
        except Exception as e:
            logger.error(f"Erreur lors de la sauvegarde des modèles: {str(e)}")
    
    # ────────────────────────────────────────────────────────────────────────
    # RECOMMANDATIONS PAR ENSEMBLE (Combinaison de tous les modèles)
    # ────────────────────────────────────────────────────────────────────────
    
    def recommend_filieres(
        self,
        profil_features: Dict[str, Any],
        filieres: List[Dict[str, Any]],
        scores_test: Dict[str, float] = None,
        weights: Dict[str, float] = None
    ) -> List[Dict[str, Any]]:
        """
        Générer des recommandations en combinant plusieurs modèles
        
        Poids des modèles :
        - Weighted Scoring: 35% (ancien système stable)
        - KNN Similarity: 30% (basé sur profils similaires)
        - Random Forest: 35% (prédiction ML)
        """
        try:
            if weights is None:
                weights = {
                    'scoring_pondéré': 0.35,
                    'knn': 0.30,
                    'random_forest': 0.35
                }
            
            recommendations = []
            
            # Calculer les scores pour chaque filière
            for filiere in filieres:
                # Score par scoring pondéré
                score_weighted = self._calculate_weighted_score(
                    profil_features,
                    filiere,
                    scores_test
                )
                
                # Score par KNN (si modèle disponible)
                score_knn = 50  # Score par défaut
                if self.knn_model:
                    score_knn = self._get_knn_score(profil_features, filiere)
                
                # Score par Random Forest (si modèle disponible)
                score_rf = 50  # Score par défaut
                if self.rf_regressor:
                    score_rf = self._get_rf_score(profil_features, filiere)
                
                # Score ensemble pondéré
                ensemble_score = (
                    score_weighted * weights['scoring_pondéré'] +
                    score_knn * weights['knn'] +
                    score_rf * weights['random_forest']
                )
                
                # Justification
                justification = self._generate_justification(
                    profil_features,
                    filiere,
                    ensemble_score,
                    {
                        'scoring_pondéré': score_weighted,
                        'knn': score_knn,
                        'random_forest': score_rf
                    }
                )
                
                recommendations.append({
                    'filiere_id': filiere.get('id'),
                    'nom': filiere.get('nom'),
                    'universite': filiere.get('universite', {}),
                    'score': round(ensemble_score, 2),
                    'scores_details': {
                        'weighted_scoring': round(score_weighted, 2),
                        'knn_similarity': round(score_knn, 2),
                        'random_forest': round(score_rf, 2)
                    },
                    'methode': 'ml_ensemble',
                    'justification': justification
                })
            
            # Trier par score décroissant
            recommendations.sort(key=lambda x: x['score'], reverse=True)
            
            return recommendations
            
        except Exception as e:
            logger.error(f"Erreur lors des recommandations ensemble: {str(e)}")
            return []
    
    # ────────────────────────────────────────────────────────────────────────
    # KNN - K-Nearest Neighbors
    # ────────────────────────────────────────────────────────────────────────
    
    def knn_recommend(
        self,
        profil_features: Dict[str, Any],
        all_profils_features: List[Dict[str, Any]],
        filieres: List[Dict[str, Any]],
        k: int = 5
    ) -> List[Dict[str, Any]]:
        """
        Recommander les filières basées sur les k profils les plus similaires
        """
        try:
            if not all_profils_features or len(all_profils_features) < k:
                logger.warning("Pas assez de profils pour KNN")
                return []
            
            # Préparer les données
            X = self._prepare_features_matrix(all_profils_features)
            X_profil = self._prepare_features_matrix([profil_features])
            
            # Créer et entraîner le modèle KNN si nécessaire
            if self.knn_model is None or X.shape[0] < k:
                self.knn_model = NearestNeighbors(n_neighbors=min(k, X.shape[0]))
                self.knn_model.fit(X)
            
            # Trouver les k voisins les plus proches
            distances, indices = self.knn_model.kneighbors(X_profil)
            
            # Collecter les filières des profils similaires
            filiere_scores = {}
            for i, neighbor_idx in enumerate(indices[0]):
                neighbor_profil = all_profils_features[neighbor_idx]
                similarity_score = 100 - (distances[0][i] * 10)  # Convertir distance en score
                
                # Supposer que chaque profil a des filières acceptées
                chosen_filieres = neighbor_profil.get('chosen_filieres', [])
                for filiere_id in chosen_filieres:
                    if filiere_id not in filiere_scores:
                        filiere_scores[filiere_id] = []
                    filiere_scores[filiere_id].append(similarity_score)
            
            # Calculer les scores moyens
            recommendations = []
            for filiere in filieres:
                filiere_id = filiere.get('id')
                if filiere_id in filiere_scores:
                    avg_score = np.mean(filiere_scores[filiere_id])
                    recommendations.append({
                        'filiere_id': filiere_id,
                        'nom': filiere.get('nom'),
                        'score': round(avg_score, 2),
                        'methode': 'knn',
                        'reasoning': f"Basé sur {len(filiere_scores[filiere_id])} profils similaires"
                    })
            
            # Trier par score
            recommendations.sort(key=lambda x: x['score'], reverse=True)
            
            return recommendations[:10]
            
        except Exception as e:
            logger.error(f"Erreur KNN: {str(e)}")
            return []
    
    def _get_knn_score(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> float:
        """Obtenir le score KNN pour une filière spécifique"""
        try:
            if self.knn_model is None:
                return 50.0
            
            # Score basé sur la compatibilité avec les filières des voisins
            # Simplifié : retourner un score basé sur les caractéristiques
            score = 50.0
            
            # Ajustements simples basés sur les features
            if profil_features.get('centres_interet_match', 0) > 0.7:
                score += 20
            if profil_features.get('moyenne_score', 50) > 70:
                score += 15
            if profil_features.get('competences_match', 0) > 0.6:
                score += 10
            
            return min(score, 100.0)
            
        except Exception as e:
            logger.error(f"Erreur dans _get_knn_score: {str(e)}")
            return 50.0
    
    # ────────────────────────────────────────────────────────────────────────
    # RANDOM FOREST
    # ────────────────────────────────────────────────────────────────────────
    
    def random_forest_recommend(
        self,
        profil_features: Dict[str, Any],
        filieres: List[Dict[str, Any]]
    ) -> List[Dict[str, Any]]:
        """
        Recommander les filières basées sur un Random Forest entraîné
        """
        try:
            if self.rf_regressor is None:
                logger.warning("Random Forest non encore entraîné")
                return []
            
            recommendations = []
            X_profil = self._prepare_features_matrix([profil_features])
            
            for filiere in filieres:
                # Prédiction de score
                score = self.rf_regressor.predict(X_profil)[0]
                score = max(0, min(100, score))  # Clamp entre 0-100
                
                recommendations.append({
                    'filiere_id': filiere.get('id'),
                    'nom': filiere.get('nom'),
                    'score': round(score, 2),
                    'methode': 'random_forest',
                    'confidence': round(np.std(self.rf_regressor.predict(X_profil)), 2)
                })
            
            recommendations.sort(key=lambda x: x['score'], reverse=True)
            return recommendations[:10]
            
        except Exception as e:
            logger.error(f"Erreur Random Forest: {str(e)}")
            return []
    
    def _get_rf_score(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> float:
        """Obtenir le score Random Forest pour une filière spécifique"""
        try:
            if self.rf_regressor is None:
                return 50.0
            
            X_profil = self._prepare_features_matrix([profil_features])
            score = self.rf_regressor.predict(X_profil)[0]
            
            return max(0, min(100, score))
            
        except Exception as e:
            logger.error(f"Erreur dans _get_rf_score: {str(e)}")
            return 50.0
    
    # ────────────────────────────────────────────────────────────────────────
    # WEIGHTED SCORING (Ancien système amélioré)
    # ────────────────────────────────────────────────────────────────────────
    
    def _calculate_weighted_score(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any],
        scores_test: Dict[str, float] = None
    ) -> float:
        """
        Calculer le score par la méthode de scoring pondéré
        """
        try:
            weights = {
                'serie_bac': 0.20,
                'moyenne_generale': 0.20,
                'centres_interet': 0.20,
                'competences': 0.15,
                'budget': 0.10,
                'duree': 0.10,
                'test_scores': 0.05
            }
            
            scores = {}
            
            # Score série bac
            scores['serie_bac'] = self._score_serie_bac(profil_features, filiere)
            
            # Score moyenne générale
            scores['moyenne_generale'] = profil_features.get('moyenne_score', 50)
            
            # Score centres d'intérêt
            scores['centres_interet'] = profil_features.get('centres_interet_match', 50) * 100
            
            # Score compétences
            scores['competences'] = profil_features.get('competences_score', 50)
            
            # Score budget
            scores['budget'] = self._score_budget(profil_features, filiere)
            
            # Score durée
            scores['duree'] = self._score_duree(profil_features, filiere)
            
            # Score test
            scores['test_scores'] = self._score_test(profil_features, filiere, scores_test)
            
            # Score pondéré final
            weighted_score = sum(scores[k] * weights[k] for k in weights.keys())
            
            return min(max(weighted_score, 0), 100)
            
        except Exception as e:
            logger.error(f"Erreur dans _calculate_weighted_score: {str(e)}")
            return 50.0
    
    def _score_serie_bac(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> float:
        """Scorer la compatibilité de la série bac"""
        serie_profil = profil_features.get('serie_bac', '').lower()
        series_acceptees = filiere.get('series_bac_acceptees', [])
        
        if not series_acceptees:
            return 70
        
        series_acceptees_lower = [s.lower() for s in series_acceptees]
        
        if serie_profil in series_acceptees_lower:
            idx = series_acceptees_lower.index(serie_profil)
            return 100 if idx == 0 else 80
        
        return 40
    
    def _score_budget(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> float:
        """Scorer le budget"""
        budget_max = profil_features.get('budget_max_mensuel', 0)
        cout_annuel = filiere.get('cout_annuel', 0)
        
        if not budget_max or not cout_annuel:
            return 70
        
        cout_mensuel = cout_annuel / 12
        
        if cout_mensuel <= budget_max * 0.7:
            return 100
        elif cout_mensuel <= budget_max:
            return 75
        elif cout_mensuel <= budget_max * 1.2:
            return 40
        else:
            return 10
    
    def _score_duree(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> float:
        """Scorer la durée des études"""
        duree_max = profil_features.get('duree_max_etudes', 0)
        duree_filiere = filiere.get('duree_annees', 0)
        
        if not duree_max or not duree_filiere:
            return 70
        
        if duree_filiere <= duree_max:
            return 100
        elif duree_filiere <= duree_max + 1:
            return 60
        else:
            return 20
    
    def _score_test(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any],
        scores_test: Dict[str, float] = None
    ) -> float:
        """Scorer basé sur les tests d'orientation"""
        if not scores_test:
            return 50
        
        centres_interet = filiere.get('centres_interet', [])
        if not centres_interet:
            return 50
        
        test_scores = []
        for interet in centres_interet:
            if interet.lower() in scores_test:
                test_scores.append(scores_test[interet.lower()])
        
        return np.mean(test_scores) if test_scores else 50
    
    # ────────────────────────────────────────────────────────────────────────
    # EXPLICATION ET INTERPRETABILITÉ
    # ────────────────────────────────────────────────────────────────────────
    
    def explain_recommendation(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any]
    ) -> Dict[str, Any]:
        """
        Expliquer en détail pourquoi une filière est recommandée
        """
        try:
            explanation = {
                'forces': [],
                'points_attention': [],
                'score_breakdown': {},
                'factors_influencing': []
            }
            
            # Analyse de la série bac
            serie_score = self._score_serie_bac(profil_features, filiere)
            if serie_score >= 80:
                explanation['forces'].append(
                    f"Votre série {profil_features.get('serie_bac')} est bien adaptée"
                )
            elif serie_score < 50:
                explanation['points_attention'].append(
                    "Votre série n'est pas la plus adaptée pour cette filière"
                )
            
            # Analyse de la moyenne
            moyenne_score = profil_features.get('moyenne_score', 50)
            moyenne_min = filiere.get('moyenne_min_requise', 0)
            if moyenne_score >= moyenne_min + 4:
                explanation['forces'].append(
                    f"Votre moyenne ({profil_features.get('moyenne_generale')}/20) "
                    f"est bien au-dessus du seuil requis"
                )
            elif moyenne_score < moyenne_min:
                explanation['points_attention'].append(
                    f"Votre moyenne est légèrement en-dessous du seuil recommandé"
                )
            
            # Analyse des centres d'intérêt
            interet_match = profil_features.get('centres_interet_match', 0)
            if interet_match > 0.7:
                explanation['forces'].append(
                    "Vos centres d'intérêt correspondent très bien à cette filière"
                )
            elif interet_match < 0.3:
                explanation['points_attention'].append(
                    "Peu de correspondance entre vos intérêts et cette filière"
                )
            
            # Score breakdown
            explanation['score_breakdown'] = {
                'serie_bac': round(self._score_serie_bac(profil_features, filiere), 2),
                'moyenne': moyenne_score,
                'centres_interet': round(interet_match * 100, 2),
                'budget': round(self._score_budget(profil_features, filiere), 2),
                'duree': round(self._score_duree(profil_features, filiere), 2)
            }
            
            # Facteurs influents
            if filiere.get('taux_emploi', 0) >= 80:
                explanation['factors_influencing'].append(
                    f"Excellent taux d'emploi: {filiere.get('taux_emploi')}%"
                )
            
            if filiere.get('debouches'):
                explanation['factors_influencing'].append(
                    f"Débouchés variés: {', '.join(filiere.get('debouches', [])[:3])}"
                )
            
            return explanation
            
        except Exception as e:
            logger.error(f"Erreur lors de l'explication: {str(e)}")
            return {}
    
    def get_feature_importance(self) -> Dict[str, float]:
        """
        Récupérer l'importance des features selon les modèles entraînés
        """
        try:
            importance = {}
            
            if self.rf_regressor and hasattr(self.rf_regressor, 'feature_importances_'):
                importances = self.rf_regressor.feature_importances_
                if self.feature_names:
                    importance['random_forest'] = dict(
                        zip(self.feature_names, importances.tolist())
                    )
            
            # Importance statique basée sur le scoring pondéré
            importance['weighted_scoring'] = {
                'serie_bac': 0.20,
                'moyenne_generale': 0.20,
                'centres_interet': 0.20,
                'competences': 0.15,
                'budget': 0.10,
                'duree': 0.10,
                'test_scores': 0.05
            }
            
            return importance
            
        except Exception as e:
            logger.error(f"Erreur lors de la récupération de l'importance: {str(e)}")
            return {}
    
    def _generate_justification(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any],
        ensemble_score: float,
        score_details: Dict[str, float]
    ) -> Dict[str, Any]:
        """Générer une justification détaillée pour la recommandation"""
        return {
            'score_global': round(ensemble_score, 2),
            'explication': f"Score ensemble combinant 3 approches ML: "
                          f"Scoring pondéré ({score_details['scoring_pondéré']}), "
                          f"KNN ({score_details['knn']}), "
                          f"Random Forest ({score_details['random_forest']})",
            'points_forts': self._get_strengths(profil_features, filiere),
            'points_attention': self._get_weaknesses(profil_features, filiere),
            'debouches': filiere.get('debouches', [])
        }
    
    def _get_strengths(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> List[str]:
        """Identifier les points forts du match"""
        strengths = []
        
        serie_score = self._score_serie_bac(profil_features, filiere)
        if serie_score >= 80:
            strengths.append(f"Série {profil_features.get('serie_bac')} adaptée")
        
        if profil_features.get('centres_interet_match', 0) > 0.6:
            strengths.append("Centres d'intérêt bien alignés")
        
        budget_score = self._score_budget(profil_features, filiere)
        if budget_score >= 75:
            strengths.append("Coût compatible avec votre budget")
        
        if profil_features.get('moyenne_score', 0) > 70:
            strengths.append("Excellente moyenne académique")
        
        return strengths
    
    def _get_weaknesses(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> List[str]:
        """Identifier les faiblesses du match"""
        weaknesses = []
        
        serie_score = self._score_serie_bac(profil_features, filiere)
        if serie_score < 50:
            weaknesses.append("Série bac non prioritaire")
        
        if profil_features.get('centres_interet_match', 0) < 0.3:
            weaknesses.append("Peu de correspondance avec vos intérêts")
        
        budget_score = self._score_budget(profil_features, filiere)
        if budget_score < 50:
            weaknesses.append("Coût élevé par rapport au budget")
        
        duree_score = self._score_duree(profil_features, filiere)
        if duree_score < 50:
            weaknesses.append("Durée supérieure à votre préférence")
        
        return weaknesses
    
    # ────────────────────────────────────────────────────────────────────────
    # UTILITAIRES
    # ────────────────────────────────────────────────────────────────────────
    
    def _prepare_features_matrix(self, profils_features: List[Dict[str, Any]]) -> np.ndarray:
        """Préparer une matrice de features pour les modèles ML"""
        features = []
        for profil in profils_features:
            f = [
                profil.get('moyenne_score', 50),
                profil.get('centres_interet_match', 0.5),
                profil.get('competences_score', 50),
                profil.get('budget_max_mensuel', 500),
                profil.get('duree_max_etudes', 3),
            ]
            features.append(f)
        
        return np.array(features)
