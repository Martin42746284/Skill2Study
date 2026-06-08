"""
Service de préparation des données pour les modèles ML
- Normalisation des features
- Feature engineering
- Gestion des données manquantes
"""

import numpy as np
import pandas as pd
from typing import Dict, List, Any
import logging

logger = logging.getLogger(__name__)


class DataProcessor:
    """Classe pour traiter et normaliser les données académiques"""
    
    def __init__(self):
        """Initialiser le processeur de données"""
        self.scaler = None
        self.feature_names = [
            'moyenne_score',
            'centres_interet_match',
            'competences_score',
            'budget_max_mensuel',
            'duree_max_etudes',
        ]
    
    # ────────────────────────────────────────────────────────────────────────
    # PRÉPARATION DES FEATURES
    # ────────────────────────────────────────────────────────────────────────
    
    def prepare_profil_features(self, profil: Dict[str, Any]) -> Dict[str, Any]:
        """
        Préparer les features d'un profil académique pour les modèles ML

        Input:
        {
            "serie_bac": "S",
            "moyenne_generale": 15.5,
            "centres_interet": ["informatique", "science"],
            "competences": {"logique": 4, "communication": 3},
            "budget_max_mensuel": 500,
            "duree_max_etudes": 4,
            "distance_max_km": 100,
            "objectifs_professionnels": "Devenir ingénieur informatique",
            "secteur_vise": "Informatique",
            "preference_type_univ": "publique",
            "ville_preference": "Antananarivo",
            "test_responses": {...}  # Réponses brutes du test
        }

        Output:
        {
            "serie_bac": "S",
            "moyenne_score": 77.5,  # Normalisé 0-100
            "centres_interet_match": 0.8,  # Similarity score 0-1
            "competences_score": 75.0,  # Moyen des compétences 0-100
            "budget_max_mensuel": 500,
            "duree_max_etudes": 4,
            "distance_max_km": 100,
            "objectifs_professionnels": "Devenir ingénieur informatique",
            "secteur_vise": "Informatique",
            "preference_type_univ": "publique",
            "ville_preference": "Antananarivo",
            "test_alignment_score": 0.85,  # Basé sur les réponses du test
            "chosen_filieres": []  # Pour tracking
        }
        """
        try:
            features = {}

            # Série bac (conservation)
            features['serie_bac'] = profil.get('serie_bac', '').upper()

            # Normalisé moyenne générale (0-20 → 0-100)
            moyenne = profil.get('moyenne_generale', 10)
            features['moyenne_score'] = self._normalize_moyenne(moyenne)

            # Centres d'intérêt (placeholder, sera comparé avec filière)
            centres_interet = profil.get('centres_interet', [])
            features['centres_interet'] = centres_interet
            features['centres_interet_match'] = 0.5  # Sera calculé vs filière

            # Compétences (normaliser 1-5 → 0-100)
            competences = profil.get('competences', {})
            features['competences_score'] = self._calculate_competences_score(competences)

            # Contraintes
            features['budget_max_mensuel'] = max(profil.get('budget_max_mensuel', 0), 0)
            features['duree_max_etudes'] = max(profil.get('duree_max_etudes', 3), 1)
            features['distance_max_km'] = max(profil.get('distance_max_km', 0), 0)

            # Type d'université préféré
            features['preference_type_univ'] = profil.get('preference_type_univ', 'indifferent').lower()

            # Ville préférée
            features['ville_preference'] = profil.get('ville_preference', '').lower()

            # Données pour tracking - CRITÈRES CLÉS POUR LA RECOMMANDATION
            features['objectifs_professionnels'] = profil.get('objectifs_professionnels', '')
            features['secteur_vise'] = profil.get('secteur_vise', '').lower()

            # Score d'alignement avec les réponses du test
            test_responses = profil.get('test_responses', {})
            features['test_alignment_score'] = self._calculate_test_alignment(
                centres_interet,
                test_responses
            )

            features['chosen_filieres'] = profil.get('chosen_filieres', [])

            return features

        except Exception as e:
            logger.error(f"Erreur lors de la préparation des features: {str(e)}")
            return self._get_default_features()
    
    def prepare_batch_profils(self, profils: List[Dict[str, Any]]) -> pd.DataFrame:
        """
        Préparer un batch de profils pour l'entraînement
        Retourne un DataFrame avec toutes les features
        """
        try:
            features_list = []
            
            for profil in profils:
                features = self.prepare_profil_features(profil)
                features_list.append(features)
            
            return pd.DataFrame(features_list)
            
        except Exception as e:
            logger.error(f"Erreur lors de la préparation du batch: {str(e)}")
            return pd.DataFrame()
    
    # ────────────────────────────────────────────────────────────────────────
    # NORMALISATION
    # ────────────────────────────────────────────────────────────────────────
    
    def _normalize_moyenne(self, moyenne: float) -> float:
        """
        Normaliser la moyenne générale (0-20) en score 0-100
        """
        try:
            # Clamp entre 0-20
            moyenne_clamped = max(0, min(20, moyenne))
            # Conversion linéaire vers 0-100
            score = (moyenne_clamped / 20) * 100
            return round(score, 2)
        except:
            return 50.0
    
    def _calculate_competences_score(self, competences: Dict[str, float]) -> float:
        """
        Calculer un score global des compétences
        Les compétences sont notées 1-5, on les convertit en 0-100
        """
        try:
            if not competences:
                return 50.0

            scores = []
            for competence, level in competences.items():
                # Niveau 1-5 → 0-100
                score = (level / 5) * 100
                scores.append(score)

            avg_score = np.mean(scores) if scores else 50
            return round(avg_score, 2)

        except:
            return 50.0

    def _calculate_test_alignment(
        self,
        centres_interet: List[str],
        test_responses: Dict[str, Any]
    ) -> float:
        """
        Calculer le score d'alignement basé sur les réponses du test
        Prend en compte toutes les réponses pour un calcul holistique
        """
        try:
            if not test_responses:
                return 0.5

            # Extraire les scores de test par catégorie
            test_scores = test_responses.get('scores_par_categorie', {})
            if not test_scores:
                return 0.5

            # Normaliser les scores du test
            scores = []
            for category, score in test_scores.items():
                if score is not None:
                    # Assumer que les scores sont entre 0-100
                    normalized = max(0, min(100, score)) / 100
                    scores.append(normalized)

            # Score moyen du test normalisé
            avg_test_score = np.mean(scores) if scores else 0.5

            # Aligner avec les centres d'intérêt
            interet_alignment = 0.5
            if centres_interet and test_scores:
                # Bonus si les intérêts correspondent aux scores du test
                matching_interests = 0
                for interet in centres_interet:
                    if interet.lower() in [k.lower() for k in test_scores.keys()]:
                        matching_interests += 1
                interet_alignment = (matching_interests / len(centres_interet)) if centres_interet else 0.5

            # Combinaison: 60% score test + 40% alignement intérêts
            final_score = (avg_test_score * 0.6) + (interet_alignment * 0.4)

            return round(final_score, 2)

        except:
            return 0.5
    
    def _calculate_interet_similarity(
        self,
        centres_interet_profil: List[str],
        centres_interet_filiere: List[str]
    ) -> float:
        """
        Calculer la similarité Jaccard entre les centres d'intérêt
        Retourne un score 0-1
        """
        try:
            if not centres_interet_profil or not centres_interet_filiere:
                return 0.5  # Score neutre par défaut
            
            # Convertir en sets lowercase pour comparaison
            set_profil = set(s.lower() for s in centres_interet_profil)
            set_filiere = set(s.lower() for s in centres_interet_filiere)
            
            # Jaccard similarity
            intersection = len(set_profil & set_filiere)
            union = len(set_profil | set_filiere)
            
            similarity = intersection / union if union > 0 else 0
            return round(similarity, 2)
            
        except:
            return 0.5
    
    # ────────────────────────────────────────────────────────────────────────
    # PRÉPARATION POUR ENTRAÎNEMENT
    # ────────────────────────────────────────────────────────────────────────
    
    def prepare_training_data(
        self,
        training_examples: List[Dict[str, Any]]
    ) -> tuple:
        """
        Préparer les données d'entraînement pour les modèles ML
        
        Input:
        [
            {
                "profil_features": {...},
                "filiere_id": 1,
                "accepted": True,  # Admis à cette filière
                "success": True,   # Réussite/satisfaction
                "engagement": 0.8  # Niveau d'engagement (0-1)
            }
        ]
        
        Returns:
        (X, y_accept, y_success, y_engagement) - matrices pour l'entraînement
        """
        try:
            X = []
            y_accept = []
            y_success = []
            y_engagement = []
            
            for example in training_examples:
                features = example.get('profil_features', {})
                
                # Vecteur de features
                feature_vector = [
                    features.get('moyenne_score', 50),
                    features.get('centres_interet_match', 0.5),
                    features.get('competences_score', 50),
                    features.get('budget_max_mensuel', 500),
                    features.get('duree_max_etudes', 3),
                ]
                
                X.append(feature_vector)
                y_accept.append(1 if example.get('accepted', False) else 0)
                y_success.append(1 if example.get('success', False) else 0)
                y_engagement.append(example.get('engagement', 0.5))
            
            return np.array(X), np.array(y_accept), np.array(y_success), np.array(y_engagement)
            
        except Exception as e:
            logger.error(f"Erreur lors de la préparation des données d'entraînement: {str(e)}")
            return np.array([]), np.array([]), np.array([]), np.array([])
    
    def prepare_filiere_features(self, filiere: Dict[str, Any]) -> Dict[str, Any]:
        """
        Préparer les features d'une filière
        """
        try:
            features = {
                'id': filiere.get('id'),
                'nom': filiere.get('nom'),
                'series_bac_acceptees': filiere.get('series_bac_acceptees', []),
                'moyenne_min_requise': filiere.get('moyenne_min_requise', 10),
                'centres_interet': filiere.get('centres_interet', []),
                'competences_requises': filiere.get('competences_requises', []),
                'cout_annuel': float(filiere.get('cout_annuel', 0)),
                'duree_annees': int(filiere.get('duree_annees', 3)),
                'taux_emploi': float(filiere.get('taux_emploi', 0)),
                'debouches': filiere.get('debouches', []),
                'universite': filiere.get('universite', {})
            }
            
            return features
            
        except Exception as e:
            logger.error(f"Erreur lors de la préparation des features de filière: {str(e)}")
            return {}
    
    # ────────────────────────────────────────────────────────────────────────
    # GESTION DES DONNÉES MANQUANTES
    # ────────────────────────────────────────────────────────────────────────
    
    def _get_default_features(self) -> Dict[str, Any]:
        """Retourner les features par défaut en cas d'erreur"""
        return {
            'serie_bac': '',
            'moyenne_score': 50,
            'centres_interet': [],
            'centres_interet_match': 0.5,
            'competences_score': 50,
            'budget_max_mensuel': 0,
            'duree_max_etudes': 3,
            'distance_max_km': 0,
            'preference_type_univ': 'indifferent',
            'ville_preference': '',
            'objectifs_professionnels': '',
            'secteur_vise': '',
            'chosen_filieres': []
        }
    
    def handle_missing_values(self, df: pd.DataFrame) -> pd.DataFrame:
        """
        Gérer les valeurs manquantes dans un DataFrame
        """
        try:
            # Remplir les colonnes numériques avec la médiane
            numeric_columns = df.select_dtypes(include=[np.number]).columns
            for col in numeric_columns:
                df[col].fillna(df[col].median(), inplace=True)
            
            # Remplir les colonnes catégorielles avec le mode
            categorical_columns = df.select_dtypes(include=['object']).columns
            for col in categorical_columns:
                df[col].fillna(df[col].mode()[0], inplace=True)
            
            return df
            
        except Exception as e:
            logger.error(f"Erreur lors de la gestion des valeurs manquantes: {str(e)}")
            return df
    
    # ────────────────────────────────────────────────────────────────────────
    # ANALYSE EXPLORATOIRE
    # ────────────────────────────────────────────────────────────────────────
    
    def analyze_data_distribution(self, profils: List[Dict[str, Any]]) -> Dict[str, Any]:
        """
        Analyser la distribution des données
        Utile pour comprendre les biais et la qualité des données
        """
        try:
            df = self.prepare_batch_profils(profils)
            
            analysis = {
                'total_profils': len(df),
                'missing_values': df.isnull().sum().to_dict(),
                'statistics': {
                    'moyenne_score': {
                        'mean': df['moyenne_score'].mean(),
                        'std': df['moyenne_score'].std(),
                        'min': df['moyenne_score'].min(),
                        'max': df['moyenne_score'].max()
                    },
                    'competences_score': {
                        'mean': df['competences_score'].mean(),
                        'std': df['competences_score'].std(),
                    },
                    'budget_max_mensuel': {
                        'mean': df['budget_max_mensuel'].mean(),
                        'median': df['budget_max_mensuel'].median(),
                    }
                }
            }
            
            return analysis
            
        except Exception as e:
            logger.error(f"Erreur lors de l'analyse: {str(e)}")
            return {}
    
    # ────────────────────────────────────────────────────────────────────────
    # FEATURE ENGINEERING AVANCÉ
    # ────────────────────────────────────────────────────────────────────────
    
    def create_interaction_features(
        self,
        profil_features: Dict[str, Any],
        filiere: Dict[str, Any]
    ) -> Dict[str, Any]:
        """
        Créer des features d'interaction entre profil et filière
        Ces features capturent les interactions complexes
        """
        try:
            interaction_features = {}
            
            # Interaction: Moyenne vs Seuil requis
            moyenne_score = profil_features.get('moyenne_score', 50)
            seuil_requis = filiere.get('moyenne_min_requise', 10)
            seuil_score = self._normalize_moyenne(seuil_requis)
            interaction_features['moyenne_vs_seuil'] = moyenne_score - seuil_score
            
            # Interaction: Budget vs Coût
            budget = profil_features.get('budget_max_mensuel', 1)
            cout_annuel = filiere.get('cout_annuel', 0)
            cout_mensuel = cout_annuel / 12 if cout_annuel > 0 else 0
            interaction_features['budget_ratio'] = budget / (cout_mensuel + 1)
            
            # Interaction: Durée vs Préférence
            duree_max = profil_features.get('duree_max_etudes', 3)
            duree_filiere = filiere.get('duree_annees', 3)
            interaction_features['duree_compatibility'] = duree_max / duree_filiere if duree_filiere > 0 else 1
            
            # Interaction: Centres d'intérêt et compétences
            centres_interet_profil = profil_features.get('centres_interet', [])
            centres_interet_filiere = filiere.get('centres_interet', [])
            interaction_features['interet_competence_alignment'] = self._calculate_interet_similarity(
                centres_interet_profil,
                centres_interet_filiere
            )
            
            return interaction_features
            
        except Exception as e:
            logger.error(f"Erreur lors de la création des features d'interaction: {str(e)}")
            return {}
    
    def extract_temporal_features(self, profil: Dict[str, Any]) -> Dict[str, Any]:
        """
        Extraire les features temporelles (année bac, etc.)
        """
        try:
            temporal_features = {}
            
            # Année du bac
            annee_bac = profil.get('annee_bac', 2023)
            temporal_features['annee_bac'] = annee_bac
            
            # Mention au bac
            mention_map = {
                'Passable': 1,
                'Assez bien': 2,
                'Bien': 3,
                'Très bien': 4
            }
            mention = profil.get('mention', 'Passable')
            temporal_features['mention_score'] = mention_map.get(mention, 1)
            
            return temporal_features
            
        except Exception as e:
            logger.error(f"Erreur lors de l'extraction des features temporelles: {str(e)}")
            return {}
