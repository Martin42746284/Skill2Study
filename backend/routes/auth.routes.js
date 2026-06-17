const router = require('express').Router();
const { body } = require('express-validator');
const { validate } = require('../middlewares/validate.middleware');
const { protect } = require('../middlewares/auth.middleware');
const { validatePasswordStrength, validateResetPasswordStrength } = require('../middlewares/validatePassword.middleware');
const ctrl = require('../controllers/auth.controller');

/**
 * @swagger
 * /auth/register:
 *   post:
 *     summary: Inscription d'un nouveau bachelier
 *     tags: [Auth]
 *     security: []
 */
router.post('/register', [
  body('nom').notEmpty().withMessage('Le nom est requis'),
  body('prenom').notEmpty().withMessage('Le prénom est requis'),
  body('email').isEmail().withMessage('Email invalide'),
  ...validatePasswordStrength
], ctrl.inscrire);

/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Connexion
 *     tags: [Auth]
 *     security: []
 */
router.post('/login', [
  body('email').isEmail(),
  body('mot_de_passe').notEmpty(),
  validate
], ctrl.connexion);

router.get('/me', protect, ctrl.moi);

router.post('/verify-email', [
  body('token').notEmpty().withMessage('Token de vérification requis'),
  validate
], ctrl.verifierEmail);

router.post('/forgot-password', [
  body('email').isEmail().withMessage('Email invalide'),
  validate
], ctrl.forgotPassword);

router.post('/reset-password', [
  body('token').notEmpty().withMessage('Token requis'),
  ...validateResetPasswordStrength
], ctrl.resetPassword);

module.exports = router;
