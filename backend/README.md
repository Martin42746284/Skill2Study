# 🎓 Backend — Plateforme d'Orientation Universitaire Post-Bac

API REST Node.js/Express pour la plateforme intelligente d'aide à la décision.

---

## Structure du projet

```
backend/
├── server.js                    # Point d'entrée
├── app.js                       # Configuration Express
├── package.json
├── .env.example
│
├── config/
│   ├── database.js              # Connexion Sequelize/MySQL
│   └── swagger.js               # Documentation API
│
├── models/
│   ├── index.js                 # Associations entre modèles
│   ├── User.model.js            # Utilisateur (bachelier / admin)
│   ├── Universite.model.js      # Université
│   ├── Filiere.model.js         # Filière (avec critères IA)
│   ├── ProfilAcademique.model.js# Profil complet du bachelier
│   └── TestOrientation.model.js # Question, Option, Session, Recommandation, Favori
│
├── controllers/
│   ├── auth.controller.js       # Inscription, connexion, JWT
│   ├── user.controller.js       # Profil, favoris
│   ├── universite.controller.js # CRUD universités
│   ├── filiere.controller.js    # CRUD filières + filtres
│   ├── test.controller.js       # Test d'orientation intelligent
│   ├── recommendation.controller.js # Déclenchement IA + explications
│   ├── comparateur.controller.js    # Comparaison de filières
│   ├── stats.controller.js      # Statistiques dashboard
│   └── admin.controller.js      # Gestion admin (users, questions)
│
├── services/
│   └── recommendation.service.js # MOTEUR IA (scoring pondéré + Jaccard)
│
├── routes/
│   ├── auth.routes.js
│   ├── user.routes.js
│   ├── universite.routes.js
│   ├── filiere.routes.js
│   ├── test.routes.js
│   ├── recommendation.routes.js
│   ├── comparateur.routes.js
│   ├── stats.routes.js
│   └── admin.routes.js
│
├── middlewares/
│   ├── auth.middleware.js        # protect + adminOnly (JWT)
│   ├── validate.middleware.js    # Validation express-validator
│   ├── error.middleware.js       # Gestionnaire d'erreurs global
│   └── notFound.middleware.js
│
└── utils/
    ├── logger.js                 # Winston logger
    └── seeder.js                 # Données de test initiales
```

---

## Installation et démarrage

### Prérequis
- **Node.js** v18+
- **PostgreSQL** 12+

### Étapes

```bash
# 1. Installer les dépendances
npm install

# 2. Créer la base de données PostgreSQL
# Via pgAdmin, psql ou votre outils préféré :
# CREATE DATABASE orientation_universitaire;
# CREATE USER postgres WITH PASSWORD 'postgres';
# GRANT ALL PRIVILEGES ON DATABASE orientation_universitaire TO postgres;

# 3. Configurer les variables d'environnement
cp .env.example .env
# Éditer .env avec vos paramètres PostgreSQL :
# DATABASE_URL=postgresql://user:password@localhost:5432/orientation_universitaire

# 4. Peupler la base de données avec données de test
npm run seed

# 5. Démarrer en développement (avec hot reload)
npm run dev

# 6. Démarrer en production
npm start
```

### Configuration PostgreSQL rapide

```bash
# Via Docker (optionnel mais recommandé)
docker run --name postgres-orientation \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=orientation_universitaire \
  -p 5432:5432 \
  -d postgres:15

# Puis créer la base si nécessaire
# docker exec -it postgres-orientation psql -U postgres -c "CREATE DATABASE orientation_universitaire;"
```

### Variables d'environnement

Voir `.env.example` pour la liste complète :

```env
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/orientation_universitaire
PORT=5000
NODE_ENV=development
JWT_SECRET=your_secret_key
JWT_EXPIRES_IN=7d
CLIENT_URL=http://localhost:5173
LOG_LEVEL=debug
```

---

## 📡 Routes de l'API

### Authentification (`/api/auth`)
| Méthode | Route | Description |
|---------|-------|-------------|
| POST | `/register` | Inscription bachelier |
| POST | `/login` | Connexion |
| GET | `/me` | Profil connecté |
| POST | `/mot-de-passe/reinitialiser` | Réinitialisation MDP |

### Utilisateur (`/api/users`) — 🔒 Auth requise
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/profil` | Voir son profil |
| PUT | `/profil` | Modifier infos personnelles |
| PUT | `/profil/academique` | Modifier profil académique + contraintes |
| GET | `/favoris` | Liste des favoris |
| POST | `/favoris/:filiereId` | Ajouter un favori |
| DELETE | `/favoris/:filiereId` | Supprimer un favori |

### Universités (`/api/universites`)
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/` | Liste filtrée (ville, type, search) |
| GET | `/:id` | Détail + filières |
| POST | `/` | Créer 🔒 Admin |
| PUT | `/:id` | Modifier 🔒 Admin |
| DELETE | `/:id` | Désactiver 🔒 Admin |

### Filières (`/api/filieres`)
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/` | Liste filtrée (domaine, niveau, serie_bac…) |
| GET | `/:id` | Détail filière |
| POST | `/` | Créer 🔒 Admin |
| PUT | `/:id` | Modifier 🔒 Admin |
| DELETE | `/:id` | Désactiver 🔒 Admin |

### Test d'orientation (`/api/test`) — 🔒 Auth requise
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/questions?serie_bac=Sciences` | Questions filtrées |
| POST | `/demarrer` | Démarrer une session |
| POST | `/:sessionId/repondre` | Soumettre une réponse |
| POST | `/:sessionId/terminer` | Terminer + calculer scores |
| GET | `/historique` | Historique des sessions |

### Recommandations IA (`/api/recommendations`) — 🔒 Auth requise
| Méthode | Route | Description |
|---------|-------|-------------|
| POST | `/generer` | Lancer le moteur IA |
| GET | `/mes-recommendations` | Voir ses recommandations |
| PATCH | `/:id/sauvegarder` | Sauvegarder/désauvegarder |
| GET | `/:id/explication` | Explication détaillée |

### Comparateur (`/api/comparateur`) — 🔒 Auth requise
| Méthode | Route | Description |
|---------|-------|-------------|
| POST | `/` | Comparer 2 à 5 filières |

### Statistiques (`/api/stats`)
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/dashboard` | Dashboard 🔒 Admin |
| GET | `/filieres/:id` | Stats d'une filière 🔒 Auth |
| GET | `/moi` | Mes stats personnelles 🔒 Auth |

---

## 🧠 Algorithme de Recommandation IA

Le moteur utilise un **scoring pondéré multi-critères** :

| Critère | Poids |
|---------|-------|
| Compatibilité série bac | 25% |
| Moyenne générale vs seuil | 20% |
| Centres d'intérêt (Jaccard) | 20% |
| Compétences auto-évaluées | 15% |
| Contraintes budget | 10% |
| Contraintes durée | 5% |
| Scores test d'orientation | 5% |

Le **module explicatif** génère pour chaque recommandation :
- [DONE] Points forts
- [WARNING] Points d'attention
- [STATS] Raisons (débouchés, taux emploi…)

---

## Documentation interactive
Disponible sur `http://localhost:5000/api/docs` (Swagger UI)
