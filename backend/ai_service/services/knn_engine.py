"""
ENGINE KNN
=========
Implémentation de K-Nearest Neighbors pour trouver des profils similaires.
Utilisé pour améliorer les recommandations en s'appuyant sur des profils similaires.
"""

import logging
import numpy as np
from typing import List, Tuple, Dict
from sklearn.preprocessing import StandardScaler
from sklearn.metrics.pairwise import cosine_similarity

logger = logging.getLogger(__name__)


class KNNEngine:
    """Engine KNN pour similarité entre profils"""
    
    def __init__(self):
        self.scaler = StandardScaler()
        logger.info("✓ KNNEngine initialisé")
    
    
    def find_similar_profiles(self, profil: Dict, all_profils: List[Dict], 
                             k: int = 5) -> List[Tuple[Dict, float]]:
        """
        Trouver les K profils les plus similaires au profil donné.
        
        Args:
            profil: Profil cible
            all_profils: Tous les profils disponibles
            k: Nombre de profils à retourner
        
        Returns:
            Liste de tuples (profil_similaire, score_similarité)
            Trié par similarité décroissante
        """
        if len(all_profils) == 0:
            return []
        
        logger.info(f"KNN: Recherche de {k} profils similaires parmi {len(all_profils)}")
        
        try:
            # Vectoriser le profil cible
            target_vector = self._vectorize_profile(profil)
            
            if target_vector is None:
                logger.warning("Impossible de vectoriser le profil cible")
                return []
            
            # Vectoriser tous les profils
            all_vectors = []
            valid_profils = []
            
            for other_profil in all_profils:
                vector = self._vectorize_profile(other_profil)
                if vector is not None:
                    all_vectors.append(vector)
                    valid_profils.append(other_profil)
            
            if not all_vectors:
                logger.warning("Aucun profil valide à comparer")
                return []
            
            # Reshaper pour sklearn
            all_vectors = np.array(all_vectors)
            target_vector = target_vector.reshape(1, -1)
            
            # Calculer les similarités cosinus
            similarities = cosine_similarity(target_vector, all_vectors)[0]
            
            # Obtenir les indices des K plus proches (excluant le profil lui-même)
            k_indices = np.argsort(similarities)[::-1][:k]
            
            # Retourner les K profils les plus similaires avec leur score
            results = []
            for idx in k_indices:
                results.append((valid_profils[idx], float(similarities[idx])))
            
            logger.info(f"✓ {len(results)} profils similaires trouvés")
            return results
            
        except Exception as e:
            logger.error(f"Erreur KNN: {str(e)}")
            return []
    
    
    def _vectorize_profile(self, profil: Dict) -> np.ndarray:
        """
        Convertir un profil en vecteur numérique pour calcul de similarité.

        Features:
        - moyenne_generale
        - centres_interet (one-hot encoding)
        - competences (moyenne des scores)
        - duree_max_etudes
        """
        try:
            features = []
            
            # 1. Moyenne générale (normalisée 0-20)
            moyenne = float(profil.get('moyenne_generale', 10.0))
            features.append(moyenne / 20.0)
            
            # 2. Compétences (moyenne des scores 1-5)
            competences = profil.get('competences', {})
            if competences:
                comp_scores = [v for v in competences.values() if isinstance(v, (int, float))]
                comp_mean = sum(comp_scores) / len(comp_scores) / 5.0 if comp_scores else 0.5
            else:
                comp_mean = 0.5
            features.append(comp_mean)
            
            # 3. Centres d'intérêt (nombre normalisé)
            interests = profil.get('centres_interet', [])
            features.append(min(len(interests) / 5.0, 1.0))  # Max 5 intérêts

            # 4. Durée max études
            duree = float(profil.get('duree_max_etudes', 3.0))
            features.append(min(duree / 6.0, 1.0))  # Max 6 ans

            # 5. Nombre de filières choisies
            chosen_filieres = profil.get('chosen_filieres', [])
            features.append(min(len(chosen_filieres) / 5.0, 1.0))
            
            # 7-12. One-hot pour séries bac communes
            serie = profil.get('serie_bac', '').lower()
            series_possibles = ['sciences', 'mathematiques', 'technique', 'lettres', 'economie']
            for s in series_possibles:
                features.append(1.0 if s in serie else 0.0)
            
            # 13. Scores du test (moyenne)
            scores_test = profil.get('scores_test', {})
            if scores_test:
                test_scores = [v for v in scores_test.values() if isinstance(v, (int, float))]
                test_mean = sum(test_scores) / len(test_scores) / 100.0 if test_scores else 0.5
            else:
                test_mean = 0.5
            features.append(test_mean)
            
            return np.array(features, dtype=np.float32)
            
        except Exception as e:
            logger.warning(f"Erreur vectorisation profil: {str(e)}")
            return None
    
    
    @staticmethod
    def calculate_profile_distance(profil1: Dict, profil2: Dict) -> float:
        """
        Calculer la distance (dissimilarité) entre deux profils.
        Retourne un score 0-1 (0 = très similaire, 1 = très différent)
        """
        distance = 0.0
        weight_count = 0
        
        # Comparer les moyennes (poids 2)
        if 'moyenne_generale' in profil1 and 'moyenne_generale' in profil2:
            m1 = float(profil1['moyenne_generale'])
            m2 = float(profil2['moyenne_generale'])
            distance += (abs(m1 - m2) / 20.0) * 2
            weight_count += 2
        
        # Comparer les centres d'intérêt (poids 2)
        interests1 = set(str(i).lower() for i in profil1.get('centres_interet', []))
        interests2 = set(str(i).lower() for i in profil2.get('centres_interet', []))
        if interests1 or interests2:
            intersection = len(interests1 & interests2)
            union = len(interests1 | interests2)
            jaccard = intersection / union if union > 0 else 0
            distance += (1 - jaccard) * 2
            weight_count += 2
        
        # Comparer les séries bac (poids 1)
        serie1 = profil1.get('serie_bac', '').lower()
        serie2 = profil2.get('serie_bac', '').lower()
        distance += (0.0 if serie1 == serie2 else 1.0) * 1
        weight_count += 1
        
        return distance / weight_count if weight_count > 0 else 0.5
