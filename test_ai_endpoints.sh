#!/bin/bash

# Configuration
AI_URL="http://localhost:5000"
HEADER="Content-Type: application/json"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     TEST DES ENDPOINTS DU SERVICE IA                      ║"
echo "╚════════════════════════════════════════════════════════════╝"

# 1. Health Check
echo -e "\n\n📊 1. HEALTH CHECK"
echo "GET /health"
curl -s "$AI_URL/health" | jq '.'

# 2. Database Stats
echo -e "\n\n📈 2. STATISTICS BASE DE DONNÉES"
echo "GET /api/stats/database"
curl -s "$AI_URL/api/stats/database" | jq '.'

# 3. Feature Importance
echo -e "\n\n⭐ 3. FEATURE IMPORTANCE"
echo "GET /api/feature-importance"
curl -s "$AI_URL/api/feature-importance" | jq '.'

# 4. Generate Recommendations
echo -e "\n\n🎯 4. GENERATE RECOMMENDATIONS (Ensemble ML)"
echo "POST /api/recommendations/generate"
curl -s -X POST "$AI_URL/api/recommendations/generate" \
  -H "$HEADER" \
  -d '{
    "profil": {
      "serie_bac": "S",
      "moyenne_generale": 15.5,
      "centres_interet": ["informatique", "science"],
      "competences": {"logique": 4, "communication": 3},
      "budget_max_mensuel": 500,
      "duree_max_etudes": 4
    },
    "filieres": [
      {"id": 1, "nom": "Informatique", "moyenne_min": 12},
      {"id": 2, "nom": "Mathématiques", "moyenne_min": 13},
      {"id": 3, "nom": "Physique", "moyenne_min": 14}
    ],
    "scores_test": {"informatique": 85, "science": 80}
  }' | jq '.'

# 5. KNN Recommendations
echo -e "\n\n🔍 5. KNN RECOMMENDATIONS (Profils similaires)"
echo "POST /api/recommendations/knn"
curl -s -X POST "$AI_URL/api/recommendations/knn" \
  -H "$HEADER" \
  -d '{
    "profil": {
      "serie_bac": "S",
      "moyenne_generale": 14.0
    },
    "all_profils": [
      {"serie_bac": "S", "moyenne_generale": 15.0},
      {"serie_bac": "S", "moyenne_generale": 13.5},
      {"serie_bac": "L", "moyenne_generale": 12.0}
    ],
    "filieres": [
      {"id": 1, "nom": "Informatique"},
      {"id": 2, "nom": "Littérature"}
    ],
    "k": 2
  }' | jq '.'

# 6. Random Forest Recommendations
echo -e "\n\n🌳 6. RANDOM FOREST RECOMMENDATIONS"
echo "POST /api/recommendations/random-forest"
curl -s -X POST "$AI_URL/api/recommendations/random-forest" \
  -H "$HEADER" \
  -d '{
    "profil": {
      "serie_bac": "S",
      "moyenne_generale": 16.0,
      "centres_interet": ["technologie"],
      "competences": {"analytique": 5}
    },
    "filieres": [
      {"id": 1, "nom": "Informatique"},
      {"id": 4, "nom": "Génie logiciel"},
      {"id": 5, "nom": "IA/Machine Learning"}
    ]
  }' | jq '.'

# 7. Explain Recommendation
echo -e "\n\n💡 7. EXPLAIN RECOMMENDATION"
echo "POST /api/explain-recommendation"
curl -s -X POST "$AI_URL/api/explain-recommendation" \
  -H "$HEADER" \
  -d '{
    "profil": {
      "serie_bac": "S",
      "moyenne_generale": 15.5
    },
    "filiere": {
      "id": 1,
      "nom": "Informatique",
      "domaine": "Technologie"
    }
  }' | jq '.'

# 8. Model Evaluation
echo -e "\n\n📊 8. MODEL EVALUATION"
echo "POST /api/model/evaluate"
curl -s -X POST "$AI_URL/api/model/evaluate" \
  -H "$HEADER" \
  -d '{
    "test_data": [
      {"profil_features": {"moyenne_score": 75, "centres_interet_match": 0.8, "competences_score": 70, "budget_max_mensuel": 500, "duree_max_etudes": 3}, "filiere_id": 1, "accepted": true, "success": true},
      {"profil_features": {"moyenne_score": 55, "centres_interet_match": 0.4, "competences_score": 50, "budget_max_mensuel": 300, "duree_max_etudes": 2}, "filiere_id": 2, "accepted": false, "success": false}
    ]
  }' | jq '.'

# 9. Train from Database
echo -e "\n\n🚀 9. TRAIN FROM DATABASE (données récentes)"
echo "POST /api/model/train-from-db"
curl -s -X POST "$AI_URL/api/model/train-from-db" \
  -H "$HEADER" \
  -d '{
    "days": 30,
    "limit": 100
  }' | jq '.'

echo -e "\n\n✅ TESTS TERMINÉS!\n"
