# 🚀 Setup - Service IA avec Docker

## Vue d'ensemble

Vous avez maintenant une **plateforme intelligente d'orientation universitaire** avec :

✅ **Backend Node.js** - API REST  
✅ **Service IA Python** - Recommandations avec scikit-learn  
✅ **Base de données PostgreSQL** - Stockage des données  
✅ **Docker Compose** - Orchestration des services  

## Architecture Globale

```
┌──────────────────────────────────────────────────────┐
│                  Frontend React                      │
│              (http://localhost:3001)                 │
└──────────────────────────────────────────────────────┘
                         ↓ HTTP/REST
┌──────────────────────────────────────────────────────┐
│            Backend Node.js (Express)                 │
│           (http://localhost:3000)                    │
│  - Authentification & Autorisation                   │
│  - Gestion Profil Académique                         │
│  - Tests d'Orientation                               │
│  - Orchestration des recommandations                 │
└──────────────────────────────────────────────────────┘
        ↓ HTTP/JSON           ↓ SQL
┌──────────────────────┐  ┌──────────────────────────┐
│   Service IA Python  │  │  PostgreSQL Database     │
│ (http://localhost:5000) │ (localhost:5432)         │
│ - scikit-learn       │  │ - Utilisateurs           │
│ - Recommandations    │  │ - Profils                │
│ - Scoring            │  │ - Filières               │
│ - KNN & ML           │  │ - Universités            │
└──────────────────────┘  └──────────────────────────┘
```

## Prérequis

- ✅ **Docker & Docker Compose** installés
- ✅ Variables d'environnement configurées (`.env`)

## Installation Rapide

### 1. Démarrer tous les services

```bash
cd /chemin/vers/skill2study

# Démarrer avec Docker Compose
docker-compose up -d

# Ou utiliser le script fourni
./scripts/start-docker.sh up
```

### 2. Vérifier que tous les services sont actifs

```bash
./scripts/start-docker.sh health
```

Output attendu :
```
✓ Backend: OK
✓ Service IA: OK
✓ Base de données: OK
```

### 3. Initialiser la base de données (si nécessaire)

```bash
# Entrer dans le container backend
docker exec -it skill2study_backend bash

# Exécuter les migrations
npm run sync

# Remplir les données (optionnel)
npm run seed:fresh
```

## Endpoints Clés

### Backend (Node.js)

```
Port: 3000
Health: GET http://localhost:3000/health
API: http://localhost:3000/api/
```

Endpoints recommandations :
- `POST /api/recommendations/generer` - Générer des recommandations
- `GET /api/recommendations/mes-recommendations` - Récupérer mes recommandations
- `GET /api/recommendations/:id/explication` - Détails d'une recommandation

### Service IA (Python)

```
Port: 5000
Health: GET http://localhost:5000/health
API: http://localhost:5000/api/
```

Endpoints principaux :
- `POST /api/recommendations/generate` - Générer recommandations
- `POST /api/model/train` - Entraîner modèles ML
- `GET /api/feature-importance` - Importance des features

## Logs

### Voir les logs en temps réel

```bash
# Tous les services
docker-compose logs -f

# Service spécifique
docker-compose logs -f ai-service
docker-compose logs -f backend
docker-compose logs -f postgres

# Avec filtre
docker-compose logs -f --tail=100 ai-service
```

### Accéder aux fichiers logs

```bash
# Backend
cat backend/logs/app.log
cat backend/logs/ai_service.log

# Service IA
docker exec skill2study_ai_service cat logs/ai_service.log
```

## Commandes Utiles

### Gestion des services

```bash
# Démarrer tous les services
docker-compose up -d

# Arrêter tous les services
docker-compose down

# Redémarrer un service spécifique
docker-compose restart ai-service
docker-compose restart backend

# Construire les images
docker-compose build

# Voir l'état des services
docker-compose ps
```

### Accès aux containers

```bash
# Shell dans le backend
docker exec -it skill2study_backend bash

# Shell dans le service IA
docker exec -it skill2study_ai_service bash

# Shell dans la base de données
docker exec -it skill2study_postgres psql -U postgres -d orientation_db
```

### Tester l'API

```bash
# Health check Backend
curl http://localhost:3000/health

# Health check Service IA
curl http://localhost:5000/health

# Test de recommandation (avec données valides)
curl -X POST http://localhost:5000/api/recommendations/generate \
  -H "Content-Type: application/json" \
  -d '{
    "profil": {
      "serie_bac": "Sciences",
      "moyenne_generale": 16.5,
      "centres_interet": ["informatique"],
      "scores_test": {"informatique": 85}
    },
    "filieres": [...]
  }'
```

## Flux de Recommandation

### 1. L'utilisateur complète son profil

```
Frontend → Backend → Database
- Série bac
- Moyenne générale
- Centres d'intérêt
- Compétences auto-évaluées
- Budget
```

### 2. L'utilisateur passe le test d'orientation

```
Frontend → Test Questions → Backend → Database
- 20-30 questions
- Réponses stockées
- Scores calculés par domaine
```

### 3. Génération de recommandations (IA)

```
Backend → Service IA → Recommandations
         ↓
    Combine:
    - Scoring pondéré
    - Résultats du test (40% du score)
    - KNN (similarité profils)
    - Random Forest (prédiction succès)
    ↓
    Retourne TOP 10 filières
```

### 4. Affichage des recommandations

```
Recommandations → Frontend
- Score de compatibilité
- Explication détaillée
- Points forts/attention
- Taux d'emploi
- Débouchés
```

## Configuration du Service IA

### Ajuster les poids de scoring

Éditer `backend/ai_service/services/scoring.py` :

```python
POIDS_DEFAUT = {
    'scores_test': 40,          # Test = critère principal
    'compatibilite_serie': 20,
    'centres_interet': 15,
    'moyenne_generale': 15,
    'competences': 5,
    'budget': 3,
    'duree': 2,
}
```

Redémarrer le service pour appliquer :
```bash
docker-compose restart ai-service
```

### Entraîner les modèles ML

Pour utiliser les modèles Random Forest, vous devez d'abord les entraîner :

```bash
# Collecter les données historiques (succès/échec de recommandations)
# Via endpoint Node.js ou script d'entraînement

# Appeler l'endpoint d'entraînement
curl -X POST http://localhost:5000/api/model/train \
  -H "Content-Type: application/json" \
  -d '{
    "training_data": [
      {
        "profil_features": {...},
        "filiere_id": 1,
        "accepted": true,
        "success": true,
        "engagement": 0.8
      },
      ...
    ]
  }'
```

## Dépannage

### ❌ Service IA inaccessible depuis le Backend

**Cause** : Les containers ne peuvent pas communiquer  
**Solution** :

```bash
# Vérifier que les containers sont sur le même réseau
docker network ls
docker network inspect skill2study-network

# Vérifier que le service IA est actif
docker-compose ps ai-service

# Redémarrer les services
docker-compose down
docker-compose up -d
```

### ❌ Erreur "Database connection refused"

**Cause** : PostgreSQL n'est pas prêt  
**Solution** :

```bash
# Attendre que PostgreSQL démarre (environ 10 secondes)
docker-compose logs postgres
docker-compose restart postgres

# Ou relancer tout
docker-compose down && docker-compose up -d
```

### ❌ Port 5000 ou 3000 déjà utilisé

**Solution** : Changer les ports dans `docker-compose.yml`

```yaml
ai-service:
  ports:
    - "5001:5000"  # Mapper sur 5001 localement

backend:
  ports:
    - "3001:3000"  # Mapper sur 3001 localement
```

### ❌ Le service IA retourne des erreurs

```bash
# Vérifier les logs détaillés
docker-compose logs -f ai-service --tail=50

# Redémarrer le service
docker-compose restart ai-service

# Vérifier la santé
docker-compose exec ai-service curl http://localhost:5000/health
```

## Tests

### Test rapide du service IA

```bash
# 1. Health check
curl http://localhost:5000/health

# 2. Générer recommandations (test simple)
python backend/ai_service/test_api.py  # À créer

# 3. Vérifier logs
docker-compose logs ai-service
```

### Test du flux complet

1. ✅ Créer un compte utilisateur
2. ✅ Compléter le profil académique
3. ✅ Passer le test d'orientation
4. ✅ Générer les recommandations
5. ✅ Consulter les explications

## Performance

- **Service IA** : ~200-500ms par requête
- **Database** : ~50-100ms par query
- **Total latence** : ~300-600ms

Pour optimiser en production :
- Ajouter du caching Redis
- Utiliser des indexes de base de données
- Augmenter les workers Gunicorn

## Mise à Jour

Pour mettre à jour le code après des modifications :

```bash
# Backend
docker-compose restart backend

# Service IA
docker-compose build ai-service
docker-compose up -d ai-service

# Tout reconstruire
docker-compose down
docker-compose build
docker-compose up -d
```

## Prochaines Étapes

1. ✅ **Tester les recommandations** avec de vrais données
2. ✅ **Entraîner les modèles ML** avec l'historique d'utilisateurs
3. ✅ **Monitorer les performances** (logs, métriques)
4. ✅ **Déployer en production** (AWS, Heroku, etc.)

## Support

Pour des questions ou des problèmes :
- Consultez les logs : `docker-compose logs [service]`
- Vérifiez la documentation : `backend/ai_service/README.md`
- Vérifiez la configuration : `docker-compose.yml`

---

**La plateforme Skill2Study est maintenant prête à fournir des recommandations intelligentes ! 🎓🚀**
