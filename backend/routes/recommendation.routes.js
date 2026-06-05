const router = require('express').Router();
const { body, param } = require('express-validator');
const { protect } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/recommendation.controller');

router.use(protect);

router.post('/generer', [
  body('session_test_id').optional().isInt().withMessage('L\'ID de session doit être un entier'),
  validate
], ctrl.genererRecommendations);

router.get('/mes-recommendations', ctrl.mesRecommendations);

router.patch('/:id/sauvegarder', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.sauvegarderRecommendation);

router.get('/:id/explication', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.explicationRecommendation);

router.delete('/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.supprimerRecommendation);

module.exports = router;
