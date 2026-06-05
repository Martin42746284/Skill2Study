const router = require('express').Router();
const { body } = require('express-validator');
const { validate } = require('../middlewares/validate.middleware');
const { protect } = require('../middlewares/auth.middleware');
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
  body('mot_de_passe').isLength({ min: 6 }).withMessage('Mot de passe trop court (min 6 caractères)'),
  validate
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
  body('nouveau_mot_de_passe').isLength({ min: 6 }).withMessage('Mot de passe trop court'),
  validate
], ctrl.resetPassword);

router.post('/mot-de-passe/reinitialiser', [
  body('email').isEmail(),
  body('nouveau_mot_de_passe').isLength({ min: 6 }),
  validate
], ctrl.reinitialiserMotDePasse);

module.exports = router;
