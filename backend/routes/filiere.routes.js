// routes/filiere.routes.js
const router = require('express').Router();
const { body, param, query } = require('express-validator');
const { protect, adminOnly } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/filiere.controller');

router.get('/', [
  query('page').optional().isInt({ min: 1 }).withMessage('La page doit être > 0'),
  query('limit').optional().isInt({ min: 1, max: 10000 }).withMessage('La limite doit être entre 1 et 10000'),
  query('difficulte').optional().isIn(['facile', 'moyen', 'difficile', 'tres_difficile']).withMessage('Difficulté invalide'),
  validate
], ctrl.getFilieres);

router.get('/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.getFiliere);

router.post('/', protect, adminOnly, [
  body('universite_id').notEmpty().isInt().withMessage('L\'ID de l\'université est requis'),
  body('nom').notEmpty().isLength({ min: 3 }).withMessage('Le nom doit contenir au moins 3 caractères'),
  body('code').optional().isLength({ min: 2 }).withMessage('Le code invalide'),
  body('domaine').optional().isString().trim(),
  body('specialite').optional().isString().trim(),
  body('niveaux').optional().isArray().withMessage('Les niveaux doivent être un tableau'),
  body('duree_annees').optional().isString().trim().isLength({ max: 50 }).withMessage('Durée invalide (ex: 3 - 5, 2 ans)'),
  body('cout_annuel').optional().isFloat({ min: 0 }).withMessage('Coût invalide'),
  body('cout_description').optional().isString().trim().isLength({ max: 255 }).withMessage('Description du coût invalide'),
  body('langue').optional().isString(),
  body('series_bac_acceptees').optional().isArray().withMessage('Doit être un tableau'),
  body('moyenne_min_requise').optional().isFloat({ min: 0, max: 20 }).withMessage('Moyenne invalide'),
  body('competences_requises').optional().isArray().withMessage('Doit être un tableau'),
  body('centres_interet').optional().isArray().withMessage('Doit être un tableau'),
  body('difficulte').optional().isIn(['facile', 'moyen', 'difficile', 'tres_difficile']).withMessage('Difficulté invalide'),
  body('taux_emploi').optional().isFloat({ min: 0, max: 100 }).withMessage('Taux emploi invalide'),
  body('salaire_moyen_debutant').optional().isFloat({ min: 0 }).withMessage('Salaire invalide'),
  body('debouches').optional().isArray().withMessage('Doit être un tableau'),
  validate
], ctrl.creerFiliere);

router.put('/:id', protect, adminOnly, [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  body('nom').optional().isLength({ min: 3 }).withMessage('Le nom doit contenir au moins 3 caractères'),
  body('code').optional().isLength({ min: 2 }).withMessage('Le code invalide'),
  body('domaine').optional().isString().trim(),
  body('specialite').optional().isString().trim(),
  body('niveaux').optional().isArray().withMessage('Les niveaux doivent être un tableau'),
  body('duree_annees').optional().isString().trim().isLength({ max: 50 }).withMessage('Durée invalide (ex: 3 - 5, 2 ans)'),
  body('cout_annuel').optional().isFloat({ min: 0 }).withMessage('Coût invalide'),
  body('cout_description').optional().isString().trim().isLength({ max: 255 }).withMessage('Description du coût invalide'),
  body('langue').optional().isString(),
  body('series_bac_acceptees').optional().isArray().withMessage('Doit être un tableau'),
  body('moyenne_min_requise').optional().isFloat({ min: 0, max: 20 }).withMessage('Moyenne invalide'),
  body('competences_requises').optional().isArray().withMessage('Doit être un tableau'),
  body('centres_interet').optional().isArray().withMessage('Doit être un tableau'),
  body('difficulte').optional().isIn(['facile', 'moyen', 'difficile', 'tres_difficile']).withMessage('Difficulté invalide'),
  body('taux_emploi').optional().isFloat({ min: 0, max: 100 }).withMessage('Taux emploi invalide'),
  body('salaire_moyen_debutant').optional().isFloat({ min: 0 }).withMessage('Salaire invalide'),
  body('debouches').optional().isArray().withMessage('Doit être un tableau'),
  validate
], ctrl.modifierFiliere);

router.delete('/:id', protect, adminOnly, [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.supprimerFiliere);

module.exports = router;
