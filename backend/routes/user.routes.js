// routes/user.routes.js
const router = require('express').Router();
const { body, param } = require('express-validator');
const { protect, bacheliersOnly } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const userCtrl = require('../controllers/user.controller');
const settingsCtrl = require('../controllers/settings.controller');

const SERIES_BAC_VALIDES = ['A1', 'A2', 'C', 'D', 'S', 'OSE', 'L', 'Technique', 'Toutes séries'];

// Toutes les routes utilisateur requièrent l'authentification ET le rôle de bachelier
router.use(protect, bacheliersOnly);

router.get('/profil', userCtrl.getProfil);

router.put('/profil/avatar', [
  body('avatar_url').isString().withMessage('L\'URL de l\'avatar doit être une chaîne'),
  validate
], userCtrl.modifierAvatar);

router.put('/profil', [
  body('nom').trim().optional({ checkFalsy: true }).isLength({ min: 2 }).withMessage('Le nom doit contenir au moins 2 caractères'),
  body('prenom').trim().optional({ checkFalsy: true }).isLength({ min: 2 }).withMessage('Le prénom doit contenir au moins 2 caractères'),
  body('ville').trim().optional({ checkFalsy: true }).isString().withMessage('La ville doit être une chaîne'),
  body('budget_mensuel').optional({ checkFalsy: true }).isFloat({ min: 0 }).withMessage('Le budget doit être un nombre positif'),
  validate
], userCtrl.modifierProfil);

router.put('/profil/academique', [
  body('serie_bac')
    .trim()
    .optional({ checkFalsy: true })
    .isIn(SERIES_BAC_VALIDES)
    .withMessage(`La série bac doit être parmi: ${SERIES_BAC_VALIDES.join(', ')}`),
  body('annee_bac').optional({ checkFalsy: true }).isInt({ min: 2000, max: 2030 }).withMessage('L\'année bac invalide'),
  body('mention').optional({ checkFalsy: true }).isIn(['Passable', 'Assez bien', 'Bien', 'Très bien']).withMessage('Mention invalide'),
  body('moyenne_generale').optional({ checkFalsy: true }).isFloat({ min: 0, max: 20 }).withMessage('La moyenne doit être entre 0 et 20'),
  body('notes_matieres').optional({ checkFalsy: true }).isObject().withMessage('Les notes doivent être un objet'),
  body('competences').optional({ checkFalsy: true }).isObject().withMessage('Les compétences doivent être un objet'),
  body('centres_interet').optional({ checkFalsy: true }).isArray().withMessage('Les centres d\'intérêt doivent être un tableau'),
  body('objectifs_professionnels').trim().optional({ checkFalsy: true }).isString(),
  body('secteur_vise').trim().optional({ checkFalsy: true }).isString(),
  body('budget_max_mensuel').optional({ checkFalsy: true }).isFloat({ min: 0 }).withMessage('Budget invalide'),
  body('distance_max_km').optional({ checkFalsy: true }).isInt({ min: 0 }).withMessage('Distance invalide'),
  body('duree_max_etudes').optional({ checkFalsy: true }).isInt({ min: 1, max: 10 }).withMessage('Durée invalide'),
  body('preference_type_univ').optional({ checkFalsy: true }).isIn(['publique', 'privee', 'indifferent']).withMessage('Préférence invalide'),
  body('ville_preference').trim().optional({ checkFalsy: true }).isString(),
  validate
], userCtrl.modifierProfilAcademique);

router.get('/favoris', userCtrl.getFavoris);

router.post('/favoris/:filiereId', [
  param('filiereId').isInt().withMessage('L\'ID de la filière doit être un entier'),
  validate
], userCtrl.ajouterFavori);

router.delete('/favoris/:filiereId', [
  param('filiereId').isInt().withMessage('L\'ID de la filière doit être un entier'),
  validate
], userCtrl.supprimerFavori);

// Settings routes
router.get('/settings', settingsCtrl.getSettings);

router.put('/settings', [
  body('email_notifications').optional({ checkFalsy: true }).isBoolean(),
  body('new_university_notifications').optional({ checkFalsy: true }).isBoolean(),
  body('test_updates_notifications').optional({ checkFalsy: true }).isBoolean(),
  body('recommendations_notifications').optional({ checkFalsy: true }).isBoolean(),
  body('theme').optional({ checkFalsy: true }).isIn(['light', 'dark', 'system']),
  body('language').optional({ checkFalsy: true }).isString(),
  body('profile_visibility').optional({ checkFalsy: true }).isIn(['public', 'private']),
  validate
], settingsCtrl.updateSettings);

// Password change route
router.put('/change-password', [
  body('current_password').notEmpty().withMessage('Mot de passe actuel requis'),
  body('new_password').matches(/^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])(?=.{6,})/).withMessage('Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial (!@#$%^&*).'),
  body('confirm_password').notEmpty().withMessage('Confirmation requise'),
  validate
], settingsCtrl.changePassword);

// Account deletion route
router.delete('/account', [
  body('password').notEmpty().withMessage('Mot de passe requis'),
  validate
], settingsCtrl.deleteAccount);

module.exports = router;
