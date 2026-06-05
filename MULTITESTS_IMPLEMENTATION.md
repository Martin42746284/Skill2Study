# 📚 Multi-Tests Implementation Guide

## Overview
Système de tests multiples spécialisés pour améliorer les recommandations d'orientation universitaire.

---

## 🗄️ **Backend Models**

### 1. **Test** (`backend/models/Test.model.js`)
```javascript
{
  id: INTEGER (PK),
  nom: STRING(150),                    // ex: "Test de Mathématiques"
  description: TEXT,
  type: ENUM('diagnostic', 'specialise', 'competence'),
  domaine: STRING(100),                // ex: "mathematiques", "sciences"
  duree_minutes: INTEGER (default: 15),
  ordre: INTEGER,                      // pour l'affichage
  actif: BOOLEAN (default: true),
  createdAt: DATE,
  updatedAt: DATE
}
```

### 2. **TestQuestion** (`backend/models/Test.model.js`)
Relation many-to-many entre Tests et Questions
```javascript
{
  id: INTEGER (PK),
  test_id: INTEGER (FK),
  question_id: INTEGER (FK),
  ordre: INTEGER,                      // ordre des questions dans le test
  poids_importance: FLOAT (default: 1.0)
}
```

### 3. **SessionTestMulti** (`backend/models/Test.model.js`)
Sessions de test par utilisateur
```javascript
{
  id: INTEGER (PK),
  user_id: INTEGER (FK),
  test_id: INTEGER (FK),
  reponses: JSON { question_id: option_id },
  score: FLOAT (0-100),
  scores_par_domaine: JSON { domaine: score },
  complete: BOOLEAN (default: false),
  date_completion: DATE,
  createdAt: DATE,
  updatedAt: DATE
}
```

---

## 🔌 **API Endpoints**

### Base: `/api/tests-multi`

| Endpoint | Method | Auth | Description |
|----------|--------|------|-------------|
| `/` | GET | ❌ | Récupère tous les tests actifs |
| `/:testId` | GET | ❌ | Récupère un test avec ses questions |
| `/:testId/demarrer` | POST | ✅ | Crée une nouvelle session |
| `/:sessionId/repondre` | POST | ✅ | Soumet une réponse |
| `/:sessionId/terminer` | POST | ✅ | Termine le test et calcule les scores |
| `/user/historique` | GET | ✅ | Récupère l'historique de l'utilisateur |

---

## 📱 **Frontend Implementation**

### Files Created:

1. **`src/pages/MultiTests.tsx`**
   - Liste des tests spécialisés
   - Interface de passage de test
   - Gestion des réponses et navigation

2. **API Client** (`src/lib/api.ts`)
   - Export `multiTests` object avec tous les endpoints

3. **Routes** (`src/App.tsx`)
   - `/tests-multi` - Liste des tests
   - `/tests-multi/:testId` - Passage d'un test

4. **Navigation** (`src/components/DashboardLayout.tsx`)
   - Lien "Tests Spécialisés" dans la sidebar

---

## 🎯 **Scoring System**

### Comment ça marche:

1. **Chaque option de réponse** a des poids par domaine:
```json
{
  "texte": "J'aime les calculs complexes",
  "poids": {
    "mathematiques": 3,
    "ingenierie": 2,
    "sciences": 1
  }
}
```

2. **Calcul du score**:
   - Somme les poids pour chaque domaine
   - Normalise (0-100) en divisant par le max

3. **Stockage**:
   - Score global dans `SessionTestMulti.score`
   - Scores par domaine dans `SessionTestMulti.scores_par_domaine`

---

## 📊 **Example Data Structure**

### Test de Mathématiques
```
Test: "Test de Mathématiques"
├─ Question 1: "Résolvez: 2x + 5 = 13"
│  ├─ Réponse A: "x = 4" → {mathematiques: 3, ingenierie: 1}
│  ├─ Réponse B: "x = 3" → {mathematiques: 1}
│  └─ Réponse C: "x = 9" → {mathematiques: 0}
└─ Question 2: "Dérivée de x²?"
   ├─ Réponse A: "2x" → {mathematiques: 3, ingenierie: 2, sciences: 1}
   ├─ Réponse B: "x" → {mathematiques: 1}
   └─ Réponse C: "x³/3" → {mathematiques: 0}
```

---

## 🌱 **Seeding Tests**

Pour ajouter les tests d'exemple:

```bash
# Dans le script de seeding principal ou:
node backend/scripts/seed-multitests.js
```

Cela crée:
- 3 tests spécialisés (Maths, Sciences, Langues)
- 2 questions par test
- 3 options de réponse par question
- Poids d'importance pour chaque option

---

## 🔄 **Workflow Utilisateur**

1. **Vue Liste** (`/tests-multi`)
   - Affiche tous les tests disponibles
   - Bouton "Commencer" pour chaque test

2. **Vue Passage**
   - Question avec options cliquables
   - Navigation (Précédent/Suivant)
   - Bouton "Terminer" à la dernière question

3. **Résultats**
   - Score global et par domaine
   - Redirection vers `/tests-multi`
   - Historique dans profile utilisateur

---

## 📈 **Recommandation Logic (Future)**

Les scores des tests vont améliorer la logique de recommandation:

```
Score Compatibilité = 
  (25% × Tests Spécialisés) +     // ← NOUVEAU
  (25% × Série Bac) +
  (20% × Intérêts) + 
  (15% × Moyenne) + 
  (10% × Budget) + 
  (5% × Localisation)
```

À intégrer dans `backend/services/recommendation.service.js`

---

## 🛠️ **Integration Steps**

1. ✅ Créer les modèles
2. ✅ Créer les routes API
3. ✅ Créer l'UI frontend
4. ⏭️ **Intégrer dans la recommandation**
5. ⏭️ **Admin CRUD pour gérer les tests**

---

## 📝 **Notes**

- Tests et Questions sont découplés → Questions réutilisables
- SessionTestMulti = une session = un utilisateur + un test
- Scores normalisés 0-100 pour cohérence
- Historique conservé pour chaque utilisateur

