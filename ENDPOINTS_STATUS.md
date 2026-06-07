# État des Endpoints et Intégration Frontend

## Résumé
Document récapitulatif de tous les endpoints API utilisés par le frontend et leur état d'intégration.

**Statut global:** En cours d'intégration  
**Dernière mise à jour:** 2024

---

## AUTHENTIFICATION (Auth)
Base URL: `/api/auth`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/auth/register` | POST | [DONE] | Register | [DONE] Implémenté |
| `/auth/login` | POST | [DONE] | Login | [DONE] Implémenté |
| `/auth/me` | GET | [DONE] | Dashboard | [DONE] Implémenté |
| `/auth/mot-de-passe/reinitialiser` | POST | [WARNING] | Login | [WARNING] À tester |

---

## PROFIL UTILISATEUR (Users)
Base URL: `/api/users`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/users/profil` | GET | [DONE] | Profile, Dashboard | [DONE] Implémenté |
| `/users/profil` | PUT | [DONE] | Profile | [DONE] Implémenté |
| `/users/profil/academique` | PUT | [DONE] | Profile | [DONE] Implémenté |
| `/users/favoris` | GET | [DONE] | Recommendations, Favorites | [DONE] Implémenté |
| `/users/favoris/{id}` | POST | [DONE] | Recommendations | [DONE] Implémenté |
| `/users/favoris/{id}` | DELETE | [DONE] | Recommendations, Favorites | [DONE] Implémenté |

---

## UNIVERSITÉS (Universities)
Base URL: `/api/universites`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/universites` | GET | [DONE] | MapExplorer, Search | [DONE] Implémenté |
| `/universites/{id}` | GET | [DONE] | UniversityDetails | [DONE] Implémenté |
| `/universites` | POST | [TODO] | Admin | [WARNING] Admin seulement |
| `/universites/{id}` | PUT | [TODO] | Admin | [WARNING] Admin seulement |
| `/universites/{id}` | DELETE | [TODO] | Admin | [WARNING] Admin seulement |

---

## FILIÈRES (Fields)
Base URL: `/api/filieres`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/filieres` | GET | [DONE] | Search, Compare, MapExplorer | [DONE] Implémenté |
| `/filieres/{id}` | GET | [DONE] | Recommendations | [DONE] Implémenté |
| `/filieres` | POST | [TODO] | Admin | [WARNING] Admin seulement |
| `/filieres/{id}` | PUT | [TODO] | Admin | [WARNING] Admin seulement |
| `/filieres/{id}` | DELETE | [TODO] | Admin | [WARNING] Admin seulement |

---

## PARCOURS (Study Paths)
Base URL: `/api/parcours`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/parcours` | GET | [WARNING] | Non utilisé | [TODO] À implémenter |
| `/parcours/{id}` | GET | [WARNING] | Non utilisé | [TODO] À implémenter |
| `/parcours/filiere/{id}` | GET | [WARNING] | Non utilisé | [TODO] À implémenter |
| `/parcours` | POST | [TODO] | Admin | [WARNING] Admin seulement |

---

## TESTS D'ORIENTATION (Tests)
Base URL: `/api/test`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/test/questions` | GET | [DONE] | OrientationTest | [DONE] Implémenté |
| `/test/demarrer` | POST | [DONE] | OrientationTest | [DONE] Implémenté |
| `/test/{id}/repondre` | POST | [DONE] | OrientationTest | [DONE] Implémenté |
| `/test/{id}/terminer` | POST | [DONE] | OrientationTest, TestResults | [DONE] Implémenté |
| `/test/historique` | GET | [DONE] | Dashboard, TestsList, History | [DONE] Implémenté |

---

## RECOMMANDATIONS (Recommendations)
Base URL: `/api/recommendations`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/recommendations/generer` | POST | [DONE] | Recommendations, Dashboard | [DONE] Implémenté |
| `/recommendations/mes-recommendations` | GET | [DONE] | Recommendations, Compare, Dashboard | [DONE] Implémenté |
| `/recommendations/{id}/sauvegarder` | PATCH | [DONE] | Recommendations | [DONE] Implémenté |
| `/recommendations/{id}/explication` | GET | [WARNING] | Recommendations (modal) | [WARNING] À tester |
| **NEW:** `/recommendations/ml/entrainer-modeles` | POST | [TODO] | Admin | [NEW] À implémenter |
| **NEW:** `/recommendations/ml/feature-importance` | GET | [TODO] | AdminStatistics | [NEW] À implémenter |

---

## COMPARATEUR (Comparison)
Base URL: `/api/comparateur`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/comparateur` | POST | [DONE] | Compare | [DONE] Implémenté |

---

## STATISTIQUES (Statistics)
Base URL: `/api/stats`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/stats/dashboard` | GET | [WARNING] | AdminOverview | [WARNING] À tester |
| `/stats/filieres/{id}` | GET | [WARNING] | Non implémenté | [TODO] À implémenter |
| `/stats/moi` | GET | [DONE] | Dashboard | [DONE] Implémenté |

---

## ADMINISTRATION (Admin)
Base URL: `/api/admin`

### Utilisateurs
| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/admin/users` | GET | [DONE] | AdminUsers | [DONE] Implémenté |
| `/admin/users` | POST | [DONE] | AdminUsers | [DONE] Implémenté |
| `/admin/users/{id}` | PUT | [DONE] | AdminUsers | [DONE] Implémenté |
| `/admin/users/{id}` | DELETE | [DONE] | AdminUsers | [DONE] Implémenté |
| `/admin/users/{id}/toggle` | PATCH | [DONE] | AdminUsers | [DONE] Implémenté |

### Questions de Test
| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/admin/questions` | POST | [DONE] | AdminTests | [DONE] Implémenté |
| `/admin/questions/{id}` | PUT | [DONE] | AdminTests | [DONE] Implémenté |
| `/admin/questions/{id}` | DELETE | [DONE] | AdminTests | [DONE] Implémenté |

### Règles de Recommandation
| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/admin/recommendation-rules` | GET | [DONE] | AdminRules | [DONE] Implémenté |
| `/admin/recommendation-rules/{id}` | GET | [DONE] | AdminRules | [DONE] Implémenté |
| `/admin/recommendation-rules/active` | GET | [DONE] | AdminRules | [DONE] Implémenté |
| `/admin/recommendation-rules` | POST | [DONE] | AdminRules | [DONE] Implémenté |
| `/admin/recommendation-rules/{id}` | PUT | [DONE] | AdminRules | [DONE] Implémenté |
| `/admin/recommendation-rules/{id}/activate` | PATCH | [DONE] | AdminRules | [DONE] Implémenté |
| `/admin/recommendation-rules/{id}` | DELETE | [DONE] | AdminRules | [DONE] Implémenté |

### Témoignages
| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/admin/testimonials` | GET | [DONE] | AdminTestimonials | [DONE] Implémenté |
| `/admin/testimonials` | POST | [DONE] | AdminTestimonials | [DONE] Implémenté |
| `/admin/testimonials/{id}` | PUT | [DONE] | AdminTestimonials | [DONE] Implémenté |
| `/admin/testimonials/{id}` | DELETE | [DONE] | AdminTestimonials | [DONE] Implémenté |
| `/admin/testimonials/{id}/approve` | PATCH | [DONE] | AdminTestimonials | [DONE] Implémenté |
| `/admin/testimonials/{id}/reject` | PATCH | [DONE] | AdminTestimonials | [DONE] Implémenté |

### Settings
| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/admin/settings` | GET | [DONE] | AdminSettings | [DONE] Implémenté |
| `/admin/settings` | PUT | [DONE] | AdminSettings | [DONE] Implémenté |

---

## TÉMOIGNAGES (Public)
Base URL: `/api/testimonials`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/testimonials` | GET | [DONE] | Index | [DONE] Implémenté |
| `/testimonials/{id}` | GET | [WARNING] | Non implémenté | [TODO] À implémenter |

---

## HEALTH CHECK
Base URL: `/api`

| Endpoint | Méthode | Utilisé | Pages | Statut |
|----------|---------|---------|-------|--------|
| `/health` | GET | [WARNING] | Navigation | [DONE] Implémenté |

---

## Pages et leurs endpoints

### Index
- `GET /testimonials` - Témoignages approuvés

### Login
- `POST /auth/login` - Connexion
- `POST /auth/mot-de-passe/reinitialiser` - Réinitialisation mot de passe

### Register
- `POST /auth/register` - Inscription

### Dashboard
- `GET /auth/me` - Utilisateur courant
- `GET /stats/moi` - Statistiques personnelles
- `GET /recommendations/mes-recommendations` - Recommandations
- `GET /test/historique` - Historique tests
- `GET /users/favoris` - Favoris

### Profile
- `GET /users/profil` - Profil utilisateur
- `PUT /users/profil` - Mise à jour profil
- `PUT /users/profil/academique` - Mise à jour profil académique

### Orientation Test
- `GET /test/questions` - Questions du test
- `POST /test/demarrer` - Démarrer un test
- `POST /test/{id}/repondre` - Répondre à une question
- `POST /test/{id}/terminer` - Terminer le test

### Test Results
- `POST /test/{id}/terminer` - Résultats du test
- `GET /recommendations/generer` - Générer recommandations

### Recommendations
- `GET /recommendations/mes-recommendations` - Liste des recommandations
- `POST /recommendations/generer` - Générer recommandations
- `GET /recommendations/{id}/explication` - Explication d'une recommandation
- `PATCH /recommendations/{id}/sauvegarder` - Sauvegarder/retirer des favoris
- `GET /users/favoris` - Récupérer les favoris

### Compare
- `GET /recommendations/mes-recommendations` - Recommandations
- `GET /filieres?page=1&limit=3` - Filières par défaut
- `POST /comparateur` - Comparaison de filières

### Search
- `GET /universites?page={p}&limit={l}` - Recherche universités
- `GET /filieres?page={p}&limit={l}` - Recherche filières
- `GET /universites/{id}` - Détails université
- `GET /filieres/{id}` - Détails filière

### Map Explorer
- `GET /universites` - Toutes les universités

### Favorites
- `GET /users/favoris` - Favoris
- `DELETE /users/favoris/{id}` - Supprimer des favoris

### History
- `GET /test/historique` - Historique des tests

### Notifications
- (Pas d'endpoints spécifiques)

### Guide & About & Blog & FAQ
- (Pages statiques)

---

## Admin Pages

### Admin Overview
- `GET /stats/dashboard` - Statistiques globales

### Admin Users
- `GET /admin/users?page={p}&limit={l}&role={r}` - Liste utilisateurs
- `POST /admin/users` - Créer utilisateur
- `PUT /admin/users/{id}` - Modifier utilisateur
- `DELETE /admin/users/{id}` - Supprimer utilisateur
- `PATCH /admin/users/{id}/toggle` - Activer/désactiver

### Admin Tests
- `POST /admin/questions` - Créer question
- `PUT /admin/questions/{id}` - Modifier question
- `DELETE /admin/questions/{id}` - Supprimer question

### Admin Rules
- `GET /admin/recommendation-rules` - Liste des règles
- `GET /admin/recommendation-rules/{id}` - Détail règle
- `GET /admin/recommendation-rules/active` - Règle active
- `POST /admin/recommendation-rules` - Créer règle
- `PUT /admin/recommendation-rules/{id}` - Modifier règle
- `PATCH /admin/recommendation-rules/{id}/activate` - Activer règle
- `DELETE /admin/recommendation-rules/{id}` - Supprimer règle

### Admin Testimonials
- `GET /admin/testimonials?page={p}&limit={l}&status={s}` - Liste témoignages
- `POST /admin/testimonials` - Créer témoignage
- `PUT /admin/testimonials/{id}` - Modifier témoignage
- `DELETE /admin/testimonials/{id}` - Supprimer témoignage
- `PATCH /admin/testimonials/{id}/approve` - Approuver
- `PATCH /admin/testimonials/{id}/reject` - Rejeter

### Admin Settings
- `GET /admin/settings` - Paramètres
- `PUT /admin/settings` - Mettre à jour paramètres

### Admin Statistics
- `GET /stats/dashboard` - Statistiques
- **NEW:** `GET /recommendations/ml/feature-importance` - Feature importance

### Admin Fields
- (Pas d'endpoint dédié trouvé - voir Filières)

### Admin Universities
- (Pas d'endpoint dédié trouvé - voir Universités)

---

## ✅ Tâches Prioritaires

### Priority 1 - Critical (Core Features)
- [x] Auth endpoints (login, register)
- [x] Profil utilisateur (get, update)
- [x] Tests d'orientation (questions, demarrer, terminer)
- [x] Recommandations (generer, getMine, save)
- [x] Comparateur (compare)
- [x] Statistiques (getMine)
- [x] Admin users management
- [x] Admin recommendation rules

### Priority 2 - Important
- [ ] Explication détaillée recommandations (`/recommendations/{id}/explication`)
- [ ] Statistiques dashboard (`/stats/dashboard`)
- [ ] Parcours (si nécessaire)
- [ ] Détails université/filière complètes

### Priority 3 - Nice to Have
- [ ] Notifications (si implémenté)
- [ ] Blog & Guide intégration
- [ ] Fonctionnalités avancées admin

### Priority 4 - ML Integration (Futur)
- [ ] `/recommendations/ml/entrainer-modeles` - Training endpoint
- [ ] `/recommendations/ml/feature-importance` - Feature importance

---

## 🚀 Checklist d'Intégration Frontend

### Chaque endpoint doit avoir:
- [x] Fonction API client dans `src/lib/api.ts`
- [ ] Hook custom si besoin (ex: `useRecommendations`)
- [ ] Gestion des erreurs
- [ ] Loading state
- [ ] Affichage des résultats
- [ ] Tests (optionnel)

### Configuration requise:
- [x] Variable d'environnement `VITE_API_URL`
- [x] Token JWT dans localStorage
- [ ] Intercepteur pour tokens expiré
- [x] CORS configuré

---

## 📝 Notes Importantes

1. **Base URL**: Les endpoints sont préfixés par `/api`
   - Frontend: `http://localhost:5000/api` (VITE_API_URL)
   - Backend: Port 3000 (Node.js)
   - Service IA: Port 5000 (Python - optionnel pour le moment)

2. **Authentification**: 
   - Token JWT stocké dans `localStorage` sous clé `orientai_token`
   - Inclus automatiquement dans les headers avec le helper `apiCall`

3. **Erreurs**:
   - Toutes les erreurs jettent une exception
   - À gérer avec try/catch dans les composants

4. **Pagination**:
   - Utilise `page` et `limit` comme query params
   - Les réponses incluent généralement `total`, `page`, `limit`

---

## 🔄 Prochaines Étapes

1. **Vérifier chaque page** pour s'assurer que tous les endpoints sont correctement utilisés
2. **Tester en cascade** (Login → Dashboard → Recommendations → etc.)
3. **Implémenter les modales/détails** manquants
4. **Ajouter gestion d'erreurs** robuste partout
5. **Tester le flux complet** avec un utilisateur réel
6. **Documenter les cas limites** (pas de données, erreurs, etc.)
