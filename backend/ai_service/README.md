# Service IA pour Recommandations Universitaires

## Vue d'ensemble

Service Python basé sur **scikit-learn** qui fournit des recommandations intelligentes de filières académiques en analysant :

- **Profil académique** : série bac, moyenne générale, compétences, centres d'intérêt
- **Résultats du test d'orientation** : scores par domaine (critère principal)
- **Données des filières** : admission, coût, débouchés, employabilité
- **Historique des profils similaires** : via KNN (K-Nearest Neighbors)

## Architecture

```
┌─────────────────────────────────────────────────┐
│           Flask REST API (port 5000)            │
│                                                 │
│  GET  /health                                  │
│  POST /api/recommendations/generate            │
│  POST /api/recommendations/knn                 │
│  POST /api/recommendations/random-forest       │
│  POST /api/model/train                         │
│  POST /api/model/evaluate                      │
│  POST /api/explain-recommendation              │
│  GET  /api/feature-importance                  │
└─────────────────────────────────────────────────┘
        ↕ HTTP/JSON
┌─────────────────────────────────────────────────┐
│       Moteur de Recommandations (Python)       │
│                                                 │
│  • RecommendationEngine      (orchestration)   │
│  • ScoringEngine             (scoring pondéré) │
│  • KNNEngine                 (similarité)      │
│  • MLModels                  (Random Forest)   │
└─────────────────────────────────────────────────┘
```

## Installation

### Avec Docker (Recommandé)

```bash
# À partir de la racine du projet
docker-compose up -d ai-service
```

### Installation locale (Développement)

```bash
# Créer un environnement virtuel
python3 -m venv venv
source venv/bin/activate  # Sur Windows: venv\Scripts\activate

# Installer les dépendances
pip install -r requirements.txt

# Créer les dossiers nécessaires
mkdir -p logs models

# Démarrer le service
python app.py
```

Le service sera accessible à : `http://localhost:5000`

## Endpoints API

### 1. Health Check

```bash
GET /health

Response:
{
  "status": "ok",
  "service": "AI Recommendation Engine",
  "timestamp": "2024-06-05T10:30:00",
  "models_loaded": true
}
```

### 2. Générer des Recommandations

**Le principale endpoint** - Utilise le scoring pondéré + résultats du test

```bash
POST /api/recommendations/generate

Request:
{
  "profil": {
    "serie_bac": "Sciences",
    "moyenne_generale": 16.5,
    "centres_interet": ["informatique", "innovation"],
    "competences": {
      "mathematiques": 4,
      "logique": 5,
      "communication": 3
    },
    "budget_max_mensuel": 2000,
    "duree_max_etudes": 3,
    "scores_test": {
      "informatique": 85,
      "sciences": 90,
      "gestion": 70
    }
  },
  "filieres": [
    {
      "id": 1,
      "nom": "Licence Informatique",
      "series_bac_acceptees": ["Sciences", "Technique"],
      "moyenne_min_requise": 12,
      "centres_interet": ["informatique", "recherche"],
      "competences_requises": ["mathematiques", "logique"],
      "cout_annuel": 0,
      "duree_annees": 3,
      "taux_emploi": 92,
      "debouches": ["Développeur", "Administrateur réseau"]
    },
    ...
  ],
  "scores_test": { ... }  // Optionnel, peut aussi être dans profil
}

Response:
{
  "success": true,
  "count": 10,
  "recommendations": [
    {
      "filiere_id": 1,
      "filiere_nom": "Licence Informatique",
      "score": 91.5,
      "score_base": 89.2,
      "explanation": {
        "points_forts": [
          "Votre série 'Sciences' est bien adaptée à cette filière.",
          "Votre moyenne (16.5/20) est excellente pour cette formation.",
          "Vos résultats au test d'orientation sont très favorables..."
        ],
        "points_attention": [],
        "raisons": [
          "Excellent taux d'employabilité (92%)",
          "Débouchés variés: Développeur, Administrateur réseau"
        ]
      },
      "factors": {
        "serie_bac": 100.0,
        "moyenne_generale": 100.0,
        "centres_interet": 85.5,
        "competences": 90.0,
        "scores_test": 87.5,
        "budget": 100.0,
        "duree": 100.0
      }
    },
    ...
  ]
}
```

### 3. KNN - Recommandations par Similarité

```bash
POST /api/recommendations/knn

Request:
{
  "profil": { ... },
  "all_profils": [ ... ],  // Tous les profils historiques
  "filieres": [ ... ],
  "k": 5  // Nombre de voisins
}

Response:
{
  "success": true,
  "count": 10,
  "recommendations": [
    {
      "filiere_id": 5,
      "filiere_nom": "...",
      "score": 85.0,
      "method": "knn",
      "similar_profiles_count": 3  // Combien de profils similaires ont choisi cette filière
    }
  ]
}
```

### 4. Random Forest - Prédiction de Succès

```bash
POST /api/recommendations/random-forest

Request:
{
  "profil": { ... },
  "filieres": [ ... ]
}

Response:
{
  "success": true,
  "recommendations": [
    {
      "filiere_id": 1,
      "filiere_nom": "...",
      "score": 87.5,
      "compatibility_score": 89.2,
      "success_probability": 83.0,  // Score de succès prédis
      "method": "random_forest"
    }
  ]
}
```

### 5. Entraîner les Modèles

```bash
POST /api/model/train

Request:
{
  "training_data": [
    {
      "profil_features": { ... },
      "filiere_id": 1,
      "accepted": true,
      "success": true,
      "engagement": 0.8
    },
    ...
  ]
}

Response:
{
  "success": true,
  "message": "Modèles entraînés avec succès",
  "metrics": {
    "training_examples": 150,
    "accuracy": 0.854,
    "feature_importance": { ... }
  }
}
```

### 6. Explication d'une Recommandation

```bash
POST /api/explain-recommendation

Request:
{
  "profil": { ... },
  "filiere": { ... }
}

Response:
{
  "success": true,
  "explanation": {
    "points_forts": [ ... ],
    "points_attention": [ ... ],
    "raisons": [ ... ],
    "detailed_factors": {
      "serie_bac": { ... },
      "moyenne": { ... },
      ...
    }
  }
}
```

## Poids de Scoring

Les scores de compatibilité sont calculés avec des poids configurables :

```python
POIDS_DEFAUT = {
    'scores_test': 40,          # [STAR] PRINCIPAL - Résultats du test
    'compatibilite_serie': 20,  # Série bac compatible
    'moyenne_generale': 15,     # Moyenne vs seuil requis
    'centres_interet': 15,      # Correspondance des intérêts
    'competences': 5,           # Compétences auto-évaluées
    'duree': 5,                 # Durée dans les préférences
}
```

**[STAR] Important** : Le **test d'orientation** est le critère principal (40% du score final)
**Note** : La contrainte budget a été supprimée car les données ne précisent pas bien le coût annuel.

## Algorithmes Utilisés

### 1. Scoring Pondéré (ScoringEngine)

Combine 7 critères avec des poids configurables :
- [OK] Compatibilité série bac
- [OK] Analyse de la moyenne générale
- [OK] Matching centres d'intérêt (Jaccard similarity)
- [OK] Évaluation des compétences requises
- [OK] Analyse du budget
- [OK] Vérification de la durée d'études
- [OK] **Scoring du test d'orientation** (matching intelligent avec domaines)

### 2. K-Nearest Neighbors (KNNEngine)

Vectorise les profils avec 13 features :
- Moyenne générale (normalisée)
- Compétences (moyenne des scores)
- Centres d'intérêt (nombre)
- Budget mensuel
- Durée max études
- Filières choisies historiquement
- One-hot encoding séries bac
- Scores du test d'orientation

Utilise la **similarité cosinus** pour trouver les K profils les plus similaires.

### 3. Random Forest (MLModels)

**Demande un entraînement préalable** avec des données historiques.

Prédit :
- **Classification** : Succès/Échec académique
- **Régression** : Score de succès (0-100)

Nécessite des exemples contenant :
- Profil académique
- Filière choisie
- Résultat (succès/échec)
- Engagement/satisfaction (0-1)

## Flux d'Intégration Node.js ↔ Python

### Depuis le Backend Node.js

```javascript
// 1. L'utilisateur clique sur "Générer recommandations"
POST /api/recommendations/generer
  ↓
// 2. Le controller Node.js récupère le profil et les filières
const profil = await ProfilAcademique.findOne(...)
const filieres = await Filiere.findAll(...)
  ↓
// 3. Appel du service IA Python
const recommendations = await AIRecommendationService.generateRecommendationsML(
  profil, filieres, scoresTest
)
  ↓
// 4. Le service Python (Flask) traite et retourne les recommandations
// 5. Sauvegarde en BD et notification utilisateur
```

## Logging

Les logs sont disponibles dans :
- **Console** : stdout/stderr en temps réel
- **Fichier** : `logs/ai_service.log`

Niveaux de log : INFO, WARNING, ERROR

```bash
# Voir les logs en temps réel
docker-compose logs -f ai-service

# Ou localement
tail -f logs/ai_service.log
```

## Dépannage

### Service IA inaccessible

```bash
# Vérifier que le service est actif
docker-compose ps ai-service

# Vérifier les logs
docker-compose logs ai-service

# Redémarrer
docker-compose restart ai-service
```

### Erreur de connexion vers le service IA depuis Node.js

**En Docker** : Utiliser `http://ai-service:5000` (nom du service)  
**Localement** : Utiliser `http://localhost:5000`

Configurer dans `backend/.env` :
```
AI_SERVICE_URL=http://ai-service:5000  # Docker
AI_SERVICE_URL=http://localhost:5000   # Local
```

### Modèles non entraînés

Le service fonctionne même sans modèles Random Forest. Les recommandations utilisent :
1. Scoring pondéré ✓ (toujours disponible)
2. KNN ✓ (si data historique)
3. Random Forest ✗ (nécessite entraînement)

## Performance

- **Recommandations simples** : ~200-500ms
- **Avec KNN** (100+ profils) : ~500-1000ms
- **Avec Random Forest** : ~100-200ms

## Architecture Production

Pour la production :

1. **Gunicorn** : 4+ workers (configurable dans Dockerfile)
2. **Load balancing** : Via reverse proxy (nginx)
3. **Caching** : Redis pour les recommandations statiques
4. **Monitoring** : Prometheus + Grafana

## Fichiers de Modèles

Les modèles entraînés sont sauvegardés dans le dossier `models/` :
- `rf_classifier.pkl` : Classifieur (succès/échec)
- `rf_regressor.pkl` : Régresseur (score succès)

## Support et Contribution

Pour des questions ou des améliorations, consultez la documentation du projet principal.
