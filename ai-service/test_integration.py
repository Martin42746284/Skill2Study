"""
Script de test pour valider l'intégration du service IA avec le backend Node.js
"""

import requests
import json
import time
from typing import Dict, Any

BASE_URL = "http://localhost:5000"
BACKEND_URL = "http://localhost:3000/api"

class TestAIService:
    """Tester le service IA"""
    
    def __init__(self):
        self.session = requests.Session()
        self.results = []
    
    def test_health(self):
        """Test 1: Vérifier que le service est en ligne"""
        print("\n" + "="*60)
        print("TEST 1: Health Check")
        print("="*60)
        
        try:
            response = self.session.get(f"{BASE_URL}/health")
            assert response.status_code == 200
            data = response.json()
            assert data['status'] == 'ok'
            
            print("✓ Service en ligne")
            print(f"  Service: {data.get('service')}")
            print(f"  Version: {data.get('version')}")
            self.results.append(("Health Check", True))
            return True
            
        except Exception as e:
            print(f"✗ Erreur: {str(e)}")
            self.results.append(("Health Check", False))
            return False
    
    def test_weighted_scoring(self):
        """Test 2: Scoring pondéré basique"""
        print("\n" + "="*60)
        print("TEST 2: Weighted Scoring")
        print("="*60)
        
        try:
            payload = {
                "profil": {
                    "serie_bac": "S",
                    "moyenne_generale": 16.0,
                    "centres_interet": ["informatique", "science"],
                    "competences": {
                        "logique": 5,
                        "communication": 3,
                        "creativite": 4
                    },
                    "budget_max_mensuel": 600,
                    "duree_max_etudes": 3
                },
                "filieres": [
                    {
                        "id": 1,
                        "nom": "Informatique",
                        "series_bac_acceptees": ["S", "STI"],
                        "moyenne_min_requise": 12,
                        "centres_interet": ["informatique", "technologie"],
                        "competences_requises": ["logique", "rigueur"],
                        "cout_annuel": 3000,
                        "duree_annees": 3,
                        "taux_emploi": 92,
                        "debouches": ["Développeur", "Data Scientist"]
                    },
                    {
                        "id": 2,
                        "nom": "Lettres",
                        "series_bac_acceptees": ["ES", "L"],
                        "moyenne_min_requise": 10,
                        "centres_interet": ["litterature", "histoire"],
                        "competences_requises": ["communication", "analyse"],
                        "cout_annuel": 2000,
                        "duree_annees": 3,
                        "taux_emploi": 75,
                        "debouches": ["Professeur", "Journaliste"]
                    }
                ]
            }
            
            response = self.session.post(
                f"{BASE_URL}/api/recommendations/generate",
                json=payload
            )
            
            assert response.status_code == 200
            data = response.json()
            assert data['success'] is True
            assert len(data['recommendations']) > 0
            
            # Vérifier que l'informatique est en haut (mieux aligné)
            top_rec = data['recommendations'][0]
            print(f"✓ Recommandation top: {top_rec['nom']} (score: {top_rec['score']})")
            print(f"  Détails des scores:")
            for method, score in top_rec['scores_details'].items():
                print(f"    - {method}: {score}")
            
            self.results.append(("Weighted Scoring", True))
            return True
            
        except Exception as e:
            print(f"✗ Erreur: {str(e)}")
            self.results.append(("Weighted Scoring", False))
            return False
    
    def test_ml_ensemble(self):
        """Test 3: ML Ensemble (KNN + Random Forest + Scoring)"""
        print("\n" + "="*60)
        print("TEST 3: ML Ensemble")
        print("="*60)
        
        try:
            payload = {
                "profil": {
                    "serie_bac": "ES",
                    "moyenne_generale": 14.5,
                    "centres_interet": ["economie", "commerce"],
                    "competences": {
                        "communication": 4,
                        "organisation": 5,
                        "leadership": 4
                    },
                    "budget_max_mensuel": 500,
                    "duree_max_etudes": 3
                },
                "filieres": [
                    {
                        "id": 3,
                        "nom": "Gestion-Commerce",
                        "series_bac_acceptees": ["ES", "S"],
                        "moyenne_min_requise": 11,
                        "centres_interet": ["economie", "commerce", "management"],
                        "competences_requises": ["organisation", "leadership"],
                        "cout_annuel": 2500,
                        "duree_annees": 3,
                        "taux_emploi": 85,
                        "debouches": ["Manager", "Entrepreneur"]
                    }
                ]
            }
            
            response = self.session.post(
                f"{BASE_URL}/api/recommendations/generate",
                json=payload
            )
            
            assert response.status_code == 200
            data = response.json()
            
            print(f"✓ Recommandations générées ({len(data['recommendations'])})")
            
            if data['recommendations']:
                rec = data['recommendations'][0]
                print(f"  Top: {rec['nom']} - Score: {rec['score']}")
                print(f"  Justification: {rec['justification']['score_global']}")
            
            self.results.append(("ML Ensemble", True))
            return True
            
        except Exception as e:
            print(f"✗ Erreur: {str(e)}")
            self.results.append(("ML Ensemble", False))
            return False
    
    def test_feature_importance(self):
        """Test 4: Feature Importance"""
        print("\n" + "="*60)
        print("TEST 4: Feature Importance")
        print("="*60)
        
        try:
            response = self.session.get(f"{BASE_URL}/api/feature-importance")
            
            assert response.status_code == 200
            data = response.json()
            assert data['success'] is True
            
            importance = data.get('feature_importance', {})
            print("✓ Feature importance obtenue")
            print("\n  Weighted Scoring Importance:")
            for feature, value in importance.get('weighted_scoring', {}).items():
                print(f"    - {feature}: {value:.1%}")
            
            self.results.append(("Feature Importance", True))
            return True
            
        except Exception as e:
            print(f"✗ Erreur: {str(e)}")
            self.results.append(("Feature Importance", False))
            return False
    
    def test_explanation(self):
        """Test 5: Explication détaillée"""
        print("\n" + "="*60)
        print("TEST 5: Explication Détaillée")
        print("="*60)
        
        try:
            payload = {
                "profil": {
                    "serie_bac": "S",
                    "moyenne_generale": 15.5,
                    "centres_interet": ["informatique", "science"],
                    "competences": {
                        "logique": 4,
                        "communication": 3
                    },
                    "budget_max_mensuel": 500,
                    "duree_max_etudes": 4
                },
                "filiere": {
                    "id": 1,
                    "nom": "Informatique",
                    "series_bac_acceptees": ["S"],
                    "moyenne_min_requise": 12,
                    "centres_interet": ["informatique", "technologie"],
                    "competences_requises": ["logique"],
                    "cout_annuel": 3000,
                    "duree_annees": 3,
                    "taux_emploi": 92,
                    "debouches": ["Dev", "Data Scientist"]
                }
            }
            
            response = self.session.post(
                f"{BASE_URL}/api/explain-recommendation",
                json=payload
            )
            
            assert response.status_code == 200
            data = response.json()
            
            if data['success']:
                exp = data['explanation']
                print("✓ Explication générée")
                print(f"\n  Points forts: {exp.get('points_forts', [])}")
                print(f"  Points attention: {exp.get('points_attention', [])}")
                print(f"  Score breakdown: {exp.get('score_breakdown', {})}")
            
            self.results.append(("Explanation", True))
            return True
            
        except Exception as e:
            print(f"✗ Erreur: {str(e)}")
            self.results.append(("Explanation", False))
            return False
    
    def test_performance(self):
        """Test 6: Performance"""
        print("\n" + "="*60)
        print("TEST 6: Performance")
        print("="*60)
        
        try:
            payload = {
                "profil": {
                    "serie_bac": "S",
                    "moyenne_generale": 15.0,
                    "centres_interet": ["informatique"],
                    "competences": {"logique": 4},
                    "budget_max_mensuel": 500,
                    "duree_max_etudes": 3
                },
                "filieres": [
                    {
                        "id": i,
                        "nom": f"Filiere {i}",
                        "series_bac_acceptees": ["S"],
                        "moyenne_min_requise": 10,
                        "centres_interet": ["informatique"],
                        "competences_requises": ["logique"],
                        "cout_annuel": 2000,
                        "duree_annees": 3,
                        "taux_emploi": 80,
                        "debouches": ["Job"]
                    }
                    for i in range(1, 101)  # 100 filières
                ]
            }
            
            start = time.time()
            response = self.session.post(
                f"{BASE_URL}/api/recommendations/generate",
                json=payload
            )
            duration = time.time() - start
            
            assert response.status_code == 200
            
            print(f"✓ Performance: {duration:.2f}s pour 100 filières")
            
            if duration > 2:
                print("  ⚠️  Temps > 2s (seuil recommandé)")
            else:
                print("  ✓ Performance acceptable")
            
            self.results.append(("Performance", True))
            return True
            
        except Exception as e:
            print(f"✗ Erreur: {str(e)}")
            self.results.append(("Performance", False))
            return False
    
    def run_all(self):
        """Exécuter tous les tests"""
        print("\n" + "="*60)
        print("TESTS D'INTÉGRATION DU SERVICE IA")
        print("="*60)
        
        self.test_health()
        self.test_weighted_scoring()
        self.test_ml_ensemble()
        self.test_feature_importance()
        self.test_explanation()
        self.test_performance()
        
        # Résumé
        print("\n" + "="*60)
        print("RÉSUMÉ DES TESTS")
        print("="*60)
        
        for test_name, passed in self.results:
            status = "✓ PASSED" if passed else "✗ FAILED"
            print(f"{test_name:30} {status}")
        
        total = len(self.results)
        passed = sum(1 for _, p in self.results if p)
        print(f"\nTotal: {passed}/{total} tests réussis")
        
        if passed == total:
            print("\n✓ Tous les tests sont passés! Le service est prêt.")
        else:
            print("\n✗ Certains tests ont échoué. Vérifiez la configuration.")
        
        return passed == total

if __name__ == "__main__":
    tester = TestAIService()
    success = tester.run_all()
    exit(0 if success else 1)
