#!/usr/bin/env python3
import requests
import json
import random

# Configuration
AI_SERVICE_URL = "http://localhost:5000"
ENDPOINT = f"{AI_SERVICE_URL}/api/model/train"

# Générer des données d'entraînement pour 522 filières
num_filieres = 522
num_samples_per_filiere = 3  # 3 exemples par filière = 1566 exemples totaux

training_data = []

for filiere_id in range(1, num_filieres + 1):
    for _ in range(num_samples_per_filiere):
        # Générer des profils variés avec les 5 features requises
        moyenne_score = random.uniform(30.0, 100.0)  # 30-100
        centres_interet_match = random.uniform(0.0, 1.0)  # 0-1
        competences_score = random.uniform(30.0, 100.0)  # 30-100
        budget_max_mensuel = random.choice([300, 500, 800, 1000, 1500])  # Variations
        duree_max_etudes = random.choice([2, 3, 4, 5])  # Années d'études

        # Résultats basés sur la moyenne (plus haute = plus de succès)
        accepted = moyenne_score >= 50
        success = moyenne_score >= 70
        engagement = moyenne_score / 100.0  # Engagement proportionnel à la moyenne

        sample = {
            "profil_features": {
                "moyenne_score": moyenne_score,
                "centres_interet_match": centres_interet_match,
                "competences_score": competences_score,
                "budget_max_mensuel": budget_max_mensuel,
                "duree_max_etudes": duree_max_etudes
            },
            "filiere_id": filiere_id,
            "accepted": accepted,
            "success": success,
            "engagement": engagement
        }
        training_data.append(sample)

print(f"Génération de {len(training_data)} exemples d'entraînement...")

# Envoyer les données au service IA
payload = {
    "from_database": False,
    "training_data": training_data
}

print(f"Envoi des données au service IA...")
try:
    response = requests.post(ENDPOINT, json=payload, timeout=60)
    result = response.json()
    
    print(f"Statut: {response.status_code}")
    print(f"Réponse: {json.dumps(result, indent=2, ensure_ascii=False)}")
    
    if result.get('success'):
        print("\n✅ Entraînement réussi!")
        
        # Vérifier le health check
        print("\nVérification du status...")
        health = requests.get(f"{AI_SERVICE_URL}/health").json()
        print(json.dumps(health, indent=2, ensure_ascii=False))
    else:
        print("\n❌ Erreur lors de l'entraînement")
        
except Exception as e:
    print(f"❌ Erreur de connexion: {str(e)}")
    print(f"Assurez-vous que le service IA tourne sur {AI_SERVICE_URL}")
