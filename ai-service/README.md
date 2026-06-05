# Service de Recommandation Intelligente avec scikit-learn

Service Python pour générer des recommandations d'orientation universitaire basées sur des algorithmes de Machine Learning.

## Architecture

### Composants principaux

1. **Flask API** - Serveur HTTP pour les endpoints
2. **RecommendationMLService** - Moteur de recommandation avec 3 approches ML
3. **DataProcessor** - Préparation et normalisation des données
4. **ModelTrainer** - Entraînement et évaluation des modèles

### Algorithmes utilisés

- **Weighted Scoring** (35%) : Système de scoring pondéré multi-critères
- **KNN** (30%) : K-Nearest Neighbors pour trouver les profils similaires
- **Random Forest** (35%) : Prédiction de compatibilité avec régression

## Installation

### Prérequis

- Python 3.8+
- pip ou conda

### Setup

```bash
# 1. Créer un environnement virtuel
python -m venv venv
source venv/bin/activate  # Linux/Mac
# ou
venv\Scripts\activate  # Windows

# 2. Installer les dépendances
pip install -r requirements.txt

# 3. Créer le fichier .env
cp .env.example .env

# 4. Modifier .env avec vos configurations
```

## Utilisation

### Lancer le service

```bash
python app.py
```

Le service sera disponible sur `http://localhost:5000`

### Endpoints principaux

#### 1. Vérifier le service

```bash
GET /health
```

#### 2. Générer des recommandations

```bash
POST /api/recommendations/generate
Content-Type: application/json

{
  "profil": {
    "serie_bac": "S",
    "moyenne_generale": 15.5,
    "centres_interet": ["informatique", "science"],
    "competences": {"logique": 4, "communication": 3},
    "budget_max_mensuel": 500,
    "duree_max_etudes": 4
  },
  "filieres": [...],
  "scores_test": {"informatique": 85, "science": 80}
}
```

#### 3. Recommandations par KNN

```bash
POST /api/recommendations/knn

{
  "profil": {...},
  "all_profils": [...],
  "filieres": [...],
  "k": 5
}
```

#### 4. Recommandations par Random Forest

```bash
POST /api/recommendations/random-forest

{
  "profil": {...},
  "filieres": [...]
}
```

#### 5. Entraîner les modèles

```bash
POST /api/model/train

{
  "training_data": [
    {
      "profil_features": [...],
      "filiere_id": 1,
      "accepted": true,
      "success": true,
      "engagement": 0.8
    }
  ]
}
```

#### 6. Évaluer les modèles

```bash
POST /api/model/evaluate

{
  "test_data": [...]
}
```

#### 7. Expliquer une recommandation

```bash
POST /api/explain-recommendation

{
  "profil": {...},
  "filiere": {...}
}
```

#### 8. Feature importance

```bash
GET /api/feature-importance
```

## Structure des données

### Profil académique

```python
{
    "serie_bac": "S",              # S, ES, L, STI, ST2S, etc.
    "moyenne_generale": 15.5,      # 0-20
    "centres_interet": [           # Liste
        "informatique",
        "science"
    ],
    "competences": {               # Auto-évaluation 1-5
        "logique": 4,
        "communication": 3,
        "creativite": 5
    },
    "budget_max_mensuel": 500,     # Euros
    "duree_max_etudes": 4,         # Années
    "distance_max_km": 100,        # Km
    "preference_type_univ": "publique",  # publique/privee/indifferent
    "ville_preference": "Paris",
    "objectifs_professionnels": "...",
    "secteur_vise": "Tech"
}
```

### Filière

```python
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
    "debouches": ["Développeur", "Data Scientist"],
    "universite": {
        "id": 1,
        "nom": "Sorbonne",
        "type": "publique"
    }
}
```

## Feature Engineering

Le service prépare automatiquement les features:

- **moyenne_score** : 0-100 (normalisé de 0-20)
- **centres_interet_match** : 0-1 (similarité Jaccard)
- **competences_score** : 0-100 (moyenne des compétences)
- **budget_max_mensuel** : Euros
- **duree_max_etudes** : Années

## Entraînement des modèles

Pour de meilleurs résultats, entraînez régulièrement les modèles avec les données réelles:

```bash
# Récupérer les données d'entraînement du backend
curl -X GET http://localhost:3000/api/training-data

# Entraîner les modèles
curl -X POST http://localhost:5000/api/model/train \
  -H "Content-Type: application/json" \
  -d @training_data.json
```

## Performance

- Temps de réponse: < 500ms par recommandation
- KNN: O(n*d) où n=nombre de profils, d=dimensions
- Random Forest: O(log n) après entraînement
- Scoring pondéré: O(1)

## Logs

Les logs sont écrits en console par défaut. Pour activer la persistance:

```python
# Modifier app.py
logging.basicConfig(
    level=logging.INFO,
    filename='ai_service.log',
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
```

## Développement

### Tests

```bash
python -m pytest tests/
```

### Code style

```bash
black .
flake8 .
```

## Intégration avec le backend Node.js

Le backend Node.js peut appeler le service via HTTP:

```javascript
// Exemple en Node.js
const response = await fetch('http://localhost:5000/api/recommendations/generate', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    profil: {...},
    filieres: [...],
    scores_test: {...}
  })
});
const recommendations = await response.json();
```

## Troubleshooting

### Modèles non trouvés
Les modèles sont créés automatiquement lors du premier entraînement. Jusqu'à là, le système utilise le scoring pondéré.

### Performance lente
- Augmenter la taille du batch pour l'entraînement
- Réduire la profondeur du Random Forest
- Utiliser KNN avec un k plus petit

### Résultats peu pertinents
- Entraîner les modèles avec plus de données (min 100 exemples)
- Vérifier la qualité des données d'entrée
- Vérifier l'alignement des features

## Futur

- [ ] Intégration avec PostgreSQL pour l'historique
- [ ] Dashboard web pour visualiser les performances
- [ ] AutoML pour l'optimisation automatique
- [ ] Explainability avancée (SHAP values)
- [ ] Support du clustering pour segmentation d'étudiants
- [ ] Recommandations contextelles (basées sur événements)
