# Guide de Configuration du Panel Admin

Ce document détaille tous les pas pour configurer et tester complètement l'espace admin du projet OrientAI.

---

## Prérequis Vérifiés

[DONE] **Modèles Sequelize :**
- User, Universite, Filiere, Parcours [DONE]
- Settings [DONE] (créé)
- Testimonial [DONE] (créé)
- Question, OptionReponse, RecommendationRules [DONE]
- SessionTest, Recommendation, Favori [DONE]

[DONE] **Routes & Contrôleurs :**
- `/api/admin/*` - Gestion utilisateurs, questions, règles, témoignages, paramètres [DONE]
- `/api/universites/*` - CRUD universités [DONE]
- `/api/filieres/*` - CRUD filières [DONE]
- `/api/stats/*` - Statistiques & dashboard [DONE]

[DONE] **Middleware d'Authentification :**
- `protect` - Vérifie le JWT token [DONE]
- `adminOnly` - Réserve l'accès aux admins [DONE]

[DONE] **Pages Admin Frontend :**
- AdminOverview, AdminUniversities, AdminFilieres [DONE]
- AdminUsers, AdminRules, AdminSettings [DONE]
- AdminStatistics, AdminTestimonials, AdminTests [DONE]
- AdminParcours, AdminFields [DONE]

---

## 🔧 Étape 1 : Préparer la Base de Données

### 1a. Vérifier la configuration d'environnement

Assurez-vous que votre fichier `.env` backend contient :

```env
# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=orientai_db
DB_USER=postgres
DB_PASSWORD=your_password

# JWT
JWT_SECRET=your_secret_key
JWT_EXPIRES_IN=7d

# Server
PORT=5000
NODE_ENV=development
CLIENT_URL=http://localhost:5173
```

### 1b. Créer la base de données (si nécessaire)

```bash
# Avec psql
createdb orientai_db
```

Ou via pgAdmin si vous utilisez une interface graphique.

---

## 💾 Étape 2 : Exécuter le Seeder

### 2a. Naviguez dans le dossier backend

```bash
cd backend
```

### 2b. Installez les dépendances (si nécessaire)

```bash
npm install
```

### 2c. Exécutez le seeder

```bash
# Nouvelle commande dédiée
npm run seed:fresh

# OU l'ancienne commande
npm run seed
```

**Résultat attendu :**

```
[DONE] Connexion établie

[SEED] Démarrage du seeding de la base de données...
[DONE] Tables synchronisées
[DONE] Admin créé : admin@orientai.mg / admin123456
[DONE] 4 utilisateurs bacheliiers créés
[DONE] 5 universités créées
[DONE] 6 filières créées
[DONE] Parcours créés
[DONE] Paramètres créés
[DONE] Règles de recommandation créées
[DONE] Témoignages créés
[DONE] Questions créés
[DONE] Options de réponse créées

[DONE] [DONE] [DONE] Seeding terminé avec succès ! [DONE] [DONE] [DONE]
```

---

## Étape 3 : Démarrer le Backend

### 3a. En mode développement

```bash
npm run dev
```

**Résultat attendu :**

```
[DONE] Base de données connectée
[LAUNCH] Serveur lancé sur http://localhost:5000
[DOCS] Documentation Swagger: http://localhost:5000/api/docs
```

### 3b. En mode production

```bash
npm start
```

---

## Étape 4 : Démarrer le Frontend

Dans un autre terminal :

```bash
cd ../
npm run dev
```

L'application sera disponible sur `http://localhost:5173`

---

## 🔐 Étape 5 : Se Connecter au Panel Admin

### Identifiants de test créés par le seeder :

#### Admin

- **Email :** `admin@orientai.mg`
- **Mot de passe :** `admin123456`
- **Rôle :** Admin

#### Bacheliiers (pour tester les restrictions)

- **Email :** `martin.rakoto@email.mg`
- **Mot de passe :** `password123`
- **Rôle :** Bachelier

### Procédure de connexion :

1. Allez sur `http://localhost:5173`
2. Cliquez sur "Se connecter"
3. Entrez `admin@orientai.mg` et `admin123456`
4. Cliquez sur "Connexion"
5. Vous serez redirigé vers `/admin/overview`

---

## Étape 6 : Tester les Fonctionnalités du Panel Admin

### 6a. Page d'Accueil Admin (`/admin/overview`)

- [DONE] Affiche les KPIs (total utilisateurs, universités, filières, etc.)
- [DONE] Affiche les filières les plus recommandées
- [DONE] Affiche les statistiques de compatibilité

### 6b. Gestion des Universités (`/admin/universites`)

- [DONE] Liste toutes les universités
- [DONE] Boutons : Ajouter, Modifier, Supprimer
- [DONE] Filtre par ville
- [DONE] Export en CSV
- **À tester :**
  ```
  POST /api/universites
  PUT /api/universites/:id
  DELETE /api/universites/:id
  GET /api/universites
  ```

### 6c. Gestion des Filières (`/admin/filieres`)

- [DONE] Liste toutes les filières
- [DONE] CRUD complet (Créer, Lire, Modifier, Supprimer)
- [DONE] Filtre par niveau, domaine, université
- **À tester :**
  ```
  POST /api/filieres
  PUT /api/filieres/:id
  DELETE /api/filieres/:id
  GET /api/filieres
  ```

### 6d. Gestion des Utilisateurs (`/admin/users`)

- [DONE] Liste tous les utilisateurs (admin + bacheliiers)
- [DONE] CRUD complet
- [DONE] Activation/Désactivation des comptes
- **À tester :**
  ```
  GET /api/admin/users
  POST /api/admin/users
  PUT /api/admin/users/:id
  DELETE /api/admin/users/:id
  PATCH /api/admin/users/:id/toggle
  ```

### 6e. Gestion des Règles de Recommandation (`/admin/rules`)

- [DONE] Liste toutes les règles
- [DONE] Poids des critères (série, moyenne, intérêt, compétences, budget, durée, test)
- [DONE] Validation : somme des poids = 100
- **À tester :**
  ```
  GET /api/admin/recommendation-rules
  POST /api/admin/recommendation-rules
  PUT /api/admin/recommendation-rules/:id
  PATCH /api/admin/recommendation-rules/:id/activate
  DELETE /api/admin/recommendation-rules/:id
  ```

### 6f. Gestion des Paramètres (`/admin/settings`)

- [DONE] Nom plateforme, description
- [DONE] Email de contact
- [DONE] Notifications et alertes (toggles)
- [DONE] Mode maintenance
- **À tester :**
  ```
  GET /api/admin/settings
  PUT /api/admin/settings
  ```

### 6g. Gestion des Témoignages (`/admin/testimonials`)

- [DONE] Liste les témoignages avec statut (Approuvé, En attente, Rejeté)
- [DONE] Approbation/Rejet de témoignages
- **À tester :**
  ```
  GET /api/admin/testimonials
  POST /api/admin/testimonials
  PUT /api/admin/testimonials/:id
  PATCH /api/admin/testimonials/:id/approve
  PATCH /api/admin/testimonials/:id/reject
  DELETE /api/admin/testimonials/:id
  ```

### 6h. Gestion des Tests (`/admin/tests`)

- [DONE] Questions du test d'orientation
- [DONE] Création/modification/suppression de questions
- **À tester :**
  ```
  POST /api/admin/questions
  PUT /api/admin/questions/:id
  DELETE /api/admin/questions/:id
  ```

### 6i. Statistiques Avancées (`/admin/statistics`)

- [DONE] Graphiques de recommandation par filière
- [DONE] Répartition des utilisateurs par série bac
- [DONE] Top filières recommandées
- [DONE] Répartition par domaine
- [DONE] Résumé des profils utilisateurs
- **À tester :**
  ```
  GET /api/stats/dashboard
  ```

---

## Étape 7 : Tests API avec cURL ou Postman

### 7a. Obtenir un token d'authentification

```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@orientai.mg","mot_de_passe":"admin123456"}'

# Réponse :
# {
#   "success": true,
#   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
#   "user": {...}
# }
```

### 7b. Utiliser le token pour une requête protégée

```bash
# Remplacez TOKEN_HERE par le token obtenu ci-dessus
curl -X GET http://localhost:5000/api/admin/users \
  -H "Authorization: Bearer TOKEN_HERE"
```

### 7c. Tester les statistiques

```bash
curl -X GET http://localhost:5000/api/stats/dashboard \
  -H "Authorization: Bearer TOKEN_HERE"
```

### 7d. Créer une nouvelle université

```bash
curl -X POST http://localhost:5000/api/universites \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TOKEN_HERE" \
  -d '{
    "nom":"Université de Test",
    "type":"publique",
    "ville":"Test City",
    "site_web":"https://test.mg",
    "email_contact":"test@test.mg"
  }'
```

---

## Checklist de Vérification Complète

### Backend

- [ ] Base de données créée et accessible
- [ ] Seeder exécuté avec succès
- [ ] Serveur backend lancé (`npm run dev`)
- [ ] Authentification fonctionne (`/api/auth/login`)
- [ ] Middleware `protect` et `adminOnly` fonctionnels
- [ ] Routes admin accessible (`/api/admin/*`)
- [ ] Routes universités/filières accessibles

### Frontend Admin

- [ ] Application frontend lancée (`npm run dev`)
- [ ] Connexion avec admin@orientai.mg réussie
- [ ] Redirection vers `/admin/overview`
- [ ] Statistiques affichées correctement
- [ ] Liste des universités chargée
- [ ] Liste des filières chargée
- [ ] Liste des utilisateurs chargée

### Fonctionnalités CRUD

- [ ] **Universités :** Créer, Lire, Modifier, Supprimer
- [ ] **Filières :** Créer, Lire, Modifier, Supprimer
- [ ] **Utilisateurs :** Créer, Lire, Modifier, Supprimer, Toggle statut
- [ ] **Règles :** Créer, Modifier, Supprimer, Activer comme défaut
- [ ] **Témoignages :** Approuver, Rejeter, Supprimer
- [ ] **Paramètres :** Sauvegarder les modifications

### Sécurité

- [ ] Un bachelier ne peut pas accéder aux routes admin
- [ ] Un utilisateur sans token ne peut pas accéder aux routes protégées
- [ ] Token expiré rejette la requête
- [ ] Compte désactivé empêche la connexion

---

## 🐛 Dépannage

### Erreur : "Base de données non trouvée"

```bash
# Créez la base de données
createdb orientai_db

# Re-lancez le seeder
npm run seed:fresh
```

### Erreur : "Token manquant" ou "Token invalide"

- Vérifiez que le JWT_SECRET dans .env existe
- Assurez-vous que le token est inclus dans l'en-tête `Authorization: Bearer TOKEN`

### Erreur : "Accès refusé. Admin requis"

- Vérifiez que vous êtes connecté avec un compte admin
- Vérifiez que le rôle est bien "admin" dans la BD

### Les données du seeder ne s'affichent pas

```bash
# Réinitialisez les tables et reseedez
npm run seed:fresh
```

### Problème de connexion frontend-backend

- Vérifiez que `VITE_API_URL` dans le frontend pointe vers `http://localhost:5000/api`
- Vérifiez que le backend CORS est bien configuré

---

## Prochaines Étapes (Optionnel)

- [ ] Ajouter des validations supplémentaires côté frontend
- [ ] Implémenter la pagination côté backend pour les grosses listes
- [ ] Ajouter des filtres avancés
- [ ] Générer des rapports PDF
- [ ] Implémenter un système de logs audit
- [ ] Ajouter la suppression en masse (bulk delete)
- [ ] Ajouter l'import CSV pour les données

---

## Support

Si vous rencontrez des problèmes :

1. Vérifiez les logs du backend (`npm run dev`)
2. Vérifiez les logs du frontend (Console Chrome/Firefox)
3. Vérifiez que les ports 5000 et 5173 sont libres
4. Vérifiez les identifiants de base de données dans `.env`

---

**[DONE] Configuration complète du panel admin terminée !**
