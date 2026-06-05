// routes/comparateur.routes.js
const router = require('express').Router();
const { body } = require('express-validator');
const { protect } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/comparateur.controller');

router.post('/', protect, [
  body('filiere_ids')
    .isArray({ min: 2, max: 50 })
    .withMessage('Fournir entre 2 et 50 filières à comparer'),
  body('filiere_ids.*')
    .isInt()
    .withMessage('Chaque ID doit être un entier'),
  validate
], ctrl.comparerFilieres);

module.exports = router;
