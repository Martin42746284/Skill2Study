"""
Service de base de données pour récupérer les données d'entraînement
Se connecte à PostgreSQL via la chaîne de connexion
"""

import logging
from datetime import datetime, timedelta
from typing import List, Dict, Any, Optional
import json
from sqlalchemy import text, desc
from sqlalchemy.orm import Session

logger = logging.getLogger(__name__)


class DatabaseService:
    """Service pour accéder à la base de données"""
    
    def __init__(self, session: Session):
        """
        Initialiser le service
        
        Args:
            session: Session SQLAlchemy
        """
        self.session = session
    
    # ────────────────────────────────────────────────────────────────────────
    # RÉCUPÉRATION DES DONNÉES D'ENTRAÎNEMENT
    # ────────────────────────────────────────────────────────────────────────
    
    def get_training_data(self, limit: int = 1000) -> List[Dict[str, Any]]:
        """
        Récupérer les données d'entraînement depuis la base
        
        Returns:
            Liste d'exemples d'entraînement avec profil, filière, et résultats
        """
        try:
            # Requête pour récupérer les recommandations avec leurs profils et filières
            query = """
            SELECT 
                u.id as user_id,
                pa.serie_bac,
                pa.moyenne_generale,
                pa.centres_interet,
                pa.competences,
                pa.budget_max_mensuel,
                pa.distance_max_km,
                pa.duree_max_etudes,
                pa.preference_type_univ,
                r.filiere_id,
                f.nom as filiere_nom,
                f.series_bac_acceptees,
                f.moyenne_min_requise,
                f.centres_interet as f_centres_interet,
                f.competences_requises,
                f.cout_annuel,
                f.duree_annees,
                f.taux_emploi,
                r.score_compatibilite,
                r.created_at,
                -- Estimations : on considère les recommandations sauvegardées comme acceptées
                CASE WHEN r.sauvegardee THEN 1 ELSE 0 END as accepted,
                -- Succès estimé : si plusieurs filieres de la même universite sont sauvegardées
                CASE WHEN COUNT(*) OVER (PARTITION BY u.id) > 1 THEN 1 ELSE 0 END as success,
                -- Engagement estimé : score normalisé 0-1
                (r.score_compatibilite / 100.0) as engagement
            FROM 
                recommendations r
                JOIN users u ON r.user_id = u.id
                JOIN profils_academiques pa ON u.id = pa.user_id
                JOIN filieres f ON r.filiere_id = f.id
            WHERE 
                r.created_at > NOW() - INTERVAL '6 months'
                AND pa.moyenne_generale IS NOT NULL
                AND f.id IS NOT NULL
            ORDER BY 
                r.created_at DESC
            LIMIT :limit
            """
            
            result = self.session.execute(
                text(query),
                {"limit": limit}
            )
            
            training_examples = []
            for row in result:
                try:
                    example = self._format_training_example(row)
                    if example:
                        training_examples.append(example)
                except Exception as e:
                    logger.warning(f"Erreur lors du formatage d'un exemple: {str(e)}")
                    continue
            
            logger.info(f"Récupéré {len(training_examples)} exemples d'entraînement")
            return training_examples
            
        except Exception as e:
            logger.error(f"Erreur lors de la récupération des données: {str(e)}")
            return []
    
    def get_recent_training_data(self, days: int = 30, limit: int = 500) -> List[Dict[str, Any]]:
        """
        Récupérer les données d'entraînement récentes
        
        Args:
            days: Nombre de jours à remonter
            limit: Limite du nombre d'exemples
        """
        try:
            query = f"""
            SELECT 
                u.id as user_id,
                pa.serie_bac,
                pa.moyenne_generale,
                pa.centres_interet,
                pa.competences,
                pa.budget_max_mensuel,
                pa.distance_max_km,
                pa.duree_max_etudes,
                pa.preference_type_univ,
                r.filiere_id,
                f.nom as filiere_nom,
                f.series_bac_acceptees,
                f.moyenne_min_requise,
                f.centres_interet as f_centres_interet,
                f.competences_requises,
                f.cout_annuel,
                f.duree_annees,
                f.taux_emploi,
                r.score_compatibilite,
                CASE WHEN r.sauvegardee THEN 1 ELSE 0 END as accepted,
                CASE WHEN COUNT(*) OVER (PARTITION BY u.id) > 1 THEN 1 ELSE 0 END as success,
                (r.score_compatibilite / 100.0) as engagement
            FROM 
                recommendations r
                JOIN users u ON r.user_id = u.id
                JOIN profils_academiques pa ON u.id = pa.user_id
                JOIN filieres f ON r.filiere_id = f.id
            WHERE 
                r.created_at > NOW() - INTERVAL '{days} days'
            ORDER BY 
                r.created_at DESC
            LIMIT {limit}
            """
            
            result = self.session.execute(text(query))
            
            training_examples = []
            for row in result:
                example = self._format_training_example(row)
                if example:
                    training_examples.append(example)
            
            return training_examples
            
        except Exception as e:
            logger.error(f"Erreur: {str(e)}")
            return []
    
    def _format_training_example(self, row) -> Optional[Dict[str, Any]]:
        """Formater une ligne en exemple d'entraînement"""
        try:
            # Récupérer les valeurs de la ligne
            values = row._mapping if hasattr(row, '_mapping') else dict(row)
            
            # Parser les JSON
            centres_interet = values.get('centres_interet', [])
            if isinstance(centres_interet, str):
                try:
                    centres_interet = json.loads(centres_interet)
                except:
                    centres_interet = []
            
            competences = values.get('competences', {})
            if isinstance(competences, str):
                try:
                    competences = json.loads(competences)
                except:
                    competences = {}
            
            series_bac_acceptees = values.get('series_bac_acceptees', [])
            if isinstance(series_bac_acceptees, str):
                try:
                    series_bac_acceptees = json.loads(series_bac_acceptees)
                except:
                    series_bac_acceptees = []
            
            centres_interet_filiere = values.get('f_centres_interet', [])
            if isinstance(centres_interet_filiere, str):
                try:
                    centres_interet_filiere = json.loads(centres_interet_filiere)
                except:
                    centres_interet_filiere = []
            
            # Normaliser moyenne 0-20 en score 0-100
            moyenne_score = (values.get('moyenne_generale', 10) / 20) * 100
            
            return {
                'profil_features': {
                    'serie_bac': values.get('serie_bac', ''),
                    'moyenne_score': moyenne_score,
                    'centres_interet': centres_interet,
                    'centres_interet_match': self._calculate_similarity(
                        centres_interet,
                        centres_interet_filiere
                    ),
                    'competences_score': self._calculate_competences_score(competences),
                    'budget_max_mensuel': values.get('budget_max_mensuel', 0),
                    'duree_max_etudes': values.get('duree_max_etudes', 3),
                    'distance_max_km': values.get('distance_max_km', 0),
                    'preference_type_univ': values.get('preference_type_univ', 'indifferent')
                },
                'filiere': {
                    'id': values.get('filiere_id'),
                    'nom': values.get('filiere_nom'),
                    'series_bac_acceptees': series_bac_acceptees,
                    'moyenne_min_requise': values.get('moyenne_min_requise', 10),
                    'centres_interet': centres_interet_filiere,
                    'competences_requises': values.get('competences_requises', []),
                    'cout_annuel': values.get('cout_annuel', 0),
                    'duree_annees': values.get('duree_annees', 3),
                    'taux_emploi': values.get('taux_emploi', 0)
                },
                'filiere_id': values.get('filiere_id'),
                'accepted': bool(values.get('accepted', 0)),
                'success': bool(values.get('success', 0)),
                'engagement': float(values.get('engagement', 0.5))
            }
            
        except Exception as e:
            logger.error(f"Erreur formatage: {str(e)}")
            return None
    
    # ────────────────────────────────────────────────────────────────────────
    # STATISTIQUES
    # ────────────────────────────────────────────────────────────────────────
    
    def get_statistics(self) -> Dict[str, Any]:
        """Récupérer les statistiques de la base"""
        try:
            stats = {}
            
            # Nombre d'utilisateurs
            result = self.session.execute(
                text("SELECT COUNT(*) as count FROM users")
            )
            stats['total_users'] = result.scalar() or 0
            
            # Nombre de profils complétés
            result = self.session.execute(
                text("SELECT COUNT(*) as count FROM profils_academiques")
            )
            stats['complete_profiles'] = result.scalar() or 0
            
            # Nombre de recommandations
            result = self.session.execute(
                text("SELECT COUNT(*) as count FROM recommendations")
            )
            stats['total_recommendations'] = result.scalar() or 0
            
            # Nombre de filières
            result = self.session.execute(
                text("SELECT COUNT(*) as count FROM filieres WHERE actif = true")
            )
            stats['total_filieres'] = result.scalar() or 0
            
            # Score moyen des recommandations
            result = self.session.execute(
                text("SELECT AVG(score_compatibilite) as avg_score FROM recommendations")
            )
            stats['avg_recommendation_score'] = float(result.scalar() or 0)
            
            # Taux de sauvegarde des recommandations
            result = self.session.execute(
                text("""
                SELECT 
                    COUNT(*) as total,
                    SUM(CASE WHEN sauvegardee THEN 1 ELSE 0 END) as saved
                FROM recommendations
                """)
            )
            row = result.fetchone()
            if row and row[0] > 0:
                stats['save_rate'] = (row[1] / row[0]) * 100
            else:
                stats['save_rate'] = 0
            
            return stats
            
        except Exception as e:
            logger.error(f"Erreur statistiques: {str(e)}")
            return {}
    
    # ────────────────────────────────────────────────────────────────────────
    # UTILITAIRES
    # ────────────────────────────────────────────────────────────────────────
    
    def _calculate_similarity(self, list1: list, list2: list) -> float:
        """Calculer la similarité Jaccard entre deux listes"""
        if not list1 or not list2:
            return 0.5
        
        set1 = set(s.lower() for s in list1)
        set2 = set(s.lower() for s in list2)
        
        intersection = len(set1 & set2)
        union = len(set1 | set2)
        
        return intersection / union if union > 0 else 0
    
    def _calculate_competences_score(self, competences: dict) -> float:
        """Calculer un score global des compétences"""
        if not competences:
            return 50.0
        
        scores = []
        for level in competences.values():
            if isinstance(level, (int, float)):
                score = (level / 5) * 100
                scores.append(score)
        
        return sum(scores) / len(scores) if scores else 50.0
    
    def test_connection(self) -> bool:
        """Tester la connexion"""
        try:
            result = self.session.execute(text("SELECT 1"))
            logger.info("Connexion à la base de données OK")
            return True
        except Exception as e:
            logger.error(f"Erreur connexion: {str(e)}")
            return False
