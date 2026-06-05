const router = require('express').Router();
const { body, param, query } = require('express-validator');
const { protect, adminOnly } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/parcours.controller');

// GET all parcours
router.get('/', [
  query('filiere_id').optional().isInt().withMessage('filiere_id doit être un entier'),
  query('search').optional().isString(),
  query('page').optional().isInt({ min: 1 }).withMessage('La page doit être > 0'),
  query('limit').optional().isInt({ min: 1, max: 10000 }).withMessage('La limite doit être entre 1 et 10000'),
  validate
], ctrl.getParcours);

// GET parcours by id
router.get('/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.getParcourById);

// GET all parcours for a specific filiere
router.get('/filiere/:filiere_id', [
  param('filiere_id').isInt().withMessage('L\'ID filière doit être un entier'),
  validate
], ctrl.getParcoursParFiliere);

// CREATE new parcours (admin only)
router.post('/', protect, adminOnly, [
  body('filiere_id').isInt().withMessage('filiere_id est requis et doit être un entier'),
  body('nom').notEmpty().isLength({ min: 3 }).withMessage('Le nom doit contenir au moins 3 caractères'),
  body('code').optional().isString().trim(),
  body('description').optional().isString(),
  body('duree_mois').optional().isInt({ min: 1 }).withMessage('La durée doit être un entier positif'),
  body('specialisation').optional().isString(),
  body('competences_acquises').optional().isArray().withMessage('Les compétences doivent être un tableau'),
  body('debouches_professionnels').optional().isArray().withMessage('Les débouchés doivent être un tableau'),
  validate
], ctrl.creerParcours);

// UPDATE parcours (admin only)
router.put('/:id', protect, adminOnly, [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  body('filiere_id').optional().isInt().withMessage('filiere_id doit être un entier'),
  body('nom').optional().isLength({ min: 3 }).withMessage('Le nom doit contenir au moins 3 caractères'),
  body('code').optional().isString(),
  body('description').optional().isString(),
  body('duree_mois').optional().isInt({ min: 1 }),
  body('specialisation').optional().isString(),
  body('competences_acquises').optional().isArray(),
  body('debouches_professionnels').optional().isArray(),
  validate
], ctrl.modifierParcours);

// DELETE parcours (admin only - soft delete)
router.delete('/:id', protect, adminOnly, [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.supprimerParcours);

module.exports = router;
