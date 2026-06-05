# 📚 Guide d'Installation Complet

## 🎯 Vue d'ensemble

Cette plateforme est composée de :
- **Frontend** : React + TypeScript + Tailwind CSS
- **Backend** : Node.js/Express + Sequelize + PostgreSQL
- **IA** : Système de recommandation basé sur scoring pondéré

---

## 🔧 Prérequis

Assurez-vous d'avoir installé :
- **Node.js** v18+ ([télécharger](https://nodejs.org/))
- **PostgreSQL** 12+ ([télécharger](https://www.postgresql.org/download/)) ou **Docker**
- **npm** ou **pnpm**

---

## 📋 Étape 1 : Configuration de la Base de Données PostgreSQL

### Option A : Docker (Recommandé - Plus facile)

```bash
# À la racine du projet
docker-compose up -d

# La base sera prête en quelques secondes
# Vérifier que PostgreSQL est actif :
docker ps | grep postgres
```

### Option B : Installation locale PostgreSQL

```bash
# Windows / macOS : Télécharger depuis postgresql.org
# Linux (Ubuntu/Debian) :
sudo apt-get install postgresql postgresql-contrib
sudo service postgresql start

# Créer la base de données
sudo -u postgres psql

# Dans psql :
CREATE DATABASE orientation_universitaire;
CREATE USER postgres WITH PASSWORD 'postgres';
GRANT ALL PRIVILEGES ON DATABASE orientation_universitaire TO postgres;
\q
```

Vérifier la connexion :
```bash
psql -U postgres -d orientation_universitaire -c "SELECT NOW();"
```

---

## 🛠️ Étape 2 : Installation du Backend

```bash
# 1. Aller dans le dossier backend
cd backend

# 2. Installer les dépendances
npm install

# 3. Créer le fichier .env
cp .env.example .env

# 4. Éditer .env si nécessaire (pour Docker compose, laisser par défaut)
# DATABASE_URL=postgresql://postgres:postgres@localhost:5432/orientation_universitaire

# 5. Peupler la base avec des données de test
npm run seed

# 6. Démarrer le backend
npm run dev
```

Le backend sera disponible sur : **http://localhost:5000**
Documentation API : **http://localhost:5000/api/docs**

---

## 🚀 Étape 3 : Installation du Frontend

```bash
# 1. Aller à la racine du projet (sortir de backend/)
cd ..

# 2. Installer les dépendances
npm install

# 3. Démarrer le serveur dev
npm run dev
```

Le frontend sera disponible sur : **http://localhost:5173** (port par défaut Vite)

---

## ✅ Vérifications

### Tester le Backend

```bash
# Vérifier la connexion DB
curl http://localhost:5000/api/health

# Voir la documentation API
# Ouvrir : http://localhost:5000/api/docs
```

### Tester le Frontend

Ouvrir [http://localhost:5173](http://localhost:5173) dans le navigateur

### Comptes de test

| Email | Mot de passe | Rôle |
|-------|--------------|------|
| admin@orientation.dz | Admin1234! | Admin |
| marie.dupont@example.com | Password123! | Bachelier |
| karim.ahmed@example.com | Password123! | Bachelier |

---

## 🗄️ Structure de la Base de Données

```
orientation_universitaire
├── users                    (bacheliers + admins)
├── profils_academiques      (détails académiques)
├── universites              (institutions)
├── filieres                 (programmes d'études)
├── questions                (test d'orientation)
├── options_reponses         (réponses possibles)
├── sessions_test            (historique des tests)
├── recommendations          (recommandations générées)
└── favoris                  (filières favorites)
```

---

## 🔄 Workflow de développement

### Modifier le code Backend

```bash
# Le serveur redémarre automatiquement avec nodemon
# Fichier à éditer : backend/

# Exemples :
backend/controllers/        # Logique métier
backend/routes/             # Définition des routes
backend/models/             # Schémas de données
backend/services/           # Services (ex: IA)
```

### Modifier le code Frontend

```bash
# Le navigateur se récharge automatiquement
# Fichier à éditer : src/

# Exemples :
src/pages/                  # Pages principales
src/components/             # Composants réutilisables
src/data/                   # Données statiques
src/lib/                    # Utilitaires
```

---

## 📊 Fonctionnalités principales testables

### Pour les Bacheliers

1. **Inscription/Connexion**
   - Créer un compte
   - Se connecter

2. **Passer le test d'orientation**
   - Répondre aux questions
   - Voir les scores

3. **Voir les recommandations**
   - Générer des recommandations
   - Lire les explications IA

4. **Comparer les filières**
   - Sélectionner 2-5 filières
   - Voir comparaison détaillée

5. **Gérer ses favoris**
   - Ajouter/supprimer des favoris
   - Voir la liste des favoris

### Pour les Admins

1. **Dashboard statistiques**
   - Nombre d'utilisateurs
   - Filières les plus recommandées
   - Statistiques globales

2. **Gérer les universités**
   - Ajouter/modifier/supprimer

3. **Gérer les filières**
   - Ajouter/modifier/supprimer
   - Définir les critères d'admission

4. **Gérer les questions de test**
   - Créer/modifier/supprimer des questions
   - Ajouter des options de réponse

---

## 🐛 Dépannage

### "Erreur de connexion à PostgreSQL"

```bash
# Vérifier que PostgreSQL est en cours d'exécution
# Docker :
docker ps | grep postgres

# Local :
pg_isready -d orientation_universitaire -U postgres
```

### "Port 5000 déjà utilisé"

```bash
# Changer le port dans backend/.env
PORT=5001
```

### "Port 5173 déjà utilisé"

```bash
# Vite proposera automatiquement un port libre
```

### "Erreur lors du npm run seed"

```bash
# Assurez-vous que :
# 1. PostgreSQL est actif
# 2. DATABASE_URL est correct dans .env
# 3. Les tables n'existent pas déjà (sinon : npm run seed efface tout)
```

---

## 📚 Documentation supplémentaire

- **API** : http://localhost:5000/api/docs (Swagger)
- **Backend README** : [backend/README.md](backend/README.md)
- **Cahier des charges** : [PFE.pdf](PFE.pdf)

---

## 🎓 Algorithme de Recommandation IA

Le système de recommandation utilise plusieurs critères :

```
Score Final = Σ (Critère × Poids)

Critères :
- Compatibilité série bac (25%)
- Moyenne générale (20%)
- Centres d'intérêt - Similarité Jaccard (20%)
- Compétences (15%)
- Contraintes budget (10%)
- Contraintes durée (5%)
- Résultats test (5%)
```

[Voir détails dans le code](backend/services/recommendation.service.js)

---

## ✨ Améliorations futures

- [ ] Application mobile
- [ ] Chatbot intelligent
- [ ] Intégration avec données en temps réel
- [ ] API publique
- [ ] Support pour universités internationales
- [ ] Système de notifications

---

**Besoin d'aide ?** Consultez le README du backend ou contactez l'équipe développement.
