# 📋 Format de Justification Structuré

## Vue d'ensemble
La justification retournée par le service IA est maintenant **entièrement structurée** pour répondre clairement à "Pourquoi cette recommandation?".

## Structure JSON

```json
{
  "justification": {
    "score_global": 94,
    
    "pourquoi_cette_recommandation": {
      "titre": "Pourquoi cette recommandation ?",
      "raisons": [
        "Raison 1...",
        "Raison 2...",
        "Raison 3...",
        "Raison 4...",
        "Raison 5..."
      ],
      "resume": "Résumé court de toutes les raisons..."
    },
    
    "criteres_analyzes": {
      "test_orientation": {...},
      "objectifs_secteur": {...},
      "serie_bac": {...},
      "moyenne_generale": {...},
      "centres_interet": {...},
      "localisation": {...},
      "duree_etudes": {...}
    },
    
    "points_forts": [...],
    "points_attention": [...],
    "debouches": [...],
    "taux_emploi": 87,
    "cout_annuel": 2500
  }
}
```

## Détail de chaque section

### 1️⃣ `pourquoi_cette_recommandation` - LA RÉPONSE À LA QUESTION

**Format:**
```json
{
  "titre": "Pourquoi cette recommandation ?",
  "raisons": [
    "Vos réponses au test d'orientation correspondent excellemment aux domaines de cette filière (92%)",
    "Cette filière correspond directement à votre objectif en informatique",
    "Votre série \"S\" est prioritaire pour cette filière",
    "Votre moyenne (15.5/20) est excellente pour l'admission",
    "La localisation (Antananarivo) correspond exactement à votre préférence"
  ],
  "resume": "Vos réponses au test correspondent excellemment... Cette filière correspond directement... Autres facteurs positifs: Votre série S, Votre moyenne..."
}
```

**Caractéristiques:**
- 🎯 Max 5 raisons principales (claires et spécifiques)
- 📊 Chaque raison explique UN critère et son impact
- 🔢 Inclut les scores quand pertinent
- 📝 Langage simple et direct
- ✅ Liées aux données du profil utilisateur

**Exemples de raisons générées:**
```
✓ "Vos réponses au test d'orientation correspondent excellemment aux domaines de cette filière (92%)"
✓ "Cette filière correspond directement à votre objectif en informatique"
✓ "Votre série \"S\" est prioritaire pour cette filière"
✓ "Votre moyenne (15.5/20) est excellente pour l'admission"
✓ "La localisation (Antananarivo) correspond exactement à votre préférence"
✓ "Excellent taux d'emploi: 87% des diplômés trouvent un emploi"
✓ "Durée (3 ans) conforme à votre préférence"
```

---

### 2️⃣ `criteres_analyzes` - DÉTAIL DE CHAQUE CRITÈRE

**Format pour chaque critère:**
```json
{
  "test_orientation": {
    "label": "Test d'orientation",
    "impact": "25% (Principal)",
    "score": 92,
    "detail": "Excellente correspondance (92%) avec vos réponses au test"
  },
  "objectifs_secteur": {
    "label": "Objectif professionnel & Secteur",
    "impact": "20% (Principal)",
    "score": 95,
    "detail": "Objectif: Devenir ingénieur informatique | Secteur: Informatique"
  },
  "serie_bac": {
    "label": "Série du Bac",
    "impact": "15%",
    "score": 100,
    "detail": "Votre série \"S\" est bien acceptée par cette filière"
  },
  "moyenne_generale": {
    "label": "Moyenne générale",
    "impact": "12%",
    "score": 77.5,
    "detail": "Votre moyenne (15.5/20) est excellente pour l'admission"
  }
  // ... autres critères
}
```

**Chaque critère contient:**
- `label`: Nom du critère (pour affichage)
- `impact`: Poids du critère dans le calcul (%)
- `score`: Score 0-100 pour ce critère
- `detail`: Explication spécifique au profil de l'utilisateur

---

### 3️⃣ `points_forts` - Jusqu'à 5 points positifs

```json
"points_forts": [
  "Excellente correspondance avec test d'orientation (92%)",
  "Alignement directe avec objectif \"Ingénieur informatique\"",
  "Votre série S est prioritaire",
  "Localisation exacte à Antananarivo",
  "Très bon taux d'emploi: 87%"
]
```

**Généré automatiquement basé sur:**
- Scores > 80% aux critères clés
- Correspondances exactes (localisation, objectif, secteur)
- Taux d'emploi élevé
- Autres facteurs positifs

---

### 4️⃣ `points_attention` - Jusqu'à 4 points d'attention

```json
"points_attention": [
  "Localisation: Fianarantsoa (vous préférez Antananarivo)",
  "Coût annuel significatif par rapport à votre budget"
]
```

**Généré automatiquement si:**
- Score < 50% à un critère
- Localisation ≠ préférence
- Durée > préférence
- Coût > budget

---

### 5️⃣ Données supplémentaires

```json
{
  "debouches": [
    "Ingénieur informatique",
    "Consultant IT",
    "Développeur logiciel"
  ],
  "taux_emploi": 87,
  "cout_annuel": 2500,
  "type_universite": "publique"
}
```

---

## 🎨 Exemple d'affichage Frontend

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│  Licence Informatique                    Score: 94/100 │
│  Université d'Antananarivo                             │
│                                                         │
├─────────────────────────────────────────────────────────┤
│ 📋 Pourquoi cette recommandation ?                      │
│                                                         │
│ ✓ Vos réponses au test d'orientation correspondent    │
│   excellemment (92%) aux domaines de cette filière     │
│                                                         │
│ ✓ Cette filière correspond directement à votre        │
│   objectif en informatique                             │
│                                                         │
│ ✓ Votre série "S" est prioritaire                      │
│                                                         │
│ ✓ Votre moyenne (15.5/20) est excellente              │
│                                                         │
│ ✓ Localisation exacte: Antananarivo                    │
├─────────────────────────────────────────────────────────┤
│ 📊 Analyse des critères                                │
│                                                         │
│ Test d'orientation       ████████████ 92%  (25%)       │
│ Objectif/Secteur         ██████████████ 95% (20%)      │
│ Série bac                ███████████████ 100% (15%)    │
│ Moyenne générale         ████████░░░░░░ 77.5% (12%)   │
│ Centres d'intérêt        ████████░░░░░░ 88% (12%)     │
│ Localisation             ███████████████ 100% (8%)     │
│ Durée d'études           ███████████████ 100% (5%)     │
├─────────────────────────────────────────────────────────┤
│ 💪 Points forts                                         │
│   ✓ Excellente correspondance test (92%)               │
│   ✓ Alignement objectif "Ingénieur"                   │
│   ✓ Série S prioritaire                                │
│   ✓ Taux emploi excellent: 87%                        │
│                                                         │
│ ⚠️  Points d'attention                                  │
│    (Aucun signalé)                                      │
├─────────────────────────────────────────────────────────┤
│ 🎯 Débouchés professionnels                             │
│    • Ingénieur informatique                             │
│    • Consultant IT                                      │
│    • Développeur logiciel                               │
│                                                         │
│ 📈 Taux d'emploi: 87% | 💰 Coût: 2500€/an             │
│                                                         │
│ [❤️ Ajouter aux favoris]  [👁️ Voir détails]            │
└─────────────────────────────────────────────────────────┘
```

---

## 🔄 Logique de génération des raisons

```python
# Ordre de priorité pour générer les raisons (max 5)

1. Test d'orientation (score >= 60%)
   → "Vos réponses au test correspondent ... (%)"

2. Objectif professionnel (score >= 70%)
   → "Cette filière correspond à votre objectif en ..."

3. Série bac (score >= 80%)
   → "Votre série \"X\" est bien/prioritaire"

4. Moyenne générale (score >= 75%)
   → "Votre moyenne (X/20) est excellente"

5. Localisation (score >= 95%)
   → "Localisation exacte: ..."

6. Débouchés (si pas assez de raisons)
   → "Excellent taux d'emploi: X%"

7. Durée d'études (si pas assez de raisons)
   → "Durée (X ans) conforme à votre préférence"
```

---

## 📱 Cas d'usage Frontend

### Cas 1: Recommandation excellente (score > 85)
```
Les 5 raisons les plus fortes sont affichées
Tous les critères sont verts (score > 70%)
Pas de points d'attention
```

### Cas 2: Recommandation bonne (score 70-85)
```
Les 3-4 raisons les plus fortes
Certains critères jaunes (50-70%)
Max 2 points d'attention
```

### Cas 3: Recommandation acceptable (score 50-70)
```
Les 2 raisons principales
Plusieurs critères en attention
Jusqu'à 4 points d'attention
```

---

## ✅ Validation de la justification

La justification est valide si:
- ✓ `pourquoi_cette_recommandation` a au minimum 1 raison
- ✓ `raisons` array contient 1-5 items
- ✓ `criteres_analyzes` couvre 7 critères
- ✓ Tous les critères ont `label`, `impact`, `score`, `detail`
- ✓ `points_forts` ≤ 5 items
- ✓ `points_attention` ≤ 4 items

---

## 🚀 Intégration backend

```javascript
// Depuis recommendation.controller.js
const recommendations = await AIRecommendationService.generateRecommendationsML(
  profil,          // Inclut objectifs, secteur, ville_preference, etc.
  filieres,
  scoresTest
);

// recommendations[0].justification contient maintenant la structure complète
// avec "pourquoi_cette_recommandation" au lieu de l'ancien format
```

La justification s'affichera proprement au frontend car elle est:
- 📋 **Structurée** en JSON
- 🎯 **Lisible** avec titres clairs
- 📊 **Détaillée** pour chaque critère
- ✅ **Spécifique** au profil de l'utilisateur
