# 🎓 Skill2Study - Plateforme Intelligente d'Orientation Universitaire

Un système complet d'orientation universitaire basé sur l'intelligence artificielle qui recommande les meilleures filières académiques en fonction du profil, des tests d'orientation et des préférences géographiques de l'étudiant.

## 📋 Table des matières

- [Caractéristiques](#caractéristiques)
- [Architecture](#architecture)
- [Installation](#installation)
- [Configuration](#configuration)
- [Services](#services)
- [API](#api)
- [Développement](#développement)
- [Deployment](#deployment)

## ✨ Caractéristiques

### 🤖 Moteur IA Intelligent
- **Modèles ML entraînés** avec scikit-learn (Random Forest + KNN)
- **Accuracy: 85.1%** sur 1566+ exemples d'entraînement
- Recommandations basées sur ensemble d'algorithmes

### 📊 Recommandations Personnalisées
- **86+ recommandations** par étudiant
- Scores de compatibilité calculés (0-100%)
- Justifications détaillées et personnalisées par filière
- Priorité à la préférence géographique

### 🔍 Comparaison Interactive
- Comparer jusqu'à 50 filières côte à côte
- Avantages/défis extraits intelligemment
- Tri automatique par score de compatibilité
- ROI (Retour sur Investissement) estimé

### 🧪 Test d'Orientation
- Test adaptatif multi-catégories
- Scoring détaillé par domaine
- Intégration avec les recommandations

### 📍 Localisation Intelligente
- Préférence géographique (région, ville)
- Universités classées par proximité
- Support des grandes villes de Madagascar

## 🏗️ Architecture

```
Skill2Study/
├── 📁 Frontend (Vite + React + TypeScript)
│   ├── src/pages/          # Pages principales
│   ├── src/components/     # Composants réutilisables
│   ├── src/lib/            # API client, utilities
│   └── src/hooks/          # Custom React hooks
│
├── 📁 Backend (Node.js + Express + Sequelize)
│   ├── routes/             # Endpoints API
│   ├── controllers/        # Logique métier
│   ├── services/           # Services (recommendations, AI)
│   ├── models/             # Modèles Sequelize
│   └── config/             # Configuration DB
│
├── 📁 AI Service (Python + Flask + scikit-learn)
│   ├── services/           # Moteurs ML (KNN, RF, Scoring)
│   ├── models/             # Modèles entraînés
│   ├── config/             # Configuration BD
│   └── app.py              # API Flask
│
└── 📁 Database (PostgreSQL)
    ├── users               # Profils utilisateurs
    ├── profils_academiques # Données académiques
    ├── filieres            # Programmes d'études
    ├── recommendations     # Recommandations générées
    └── universite          # Universités/Écoles
```

### Services Déployés

| Service | Port | Technologie | Statut |
|---------|------|-------------|--------|
| Frontend | 5173 | Vite + React | ✅ Live |
| Backend | 3000 | Node.js + Express | ✅ Live |
| AI Service | 5000 | Python + Flask | ✅ Live |
| PostgreSQL | 5432 | Docker | ✅ Live |

## 🚀 Installation

### Prérequis

- Node.js 20+
- Python 3.12+
- PostgreSQL 16+
- Docker & Docker Compose
- npm ou yarn

### Setup Local

#### 1. Cloner le projet

```bash
git clone <repository-url>
cd Skill2Study
```

#### 2. Variables d'environnement

**Frontend** (`.env`):
```env
VITE_API_URL=http://localhost:3000
```

**Backend** (`backend/.env`):
```env
DATABASE_URL=postgresql://postgres:martin4274@localhost:5432/orientation_db
AI_SERVICE_URL=http://localhost:5000
JWT_SECRET=your-secret-key-here
NODE_ENV=development
```

#### 3. Lancer les services

**Option A: Docker Compose (Recommandé)**

```bash
docker-compose up
```

Cela lance:
- PostgreSQL (port 5432)
- AI Service (port 5000)

**Option B: Local**

```bash
# Terminal 1: Backend
cd backend
npm install
npm run dev

# Terminal 2: Frontend
npm install
npm run dev

# Terminal 3: AI Service (optionnel, recommandé via Docker)
cd ai-service
python3 -m venv venv
source venv/bin/activate  # ou venv\Scripts\activate (Windows)
pip install -r requirements.txt
python app.py
```

#### 4. Initialiser la base de données

```bash
# Depuis le terminal du backend
npm run seed:fresh
```

## ⚙️ Configuration

### Base de Données

PostgreSQL est utilisée avec Sequelize ORM. Les migrations sont automatiques au démarrage.

**Tables principales:**
- `users` - Profils utilisateurs
- `profils_academiques` - Données académiques (série bac, moyenne, etc.)
- `filieres` - Programmes d'études disponibles
- `universite` - Établissements d'enseignement
- `recommendations` - Recommandations générées
- `test_sessions` - Sessions de test d'orientation

### AI Service

**Configuration du modèle:**
```python
# ai-service/config/
TRAINING_DATA_LIMIT = 1566
MODEL_ACCURACY = 0.851  # 85.1%
ALGORITHMS = ['RandomForest', 'KNN', 'WeightedScoring']
```

**Entraînement:**
```bash
curl -X POST http://localhost:5000/api/model/train \
  -H "Content-Type: application/json" \
  -d '{"from_database": true}'
```

## 📡 API

### Recommandations

**Générer des recommandations:**
```bash
POST /api/recommendations/generer
Authorization: Bearer <token>
Content-Type: application/json

{
  "session_test_id": 123,  # optionnel
  "use_ai": true
}

Response:
{
  "success": true,
  "count": 86,
  "recommendations": [
    {
      "filiere": { "id": 1, "nom": "Informatique", ... },
      "score": 85,
      "details": { "compatibilite_serie": 100, ... },
      "justification": { "points_forts": [...], ... }
    },
    ...
  ]
}
```

### Comparaison

**Comparer plusieurs filières:**
```bash
POST /api/comparateur
Authorization: Bearer <token>
Content-Type: application/json

{
  "filiere_ids": [1, 2, 3, 4, 5]
}

Response:
{
  "success": true,
  "comparaison": [
    {
      "id": 1,
      "nom": "Informatique",
      "score_compatibilite": 85,
      "avantages": ["Fort taux d'emploi", "Formation courte", ...],
      "inconvenients": [],
      ...
    },
    ...
  ]
}
```

### Test d'Orientation

**Soumettre les réponses du test:**
```bash
POST /api/tests/submit
Authorization: Bearer <token>
Content-Type: application/json

{
  "responses": [
    { "question_id": 1, "answer": "A" },
    { "question_id": 2, "answer": "B" },
    ...
  ]
}
```

## 👨‍💻 Développement

### Structure du Code

**Frontend:**
```
src/
├── pages/
│   ├── Dashboard.tsx       # Tableau de bord
│   ├── Compare.tsx         # Page de comparaison
│   ├── Recommendations.tsx # Recommandations
│   └── Test.tsx            # Test d'orientation
├── components/
│   ├── RecommendationCard.tsx
│   ├── ComparisonTable.tsx
│   └── TestQuestion.tsx
└── lib/
    ├── api.ts              # Endpoints API
    └── utils.ts            # Utilitaires
```

**Backend:**
```
backend/
├── controllers/
│   ├── recommendation.controller.js
│   ├── comparateur.controller.js
│   └── test.controller.js
├── services/
│   ├── recommendation.service.js  # Scoring principal
│   ├── ai_recommendation.service.js # Intégration IA
│   └── test.service.js
├── models/
│   ├── User.model.js
│   ├── ProfilAcademique.model.js
│   └── Filiere.model.js
└── routes/
    ├── recommendation.routes.js
    ├── comparateur.routes.js
    └── test.routes.js
```

### Scoring Intelligent

Le système utilise un **scoring pondéré multi-critères**:

```javascript
POIDS_DEFAUT = {
  scores_test: 35,              // Test d'orientation
  compatibilite_serie: 20,      // Série bac
  centres_interet: 15,          // Centres d'intérêt
  moyenne_generale: 15,         // Moyenne générale
  preference_geographique: 10,  // Préférence de ville
  competences: 3,               // Compétences
  contraintes_duree: 2          // Durée d'études
}
```

### Entraînement du Modèle IA

```bash
# Générer données d'entraînement
python3 train_ai_service.py

# Résultat:
# - 1566 exemples générés
# - Accuracy: 85.1%
# - 522 filières couvertes
# - Modèles sauvegardés
```

## 🌐 Deployment

### Production

**Options recommandées:**
- Frontend: Vercel, Netlify, ou AWS S3 + CloudFront
- Backend: Heroku, AWS EC2, ou DigitalOcean
- AI Service: AWS SageMaker ou EC2
- Database: AWS RDS ou Neon

**Checklist:**

- [ ] Sécuriser les secrets (JWT_SECRET, DB_PASSWORD)
- [ ] Configurer CORS pour les domaines autorisés
- [ ] Mettre en place HTTPS/SSL
- [ ] Configurer les backups automatiques de BD
- [ ] Mettre à jour l'AI_SERVICE_URL
- [ ] Tester la performance sous charge
- [ ] Mettre en place la monitoring (logs, métriques)
- [ ] Configurer CI/CD (GitHub Actions, GitLab CI)

### Docker Production

```bash
# Build les images
docker-compose build

# Déployer
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

## 🔧 Troubleshooting

### AI Service retourne 0 recommandations

**Solution:**
```bash
# Vérifier que les modèles sont entraînés
curl http://localhost:5000/health

# Entraîner si nécessaire
python3 train_ai_service.py
```

### PostgreSQL: "port 5432 already in use"

**Solution:**
```bash
# Arrêter PostgreSQL local
sudo systemctl stop postgresql

# Ou utiliser un autre port dans docker-compose.yml
ports:
  - "5433:5432"
```

### Backend ne peut pas atteindre AI Service

**Solution:**
```bash
# Vérifier la variable d'environnement
echo $AI_SERVICE_URL  # Doit être http://localhost:5000

# Ou en Docker:
# AI_SERVICE_URL=http://ai-service:5000
```

## 📚 Documentation Supplémentaire

- [API Endpoints Documentation](./docs/API.md)
- [Architecture Détaillée](./docs/ARCHITECTURE.md)
- [Guide de Contribution](./CONTRIBUTING.md)

## 📄 Licence

MIT License - Voir [LICENSE](LICENSE) pour plus de détails.

## 👥 Auteurs

- **Développement**: Manampisoa Martin
- **Architecture IA**: Skill2Study Team

---

**Dernière mise à jour**: Juin 2026
**Statut**: ✅ Production Ready
