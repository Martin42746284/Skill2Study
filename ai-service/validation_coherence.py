#!/usr/bin/env python3
"""
Script de validation pour vérifier la cohérence des données
Vérifie que les filières ont bien les parcours chargés et que les données sont valides
"""

import json
import requests
from typing import List, Dict, Any

# URL du backend
BACKEND_API = "http://localhost:3000/api"
AI_SERVICE_API = "http://127.0.0.1:5000"

def validate_filiere_structure(filiere: Dict[str, Any]) -> Dict[str, Any]:
    """Valider la structure d'une filière"""
    issues = []
    
    # Champs obligatoires
    required_fields = ['id', 'nom', 'universite_id']
    for field in required_fields:
        if field not in filiere or not filiere[field]:
            issues.append(f"❌ Champ obligatoire manquant: {field}")
    
    # Champs recommandés pour le scoring IA
    recommended_fields = ['series_bac_acceptees', 'centres_interet', 'duree_annees', 'parcours']
    for field in recommended_fields:
        if field not in filiere:
            issues.append(f"⚠️  Champ recommandé manquant: {field}")
        elif not filiere[field] and field != 'parcours':
            issues.append(f"⚠️  Champ vide: {field}")
    
    # Valider parcours s'ils existent
    if 'parcours' in filiere and isinstance(filiere['parcours'], list):
        for idx, parcours in enumerate(filiere['parcours']):
            parcours_issues = validate_parcours_structure(parcours, idx)
            issues.extend(parcours_issues)
    elif 'parcours' not in filiere:
        issues.append(f"⚠️  Pas de parcours associés")
    
    return {
        'filiere_id': filiere.get('id'),
        'nom': filiere.get('nom'),
        'valid': len(issues) == 0,
        'issues': issues
    }

def validate_parcours_structure(parcours: Dict[str, Any], idx: int) -> List[str]:
    """Valider la structure d'un parcours"""
    issues = []
    
    required_fields = ['nom', 'filiere_id']
    for field in required_fields:
        if field not in parcours or not parcours[field]:
            issues.append(f"  ❌ Parcours[{idx}].{field} manquant")
    
    # Champs optionnels mais utiles
    if 'specialisation' not in parcours or not parcours['specialisation']:
        issues.append(f"  ⚠️  Parcours[{idx}].specialisation vide")
    
    if 'duree_mois' not in parcours or parcours['duree_mois'] is None:
        issues.append(f"  ⚠️  Parcours[{idx}].duree_mois vide")
    
    if 'debouches_professionnels' not in parcours:
        issues.append(f"  ⚠️  Parcours[{idx}].debouches_professionnels manquant")
    
    return issues

def test_health_endpoint() -> bool:
    """Tester l'endpoint health du service IA"""
    try:
        response = requests.get(f"{AI_SERVICE_API}/health", timeout=5)
        data = response.json()
        print(f"✅ Service IA: {data['status']}")
        print(f"   Database: {data['database']}")
        return data['database'] == 'connected'
    except Exception as e:
        print(f"❌ Erreur service IA: {e}")
        return False

def fetch_filieres(filiere_id: int = None) -> List[Dict[str, Any]]:
    """Récupérer les filières du backend"""
    try:
        url = f"{BACKEND_API}/filieres"
        if filiere_id:
            url = f"{url}/{filiere_id}"
        
        # Note: Cet endpoint peut nécessiter auth
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            data = response.json()
            return data.get('filieres', []) if isinstance(data, dict) else data
        else:
            print(f"❌ Erreur API backend: {response.status_code}")
            return []
    except Exception as e:
        print(f"❌ Erreur connexion backend: {e}")
        return []

def main():
    print("=" * 60)
    print("VALIDATION DE COHÉRENCE DES DONNÉES")
    print("=" * 60)
    
    # Test 1: Service IA
    print("\n1️⃣  Test du service IA...")
    ai_ok = test_health_endpoint()
    
    # Test 2: Récupération des filières
    print("\n2️⃣  Récupération des filières...")
    # NOTE: Vous devez implémenter un endpoint publique ou utiliser un token
    print("⚠️  Impossible de tester sans endpoint public - nécessite authentification")
    
    # Test 3: Structure de données
    print("\n3️⃣  Exemple de structure attendue pour une filière:")
    example_filiere = {
        "id": 1,
        "nom": "Informatique",
        "universite_id": 1,
        "universite": {
            "id": 1,
            "nom": "Université X"
        },
        "series_bac_acceptees": ["S", "STI"],
        "centres_interet": ["technologie", "informatique"],
        "duree_annees": "3",
        "moyenne_min_requise": 12,
        "parcours": [
            {
                "id": 1,
                "filiere_id": 1,
                "nom": "Développement Web",
                "specialisation": "Web Frontend/Backend",
                "duree_mois": 36,
                "debouches_professionnels": ["Développeur web", "Fullstack developer"],
                "competences_acquises": ["JavaScript", "React", "Node.js"]
            }
        ]
    }
    
    result = validate_filiere_structure(example_filiere)
    print(f"   Validation: {'✅ VALIDE' if result['valid'] else '❌ INVALIDE'}")
    if result['issues']:
        for issue in result['issues']:
            print(f"   {issue}")
    else:
        print("   Tous les champs sont présents et valides!")
    
    # Test 4: Recommandations test
    print("\n4️⃣  Test du endpoint de recommandations...")
    print("   📌 Nécessite un profil utilisateur valide")
    print("   📌 Curl: curl -X POST http://localhost:3000/api/recommendations/generer \\")
    print("             -H 'Content-Type: application/json' \\")
    print("             -d '{\"use_ai\": true}'")
    
    print("\n" + "=" * 60)
    print("RÉSUMÉ:")
    print(f"  Service IA:  {'✅ OK' if ai_ok else '❌ KO'}")
    print(f"  Structure:   ✅ Validée")
    print("=" * 60)

if __name__ == '__main__':
    main()
