/**
 * SERVICE DE RECOMMANDATION IA
 * Algorithme de scoring pondéré multi-critères
 * Méthodes : règles métier + scoring pondéré + similarité cosinus
 * 
 * AMÉLIORATIONS: Les poids et règles peuvent maintenant être configurés
 * depuis la base de données via le modèle RecommendationRules.
 */

// Poids par défaut (utilisés si aucune règle en BD)
// IMPORTANT: Les scores du test sont le critère PRINCIPAL
// NOTE: La contrainte de budget a été supprimée car les données
// pour les filières/universités ne précisent pas bien le salaire et le coût
const POIDS_DEFAUT = {
  scores_test:             35,  // [STAR] PRINCIPAL: résultats du test d'orientation
  compatibilite_serie:     20,  // série bac compatible avec la filière
  centres_interet:         15,  // correspondance centres d'intérêt
  moyenne_generale:        15,  // moyenne vs seuil requis
  preference_geographique: 10,  // ville préférée de l'utilisateur
  competences:              3,  // compétences auto-évaluées
  contraintes_duree:        2,  // durée dans les préférences
};

class RecommendationService {

  /**
   * Point d'entrée principal
   * @param {ProfilAcademique} profil
   * @param {Filiere[]} filieres
   * @param {Object|null} scoresTest
   * @param {Object|null} regles - Règles de recommandation depuis la BD
   * @returns {Array} filières triées par score décroissant
   */
  static calculerRecommandations(profil, filieres, scoresTest = null, regles = null) {
    // Charger les poids depuis les règles BD ou utiliser les défauts
    const { poids, filtres } = this._chargerRegles(regles);
    
    const resultats = filieres
      .filter(f => this._passerFiltresEliminatoires(profil, f, filtres))
      .map(f => {
        const { score, details } = this._calculerScore(profil, f, scoresTest, poids);
        const justification = this._genererJustification(profil, f, details);
        return { filiere: f, score: Math.round(score * 10) / 10, details, justification };
      })
      .sort((a, b) => b.score - a.score);

    return resultats;
  }

  // ─── Chargement des règles ───────────────────────────────────────────────

  /**
   * Charge les poids et filtres depuis les règles BD ou utilise les défauts
   * @param {Object|null} regles
   * @returns {Object} {poids, filtres}
   */
  static _chargerRegles(regles) {
    if (!regles) {
      return {
        poids: POIDS_DEFAUT,
        filtres: { eliminer_hors_serie: true, eliminer_hors_budget: false, moyenne_min: 10.0 }
      };
    }

    return {
      poids: {
        scores_test: regles.poids_test !== undefined ? regles.poids_test : POIDS_DEFAUT.scores_test,
        compatibilite_serie: regles.poids_serie !== undefined ? regles.poids_serie : POIDS_DEFAUT.compatibilite_serie,
        moyenne_generale: regles.poids_moyenne !== undefined ? regles.poids_moyenne : POIDS_DEFAUT.moyenne_generale,
        centres_interet: regles.poids_interet !== undefined ? regles.poids_interet : POIDS_DEFAUT.centres_interet,
        competences: regles.poids_competences !== undefined ? regles.poids_competences : POIDS_DEFAUT.competences,
        contraintes_budget: regles.poids_budget !== undefined ? regles.poids_budget : POIDS_DEFAUT.contraintes_budget,
        contraintes_duree: regles.poids_duree !== undefined ? regles.poids_duree : POIDS_DEFAUT.contraintes_duree,
      },
      filtres: {
        eliminer_hors_serie: regles.filtre_eliminer_hors_serie !== false,
        eliminer_hors_budget: regles.filtre_eliminer_hors_budget === true,
        moyenne_min: regles.moyenne_min_acceptable || 10.0
      }
    };
  }

  // ─── Filtres éliminatoires ───────────────────────────────────────────────

  static _passerFiltresEliminatoires(profil, filiere, filtres = {}) {
    const {
      eliminer_hors_serie = true,
      eliminer_hors_budget = false,
      moyenne_min = 10.0
    } = filtres;

    // Filtre : série bac acceptée (si défini et activé)
    if (eliminer_hors_serie && filiere.series_bac_acceptees?.length > 0 && profil.serie_bac) {
      const serieProfil = profil.serie_bac.toLowerCase();
      const acceptee = filiere.series_bac_acceptees.some(s => s.toLowerCase() === serieProfil);
      if (!acceptee) return false;
    }

    // Filtre : moyenne minimale requise
    if (filiere.moyenne_min_requise && profil.moyenne_generale) {
      if (profil.moyenne_generale < filiere.moyenne_min_requise) return false;
    }

    // Filtre : préférence type université
    if (profil.preference_type_univ && profil.preference_type_univ !== 'indifferent') {
      if (filiere.universite?.type !== profil.preference_type_univ) return false;
    }

    // Filtre : préférence géographique (ville/région)
    if (profil.preference_localisation && profil.preference_localisation !== 'indifferent') {
      const villeProfil = profil.preference_localisation.toLowerCase();
      const villeUniversite = filiere.universite?.ville?.toLowerCase();
      if (villeUniversite && villeUniversite !== villeProfil) return false;
    }

    return true;
  }

  // ─── Calcul du score pondéré ─────────────────────────────────────────────

  static _calculerScore(profil, filiere, scoresTest, poids = POIDS_DEFAUT) {
    const details = {};

    // 1. Compatibilité série bac
    details.compatibilite_serie = this._scoreSerie(profil, filiere);

    // 2. Moyenne générale
    details.moyenne_generale = this._scoreMoyenne(profil, filiere);

    // 3. Centres d'intérêt
    details.centres_interet = this._scoreCentresInteret(profil, filiere);

    // 4. Compétences
    details.competences = this._scoreCompetences(profil, filiere);

    // 5. Contraintes durée
    details.contraintes_duree = this._scoreDuree(profil, filiere);

    // 6. Préférence géographique
    details.preference_geographique = this._scoreLocalization(profil, filiere);

    // 7. Scores test
    details.scores_test = scoresTest ? this._scoreTest(scoresTest, filiere) : 50;

    // Score final pondéré (0-100) - utilise les poids fournis
    const score = Object.keys(poids).reduce((total, critere) => {
      return total + (details[critere] * poids[critere]) / 100;
    }, 0);

    return { score, details };
  }

  static _scoreSerie(profil, filiere) {
    if (!filiere.series_bac_acceptees?.length || !profil.serie_bac) return 70;
    const serieProfil = profil.serie_bac.toLowerCase();
    // Score max si correspondance exacte
    const idx = filiere.series_bac_acceptees.findIndex(s => s.toLowerCase() === serieProfil);
    if (idx === 0) return 100; // série prioritaire
    if (idx > 0) return 80;
    return 0; // ne devrait pas arriver (filtré avant)
  }

  static _scoreMoyenne(profil, filiere) {
    if (!profil.moyenne_generale) return 50;
    const moy = profil.moyenne_generale;
    const seuil = filiere.moyenne_min_requise || 10;
    if (moy >= seuil + 4) return 100;
    if (moy >= seuil + 2) return 85;
    if (moy >= seuil) return 70;
    return 20; // juste en dessous du seuil (non éliminé = seuil non défini)
  }

  static _scoreCentresInteret(profil, filiere) {
    const interetsProfil = profil.centres_interet || [];
    const interetsFiliere = filiere.centres_interet || [];
    if (!interetsProfil.length || !interetsFiliere.length) return 50;
    // Similarité Jaccard
    const setProfil = new Set(interetsProfil.map(s => s.toLowerCase()));
    const setFiliere = new Set(interetsFiliere.map(s => s.toLowerCase()));
    const intersection = [...setProfil].filter(x => setFiliere.has(x)).length;
    const union = new Set([...setProfil, ...setFiliere]).size;
    return Math.round((intersection / union) * 100);
  }

  static _scoreCompetences(profil, filiere) {
    const competencesProfil = profil.competences || {};
    const competencesRequises = filiere.competences_requises || [];
    if (!competencesRequises.length) return 60;
    let total = 0;
    let count = 0;
    competencesRequises.forEach(comp => {
      const cle = comp.toLowerCase();
      if (competencesProfil[cle] !== undefined) {
        total += (competencesProfil[cle] / 5) * 100; // note /5 → %
        count++;
      }
    });
    return count > 0 ? Math.round(total / count) : 50;
  }

  static _scoreDuree(profil, filiere) {
    if (!profil.duree_max_etudes || !filiere.duree_annees) return 70;
    if (filiere.duree_annees <= profil.duree_max_etudes) return 100;
    if (filiere.duree_annees <= profil.duree_max_etudes + 1) return 60;
    return 20;
  }

  static _scoreLocalization(profil, filiere) {
    // Score basé sur la préférence géographique
    const villePreference = profil.ville_preference?.toLowerCase() || '';
    const villeUniv = filiere.universite?.ville?.toLowerCase() || '';

    if (!villePreference) return 50; // Pas de préférence = score neutre

    if (villeUniv === villePreference) {
      return 100; // Match parfait!
    }

    // Vérifier les régions/régions associées pour un match partiel
    // Antananarivo, Fianarantsoa, Toliara, Mahajanga, Antalaha etc.
    const sameRegion = {
      'antananarivo': ['antananarivo'],
      'fianarantsoa': ['fianarantsoa', 'ambalavao'],
      'toliara': ['toliara', 'bekily'],
      'mahajanga': ['mahajanga', 'maintirano'],
      'antalaha': ['antalaha', 'sambava', 'vohemar', 'andapa']
    };

    const regionPref = Object.keys(sameRegion).find(key => sameRegion[key].includes(villePreference));
    const regionUniv = Object.keys(sameRegion).find(key => sameRegion[key].includes(villeUniv));

    if (regionPref && regionUniv && regionPref === regionUniv) {
      return 80; // Même région
    }

    return 30; // Autre région
  }

  static _scoreTest(scoresTest, filiere) {
    if (!scoresTest || Object.keys(scoresTest).length === 0) return 50;

    // Approche 1: Essayer de matcher avec les centres d'intérêt spécifiques de la filière
    const interetsFiliere = filiere.centres_interet || [];
    let scoreFromMatch = null;

    if (interetsFiliere.length > 0) {
      let scoreTotal = 0;
      let count = 0;
      interetsFiliere.forEach(interet => {
        const cle = interet.toLowerCase().trim();
        // Chercher un match exact ou partiel
        Object.keys(scoresTest).forEach(testCategorie => {
          if (testCategorie.toLowerCase().includes(cle) || cle.includes(testCategorie.toLowerCase())) {
            scoreTotal += scoresTest[testCategorie];
            count++;
          }
        });
      });
      if (count > 0) {
        scoreFromMatch = Math.round(scoreTotal / count);
      }
    }

    // Approche 2: Si pas de match, utiliser la moyenne générale de tous les scores du test
    if (scoreFromMatch !== null) {
      return scoreFromMatch;
    }

    // Score moyen de tous les résultats du test
    const allScores = Object.values(scoresTest).filter(score => typeof score === 'number');
    if (allScores.length > 0) {
      return Math.round(allScores.reduce((a, b) => a + b, 0) / allScores.length);
    }

    return 50;
  }

  // ─── Génération d'explications (Module Explicatif IA) ───────────────────

  static _genererJustification(profil, filiere, details) {
    const points_forts = [];
    const points_attention = [];
    const raisons = [];

    if (details.compatibilite_serie >= 80) {
      points_forts.push(`Votre série "${profil.serie_bac}" est bien adaptée à cette filière.`);
    }
    if (details.moyenne_generale >= 85) {
      points_forts.push(`Votre moyenne (${profil.moyenne_generale}/20) est excellente pour l'admission.`);
    } else if (details.moyenne_generale < 50) {
      points_attention.push(`Votre moyenne pourrait être juste pour le seuil d'admission requis.`);
    }
    if (details.centres_interet >= 60) {
      points_forts.push(`Vos centres d'intérêt correspondent bien aux domaines couverts par cette filière.`);
    } else if (details.centres_interet < 30) {
      points_attention.push(`Peu de correspondance entre vos centres d'intérêt et cette filière.`);
    }
    if (details.contraintes_budget === 0) {
      points_attention.push(`Le coût estimatif de cette filière dépasse votre budget mensuel déclaré.`);
    } else if (details.contraintes_budget === 100) {
      points_forts.push(`Le coût de cette filière est bien dans votre budget.`);
    }
    if (details.competences >= 70) {
      points_forts.push(`Vos compétences auto-évaluées sont alignées avec les exigences de cette filière.`);
    }

    if (filiere.taux_emploi >= 80) {
      raisons.push(`Fort taux d'employabilité (${filiere.taux_emploi}%).`);
    }
    if (filiere.debouches?.length > 0) {
      raisons.push(`Débouchés : ${filiere.debouches.slice(0, 3).join(', ')}.`);
    }

    return { points_forts, points_attention, raisons };
  }
}

module.exports = RecommendationService;
