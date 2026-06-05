"""
MOTEUR DE RECOMMANDATIONS
========================
Logique principale pour générer des recommandations intelligentes
en analysant le profil académique et les résultats du test d'orientation.
"""

import logging
import numpy as np
from typing import List, Dict, Optional
from .scoring import ScoringEngine
from .knn_engine import KNNEngine
from .ml_models import MLModels

logger = logging.getLogger(__name__)


class RecommendationEngine:
    """Moteur principal de recommandations"""
    
    def __init__(self):
        self.scoring = ScoringEngine()
        self.knn = KNNEngine()
        self.ml_models = MLModels()
        logger.info("✓ RecommendationEngine initialisé")
    
    
    def generate(self, profil: Dict, filieres: List[Dict], scores_test: Optional[Dict] = None) -> List[Dict]:
        """
        Générer des recommandations pour un profil donné.
        Combine scoring pondéré + scores du test d'orientation.
        
        Args:
            profil: Profil académique de l'utilisateur
            filieres: Liste des filières disponibles
            scores_test: Résultats du test d'orientation (optionnel)
        
        Returns:
            Liste des recommandations triées par score décroissant
        """
        logger.info(f"🎯 Génération de recommandations: {len(filieres)} filières")
        
        recommendations = []
        
        for filiere in filieres:
            try:
                # Calcul du score principal
                score_data = self.scoring.calculate_score(
                    profil=profil,
                    filiere=filiere,
                    scores_test=scores_test
                )
                
                score = score_data['score']
                details = score_data['details']
                
                # Appliquer un boost basé sur KNN si possible
                knn_boost = self._calculate_knn_boost(profil, filiere)
                score_boosted = score * (1 + knn_boost * 0.1)  # max 10% boost
                
                # Générer l'explication
                explanation = self.scoring.generate_explanation(
                    profil=profil,
                    filiere=filiere,
                    details=details
                )
                
                recommendations.append({
                    'filiere_id': filiere.get('id'),
                    'filiere_nom': filiere.get('nom'),
                    'score': round(score_boosted, 2),
                    'score_base': round(score, 2),
                    'explanation': explanation,
                    'factors': {
                        'serie_bac': round(details['serie_bac'], 2),
                        'moyenne_generale': round(details['moyenne_generale'], 2),
                        'centres_interet': round(details['centres_interet'], 2),
                        'competences': round(details['competences'], 2),
                        'scores_test': round(details['scores_test'], 2),
                        'budget': round(details['budget'], 2),
                        'duree': round(details['duree'], 2),
                    }
                })
                
            except Exception as e:
                logger.warning(f"Erreur pour filière {filiere.get('id')}: {str(e)}")
                continue
        
        # Trier par score décroissant
        recommendations.sort(key=lambda x: x['score'], reverse=True)
        
        logger.info(f"✓ {len(recommendations)} recommandations générées avec succès")
        return recommendations
    
    
    def knn_recommend(self, profil: Dict, all_profils: List[Dict], 
                     filieres: List[Dict], k: int = 5) -> List[Dict]:
        """
        Générer des recommandations via KNN.
        Trouve les K profils les plus similaires et recommande leurs filières préférées.
        
        Args:
            profil: Profil cible
            all_profils: Tous les profils dans la BD
            filieres: Liste des filières
            k: Nombre de voisins
        
        Returns:
            Recommandations basées sur la similarité
        """
        logger.info(f"🤖 KNN: recherche des {k} profils similaires parmi {len(all_profils)}")
        
        if len(all_profils) == 0:
            logger.warning("Aucun profil en base de données pour KNN")
            return []
        
        # Trouver les K profils les plus similaires
        similar_profiles = self.knn.find_similar_profiles(
            profil=profil,
            all_profils=all_profils,
            k=min(k, len(all_profils))
        )
        
        logger.info(f"✓ {len(similar_profiles)} profils similaires trouvés")
        
        # Aggreger les scores des filières recommandées par les profils similaires
        filiere_scores = {}
        
        for sim_profile, similarity in similar_profiles:
            # Les filières choisies par les profils similaires reçoivent un score boost
            chosen_ids = sim_profile.get('chosen_filieres', [])
            
            for filiere in filieres:
                filiere_id = filiere.get('id')
                if filiere_id not in filiere_scores:
                    filiere_scores[filiere_id] = 0
                
                # Boost si c'est une filière choisie par un profil similaire
                if filiere_id in chosen_ids:
                    filiere_scores[filiere_id] += similarity * 20  # Poids KNN
        
        # Générer les recommandations finales
        recommendations = []
        for filiere in filieres:
            filiere_id = filiere.get('id')
            base_score = self.scoring.calculate_score(profil, filiere)['score']
            knn_score = filiere_scores.get(filiere_id, 0)
            final_score = (base_score * 0.7) + (knn_score * 0.3)
            
            recommendations.append({
                'filiere_id': filiere_id,
                'filiere_nom': filiere.get('nom'),
                'score': round(final_score, 2),
                'method': 'knn',
                'similar_profiles_count': len([p for p in similar_profiles 
                                               if filiere_id in p[0].get('chosen_filieres', [])])
            })
        
        recommendations.sort(key=lambda x: x['score'], reverse=True)
        return recommendations[:10]  # Top 10
    
    
    def random_forest_recommend(self, profil: Dict, filieres: List[Dict]) -> List[Dict]:
        """
        Utiliser Random Forest pour prédire le succès académique.
        (Demande un entraînement préalable avec des données historiques)
        
        Args:
            profil: Profil de l'utilisateur
            filieres: Filières disponibles
        
        Returns:
            Recommandations avec prédiction de succès
        """
        logger.info(f"🌲 Random Forest: prédiction pour {len(filieres)} filières")
        
        recommendations = []
        
        for filiere in filieres:
            try:
                # Prédire le score de succès (0-100)
                success_score = self.ml_models.predict_success(profil, filiere)
                
                # Score de compatibilité classique
                compat_score = self.scoring.calculate_score(profil, filiere)['score']
                
                # Combinaison des deux scores
                final_score = (compat_score * 0.6) + (success_score * 0.4)
                
                recommendations.append({
                    'filiere_id': filiere.get('id'),
                    'filiere_nom': filiere.get('nom'),
                    'score': round(final_score, 2),
                    'compatibility_score': round(compat_score, 2),
                    'success_probability': round(success_score, 2),
                    'method': 'random_forest'
                })
                
            except Exception as e:
                logger.warning(f"Erreur RF pour filière {filiere.get('id')}: {str(e)}")
                continue
        
        recommendations.sort(key=lambda x: x['score'], reverse=True)
        return recommendations
    
    
    def explain(self, profil: Dict, filiere: Dict) -> Dict:
        """
        Expliquer en détail une recommandation
        
        Returns:
            Explication détaillée avec justifications
        """
        logger.info(f"💡 Explication pour filière {filiere.get('id')}")
        
        score_data = self.scoring.calculate_score(profil, filiere)
        details = score_data['details']
        
        explanation = self.scoring.generate_explanation(profil, filiere, details)
        
        # Ajouter des détails supplémentaires
        explanation['detailed_factors'] = {
            'serie_bac': {
                'user_serie': profil.get('serie_bac'),
                'accepted_series': filiere.get('series_bac_acceptees', []),
                'score': details['serie_bac'],
                'status': 'Compatible ✓' if details['serie_bac'] > 70 else 'À vérifier ⚠'
            },
            'moyenne': {
                'user_moyenne': profil.get('moyenne_generale'),
                'required_moyenne': filiere.get('moyenne_min_requise'),
                'score': details['moyenne_generale'],
                'status': 'Conforme ✓' if details['moyenne_generale'] > 70 else 'À améliorer'
            },
            'centres_interet': {
                'match': details['centres_interet'],
                'user_interests': profil.get('centres_interet', []),
                'program_interests': filiere.get('centres_interet', [])
            },
            'emploi': {
                'taux_emploi': filiere.get('taux_emploi', 'N/A'),
                'debouches': filiere.get('debouches', [])
            }
        }
        
        return explanation
    
    
    def _calculate_knn_boost(self, profil: Dict, filiere: Dict) -> float:
        """
        Calculer le boost KNN pour une filière.
        Utilisé internement pour légèrement augmenter le score
        d'une filière populaire parmi les profils similaires.
        """
        # Simplification : dans la vraie impl, faire KNN complet
        # Pour maintenant, retourner 0 (pas de boost)
        return 0.0
