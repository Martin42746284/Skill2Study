#!/usr/bin/env python3
"""
Script de test pour l'API du Service IA
Permet de tester les endpoints sans passer par Node.js
"""

import requests
import json
import sys

BASE_URL = "http://localhost:5000"

# Couleurs pour le terminal
GREEN = '\033[92m'
RED = '\033[91m'
YELLOW = '\033[93m'
BLUE = '\033[94m'
RESET = '\033[0m'

def print_success(msg):
    print(f"{GREEN}✓ {msg}{RESET}")

def print_error(msg):
    print(f"{RED}✗ {msg}{RESET}")

def print_info(msg):
    print(f"{BLUE}ℹ {msg}{RESET}")

def print_warning(msg):
    print(f"{YELLOW}⚠ {msg}{RESET}")

def test_health():
    """Test du health check"""
    print("\n" + "="*60)
    print(f"{BLUE}TEST 1: Health Check{RESET}")
    print("="*60)
    
    try:
        response = requests.get(f"{BASE_URL}/health", timeout=5)
        if response.status_code == 200:
            data = response.json()
            print_success(f"Service IA disponible : {data.get('service')}")
            print_info(f"Status: {data.get('status')}")
            print_info(f"Models loaded: {data.get('models_loaded')}")
            return True
        else:
            print_error(f"Erreur HTTP {response.status_code}")
            return False
    except requests.exceptions.ConnectionError:
        print_error(f"Impossible de se connecter à {BASE_URL}")
        print_warning("Assurez-vous que le service IA est en cours d'exécution")
        return False
    except Exception as e:
        print_error(f"Erreur: {str(e)}")
        return False


def test_generate_recommendations():
    """Test de génération de recommandations"""
    print("\n" + "="*60)
    print(f"{BLUE}TEST 2: Génération de Recommandations{RESET}")
    print("="*60)
    
    # Profil de test
    test_profil = {
        "serie_bac": "Sciences",
        "moyenne_generale": 16.5,
        "centres_interet": ["informatique", "innovation", "recherche"],
        "competences": {
            "mathematiques": 5,
            "logique": 4,
            "communication": 3,
            "creativity": 4
        },
        "budget_max_mensuel": 2000,
        "duree_max_etudes": 3,
        "scores_test": {
            "informatique": 85,
            "sciences": 90,
            "gestion": 70,
            "langues": 65
        }
    }
    
    # Filières de test
    test_filieres = [
        {
            "id": 1,
            "nom": "Licence Informatique",
            "series_bac_acceptees": ["Sciences", "Technique"],
            "moyenne_min_requise": 12,
            "centres_interet": ["informatique", "recherche", "innovation"],
            "competences_requises": ["mathematiques", "logique"],
            "cout_annuel": 0,
            "duree_annees": 3,
            "taux_emploi": 92,
            "debouches": ["Développeur", "Administrateur réseau", "Data Scientist"]
        },
        {
            "id": 2,
            "nom": "Licence Mathématiques",
            "series_bac_acceptees": ["Sciences"],
            "moyenne_min_requise": 14,
            "centres_interet": ["mathematiques", "recherche"],
            "competences_requises": ["mathematiques", "logique"],
            "cout_annuel": 0,
            "duree_annees": 3,
            "taux_emploi": 75,
            "debouches": ["Actuaire", "Enseignant", "Analyste"]
        },
        {
            "id": 3,
            "nom": "Master Management",
            "series_bac_acceptees": ["Sciences", "Economie"],
            "moyenne_min_requise": 10,
            "centres_interet": ["gestion", "management"],
            "competences_requises": ["communication", "organisation"],
            "cout_annuel": 5000,
            "duree_annees": 2,
            "taux_emploi": 88,
            "debouches": ["Manager", "Consultant", "Entrepreneur"]
        },
        {
            "id": 4,
            "nom": "Master Biologie",
            "series_bac_acceptees": ["Sciences"],
            "moyenne_min_requise": 13,
            "centres_interet": ["sciences", "biologie"],
            "competences_requises": ["sciences", "logique"],
            "cout_annuel": 2000,
            "duree_annees": 2,
            "taux_emploi": 80,
            "debouches": ["Chercheur", "Biologiste", "Pharmacien"]
        }
    ]
    
    payload = {
        "profil": test_profil,
        "filieres": test_filieres,
        "scores_test": test_profil["scores_test"]
    }
    
    try:
        print_info("Envoi de la requête au service IA...")
        response = requests.post(
            f"{BASE_URL}/api/recommendations/generate",
            json=payload,
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print_success(f"{data['count']} recommandations générées")
                print("\nTop 3 filières recommandées :")
                for i, rec in enumerate(data.get('recommendations', [])[:3], 1):
                    print(f"\n  {i}. {rec['filiere_nom']} (Score: {rec['score']})")
                    if 'explanation' in rec and 'points_forts' in rec['explanation']:
                        for point in rec['explanation']['points_forts'][:2]:
                            print(f"     ✓ {point}")
                return True
            else:
                print_error(f"Erreur: {data.get('message')}")
                return False
        else:
            print_error(f"Erreur HTTP {response.status_code}")
            print_info(f"Response: {response.text}")
            return False
            
    except requests.exceptions.Timeout:
        print_error("Timeout: le service IA met trop de temps à répondre")
        return False
    except Exception as e:
        print_error(f"Erreur: {str(e)}")
        return False


def test_feature_importance():
    """Test de l'importance des features"""
    print("\n" + "="*60)
    print(f"{BLUE}TEST 3: Feature Importance{RESET}")
    print("="*60)
    
    try:
        response = requests.get(
            f"{BASE_URL}/api/feature-importance",
            timeout=5
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                importance = data.get('feature_importance', {})
                if importance:
                    print_success("Features importance disponible")
                    for feature, score in importance.items():
                        print(f"  {feature}: {score}")
                    return True
                else:
                    print_warning("Pas de modèles entraînés (c'est normal si c'est la première utilisation)")
                    return True
            else:
                print_error(f"Erreur: {data.get('error')}")
                return False
        else:
            print_error(f"Erreur HTTP {response.status_code}")
            return False
            
    except Exception as e:
        print_error(f"Erreur: {str(e)}")
        return False


def main():
    print(f"\n{BLUE}╔{'═'*58}╗{RESET}")
    print(f"{BLUE}║  Test API - Service IA Skill2Study{' '*23}║{RESET}")
    print(f"{BLUE}╚{'═'*58}╝{RESET}")
    
    results = []
    
    # Exécuter les tests
    results.append(("Health Check", test_health()))
    
    if results[0][1]:  # Si health check passe
        results.append(("Recommandations", test_generate_recommendations()))
        results.append(("Feature Importance", test_feature_importance()))
    else:
        print_warning("\nImpossible de continuer les tests car le service IA n'est pas accessible")
    
    # Résumé
    print("\n" + "="*60)
    print(f"{BLUE}RÉSUMÉ DES TESTS{RESET}")
    print("="*60)
    
    passed = sum(1 for _, result in results if result)
    total = len(results)
    
    for test_name, result in results:
        status = f"{GREEN}PASS{RESET}" if result else f"{RED}FAIL{RESET}"
        print(f"  {test_name}: {status}")
    
    print(f"\nTotal: {passed}/{total} tests réussis")
    
    if passed == total:
        print_success("Tous les tests sont passés ! ✓")
        return 0
    else:
        print_error(f"{total - passed} test(s) échoué(s)")
        return 1


if __name__ == "__main__":
    sys.exit(main())
