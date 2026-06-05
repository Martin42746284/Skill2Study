const router = require('express').Router();
const { body, param, query } = require('express-validator');
const { protect } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/test.controller');

router.get('/questions', protect, [
  query('serie_bac').optional().isString().trim(),
  validate
], ctrl.getQuestions);

router.post('/demarrer', protect, ctrl.demarrerSession);

router.post('/:sessionId/repondre', protect, [
  param('sessionId').isInt().withMessage('L\'ID de session doit être un entier'),
  body('question_id').notEmpty().isInt().withMessage('L\'ID de question est requis'),
  body('option_id').notEmpty().isInt().withMessage('L\'ID d\'option est requis'),
  validate
], ctrl.soumettreReponse);

router.post('/:sessionId/terminer', protect, [
  param('sessionId').isInt().withMessage('L\'ID de session doit être un entier'),
  validate
], ctrl.terminerSession);

router.get('/historique', protect, ctrl.historiqueTests);

module.exports = router;
