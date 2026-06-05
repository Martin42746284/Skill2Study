const router = require('express').Router();
const { param } = require('express-validator');
const { protect, adminOnly } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/stats.controller');

router.get('/dashboard', protect, adminOnly, ctrl.dashboardAdmin);

router.get('/filieres/:id', protect, [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.statsFiliere);

router.get('/moi', protect, ctrl.statsMoi);

module.exports = router;
