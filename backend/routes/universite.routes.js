const router = require('express').Router();
const { body, param, query } = require('express-validator');
const { protect, adminOnly } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/universite.controller');

router.get('/', [
  query('page').optional().isInt({ min: 1 }).withMessage('La page doit être > 0'),
  query('limit').optional().isInt({ min: 1, max: 10000 }).withMessage('La limite doit être entre 1 et 10000'),
  validate
], ctrl.getUniversites);

router.get('/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.getUniversite);

router.post('/', protect, adminOnly, [
  body('nom').notEmpty().isLength({ min: 3 }).withMessage('Le nom doit contenir au moins 3 caractères'),
  body('type').notEmpty().isIn(['publique', 'privee']).withMessage('Type doit être "publique" ou "privee"'),
  body('ville').notEmpty().isLength({ min: 2 }).withMessage('La ville est requise'),
  body('wilaya').optional().isString(),
  body('adresse').optional().isString(),
  body('site_web').custom((value) => {
    if (!value || value === null) return true;
    if (typeof value === 'string' && value.trim() === '') return true;
    try {
      new URL(value);
      return true;
    } catch {
      throw new Error('URL invalide');
    }
  }),
  body('email_contact').custom((value) => {
    if (!value || value === null) return true;
    if (typeof value === 'string' && !value.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
      throw new Error('Email invalide');
    }
    return true;
  }),
  body('telephone').custom((value) => {
    if (!value || value === null) return true;
    if (typeof value === 'string' && value.trim().length > 60) {
      throw new Error('Le téléphone ne doit pas dépasser 60 caractères');
    }
    return true;
  }),
  body('description').custom((value) => {
    if (value === null || value === undefined) return true;
    if (typeof value !== 'string') throw new Error('Description invalide');
    return true;
  }),
  body('cout_estimatif').custom((value) => {
    if (value === null || value === undefined) return true;
    if (typeof value !== 'string') throw new Error('Coût estimatif invalide');
    return true;
  }),
  body('duree_etudes').custom((value) => {
    if (value === null || value === undefined) return true;
    if (typeof value !== 'string') throw new Error('Durée d\'études invalide');
    return true;
  }),
  body('logo_url').custom((value) => {
    if (!value || value === null) return true;
    if (typeof value === 'string' && value.trim() === '') return true;
    try {
      new URL(value);
      return true;
    } catch {
      throw new Error('URL invalide');
    }
  }),
  body('date_fondation').optional().isInt({ min: 1000, max: 2030 }).withMessage('Année invalide'),
  validate
], ctrl.creerUniversite);

router.put('/:id', protect, adminOnly, [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  body('nom').optional().isLength({ min: 3 }).withMessage('Le nom doit contenir au moins 3 caractères'),
  body('type').optional().isIn(['publique', 'privee']).withMessage('Type invalide'),
  body('ville').optional().isLength({ min: 2 }).withMessage('La ville doit contenir au moins 2 caractères'),
  body('wilaya').optional().isString(),
  body('adresse').optional().isString(),
  body('site_web').custom((value) => {
    if (!value || value === null) return true;
    if (typeof value === 'string' && value.trim() === '') return true;
    try {
      new URL(value);
      return true;
    } catch {
      throw new Error('URL invalide');
    }
  }),
  body('email_contact').custom((value) => {
    if (!value || value === null) return true;
    if (typeof value === 'string' && !value.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
      throw new Error('Email invalide');
    }
    return true;
  }),
  body('telephone').custom((value) => {
    if (!value || value === null) return true;
    if (typeof value === 'string' && value.trim().length > 60) {
      throw new Error('Le téléphone ne doit pas dépasser 60 caractères');
    }
    return true;
  }),
  body('description').custom((value) => {
    if (value === null || value === undefined) return true;
    if (typeof value !== 'string') throw new Error('Description invalide');
    return true;
  }),
  body('cout_estimatif').custom((value) => {
    if (value === null || value === undefined) return true;
    if (typeof value !== 'string') throw new Error('Coût estimatif invalide');
    return true;
  }),
  body('duree_etudes').custom((value) => {
    if (value === null || value === undefined) return true;
    if (typeof value !== 'string') throw new Error('Durée d\'études invalide');
    return true;
  }),
  body('logo_url').custom((value) => {
    if (!value || value === null) return true;
    if (typeof value === 'string' && value.trim() === '') return true;
    try {
      new URL(value);
      return true;
    } catch {
      throw new Error('URL invalide');
    }
  }),
  body('date_fondation').optional().isInt({ min: 1000, max: 2030 }).withMessage('Année invalide'),
  validate
], ctrl.modifierUniversite);

router.delete('/:id', protect, adminOnly, [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.supprimerUniversite);

module.exports = router;
