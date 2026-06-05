# Guide de Test - Plateforme d'Orientation Universitaire

## Prérequis
- Node.js 16+ installé
- PostgreSQL en cours d'exécution avec `orientation_db` créée
- Redis (optionnel, pour les sessions)

## Démarrage des Services

### 1. Démarrer la base de données
```bash
# Vérifier que PostgreSQL est en cours d'exécution
# La base de données est configurée dans backend/.env
```

### 2. Démarrer le Backend
```bash
cd backend
npm install
npm run seed:fresh  # Initialiser la base de données
npm run dev         # Démarrer le serveur sur http://localhost:5000
```

### 3. Démarrer le Frontend
```bash
npm install
npm run dev         # Démarrer sur http://localhost:8080
```

## Flux de Test Principaux

### ✅ FLUX 1: Inscription et Connexion (Authentification)

#### Inscription
1. Aller à `http://localhost:8080/register`
2. Remplir le formulaire:
   - Nom: `Dupont`
   - Prénom: `Jean`
   - Email: `jean.dupont@test.mg`
   - Mot de passe: `Test1234!`
   - Série BAC: `Série C`
3. Cliquer sur "S'inscrire"
4. **Vérifications:**
   - ✓ Redirection vers `/dashboard` après succès
   - ✓ Token JWT sauvegardé dans localStorage
   - ✓ Profil utilisateur affiché dans le dashboard
   - ✓ Message d'erreur si email déjà utilisé

#### Connexion
1. Aller à `http://localhost:8080/login`
2. Remplir:
   - Email: `jean.dupont@test.mg`
   - Mot de passe: `Test1234!`
3. Cliquer sur "Connexion"
4. **Vérifications:**
   - ✓ Connexion réussie
   - ✓ Token sauvegardé
   - ✓ Redirection vers dashboard
   - ✓ Message d'erreur si identifiants invalides

---

### ✅ FLUX 2: Profil Académique

1. Accès: `/dashboard` > "Paramètres" ou `/profile`
2. Remplir les informations:
   - Série BAC: `Série C`
   - Année: `2024`
   - Moyenne générale: `15.5`
   - Notes par matière (voir formulaire)
   - Compétences auto-évaluées: `1-5` pour chacune
   - Centres d'intérêt: Sélectionner plusieurs
3. Indiquer les contraintes:
   - Budget max mensuel: `50000 Ar`
   - Distance max: `100 km`
   - Durée max études: `5 ans`
   - Préférence type université: `Public`
4. Cliquer "Enregistrer"
5. **Vérifications:**
   - ✓ Données sauvegardées en BD
   - ✓ Confirmation affichée
   - ✓ Profil % complété augmente

---

### ✅ FLUX 3: Test d'Orientation

1. Aller à `/tests` ou cliquer "Test d'orientation"
2. Cliquer "Démarrer le test"
3. Pour chaque question:
   - Lire la question
   - Sélectionner une réponse
   - Cliquer "Suivant"
4. À la fin: Cliquer "Voir mes recommandations"
5. **Vérifications:**
   - ✓ Questions chargées correctement
   - ✓ Progression affichée (% et barres)
   - ✓ Réponses persistées en BD
   - ✓ Redirection vers `/recommendations`
   - ✓ Scores calculés et affichés

---

### ✅ FLUX 4: Recommandations (Cœur du système)

1. Aller à `/recommendations`
2. Page affiche les recommandations triées par score
3. Pour chaque recommandation:
   - Vérifier score de compatibilité
   - Vérifier "Pourquoi cette recommandation?"
   - Voir rang et détails
4. Actions possibles:
   - Cliquer "Cœur" pour ajouter aux favoris
   - Cliquer "Détails" pour voir l'université
5. **Vérifications:**
   - ✓ Recommandations basées sur le profil
   - ✓ Scores entre 0-100
   - ✓ Justifications claires et pertinentes
   - ✓ Ajout/retrait des favoris fonctionne
   - ✓ Lien vers détails de l'université valide

---

### ✅ FLUX 5: Comparaison de Filières

1. Aller à `/compare`
2. Le système propose les 3 meilleures recommandations
3. Vérifier le tableau comparatif:
   - Université
   - Type (Public/Privé)
   - Niveau (Licence/Master/etc)
   - Durée
   - Coût
   - Difficultés/débouchés
4. **Vérifications:**
   - ✓ Données complètes affichées
   - ✓ Codes couleur pour faciliter la comparaison
   - ✓ ROI (retour sur investissement) calculé
   - ✓ Avantages/inconvénients listés

---

### ✅ FLUX 6: Recherche d'Universités

1. Aller à `/dashboard/search`
2. Utiliser les filtres:
   - Recherche par texte
   - Filtre par type (Public/Privé)
   - Filtre par province/région
3. Cliquer sur une université
4. Page détails:
   - Voir toutes les filières proposées
   - Voir parcours pour chaque filière
   - Voir coût, conditions, débouchés
5. **Vérifications:**
   - ✓ Filtres fonctionnent correctement
   - ✓ Recherche en temps réel
   - ✓ Pagination fonctionne
   - ✓ Détails complets affichés

---

### ✅ FLUX 7: Favoris et Historique

1. Ajouter plusieurs filières en favoris
2. Aller à `/favorites`
3. **Vérifications:**
   - ✓ Tous les favoris affichés
   - ✓ Nombre de favoris correct
   - ✓ Possibilité de supprimer un favori
   - ✓ Lien vers détails de la filière

4. Vérifier historique dans `/history`
   - Tests complétés
   - Dates de passage
   - Scores obtenus

---

### ✅ FLUX 8: Admin Dashboard (Rôle Administrateur)

#### Se connecter en tant qu'Admin
- Email: `admin@orientation.mg`
- Mot de passe: `Admin1234!`

#### Dashboard Admin `/admin`
- **Vérifications:**
  - ✓ Stats affichées: Utilisateurs, Universités, Filières, Recommandations
  - ✓ Graphiques de tendances
  - ✓ Top filières recommandées
  - ✓ Répartition par série BAC
  - ✓ Exports en CSV/PDF disponibles

---

### ✅ FLUX 9: Gestion des Données (Admin)

#### Gestion des Universités `/admin/universites`
1. Voir liste des universités
2. **Créer une nouvelle:**
   - Cliquer "+ Ajouter"
   - Remplir: Nom, Type, Ville, Site web, Email
   - Enregistrer
   - Vérification: ✓ Apparaît dans la liste

3. **Modifier une université:**
   - Cliquer sur l'université
   - Modifier les champs
   - Enregistrer
   - Vérification: ✓ Changements appliqués

4. **Supprimer:**
   - Cliquer menu ⋮
   - Sélectionner "Supprimer"
   - Confirmer
   - Vérification: ✓ Retrait de la liste

#### Gestion des Filières `/admin/filieres`
- Mêmes opérations (CRUD)
- **Vérifications spécifiques:**
  - ✓ Filière liée à une université
  - ✓ Tous les paramètres sauvegardés

#### Gestion des Règles de Recommandation `/admin/rules`
1. Voir règles existantes
2. **Créer une nouvelle règle:**
   - Remplir nom et description
   - Ajuster les poids (total = 100%)
   - Définir seuils et filtres
   - Enregistrer
   - Vérification: ✓ Règle créée

3. **Activer une règle comme défaut:**
   - Cliquer "Activer"
   - Vérification: ✓ Marque dans liste

---

### ✅ FLUX 10: Gestion des Questions de Test (Admin)

1. Aller à `/admin/questions` ou `/admin/tests`
2. **Créer une question:**
   - Cliquer "+ Ajouter question"
   - Remplir texte, catégorie
   - Ajouter 4-5 options de réponse
   - Enregistrer
   - Vérification: ✓ Question apparaît

3. **Modifier/Supprimer:**
   - Mêmes opérations que autres modules

---

## Points Critiques à Tester

### Performance
- [ ] Chargement des pages < 2 secondes
- [ ] Recherche responsive (pas de lag)
- [ ] Recommandations générées en < 5 secondes

### Sécurité
- [ ] Token JWT valide et expirant
- [ ] Accès admin protégé (rôle requis)
- [ ] Pas d'accès direct aux données autres utilisateurs
- [ ] Injection SQL: Formulaires résistent

### Validation
- [ ] Formulaires rejettent données invalides
- [ ] Messages d'erreur clairs
- [ ] Pas de données corrompues en BD

### Données
- [ ] Recommandations pertinentes
- [ ] Scores cohérents (0-100)
- [ ] Pas de doublon en BD

---

## Cas d'Erreur à Tester

1. **Authentification:**
   - [ ] Email invalide → Erreur
   - [ ] Mot de passe oublié → Reset mail
   - [ ] Token expiré → Redirection login

2. **Profil:**
   - [ ] Données manquantes → Erreur
   - [ ] Valeurs invalides → Rejet

3. **Recommandations:**
   - [ ] Pas de profil complet → Message "Complétez votre profil"
   - [ ] Pas de test passé → "Passez le test"

4. **Admin:**
   - [ ] Non-admin accès `/admin` → Redirection
   - [ ] Suppression protégée (règle par défaut) → Erreur

---

## Checklist Finale

- [ ] Inscription/Connexion fonctionne
- [ ] Profil académique sauvegardé
- [ ] Test d'orientation complet
- [ ] Recommandations générées correctement
- [ ] Comparaison affichée
- [ ] Recherche d'universités fonctionnelle
- [ ] Favoris gérés
- [ ] Admin dashboard visible
- [ ] CRUD pour universités/filières OK
- [ ] Règles de recommandation modifiables
- [ ] Gestion des questions OK
- [ ] Pas d'erreurs en console
- [ ] Base de données cohérente

---

## Commandes Utiles

```bash
# Vérifier santé du backend
curl http://localhost:5000/api/health

# Vérifier token JWT
# Header: Authorization: Bearer <TOKEN>

# Seed frais
npm run seed:fresh

# Logs du serveur
npm run dev

# Tests unitaires (futur)
npm test
```

## Support et Debug

- Logs backend: `npm run dev` affiche tout
- DevTools: F12 en navigateur
- Vue React: React DevTools Chrome extension
- BD: Adminer, DBeaver ou psql CLI
