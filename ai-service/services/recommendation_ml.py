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
        POIDS AMÉLIORÉS: Les critères utilisateur (objectifs, secteur, ville, distance, durée)
        sont plus fortement pondérés pour assurer une recommandation fiable
        """
        try:
            # POIDS OPTIMISÉS - Critères utilisateur essentiels au début
            weights = {
                'test_alignment': 0.25,          # [STAR] Réponses du test d'orientation
                'objectifs_secteur': 0.20,       # [STAR] Objectif professionnel + secteur + parcours
                'serie_bac': 0.15,
                'moyenne_generale': 0.12,
                'centres_interet': 0.10,
                'parcours_specialisations': 0.08,  # Alignement avec spécialisations des parcours
                'distance_ville': 0.05,          # Localisation (ville préférence + distance)
                'duree': 0.03,
                'competences': 0.02
            }

            scores = {}

            # Score alignement avec le test d'orientation (PRIORITAIRE)
            scores['test_alignment'] = self._score_test_alignment(profil_features, filiere, scores_test)

            # Score alignement objectifs professionnels + secteur
            scores['objectifs_secteur'] = self._score_objectifs_secteur(profil_features, filiere)

            # Score série bac
            scores['serie_bac'] = self._score_serie_bac(profil_features, filiere)

            # Score moyenne générale
            scores['moyenne_generale'] = profil_features.get('moyenne_score', 50)

            # Score centres d'intérêt
            scores['centres_interet'] = profil_features.get('centres_interet_match', 50) * 100

            # Score distance + ville
            scores['distance_ville'] = self._score_distance_ville(profil_features, filiere)

            # Score budget (moins prioritaire maintenant)
            # Intégré dans la justification plutôt que dans le score principal

            # Score durée
            scores['duree'] = self._score_duree(profil_features, filiere)

            # Score compétences
            scores['competences'] = profil_features.get('competences_score', 50)

            # Score alignement avec spécialisations des parcours
            scores['parcours_specialisations'] = self._score_parcours_specialisations(profil_features, filiere)

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
    
    def _score_test_alignment(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any],
        scores_test: Dict[str, float] = None
    ) -> float:
        """
        Scorer l'alignement avec les réponses du test d'orientation (CRITÈRE PRINCIPAL)
        Prend en compte toutes les réponses du test pour un calcul fiable
        """
        try:
            # Utiliser le score d'alignement global du test
            test_alignment = profil_features.get('test_alignment_score', 50) * 100

            # Si scores détaillés disponibles, les intégrer
            if scores_test:
                centres_interet_filiere = filiere.get('centres_interet', [])
                if centres_interet_filiere:
                    test_scores = []
                    for interet in centres_interet_filiere:
                        if interet.lower() in scores_test:
                            test_scores.append(scores_test[interet.lower()])

                    if test_scores:
                        # Moyenne des scores du test pour cette filière
                        filiere_test_score = np.mean(test_scores)
                        # Pondérer: 50% alignement global + 50% test spécifique
                        test_alignment = (test_alignment * 0.5) + (filiere_test_score * 0.5)

            return min(max(test_alignment, 0), 100)

        except Exception as e:
            logger.error(f"Erreur dans _score_test_alignment: {str(e)}")
            return 50.0

    def _score_objectifs_secteur(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any]
    ) -> float:
        """
        Scorer l'alignement entre les objectifs professionnels / secteur visé
        et la filière via les parcours associés (CRITÈRE PRINCIPAL)
        """
        try:
            score = 50  # Score neutre par défaut

            # 1. Vérifier l'alignement avec le secteur visé
            secteur_vise = profil_features.get('secteur_vise', '').lower()
            filiere_centres = [c.lower() for c in filiere.get('centres_interet', [])]

            if secteur_vise and filiere_centres:
                # Exact match avec le secteur visé
                if secteur_vise in filiere_centres:
                    score = 95
                # Partial match
                elif any(word in secteur_vise for word in filiere_centres):
                    score = 80
                # No match
                else:
                    score = 40
            elif secteur_vise:
                # Chercher dans le nom de la filière
                nom_filiere = filiere.get('nom', '').lower()
                if secteur_vise in nom_filiere or nom_filiere in secteur_vise:
                    score = 85
                else:
                    score = 45

            # 2. Vérifier les parcours et spécialisations vs objectifs professionnels
            objectifs = profil_features.get('objectifs_professionnels', '').lower()
            parcours_list = filiere.get('parcours', [])  # Liste des parcours associés

            if objectifs and parcours_list:
                # Analyser chaque parcours
                specialisations = [p.get('specialisation', '').lower() for p in parcours_list if p.get('specialisation')]
                debouches_parcours = []

                for parcours in parcours_list:
                    debouches_parcours.extend([d.lower() for d in parcours.get('debouches_professionnels', [])])

                # Chercher des correspondances dans les spécialisations et débouchés des parcours
                objectif_words = objectifs.split()
                matches = 0

                # Match avec spécialisations
                for word in objectif_words:
                    if len(word) > 3 and any(word in spec for spec in specialisations):
                        matches += 1

                # Match avec débouchés des parcours
                for word in objectif_words:
                    if len(word) > 3 and any(word in debouche for debouche in debouches_parcours):
                        matches += 1

                if matches > 0:
                    # Bonus selon le nombre de correspondances
                    parcours_score = min(90 + matches * 5, 100)
                    score = (score * 0.6) + (parcours_score * 0.4)
            elif objectifs and filiere.get('debouches'):
                # Fallback: utiliser débouchés de la filière si pas de parcours
                debouches = [d.lower() for d in filiere.get('debouches', [])]
                objectif_words = objectifs.split()
                matches = 0
                for word in objectif_words:
                    if len(word) > 3 and any(word in debouche for debouche in debouches):
                        matches += 1

                if matches > 0:
                    debouche_score = min(90 + matches * 5, 100)
                    score = (score * 0.6) + (debouche_score * 0.4)

            return min(max(score, 0), 100)

        except Exception as e:
            logger.error(f"Erreur dans _score_objectifs_secteur: {str(e)}")
            return 50.0

    def _score_distance_ville(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any]
    ) -> float:
        """
        Scorer l'alignement avec la ville préférée et la distance maximale
        """
        try:
            score = 70  # Score neutre favorable

            # 1. Vérifier la ville préférée
            ville_preference = profil_features.get('ville_preference', '').lower()
            universite = filiere.get('universite', {})
            ville_filiere = universite.get('ville', '').lower() if universite else ''

            if ville_preference and ville_filiere:
                # Match exact avec la ville préférée
                if ville_preference == ville_filiere:
                    score = 100
                elif ville_preference in ville_filiere or ville_filiere in ville_preference:
                    score = 85
                else:
                    score = 50
            elif not ville_preference:
                # Pas de préférence de ville = flexible
                score = 75

            # 2. Vérifier la distance maximale (approximatif basé sur ville)
            distance_max = profil_features.get('distance_max_km', 0)
            if distance_max > 0:
                # Note: Sans données GPS réelles, on simule basé sur ville
                # En production, utiliser une vraie API de distance
                if ville_preference and ville_filiere and ville_preference == ville_filiere:
                    distance_score = 100
                elif not ville_preference:
                    distance_score = 80
                else:
                    # Pénalité pour distance (approximée)
                    distance_score = max(50, 100 - (distance_max / 100))

                score = (score * 0.6) + (distance_score * 0.4)

            return min(max(score, 0), 100)

        except Exception as e:
            logger.error(f"Erreur dans _score_distance_ville: {str(e)}")
            return 70.0

    def _score_test(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any],
        scores_test: Dict[str, float] = None
    ) -> float:
        """Scorer basé sur les tests d'orientation (legacy, utilisé par l'ancien système)"""
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
        """Générer une justification structurée et claire répondant à 'Pourquoi cette recommandation?'"""

        # Collecter les raisons principales dans l'ordre d'importance
        raisons_principales = self._generer_raisons_principales(
            profil_features,
            filiere,
            ensemble_score
        )

        strengths = self._get_strengths(profil_features, filiere)
        weaknesses = self._get_weaknesses(profil_features, filiere)

        return {
            'score_global': round(ensemble_score, 2),
            'pourquoi_cette_recommandation': {
                'titre': 'Pourquoi cette recommandation ?',
                'raisons': raisons_principales,
                'resume': self._generer_resume_justification(raisons_principales)
            },
            'criteres_analyzes': {
                'test_orientation': {
                    'label': 'Test d\'orientation',
                    'impact': '25% (Principal)',
                    'score': round(self._score_test_alignment(profil_features, filiere, None), 1),
                    'detail': self._get_test_detail(profil_features, filiere)
                },
                'objectifs_secteur': {
                    'label': 'Objectif professionnel & Secteur',
                    'impact': '20% (Principal)',
                    'score': round(self._score_objectifs_secteur(profil_features, filiere), 1),
                    'detail': self._get_objectifs_detail(profil_features, filiere)
                },
                'serie_bac': {
                    'label': 'Série du Bac',
                    'impact': '15%',
                    'score': round(self._score_serie_bac(profil_features, filiere), 1),
                    'detail': f"Votre série \"{profil_features.get('serie_bac')}\" est bien acceptée par cette filière"
                },
                'moyenne_generale': {
                    'label': 'Moyenne générale',
                    'impact': '12%',
                    'score': round(profil_features.get('moyenne_score', 50), 1),
                    'detail': self._get_moyenne_detail(profil_features, filiere)
                },
                'centres_interet': {
                    'label': 'Centres d\'intérêt',
                    'impact': '12%',
                    'score': round(profil_features.get('centres_interet_match', 0.5) * 100, 1),
                    'detail': 'Vos intérêts correspondent aux domaines de cette filière'
                },
                'localisation': {
                    'label': 'Localisation',
                    'impact': '8%',
                    'score': round(self._score_distance_ville(profil_features, filiere), 1),
                    'detail': self._get_localisation_detail(profil_features, filiere)
                },
                'duree_etudes': {
                    'label': 'Durée d\'études',
                    'impact': '5%',
                    'score': round(self._score_duree(profil_features, filiere), 1),
                    'detail': f"Durée: {filiere.get('duree_annees', 3)} ans (votre préférence: max {profil_features.get('duree_max_etudes', 3)} ans)"
                }
            },
            'points_forts': strengths,
            'points_attention': weaknesses,
            'debouches': filiere.get('debouches', []),
            'taux_emploi': filiere.get('taux_emploi', 0),
            'cout_annuel': filiere.get('cout_annuel', 0),
            'type_universite': filiere.get('universite', {}).get('type', '')
        }
    
    def _generer_raisons_principales(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any],
        ensemble_score: float
    ) -> List[str]:
        """
        Générer une liste de raisons principales (max 5) expliquant clairement
        pourquoi cette filière est recommandée
        """
        raisons = []

        # Raison 1: Test d'orientation
        test_score = self._score_test_alignment(profil_features, filiere, None)
        if test_score >= 80:
            raisons.append(
                f"Vos réponses au test d'orientation correspondent excellemment "
                f"aux domaines de cette filière ({round(test_score)}%)"
            )
        elif test_score >= 60:
            raisons.append(
                f"Vos intérêts au test d'orientation s'alignent bien avec cette filière ({round(test_score)}%)"
            )

        # Raison 2: Objectif professionnel
        objectifs_score = self._score_objectifs_secteur(profil_features, filiere)
        secteur = profil_features.get('secteur_vise', '').lower()
        if objectifs_score >= 85:
            raisons.append(
                f"Cette filière correspond directement à votre objectif en {secteur}"
            )
        elif objectifs_score >= 70:
            raisons.append(
                f"Bonne correspondance avec votre secteur visé ({secteur})"
            )

        # Raison 3: Série bac
        serie_score = self._score_serie_bac(profil_features, filiere)
        if serie_score >= 90:
            raisons.append(
                f"Votre série \"{profil_features.get('serie_bac')}\" est prioritaire pour cette filière"
            )
        elif serie_score >= 80:
            raisons.append(
                f"Votre série \"{profil_features.get('serie_bac')}\" est bien acceptée"
            )

        # Raison 4: Moyenne générale
        moyenne = profil_features.get('moyenne_score', 0)
        moyenne_brute = (moyenne / 100) * 20
        moyenne_min = filiere.get('moyenne_min_requise', 10)
        if moyenne >= 75:
            raisons.append(
                f"Votre moyenne ({moyenne_brute:.1f}/20) est excellente pour l'admission"
            )
        elif moyenne >= moyenne_min * 5:
            raisons.append(
                f"Votre moyenne ({moyenne_brute:.1f}/20) dépasse le seuil requis"
            )

        # Raison 5: Localisation ou débouchés
        localisation_score = self._score_distance_ville(profil_features, filiere)
        if localisation_score >= 95:
            ville = filiere.get('universite', {}).get('ville', '')
            raisons.append(
                f"La localisation ({ville}) correspond exactement à votre préférence"
            )

        # Alternative: Débouchés
        if len(raisons) < 4:
            taux_emploi = filiere.get('taux_emploi', 0)
            if taux_emploi >= 80:
                raisons.append(
                    f"Excellent taux d'emploi: {taux_emploi}% des diplômés trouvent un emploi"
                )

        # Durée d'études si compatible
        if len(raisons) < 5:
            duree_score = self._score_duree(profil_features, filiere)
            if duree_score >= 90:
                raisons.append(
                    f"Durée ({filiere.get('duree_annees')} ans) conforme à votre préférence"
                )

        return raisons[:5]  # Max 5 raisons principales

    def _generer_resume_justification(self, raisons: List[str]) -> str:
        """Générer un résumé court des raisons"""
        if not raisons:
            return "Recommandation basée sur analyse multi-critères"

        if len(raisons) == 1:
            return raisons[0]
        elif len(raisons) == 2:
            return f"{raisons[0]}. {raisons[1]}"
        else:
            # Combiner les raisons principales
            return f"{raisons[0]}. {raisons[1]}. Autres facteurs positifs: {', '.join([r[:30] + '...' if len(r) > 30 else r for r in raisons[2:]])}"

    def _get_test_detail(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> str:
        """Détail sur le test d'orientation"""
        test_score = self._score_test_alignment(profil_features, filiere, None)
        if test_score >= 80:
            return f"Excellente correspondance ({round(test_score)}%) avec vos réponses au test"
        elif test_score >= 60:
            return f"Bonne correspondance ({round(test_score)}%) avec le test"
        else:
            return f"Alignement modéré ({round(test_score)}%) avec le test"

    def _get_objectifs_detail(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> str:
        """Détail sur l'alignement objectifs/secteur"""
        secteur = profil_features.get('secteur_vise', '')
        objectifs = profil_features.get('objectifs_professionnels', '')

        if not secteur and not objectifs:
            return "Pas d'objectif spécifique défini"
        elif secteur and objectifs:
            return f"Objectif: {objectifs[:40]}... | Secteur: {secteur}"
        elif secteur:
            return f"Secteur visé: {secteur}"
        else:
            return f"Objectif: {objectifs[:50]}..."

    def _get_moyenne_detail(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> str:
        """Détail sur la moyenne générale"""
        moyenne_score = profil_features.get('moyenne_score', 0)
        moyenne_brute = (moyenne_score / 100) * 20
        moyenne_min = filiere.get('moyenne_min_requise', 10)

        if moyenne_score >= 90:
            return f"Votre moyenne ({moyenne_brute:.1f}/20) est excellente pour l'admission"
        elif moyenne_score >= moyenne_min * 5:
            diff = moyenne_brute - moyenne_min
            return f"Votre moyenne ({moyenne_brute:.1f}/20) dépasse le seuil ({moyenne_min}/20) de {diff:.1f} points"
        else:
            return f"Votre moyenne ({moyenne_brute:.1f}/20) est acceptable"

    def _get_localisation_detail(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any]
    ) -> str:
        """Détail sur la correspondance localisation"""
        ville_pref = profil_features.get('ville_preference', '')
        ville_filiere = filiere.get('universite', {}).get('ville', '')

        if not ville_pref:
            return "Pas de préférence de localisation - flexible"
        elif ville_pref.lower() == ville_filiere.lower():
            return f"Localisation exacte: {ville_filiere} ✓"
        else:
            return f"Localisation: {ville_filiere} (vous préférez: {ville_pref})"

    def _score_parcours_specialisations(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any]
    ) -> float:
        """
        Scorer l'alignement avec les spécialisations et parcours disponibles
        Basé sur: nom du parcours, spécialisation, durée
        """
        try:
            score = 70  # Score neutre favorable
            parcours_list = filiere.get('parcours', [])

            if not parcours_list:
                return score  # Pas de parcours = score neutre

            centres_interet = profil_features.get('centres_interet', [])
            objectifs = profil_features.get('objectifs_professionnels', '').lower()
            duree_preference = profil_features.get('duree_max_etudes', 3)

            # Analyser chaque parcours
            parcours_scores = []

            for parcours in parcours_list:
                parcours_score = 50

                # 1. Match avec spécialisation
                specialisation = parcours.get('specialisation', '').lower()
                if specialisation:
                    # Match avec centres d'intérêt
                    for interet in centres_interet:
                        if interet.lower() in specialisation:
                            parcours_score = max(parcours_score, 85)
                            break

                    # Match avec objectifs professionnels
                    if objectifs and objectifs in specialisation:
                        parcours_score = max(parcours_score, 90)

                # 2. Match avec nom du parcours
                nom_parcours = parcours.get('nom', '').lower()
                if nom_parcours:
                    for interet in centres_interet:
                        if interet.lower() in nom_parcours:
                            parcours_score = max(parcours_score, 80)
                            break

                    if objectifs and objectifs in nom_parcours:
                        parcours_score = max(parcours_score, 88)

                # 3. Vérifier la durée du parcours
                duree_parcours = parcours.get('duree_mois', 0)
                if duree_parcours > 0:
                    # Convertir mois en années
                    duree_annees = duree_parcours / 12

                    if duree_annees <= duree_preference:
                        # Bonus si la durée correspond
                        duree_bonus = max(10, 20 - abs(duree_annees - duree_preference) * 5)
                        parcours_score = (parcours_score * 0.8) + (duree_bonus + 80) * 0.2

                parcours_scores.append(parcours_score)

            # Retourner le meilleur score parmi les parcours
            if parcours_scores:
                score = max(parcours_scores)

            return min(max(score, 0), 100)

        except Exception as e:
            logger.error(f"Erreur dans _score_parcours_specialisations: {str(e)}")
            return 70.0

    def _get_strengths(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> List[str]:
        """Identifier les points forts du match basés sur les critères clés"""
        strengths = []

        # Critère 1: Alignement test d'orientation
        test_alignment = profil_features.get('test_alignment_score', 0.5) * 100
        if test_alignment >= 75:
            strengths.append("Excellente correspondance avec vos réponses au test d'orientation")
        elif test_alignment >= 60:
            strengths.append("Bonne correspondance avec le test d'orientation")

        # Critère 2: Objectifs et secteur
        objectifs_secteur_score = self._score_objectifs_secteur(profil_features, filiere)
        if objectifs_secteur_score >= 85:
            secteur = profil_features.get('secteur_vise', '')
            strengths.append(f"Align directe avec votre objectif en {secteur}")
        elif objectifs_secteur_score >= 70:
            strengths.append("Correspond à votre secteur visé")

        # Critère 3: Série bac
        serie_score = self._score_serie_bac(profil_features, filiere)
        if serie_score >= 90:
            strengths.append(f"Votre série {profil_features.get('serie_bac')} est prioritaire")
        elif serie_score >= 80:
            strengths.append(f"Série {profil_features.get('serie_bac')} bien acceptée")

        # Critère 4: Localisation
        distance_score = self._score_distance_ville(profil_features, filiere)
        if distance_score >= 95:
            strengths.append(f"Localisation: {filiere.get('universite', {}).get('ville')} (exacte)")
        elif distance_score >= 80:
            strengths.append("Localisation compatible avec votre préférence")

        # Critère 5: Moyenne académique
        if profil_features.get('moyenne_score', 0) > 75:
            strengths.append("Votre moyenne est excellente pour cette filière")

        # Critère 6: Débouchés
        if filiere.get('taux_emploi', 0) >= 80:
            strengths.append(f"Très bon taux d'emploi: {filiere.get('taux_emploi')}%")

        # Critère 7: Durée d'études
        duree_score = self._score_duree(profil_features, filiere)
        if duree_score >= 90:
            strengths.append(f"Durée conforme à vos préférences ({filiere.get('duree_annees')} ans)")

        return strengths[:5]  # Limiter à 5 principaux points forts
    
    def _get_weaknesses(self, profil_features: Dict[str, Any], filiere: Dict[str, Any]) -> List[str]:
        """Identifier les faiblesses du match basées sur les critères clés"""
        weaknesses = []

        # Critère 1: Alignement test d'orientation
        test_alignment = profil_features.get('test_alignment_score', 0.5) * 100
        if test_alignment < 40:
            weaknesses.append("Faible correspondance avec vos réponses au test")

        # Critère 2: Objectifs et secteur
        objectifs_secteur_score = self._score_objectifs_secteur(profil_features, filiere)
        if objectifs_secteur_score < 50:
            weaknesses.append("Peu d'alignement avec votre secteur visé")

        # Critère 3: Série bac
        serie_score = self._score_serie_bac(profil_features, filiere)
        if serie_score < 50:
            weaknesses.append("Votre série bac n'est pas prioritaire")

        # Critère 4: Localisation
        distance_score = self._score_distance_ville(profil_features, filiere)
        if distance_score < 60:
            pref_ville = profil_features.get('ville_preference', '')
            filiere_ville = filiere.get('universite', {}).get('ville', '')
            if pref_ville:
                weaknesses.append(f"Localisation: {filiere_ville} (vous préférez {pref_ville})")

        # Critère 5: Durée d'études
        duree_score = self._score_duree(profil_features, filiere)
        if duree_score < 50:
            weaknesses.append(f"Durée ({filiere.get('duree_annees')} ans) dépasse votre préférence")

        # Critère 6: Budget
        budget_score = self._score_budget(profil_features, filiere)
        if budget_score < 40:
            weaknesses.append("Coût annuel significatif par rapport à votre budget")

        # Critère 7: Moyenne académique
        moyenne_min = filiere.get('moyenne_min_requise', 10)
        moyenne_score = profil_features.get('moyenne_score', 50)
        seuil_score = (moyenne_min / 20) * 100
        if moyenne_score < seuil_score:
            weaknesses.append(f"Votre moyenne est légèrement en-dessous du seuil ({moyenne_min}/20)")

        return weaknesses[:4]  # Limiter à 4 principaux points faibles
    
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
