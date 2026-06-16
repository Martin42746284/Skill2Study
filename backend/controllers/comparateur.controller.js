const { Filiere, Universite, ProfilAcademique, RecommendationRules } = require('../models');
const RecommendationService = require('../services/recommendation.service');

// POST /api/comparateur
exports.comparerFilieres = async (req, res, next) => {
  try {
    const { filiere_ids } = req.body;
    const user_id = req.user?.id;

    console.log('Comparateur reçu:', filiere_ids, 'pour user:', user_id);

    if (!Array.isArray(filiere_ids) || filiere_ids.length < 2 || filiere_ids.length > 50) {
      return res.status(400).json({ success: false, message: 'Fournir entre 2 et 50 filières à comparer.' });
    }

    const filieres = await Filiere.findAll({
      where: { id: filiere_ids },
      include: [{ model: Universite, as: 'universite' }]
    });

    console.log(`Filières trouvées: ${filieres.length}/${filiere_ids.length}`, filieres.map(f => ({ id: f.id, nom: f.nom, actif: f.actif })));

    // Vérifier qu'on a au moins 2 filières
    if (filieres.length < 2) {
      return res.status(422).json({
        success: false,
        message: `Seulement ${filieres.length} filière(s) trouvée(s). Les IDs demandés étaient: ${filiere_ids.join(', ')}`,
        found: filieres.length,
        requested: filiere_ids.length
      });
    }

    // Charger les scores de compatibilité et rangs depuis les recommandations de l'utilisateur
    // Pour assurer la cohérence entre la page de recommandations et la page de comparaison
    let scoresCompatibilite = {};
    let rangs = {};
    if (user_id) {
      const Recommendation = require('../models').Recommendation;

      try {
        // Récupérer les recommandations existantes de l'utilisateur
        const recommendations = await Recommendation.findAll({
          where: { user_id },
          attributes: ['filiere_id', 'score_compatibilite', 'rang'],
          raw: true
        });

        // Créer des maps score_compatibilite et rang par filiere_id
        recommendations.forEach(rec => {
          scoresCompatibilite[rec.filiere_id] = Math.round(rec.score_compatibilite);
          rangs[rec.filiere_id] = rec.rang;
        });

        console.log('Scores et rangs récupérés depuis recommandations:', { scoresCompatibilite, rangs });
      } catch (err) {
        console.warn('Erreur lors de la récupération des scores:', err.message);
        // Fallback: recalculer avec l'ancien service si les recommandations ne sont pas disponibles
        const profil = await ProfilAcademique.findOne({ where: { user_id } });
        const regles = await RecommendationRules.findOne({ where: { actif: true, est_default: true } });

        if (profil) {
          const recommandations = RecommendationService.calculerRecommandations(
            profil.dataValues,
            filieres.map(f => f.dataValues),
            profil.scores_test,
            regles?.dataValues
          );

          recommandations.forEach(rec => {
            scoresCompatibilite[rec.filiere.id] = Math.round(rec.score);
          });

          console.log('Scores de compatibilité calculés (fallback):', scoresCompatibilite);
        }
      }
    }

    // Tableau de comparaison enrichi avec scores de compatibilité
    const comparaison = filieres.map(f => ({
      id: f.id,
      nom: f.nom,
      universite_id: f.universite?.id,
      universite: f.universite?.nom,
      type_universite: f.universite?.type,
      ville: f.universite?.ville,
      domaine: f.domaine,
      niveau: f.niveau,
      duree_annees: f.duree_annees,
      cout_annuel: f.cout_annuel,
      langue: f.langue,
      moyenne_min_requise: f.moyenne_min_requise,
      difficulte: f.difficulte,
      taux_emploi: f.taux_emploi,
      salaire_moyen_debutant: f.salaire_moyen_debutant,
      debouches: f.debouches,
      competences_requises: f.competences_requises,
      centres_interet: f.centres_interet,
      // Indicateurs calculés
      score_retour_investissement: _calculerROI(f),
      score_compatibilite: scoresCompatibilite[f.id] || null, // Score de compatibilité calculé
      rang: rangs[f.id] || null, // Rang de recommandation (1, 2, 3...)
      avantages: _extraireAvantages(f),
      inconvenients: _extraireInconvenients(f),
    }));

    res.json({ success: true, comparaison });
  } catch (err) { next(err); }
};

function _calculerROI(filiere) {
  const { salaire_moyen_debutant, cout_annuel, duree_annees, nom } = filiere;

  // Log missing data for debugging
  // if (!salaire_moyen_debutant || !cout_annuel || !duree_annees) {
  //   console.warn(`⚠️ ROI calculation incomplete for "${nom}":`, {
  //     salaire: salaire_moyen_debutant || 'manquant',
  //     cout: cout_annuel || 'manquant',
  //     duree: duree_annees || 'manquant'
  //   });
  //   return null;
  // }

  // Avoid division by zero
  const coutTotal = cout_annuel * duree_annees;
  if (coutTotal === 0) return null;

  const gainAnnuel = salaire_moyen_debutant * 12;
  return Math.round((gainAnnuel / coutTotal) * 100) / 100;
}

function _extraireAvantages(filiere) {
  const avantages = [];
  // Taux d'emploi
  if (filiere.taux_emploi && filiere.taux_emploi >= 80) avantages.push('Fort taux d\'emploi');

  // Durée
  if (filiere.duree_annees && filiere.duree_annees <= 3) avantages.push('Formation courte');

  // Coût
  if (filiere.cout_annuel && filiere.cout_annuel <= 5000) avantages.push('Coût abordable');

  // Type d'université
  if (filiere.universite?.type === 'publique') avantages.push('Université publique');

  // Débouchés
  if (filiere.debouches && Array.isArray(filiere.debouches) && filiere.debouches.length >= 5) {
    avantages.push('Nombreux débouchés');
  }

  // Salaire moyen
  if (filiere.salaire_moyen_debutant && filiere.salaire_moyen_debutant >= 2000000) {
    avantages.push('Salaire de départ attractif');
  }

  // Domaine populaire
  const domaines_populaires = ['informatique', 'ingénierie', 'commerce', 'médecine', 'droit'];
  if (filiere.domaine && domaines_populaires.some(d => filiere.domaine.toLowerCase().includes(d))) {
    avantages.push('Domaine très demandé');
  }

  return avantages;
}

function _extraireInconvenients(filiere) {
  const inconvenients = [];
  // Différencier selon le niveau de difficulté
  if (filiere.difficulte === 'tres_difficile') {
    inconvenients.push('Niveau très difficile');
  } else if (filiere.difficulte === 'difficile') {
    inconvenients.push('Niveau difficile');
  }
  if (filiere.duree_annees && filiere.duree_annees >= 5) inconvenients.push('Formation longue');
  // Ne suggérer "coût élevé" que si le coût est réellement renseigné
  if (filiere.cout_annuel && filiere.cout_annuel >= 30000) inconvenients.push('Coût élevé');
  if (filiere.taux_emploi && filiere.taux_emploi < 50) inconvenients.push('Débouchés limités');
  return inconvenients;
}
