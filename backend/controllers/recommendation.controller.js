const { ProfilAcademique, SessionTest, Recommendation, Filiere, Universite, RecommendationRules } = require('../models');
const RecommendationService = require('../services/recommendation.service');
const AIRecommendationService = require('../services/ai_recommendation.service');
const { notifyRecommendationsReady } = require('../services/notification.service');
const logger = require('../utils/logger');

// POST /api/recommendations/generer
exports.genererRecommendations = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const profil = await ProfilAcademique.findOne({ where: { user_id: userId } });
    if (!profil) return res.status(400).json({ success: false, message: 'Profil académique incomplet.' });

    // Debug: log profil data
    logger.info(`Profil chargé - ID: ${profil.id}, Série: ${profil.serie_bac}, Moyenne: ${profil.moyenne_generale}`);

    const { session_test_id, use_ai = true } = req.body;
    let scoresTest = null;
    if (session_test_id) {
      const session = await SessionTest.findOne({ where: { id: session_test_id, user_id: userId } });
      if (session?.complete) scoresTest = session.scores;
    }

    // Charger les règles actives de recommandation
    const reglesActives = await RecommendationRules.findOne({ where: { est_default: true, actif: true } });

    const filieres = await Filiere.findAll({
      where: { actif: true },
      include: [
        { model: Universite, as: 'universite' },
        { model: require('../models').Parcours, as: 'parcours', where: { actif: true }, required: false }
      ]
    });

    let resultats = [];

    // Utiliser le service IA si demandé
    if (use_ai) {
      try {
        logger.info(`🤖 Tentative utilisation du service IA pour recommandations (utilisateur ${userId})`);
        resultats = await AIRecommendationService.generateRecommendations(profil, filieres, scoresTest);
        logger.info(`🤖 Service IA: ${resultats.length} recommandations générées`);
      } catch (error) {
        logger.warn(`⚠️  Service IA indisponible, fallback sur le service local: ${error.message}`);
        resultats = RecommendationService.calculerRecommandations(profil, filieres, scoresTest, reglesActives);
      }
    } else {
      logger.info(`📊 Génération des recommandations pour utilisateur ${userId}`);
      resultats = RecommendationService.calculerRecommandations(profil, filieres, scoresTest, reglesActives);
    }

    // Enrichir avec des justifications personnalisées pour chaque recommandation
    resultats = resultats.map(rec => ({
      ...rec,
      justification: _generatePersonalizedJustification(
        profil,
        rec.filiere,
        {score: rec.score, factors: rec.details},
        scoresTest
      )
    }));

    logger.info(`✓ ${resultats.length} recommandations générées avec justifications personnalisées`);

    // Vérifier que nous avons des recommandations
    if (!resultats || resultats.length === 0) {
      return res.status(400).json({ success: false, message: 'Impossible de générer des recommandations. Vérifiez votre profil académique.' });
    }

    // Dédupliquer : éviter le même nom de filière deux fois, et éviter deux filières de la même université trop rapprochées
    const deduplicatedResultats = [];
    const seenFiliereNames = new Set();
    const lastUniversiteIds = [];
    const recentUniversiteWindow = 3; // ne pas afficher 2 filières de même univ dans les 3 dernières

    for (const r of resultats) {
      const filiereName = r.filiere.nom?.toLowerCase().trim();
      const univId = r.filiere.universite?.id;

      // Vérifier si ce nom de filière a déjà été ajouté (déduplique par nom)
      if (seenFiliereNames.has(filiereName)) {
        continue;
      }

      // Vérifier si cette université a été ajoutée récemment (dans les N derniers)
      const recentUnivIndex = lastUniversiteIds.lastIndexOf(univId);
      const positionInWindow = deduplicatedResultats.length - recentUnivIndex - 1;

      // Si la même université n'a pas été ajoutée récemment (< recentUniversiteWindow), on peut l'ajouter
      if (recentUnivIndex === -1 || positionInWindow >= recentUniversiteWindow) {
        deduplicatedResultats.push(r);
        seenFiliereNames.add(filiereName);
        lastUniversiteIds.push(univId);
      }
    }

    // Préparer les nouvelles recommandations
    const newRecommendations = deduplicatedResultats.map((r, idx) => ({
      user_id: userId,
      session_test_id: session_test_id || null,
      filiere_id: r.filiere.id,
      score_compatibilite: r.score,
      rang: idx + 1,
      justification: r.justification
    }));

    // IMPORTANT: Supprimer les anciennes SEULEMENT APRÈS la préparation des nouvelles
    // Cela évite les pertes de données si quelque chose échoue
    await Recommendation.destroy({ where: { user_id: userId, sauvegardee: false } });

    // Enregistrer les nouvelles
    const recommandationsSaved = await Recommendation.bulkCreate(newRecommendations);

    // Send notification
    await notifyRecommendationsReady(userId, deduplicatedResultats.length);

    res.json({
      success: true,
      count: deduplicatedResultats.length,
      recommendations: deduplicatedResultats,
      message: `${deduplicatedResultats.length} recommandations générées`
    });
  } catch (err) { next(err); }
};

// GET /api/recommendations/mes-recommendations
exports.mesRecommendations = async (req, res, next) => {
  try {
    const recommendations = await Recommendation.findAll({
      where: { user_id: req.user.id },
      include: [{ model: Filiere, as: 'filiere', include: [{ model: Universite, as: 'universite' }] }],
      order: [['rang', 'ASC']]
    });
    // Dédupliquer par nom de filière pour éviter d'afficher deux fois le même nom
    const deduplicatedRecommendations = [];
    const seenFiliereNames = new Set();

    for (const rec of recommendations) {
      const filiereName = rec.filiere?.nom?.toLowerCase().trim();
      if (!seenFiliereNames.has(filiereName)) {
        deduplicatedRecommendations.push(rec);
        seenFiliereNames.add(filiereName);
      }
    }

    res.json({ success: true, recommendations: deduplicatedRecommendations });
  } catch (err) { next(err); }
};

// PATCH /api/recommendations/:id/sauvegarder
exports.sauvegarderRecommendation = async (req, res, next) => {
  try {
    const rec = await Recommendation.findOne({ where: { id: req.params.id, user_id: req.user.id } });
    if (!rec) return res.status(404).json({ success: false, message: 'Recommandation introuvable.' });
    rec.sauvegardee = !rec.sauvegardee;
    await rec.save();
    res.json({ success: true, sauvegardee: rec.sauvegardee });
  } catch (err) { next(err); }
};

// GET /api/recommendations/:id/explication
exports.explicationRecommendation = async (req, res, next) => {
  try {
    const rec = await Recommendation.findOne({
      where: { id: req.params.id, user_id: req.user.id },
      include: [{ model: Filiere, as: 'filiere', include: [{ model: Universite, as: 'universite' }] }]
    });
    if (!rec) return res.status(404).json({ success: false, message: 'Recommandation introuvable.' });
    res.json({ success: true, score: rec.score_compatibilite, rang: rec.rang, justification: rec.justification, filiere: rec.filiere });
  } catch (err) { next(err); }
};

// DELETE /api/recommendations/:id
exports.supprimerRecommendation = async (req, res, next) => {
  try {
    const deleted = await Recommendation.destroy({ where: { id: req.params.id, user_id: req.user.id } });
    if (deleted === 0) return res.status(404).json({ success: false, message: 'Recommandation introuvable.' });
    res.json({ success: true, message: 'Recommandation supprimée.' });
  } catch (err) { next(err); }
};

// Fonction helper pour générer des justifications personnalisées
function _generatePersonalizedJustification(profil, filiere, recommendation, scoresTest) {
  const justification = {
    raison_principale: '',
    points_forts: [],
    points_attention: [],
    raisons: []
  };

  // Vérifier la compatibilité série bac
  const seriesAcceptees = filiere.series_bac_acceptees || [];
  // Le profil peut stocker la série bac sous différents noms
  const serieProfil = profil.serie_bac || profil.serie || profil.bac_series || '';

  if (seriesAcceptees.length > 0) {
    if (seriesAcceptees.includes(serieProfil)) {
      justification.points_forts.push(`Votre série "${serieProfil}" est bien adaptée à cette filière.`);
    } else {
      justification.points_attention.push(`Votre série "${serieProfil}" n'est pas idéale pour cette filière.`);
    }
  }

  // Vérifier la moyenne générale
  const moyenneMin = filiere.moyenne_min_requise || 10;
  const moyenneProfil = profil.moyenne_generale || 0;

  if (moyenneProfil >= moyenneMin) {
    justification.points_forts.push(`Votre moyenne (${moyenneProfil}/20) est excellente pour l'admission.`);
  } else if (moyenneProfil >= moyenneMin - 2) {
    justification.points_attention.push(`Votre moyenne (${moyenneProfil}/20) est proche du minimum requis (${moyenneMin}/20).`);
  }

  // Vérifier les centres d'intérêt
  const centresInteret = filiere.centres_interet || [];
  if (centresInteret.length > 0) {
    justification.raisons.push(`Cette filière couvre les domaines: ${centresInteret.join(', ')}`);
  }

  // Vérifier la durée des études
  const dureeMax = profil.duree_max_etudes || 4;
  const dureeFil = filiere.duree_annees ? parseInt(filiere.duree_annees) : 3;

  if (dureeFil <= dureeMax) {
    justification.points_forts.push(`La durée des études (${dureeFil} ans) correspond à vos attentes.`);
  }

  // Vérifier la localisation
  const villePreference = profil.ville_preference || '';
  const villeUniv = filiere.universite?.ville || '';

  if (villeUniv && villePreference) {
    if (villeUniv.toLowerCase() === villePreference.toLowerCase()) {
      justification.points_forts.push(`Université basée à ${villeUniv}, votre ville de préférence.`);
    } else {
      justification.raisons.push(`Université basée à ${villeUniv}.`);
    }
  }

  // Raison principale basée sur le score
  const score = recommendation.score || 60;
  if (score >= 80) {
    justification.raison_principale = `Excellente correspondance (${score}%) avec votre profil académique.`;
  } else if (score >= 70) {
    justification.raison_principale = `Bonne correspondance (${score}%) avec votre profil académique.`;
  } else if (score >= 60) {
    justification.raison_principale = `Correspondance acceptable (${score}%) avec votre profil académique.`;
  } else {
    justification.raison_principale = `Recommandée à titre informatif (${score}%).`;
  }

  return justification;
}
