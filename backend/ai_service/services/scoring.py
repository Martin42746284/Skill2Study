"""
ENGINE DE SCORING
================
Calcul des scores de compatibilité entre profil et filière
Combinaison pondérée de multiples critères.
"""

import logging
from typing import Dict, List, Optional
from difflib import SequenceMatcher

logger = logging.getLogger(__name__)


# POIDS PAR DÉFAUT (en %)
POIDS_DEFAUT = {
    'scores_test': 40,          # ⭐ PRINCIPAL: résultats du test
    'compatibilite_serie': 20,  # série bac compatible
    'centres_interet': 15,      # correspondance des intérêts
    'moyenne_generale': 15,     # moyenne vs seuil requis
    'competences': 5,           # compétences auto-évaluées
    'budget': 3,                # coût dans le budget
    'duree': 2,                 # durée dans les préférences
}


class ScoringEngine:
    """Engine pour calculer les scores de compatibilité"""
    
    def __init__(self):
        self.poids = POIDS_DEFAUT
        logger.info("✓ ScoringEngine initialisé")
    
    
    def calculate_score(self, profil: Dict, filiere: Dict, 
                       scores_test: Optional[Dict] = None) -> Dict:
        """
        Calculer le score de compatibilité entre un profil et une filière.
        
        Returns:
            {
                'score': float (0-100),
                'details': { scores partiels pour chaque critère }
            }
        """
        details = {}
        
        # 1. Compatibilité série bac
        details['serie_bac'] = self._score_serie_bac(profil, filiere)
        
        # 2. Moyenne générale
        details['moyenne_generale'] = self._score_moyenne(profil, filiere)
        
        # 3. Centres d'intérêt
        details['centres_interet'] = self._score_centres_interet(profil, filiere)
        
        # 4. Compétences
        details['competences'] = self._score_competences(profil, filiere)
        
        # 5. Budget
        details['budget'] = self._score_budget(profil, filiere)
        
        # 6. Durée
        details['duree'] = self._score_duree(profil, filiere)
        
        # 7. Scores du test (CRITÈRE PRINCIPAL)
        details['scores_test'] = self._score_test(scores_test, filiere)
        
        # Score final pondéré
        score = sum(
            details[criterion] * self.poids[criterion] / 100
            for criterion in self.poids.keys()
        )
        
        return {
            'score': max(0, min(100, score)),  # Clamp entre 0 et 100
            'details': details
        }
    
    
    def _score_serie_bac(self, profil: Dict, filiere: Dict) -> float:
        """Score de compatibilité de la série bac"""
        user_serie = profil.get('serie_bac', '').lower().strip()
        accepted_series = filiere.get('series_bac_acceptees', [])
        
        if not user_serie or not accepted_series:
            return 70.0  # Score neutre si info manquante
        
        accepted_series_lower = [s.lower().strip() for s in accepted_series]
        
        # Chercher une correspondance exacte
        if user_serie in accepted_series_lower:
            idx = accepted_series_lower.index(user_serie)
            if idx == 0:
                return 100.0  # Série prioritaire
            return 85.0  # Série acceptée mais non prioritaire
        
        # Chercher une correspondance partielle (ex: "Sci" dans "Sciences")
        for accepted in accepted_series_lower:
            if user_serie in accepted or accepted in user_serie:
                return 75.0
        
        return 0.0  # Série non acceptée
    
    
    def _score_moyenne(self, profil: Dict, filiere: Dict) -> float:
        """Score de la moyenne générale"""
        user_moyenne = profil.get('moyenne_generale')
        required_moyenne = filiere.get('moyenne_min_requise', 10.0)
        
        if user_moyenne is None:
            return 50.0  # Score neutre
        
        user_moyenne = float(user_moyenne)
        required_moyenne = float(required_moyenne)
        
        if user_moyenne >= required_moyenne + 4:
            return 100.0  # Bien au-dessus du seuil
        elif user_moyenne >= required_moyenne + 2:
            return 85.0   # Au-dessus du seuil
        elif user_moyenne >= required_moyenne:
            return 70.0   # Au seuil
        elif user_moyenne >= required_moyenne - 1:
            return 40.0   # Légèrement en dessous
        else:
            return 10.0   # Bien en dessous
    
    
    def _score_centres_interet(self, profil: Dict, filiere: Dict) -> float:
        """Score de correspondance des centres d'intérêt"""
        user_interests = profil.get('centres_interet', [])
        program_interests = filiere.get('centres_interet', [])
        
        if not user_interests or not program_interests:
            return 50.0
        
        # Normaliser en minuscules
        user_interests = [str(i).lower().strip() for i in user_interests]
        program_interests = [str(i).lower().strip() for i in program_interests]
        
        # Similarité Jaccard
        set_user = set(user_interests)
        set_program = set(program_interests)
        
        if len(set_user | set_program) == 0:
            return 50.0
        
        intersection = len(set_user & set_program)
        union = len(set_user | set_program)
        jaccard_similarity = intersection / union
        
        return jaccard_similarity * 100.0
    
    
    def _score_competences(self, profil: Dict, filiere: Dict) -> float:
        """Score des compétences"""
        user_competences = profil.get('competences', {})
        required_competences = filiere.get('competences_requises', [])
        
        if not required_competences:
            return 60.0
        
        if not user_competences:
            return 40.0
        
        scores = []
        required_competences_lower = [c.lower().strip() for c in required_competences]
        
        for required_comp in required_competences_lower:
            # Chercher dans les compétences évaluées
            found_score = None
            
            for comp_key, comp_value in user_competences.items():
                if comp_key.lower().strip() == required_comp:
                    # Compétence trouvée, normaliser sa note (supposée /5)
                    found_score = (float(comp_value) / 5.0) * 100.0
                    break
            
            if found_score is None:
                # Chercher une correspondance partielle
                for comp_key, comp_value in user_competences.items():
                    if self._string_similarity(comp_key.lower(), required_comp) > 0.7:
                        found_score = (float(comp_value) / 5.0) * 100.0
                        break
            
            if found_score is not None:
                scores.append(found_score)
            else:
                scores.append(40.0)  # Score bas si compétence non évaluée
        
        return sum(scores) / len(scores) if scores else 50.0
    
    
    def _score_budget(self, profil: Dict, filiere: Dict) -> float:
        """Score du budget"""
        user_budget = profil.get('budget_max_mensuel')
        filiere_cost = filiere.get('cout_annuel')
        
        if not user_budget or not filiere_cost:
            return 70.0  # Score neutre
        
        user_budget = float(user_budget)
        filiere_cost = float(filiere_cost)
        monthly_cost = filiere_cost / 12.0
        
        if monthly_cost <= user_budget * 0.7:
            return 100.0  # Bien dans le budget
        elif monthly_cost <= user_budget:
            return 75.0   # Dans le budget
        elif monthly_cost <= user_budget * 1.2:
            return 40.0   # Légèrement au-dessus
        else:
            return 0.0    # Bien au-dessus
    
    
    def _score_duree(self, profil: Dict, filiere: Dict) -> float:
        """Score de la durée des études"""
        user_max_duree = profil.get('duree_max_etudes')
        filiere_duree = filiere.get('duree_annees')
        
        if not user_max_duree or not filiere_duree:
            return 70.0
        
        user_max_duree = float(user_max_duree)
        filiere_duree = float(filiere_duree)
        
        if filiere_duree <= user_max_duree:
            return 100.0
        elif filiere_duree <= user_max_duree + 1:
            return 60.0
        else:
            return 20.0
    
    
    def _score_test(self, scores_test: Optional[Dict], filiere: Dict) -> float:
        """
        Score basé sur les résultats du test d'orientation (CRITÈRE PRINCIPAL).
        Match les scores du test avec les domaines de la filière.
        """
        if not scores_test or len(scores_test) == 0:
            return 50.0  # Score neutre si pas de test
        
        program_interests = filiere.get('centres_interet', [])
        
        if not program_interests:
            # Pas de centres d'intérêt définis : moyenne des scores du test
            test_scores = [v for v in scores_test.values() if isinstance(v, (int, float))]
            return sum(test_scores) / len(test_scores) if test_scores else 50.0
        
        # Matcher les domaines du test avec les intérêts du programme
        program_interests_lower = [p.lower().strip() for p in program_interests]
        matched_scores = []
        
        for test_category, test_score in scores_test.items():
            if isinstance(test_score, (int, float)):
                test_cat_lower = str(test_category).lower().strip()
                
                # Chercher une correspondance exacte
                if test_cat_lower in program_interests_lower:
                    matched_scores.append(float(test_score))
                else:
                    # Chercher une correspondance partielle
                    for prog_interest in program_interests_lower:
                        if self._string_similarity(test_cat_lower, prog_interest) > 0.6:
                            matched_scores.append(float(test_score))
                            break
        
        if matched_scores:
            return sum(matched_scores) / len(matched_scores)
        
        # Pas de match : moyenne générale des scores
        test_scores = [v for v in scores_test.values() if isinstance(v, (int, float))]
        return sum(test_scores) / len(test_scores) if test_scores else 50.0
    
    
    def generate_explanation(self, profil: Dict, filiere: Dict, 
                            details: Dict) -> Dict:
        """Générer une explication humanisée de la recommandation"""
        points_forts = []
        points_attention = []
        
        # Points forts
        if details['serie_bac'] >= 80:
            points_forts.append(
                f"Votre série '{profil.get('serie_bac')}' est bien adaptée à cette filière."
            )
        
        if details['moyenne_generale'] >= 85:
            moyenne = profil.get('moyenne_generale')
            points_forts.append(
                f"Votre moyenne ({moyenne}/20) est excellente pour cette formation."
            )
        
        if details['centres_interet'] >= 70:
            points_forts.append(
                "Vos centres d'intérêt correspondent bien aux domaines de cette filière."
            )
        
        if details['scores_test'] >= 70:
            points_forts.append(
                "Vos résultats au test d'orientation sont très favorables pour cette orientation."
            )
        
        if details['budget'] == 100:
            points_forts.append("Le coût est bien adapté à votre budget.")
        
        # Points d'attention
        if details['serie_bac'] < 50:
            points_attention.append(
                f"⚠ Votre série n'est pas standard pour cette filière. Vérifiez les conditions d'admission."
            )
        
        if details['moyenne_generale'] < 50:
            points_attention.append(
                "⚠ Votre moyenne pourrait être limite pour le seuil d'admission."
            )
        
        if details['centres_interet'] < 30:
            points_attention.append(
                "⚠ Peu de correspondance entre vos intérêts et cette filière."
            )
        
        if details['budget'] == 0:
            cost = filiere.get('cout_annuel', 'N/A')
            points_attention.append(
                f"⚠ Le coût annuel ({cost}€) dépasse votre budget mensuel déclaré."
            )
        
        # Raisons complémentaires
        raisons = []
        taux_emploi = filiere.get('taux_emploi')
        if taux_emploi and taux_emploi >= 80:
            raisons.append(f"Excellent taux d'employabilité ({taux_emploi}%)")
        
        debouches = filiere.get('debouches', [])
        if debouches:
            debouches_str = ', '.join(debouches[:3])
            raisons.append(f"Débouchés variés: {debouches_str}")
        
        return {
            'points_forts': points_forts,
            'points_attention': points_attention,
            'raisons': raisons
        }
    
    
    @staticmethod
    def _string_similarity(a: str, b: str) -> float:
        """Calculer la similarité entre deux chaînes (0-1)"""
        return SequenceMatcher(None, a, b).ratio()
