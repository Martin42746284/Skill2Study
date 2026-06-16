# 🚀 Guide d'Optimisation du Modèle ML - Skill2Study

## 📊 État actuel
- **1000 échantillons** d'entraînement
- **Score moyen: 74.46/100** (acceptable)
- **60% des scores ≥ 70** (cible: 75%+)
- **Random Forest avec 5 features** actuelles

---

## 🎯 PART 1: OPTIMISATION DU MODÈLE

### 1️⃣ **Augmenter les hyperparamètres** (Impact: Moyen)

**Actuel:**
```python
n_estimators=100
max_depth=10
min_samples_split=5
```

**Optimisé:**
```python
n_estimators=200          # Plus d'arbres = plus de robustesse
max_depth=15              # Plus de profondeur = meilleure capture des patterns
min_samples_split=3       # Moins restrictif = plus d'apprentissage
min_samples_leaf=1        # Permet les feuilles individuelles
max_features='sqrt'       # Aléatorité pour éviter overfitting
```

**Où changer:** `ai-service/services/model_trainer.py` lignes 92-98

---

### 2️⃣ **Ajouter des NOUVELLES FEATURES** (Impact: TRÈS HAUT ⭐)

**Features actuelles (5):**
- moyenne_score
- centres_interet_match
- competences_score
- budget_max_mensuel
- duree_max_etudes

**Features à AJOUTER (10 nouvelles):**

#### De ProfilAcademique:
1. **serie_bac_encoded** - Encoder la série du bac (Sciences=5, Lettres=3, Technique=4, etc.)
2. **mention_value** - Convertir la mention (Très bien=4, Bien=3, Assez bien=2, Passable=1)
3. **notes_matieres_variance** - Variance des notes (aptitude générale vs spécialisée)
4. **test_orientation_score** - Score global du test d'orientation (moyenne de scores_test)
5. **langue_preference** - Matching avec langue de la filière

#### De Filiere:
6. **difficulte_encoded** - Difficulté de la filière (facile=1, moyen=2, difficile=3, très_difficile=4)
7. **taux_emploi** - Taux d'emploi de la filière (0-100)
8. **salaire_match** - Adéquation salaire vs budget étudiant
9. **competences_match_score** - Score de matching des compétences requises
10. **debouches_diversity** - Diversité des débouchés professionnels

#### De Contexte:
11. **serie_bac_filiere_compatibility** - Score de compatibilité série/filière (élevé si bonne match)
12. **localisation_match** - Distance université vs localisation étudiant

---

### 3️⃣ **Utiliser un Ensemble Model** (Impact: Moyen)

Au lieu d'utiliser SEULEMENT Random Forest, combiner:
```python
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.linear_model import Ridge

# Créer 3 modèles
rf = RandomForestRegressor(...)
gb = GradientBoostingRegressor(...)
ridge = Ridge(alpha=1.0)

# Voting: moyenne pondérée
# RF: 50%, Gradient Boosting: 30%, Ridge: 20%
predictions = (
    0.5 * rf.predict(X) +
    0.3 * gb.predict(X) +
    0.2 * ridge.predict(X)
)
```

---

### 4️⃣ **Feature Engineering avancé** (Impact: Moyen)

```python
# Interaction features
X['serie_x_moyenne'] = X['serie_bac'] * X['moyenne_score']
X['competences_x_difficulte'] = X['competences_score'] * X['difficulte']

# Polynomial features (surtout pour moyenne générale)
from sklearn.preprocessing import PolynomialFeatures
poly = PolynomialFeatures(degree=2, include_bias=False)
X_poly = poly.fit_transform(X[['moyenne_score', 'test_orientation_score']])

# Distance features
X['budget_gap'] = abs(X['budget_max'] - X['salaire_moyen'])
```

---

### 5️⃣ **Stratégie d'entraînement améliorée** (Impact: Haut)

```python
# 1. Équilibrer les classes (si déséquilibré)
from imblearn.over_sampling import SMOTE
smote = SMOTE(sampling_strategy=0.7)
X_balanced, y_balanced = smote.fit_resample(X_train, y_train)

# 2. Utiliser StratifiedKFold au lieu de random split
from sklearn.model_selection import StratifiedKFold
skf = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)

# 3. Validation croisée temporelle (si données chronologiques)
from sklearn.model_selection import TimeSeriesSplit
tscv = TimeSeriesSplit(n_splits=5)
```

---

## 🎓 PART 2: COLLECTE DE PLUS DE DONNÉES

### 📈 Stratégies par ordre de priorité:

#### **1️⃣ Synthétiser les données existantes** (0-2 semaines)

**Problème:** Vous avez 1000 samples. Target: 3000-5000.

**Solution:** Data Augmentation
```javascript
// backend/scripts/generate-training-data.js (ÉTENDRE)

function augmentData(existingRecommendations) {
  const augmented = [];
  
  for (const rec of existingRecommendations) {
    augmented.push(rec); // Original
    
    // Perturbation 1: Moyenne légèrement différente (+/- 2 points)
    augmented.push({
      ...rec,
      moyenne_generale: rec.moyenne_generale + random(-2, 2),
      score_compatibilite: rec.score_compatibilite + random(-5, 5)
    });
    
    // Perturbation 2: Centres d'intérêt partiellement modifiés
    augmented.push({
      ...rec,
      centres_interet: shuffleArray(rec.centres_interet),
      score_compatibilite: rec.score_compatibilite + random(-3, 3)
    });
    
    // Perturbation 3: Autres paramètres
    augmented.push({
      ...rec,
      budget_max_mensuel: rec.budget_max * random(0.8, 1.2),
      score_compatibilite: rec.score_compatibilite + random(-4, 4)
    });
  }
  
  return augmented;
}
```

**Gain attendu:** 1000 → 4000 samples (4x multiplicateur)

---

#### **2️⃣ Collecter des données réelles** (2-4 semaines)

**Via l'application utilisateur:**

##### A. **Feedback explicite après recommandation**
```javascript
// Routes à ajouter:
POST /api/recommendation/:id/feedback
Body: {
  "is_relevant": true,
  "rating": 4,  // 1-5
  "comment": "Good match"
}

// Ceci crée des exemples positifs/négatifs certifiés
```

##### B. **Suivi du parcours de l'utilisateur**
```javascript
// Tracker ces événements:
- clicked_filiere: true
- visited_university_page: true
- saved_to_favorites: true
- viewed_requirements: true
- stayed_on_page: 45 (secondes)
- clicked_details: true

// = Signaux implicites d'intérêt/satisfaction
```

##### C. **Compléter les profils utilisateurs**
```javascript
// Créer des incitations pour que les users complètent:
- notes_matieres (actuellement sparse)
- competences (auto-évaluation)
- objectifs_professionnels (texte)
- experience_professionnelle (si bac+1)

// Gain: Features plus riches = meilleur ML
```

---

#### **3️⃣ Intégrer des données externes** (3-6 semaines)

**Sources à Madagascar:**

1. **MINESUP (Ministère Éducation)** - Données officielles filieres
2. **Universite.mg** - Catalogues de programmes
3. **Réseaux sociaux** - Témoignages étudiants
4. **Portails emploi locaux** - Matching skills/jobs

```javascript
// Script pour enrichir Filiere model:
// - Taux d'employabilité réel (pas estimé)
// - Témoignages d'anciens étudiants
// - Partenaires entreprises
// - Programmes de bourses
```

---

### 🎯 Plan de collecte (4 semaines):

**Semaine 1-2: Augmentation de données**
```bash
node backend/scripts/augment-training-data.js  # 4000 samples
node backend/scripts/train-ai-model.js
# Test: Vérifier si score passe à 76-78%
```

**Semaine 3: Feedback utilisateur**
- Ajouter bouton "Cette recommandation vous a-t-elle aidé?"
- Collecter +100 retours (2-3 semaines = +100 samples certifiés)

**Semaine 4+: Tracking implicite**
- Enregistrer clicks/views
- Analyser les sessions utilisateur
- Créer labels positifs/négatifs automatiquement

---

## 🔧 PART 3: IMPLÉMENTATION CONCRÈTE

### A. Ajouter les nouvelles features

**Fichier:** `ai-service/services/recommendation_ml.py` (nouvelle fonction)

```python
def extract_advanced_features(profil, filiere):
    """Extraire 12 features optimisées"""
    
    features = []
    
    # 1. Série BAC encoded
    serie_mapping = {
        'Sciences': 5,
        'Mathématiques': 4.5,
        'Technique': 3.5,
        'Lettres': 2,
        'Histoire-Géo': 2.5
    }
    features.append(serie_mapping.get(profil['serie_bac'], 2))
    
    # 2. Mention value
    mention_mapping = {
        'Très bien': 4,
        'Bien': 3,
        'Assez bien': 2,
        'Passable': 1
    }
    features.append(mention_mapping.get(profil.get('mention'), 1))
    
    # 3. Notes variance
    notes = profil.get('notes_matieres', {})
    if notes:
        values = list(notes.values())
        features.append(np.std(values) if len(values) > 1 else 0)
    else:
        features.append(0)
    
    # 4. Test orientation moyenne
    test_scores = profil.get('scores_test', {})
    avg_test = np.mean(list(test_scores.values())) / 100 if test_scores else 0.5
    features.append(avg_test)
    
    # 5-7. Autres features...
    
    return features
```

---

### B. Améliorer train-ai-model.js

```javascript
// Intégrer new features dans training data preparation
const { extractAdvancedFeatures } = require('../services/ml.service');

for (const rec of recommendations) {
  const advancedFeatures = extractAdvancedFeatures(profil, filiere);
  
  trainingData.push({
    profil_features: advancedFeatures,
    filiere_id: rec.filiere_id,
    accepted: rec.score_compatibilite >= 70,
    success: rec.score_compatibilite >= 80,
    engagement: rec.score_compatibilite / 100
  });
}
```

---

### C. Créer un script d'augmentation de données

**Fichier:** `backend/scripts/augment-training-data.js`

```javascript
async function augmentTrainingData() {
  const recommendations = await Recommendation.findAll({
    limit: 1000
  });
  
  const augmented = [];
  
  for (const rec of recommendations) {
    augmented.push(rec);
    
    // 3 variations par enregistrement = 4000 total
    for (let i = 0; i < 3; i++) {
      const varied = {
        ...rec.toJSON(),
        moyenne_generale: rec.moyenne_generale + (Math.random() - 0.5) * 2,
        score_compatibilite: Math.max(0, Math.min(100,
          rec.score_compatibilite + (Math.random() - 0.5) * 5
        ))
      };
      augmented.push(varied);
    }
  }
  
  // Entraîner avec augmented
  await axios.post(`${AI_SERVICE_URL}/api/model/train`, {
    training_data: augmented
  });
}
```

---

## 📊 Résultats attendus après optimisation

| Metrique | Actuel | Optimisé (Court terme) | Optimisé (Moyen terme) |
|----------|--------|------------------------|------------------------|
| Samples | 1000 | 4000 | 10000+ |
| Accuracy | ~74% | 78-80% | 82-85% |
| F1-Score | ~70% | 74-76% | 78-82% |
| % scores ≥70 | 60% | 72% | 80%+ |
| MAE | ~10 | ~7 | ~5 |

---

## ✅ Checklist d'implémentation

- [ ] Étape 1: Ajouter 12 nouvelles features au modèle
- [ ] Étape 2: Augmenter les hyperparamètres du Random Forest
- [ ] Étape 3: Implémenter data augmentation (4x)
- [ ] Étape 4: Ajouter ensemble model (RF + Gradient Boosting)
- [ ] Étape 5: Retester avec `test-model-metrics.js`
- [ ] Étape 6: Ajouter feedback utilisateur (UI)
- [ ] Étape 7: Collecter données réelles (2-3 semaines)
- [ ] Étape 8: Réentraîner avec données réelles

---

## 🎓 Notes importantes

1. **Data augmentation n'est pas la panacée** - Doit être combinée avec vraies données
2. **Features > Hyperparamètres** - Ajouter 10 bonnes features > optimiser hyperparamètres
3. **Éviter l'overfitting** - Si train=95% et test=70%, c'est overfitting
4. **Monitoring continu** - Réentraîner le modèle mensuellement avec nouvelles données

---

## 📞 Support

Pour chaque étape, lancez:
```bash
node backend/scripts/test-model-metrics.js
```

Partagez les résultats pour ajuster les hyperparamètres!
