const { Question, OptionReponse, SessionTest } = require('../models');
const { notifyTestCompleted } = require('../services/notification.service');

// GET /api/test/questions
exports.getQuestions = async (req, res, next) => {
  try {
    const { serie_bac } = req.query;
    const where = { actif: true };

    const questions = await Question.findAll({
      where,
      include: [{ model: OptionReponse, as: 'options' }],
      order: [['ordre', 'ASC']]
    });

    // Filtrer les questions selon la série bac si spécifiée
    const filtered = serie_bac
      ? questions.filter(q => !q.series_bac_cibles?.length || q.series_bac_cibles.includes(serie_bac))
      : questions;

    res.json({ success: true, count: filtered.length, questions: filtered });
  } catch (err) { next(err); }
};

// POST /api/test/demarrer
exports.demarrerSession = async (req, res, next) => {
  try {
    const session = await SessionTest.create({
      user_id: req.user.id,
      reponses: {},
      scores: {},
      complete: false
    });
    res.status(201).json({ success: true, session_id: session.id });
  } catch (err) { next(err); }
};

// POST /api/test/:sessionId/repondre
exports.soumettreReponse = async (req, res, next) => {
  try {
    const { sessionId } = req.params;
    const { question_id, option_id } = req.body;

    const session = await SessionTest.findOne({ where: { id: sessionId, user_id: req.user.id } });
    if (!session) return res.status(404).json({ success: false, message: 'Session introuvable.' });
    if (session.complete) return res.status(400).json({ success: false, message: 'Session déjà terminée.' });

    const reponses = { ...session.reponses, [question_id]: option_id };
    await session.update({ reponses });

    res.json({ success: true, message: 'Réponse enregistrée.' });
  } catch (err) { next(err); }
};

// POST /api/test/:sessionId/terminer
exports.terminerSession = async (req, res, next) => {
  try {
    const { sessionId } = req.params;
    const session = await SessionTest.findOne({ where: { id: sessionId, user_id: req.user.id } });
    if (!session) return res.status(404).json({ success: false, message: 'Session introuvable.' });

    // Calculer les scores par catégorie
    const scores = await _calculerScores(session.reponses);

    await session.update({ scores, complete: true, date_completion: new Date() });

    // IMPORTANT: Mettre à jour le ProfilAcademique avec les scores du test
    // Cela permet aux recommandations d'être basées sur les résultats du test
    const { ProfilAcademique } = require('../models');
    const profil = await ProfilAcademique.findOne({ where: { user_id: req.user.id } });

    if (profil) {
      await profil.update({
        scores_test: scores,  // Sauvegarde les scores du test dans le champ dédié
        updated_at: new Date()
      });
    }

    // Calculate overall score
    const overallScore = Object.values(scores).length > 0
      ? Math.round(Object.values(scores).reduce((a, b) => a + b, 0) / Object.values(scores).length)
      : 0;

    // Send notification
    await notifyTestCompleted(req.user.id, session.id, overallScore);

    res.json({ success: true, scores, session_id: session.id });
  } catch (err) { next(err); }
};

// GET /api/test/historique
exports.historiqueTests = async (req, res, next) => {
  try {
    const sessions = await SessionTest.findAll({
      where: { user_id: req.user.id },
      order: [['createdAt', 'DESC']]
    });
    res.json({ success: true, sessions });
  } catch (err) { next(err); }
};

// Fonction interne : calcul des scores par catégorie
async function _calculerScores(reponses) {
  const scores = {};
  const questionIds = Object.keys(reponses).map(Number);
  const optionIds = Object.values(reponses).map(Number);

  const options = await OptionReponse.findAll({ where: { id: optionIds } });

  options.forEach(option => {
    const poids = option.poids || {};
    Object.entries(poids).forEach(([categorie, valeur]) => {
      scores[categorie] = (scores[categorie] || 0) + valeur;
    });
  });

  // Normaliser les scores sur 100
  const maxPossible = questionIds.length * 5;
  Object.keys(scores).forEach(k => {
    scores[k] = Math.min(100, Math.round((scores[k] / maxPossible) * 100));
  });

  return scores;
}
