# 🔄 Flux de données - Service IA Amélioré

## Architecture complète

```
┌──────────────────────────────────────────────────────────────────┐
│                         FRONTEND                                 │
│                   (Quiz + Profil Utilisateur)                    │
└────────────────────────┬─────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────────────┐
│                   BACKEND NODE.JS                                │
│              (recommendation.controller.js)                      │
│                                                                  │
│  POST /api/recommendations/generer                              │
│  ├─ Récupère ProfilAcademique (user_id)                         │
│  ├─ Récupère SessionTest (session_test_id)                      │
│  ├─ Récupère tous les Filieres                                  │
│  └─ Appelle AIRecommendationService.generateRecommendationsML() │
└────────────────────────┬─────────────────────────────────────────┘
                         │
                         │ Payload:
                         │ {
                         │   profil: {
                         │     serie_bac: "S",
                         │     moyenne_generale: 15.5,
                         │     centres_interet: ["info", "science"],
                         │     competences: {...},
                         │     budget_max_mensuel: 500,
                         │     duree_max_etudes: 4,
                         │     distance_max_km: 100,
                         │     preference_type_univ: "publique",
                         │     ville_preference: "Antananarivo",
                         │ ★   objectifs_professionnels: "Ingénieur",
                         │ ★   secteur_vise: "Informatique",
                         │ ★   test_responses: {...}
                         │   },
                         │   filieres: [...],
                         │   scores_test: {...}
                         │ }
                         ▼
┌──────────────────────────────────────────────────────────────────┐
│           SERVICE IA PYTHON (ai_service:5000)                    │
│                    app.py                                        │
└────────────────────────┬─────────────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────────┐
        │  DataProcessor.prepare_profil_     │
        │  features(profil)                  │
        └────────┬─────────────────────────────┘
                 │
                 │ Transformation:
                 │ Input:
                 │ {
                 │   serie_bac: "S",
                 │   moyenne_generale: 15.5,
                 │   objectifs_professionnels: "Ingénieur",
                 │   secteur_vise: "Informatique",
                 │   test_responses: {
                 │     scores_par_categorie: {
                 │       "informatique": 92,
                 │       "sciences": 85,
                 │       "mathematiques": 88
                 │     }
                 │   }
                 │ }
                 │
                 │ ★ Appel: _calculate_test_alignment()
                 │ ★ Normalise moyenne (0-20 → 0-100)
                 │ ★ Normalise compétences (1-5 → 0-100)
                 │ ★ Calcule test_alignment_score (0-1)
                 │
                 ▼
        Output:
        {
          serie_bac: "S",
          moyenne_score: 77.5,  # (15.5/20)*100
          centres_interet: [...],
          centres_interet_match: 0.5,
          competences_score: 75.0,
          budget_max_mensuel: 500,
          duree_max_etudes: 4,
          distance_max_km: 100,
          preference_type_univ: "publique",
          ville_preference: "antananarivo",
          ★ objectifs_professionnels: "Ingénieur",
          ★ secteur_vise: "informatique",
          ★ test_alignment_score: 0.88,  # 0-1 normalisé
          chosen_filieres: []
        }
                 │
                 ▼
        ┌────────────────────────────────────┐
        │  RecommendationMLService.          │
        │  recommend_filieres(               │
        │    profil_features,                │
        │    filieres,                       │
        │    scores_test                     │
        │  )                                 │
        └────────┬─────────────────────────────┘
                 │
                 │ Pour chaque filière:
                 │
                 ├─→ _score_test_alignment()
                 │   ├─ Utilise test_alignment_score (0.88)
                 │   ├─ Compare avec centres_interet filière
                 │   └─ Retourne: 0-100
                 │
                 ├─→ _score_objectifs_secteur()
                 │   ├─ Match "Ingénieur" vs débouchés
                 │   ├─ Match "Informatique" vs centres
                 │   └─ Retourne: 0-100
                 │
                 ├─→ _score_serie_bac()
                 │   ├─ Vérifie si "S" acceptée
                 │   └─ Retourne: 0-100
                 │
                 ├─→ _score_distance_ville()
                 │   ├─ Compare "Antananarivo" vs lieu filière
                 │   ├─ Considère distance_max_km
                 │   └─ Retourne: 0-100
                 │
                 ├─→ _score_duree()
                 │   ├─ Vérifie durée <= 4 ans
                 │   └─ Retourne: 0-100
                 │
                 └─→ Autres scores...
                 │
                 ▼
        ┌────────────────────────────────────┐
        │  Scoring pondéré final:            │
        │                                    │
        │  score = (                         │
        │    test_align * 0.25 +             │
        │    objectifs * 0.20 +              │
        │    serie * 0.15 +                  │
        │    moyenne * 0.12 +                │
        │    centres_interet * 0.12 +        │
        │    localisation * 0.08 +           │
        │    duree * 0.05 +                  │
        │    competences * 0.03              │
        │  )                                 │
        │                                    │
        │  Exemple:                          │
        │  (92 * 0.25) +  # test            │
        │  (95 * 0.20) +  # objectifs       │
        │  (100 * 0.15) + # série           │
        │  ... = 94                          │
        └────────┬─────────────────────────────┘
                 │
                 ▼
        ┌────────────────────────────────────┐
        │  _generer_raisons_principales()    │
        │                                    │
        │  Sélectionne top 5 raisons:        │
        │  1. Test score >= 60% → Raison    │
        │  2. Objectifs match >= 70% →      │
        │  3. Série match >= 80% →          │
        │  4. Moyenne >= 75% →              │
        │  5. Localisation exacte → Raison  │
        │                                    │
        │  Retourne: [                       │
        │    "Vos réponses au test...",     │
        │    "Cette filière correspond...",  │
        │    "Votre série S est...",        │
        │    "Votre moyenne est...",        │
        │    "Localisation exacte..."       │
        │  ]                                 │
        └────────┬─────────────────────────────┘
                 │
                 ▼
        ┌────────────────────────────────────┐
        │  _get_strengths() &                │
        │  _get_weaknesses()                 │
        │                                    │
        │  Strengths:                        │
        │  - test >= 75% → "Excellente"     │
        │  - objectifs >= 85% → "Alignée"  │
        │  - serie >= 90% → "Prioritaire"  │
        │  - moyenne >= 75% → "Excellente"  │
        │  - taux_emploi >= 80% → "Très bon"│
        │                                    │
        │  Weaknesses:                       │
        │  - test < 40% → "Faible"         │
        │  - localisation != pref → "Non"   │
        │  - duree > max → "Trop long"      │
        │  - cout > budget → "Coûteux"      │
        └────────┬─────────────────────────────┘
                 │
                 ▼
        ┌────────────────────────────────────┐
        │  _generate_justification()         │
        │                                    │
        │  Retourne structure JSON:          │
        │  {                                 │
        │    score_global: 94,               │
        │    pourquoi_cette_recommandation: │
        │    {                               │
        │      titre: "Pourquoi...",         │
        │      raisons: [...5],              │
        │      resume: "court résumé"        │
        │    },                              │
        │    criteres_analyzes: {            │
        │      test_orientation: {...},      │
        │      objectifs_secteur: {...},     │
        │      ...                           │
        │    },                              │
        │    points_forts: [...5],           │
        │    points_attention: [...4],       │
        │    debouches: [...],               │
        │    taux_emploi: 87,                │
        │    cout_annuel: 2500               │
        │  }                                 │
        └────────┬─────────────────────────────┘
                 │
                 │ ★ AMÉLIORATIONS APPLIQUÉES:
                 │ 1. Structure claire: "pourquoi_cette_recommandation"
                 │ 2. 5 raisons max, spécifiques au profil
                 │ 3. Détail de chaque critère avec impact %
                 │ 4. Points forts/faibles dynamiques
                 │ 5. Données complémentaires
                 │
                 ▼
        ┌────────────────────────────────────┐
        │  Assemblage final: recommendations │
        │                                    │
        │  [                                 │
        │    {                               │
        │      filiere_id: 42,               │
        │      nom: "Licence Informatique",  │
        │      score: 94,                    │
        │      justification: { ← ENRICHIE   │
        │        pourquoi_cette_...          │
        │        criteres_analyzes: {...},   │
        │        points_forts: [...],        │
        │        points_attention: [...]     │
        │      }                             │
        │    },                              │
        │    { ... autre filière ... }       │
        │  ]                                 │
        └────────┬─────────────────────────────┘
                 │
                 │ Tri par score descendant
                 │
                 ▼
┌──────────────────────────────────────────────────────────────────┐
│               RÉPONSE JSON (HTTP 200)                            │
│                                                                  │
│ {                                                                │
│   success: true,                                                │
│   count: 8,                                                      │
│   recommendations: [                                             │
│     {                                                            │
│       filiere_id: 42,                                            │
│       nom: "Licence Informatique",                               │
│       score: 94,                                                 │
│       justification: {                                           │
│         score_global: 94,                                        │
│         pourquoi_cette_recommandation: {                         │
│           titre: "Pourquoi cette recommandation ?",              │
│           raisons: [                                             │
│             "Vos réponses au test correspondent...",             │
│             "Cette filière correspond...",                       │
│             "Votre série S est...",                              │
│             "Votre moyenne est...",                              │
│             "Localisation exacte..."                             │
│           ],                                                     │
│           resume: "Vos réponses... Cette filière... Autres..."  │
│         },                                                       │
│         criteres_analyzes: {                                     │
│           test_orientation: {                                    │
│             label: "Test d'orientation",                         │
│             impact: "25% (Principal)",                           │
│             score: 92,                                           │
│             detail: "Excellente correspondance (92%)..."         │
│           },                                                     │
│           ...                                                    │
│         },                                                       │
│         points_forts: [...],                                     │
│         points_attention: [...]                                  │
│       }                                                          │
│     }                                                            │
│   ]                                                              │
│ }                                                                │
└────────────────────────┬─────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────────────┐
│                         FRONTEND                                 │
│                   (Affichage recommandations)                    │
│                                                                  │
│ Affiche pour chaque recommandation:                              │
│                                                                  │
│ ┌─ Score: 94/100                                               │
│ ├─ Pourquoi cette recommandation ?                              │
│ │  ✓ Vos réponses au test correspondent excellemment           │
│ │  ✓ Cette filière correspond directement à votre objectif      │
│ │  ✓ Votre série S est prioritaire                             │
│ │  ✓ Votre moyenne est excellente                              │
│ │  ✓ Localisation exacte à Antananarivo                        │
│ │                                                               │
│ ├─ Critères analysés:                                           │
│ │  Test d'orientation: ████████ 92% (25%)                      │
│ │  Objectif/Secteur: █████████ 95% (20%)                       │
│ │  Série bac: ██████████ 100% (15%)                            │
│ │  ...                                                          │
│ │                                                               │
│ ├─ Points forts:                                                │
│ │  ✓ Excellente correspondance test                             │
│ │  ✓ Alignement objectif exact                                  │
│ │  ✓ Taux emploi: 87%                                           │
│ │                                                               │
│ └─ Points attention: Aucun                                       │
│                                                                  │
│ Débouchés: Ingénieur, Consultant, Développeur...                │
│ Taux emploi: 87% | Coût: 2500€/an                               │
│                                                                  │
│ [❤️ Ajouter aux favoris]  [👁️ Plus de détails]                 │
└──────────────────────────────────────────────────────────────────┘
```

## Transformation des données clés

### Test d'orientation
```
Input (SessionTest.scores):
{
  "informatique": 92,
  "sciences": 85,
  "mathematiques": 88
}

↓ DataProcessor._calculate_test_alignment()

Output (profil_features):
{
  test_alignment_score: 0.88  # 0-1 normalisé
}

↓ RecommendationMLService._score_test_alignment()

Final (score 0-100):
92
```

### Objectifs & Secteur
```
Input (ProfilAcademique):
{
  objectifs_professionnels: "Devenir ingénieur en informatique",
  secteur_vise: "Informatique"
}

↓ RecommendationMLService._score_objectifs_secteur()

Analyse:
- "Informatique" (profil) vs centres_interet filière
- "Ingénieur" vs débouchés filière
- Match exact? → 95 points
- Partial match? → 80 points
- No match? → 40 points

Output: 95
```

### Localisation
```
Input:
{
  ville_preference: "Antananarivo",
  distance_max_km: 100
}

↓ RecommendationMLService._score_distance_ville()

Analyse:
- ville_filiere == "Antananarivo" → 100
- ville_filiere != "Antananarivo" → penalty

Output: 100 ou < 100
```

## Points importants

✅ **Tous les critères utilisateur sont utilisés**
- Objectifs professionnels
- Secteur visé
- Ville préférée
- Distance maximale
- Durée maximale
- Réponses du test (toutes)

✅ **Justification transparente et détaillée**
- Section "Pourquoi cette recommandation?" avec raisons claires
- Analyse de chaque critère avec impact %
- Points forts et attention dynamiques

✅ **Données spécifiques au profil**
- Les raisons et détails utilisent les données réelles de l'utilisateur
- Comparaisons chiffrées (moyennes, scores, etc.)
- Lien explicite entre profil et recommandation

✅ **Structure JSON prête pour le frontend**
- Facile à parser et afficher
- Sections logiques et imbriquées
- Format cohérent pour toutes les recommandations
