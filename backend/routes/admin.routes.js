const router = require('express').Router();
const { body, param, query } = require('express-validator');
const { protect, adminOnly } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/admin.controller');

router.use(protect, adminOnly);

router.get('/users', [
  query('page').optional().isInt({ min: 1 }).withMessage('La page doit être > 0'),
  query('limit').optional().isInt({ min: 1, max: 10000 }).withMessage('La limite doit être entre 1 et 10000'),
  query('role').optional().isIn(['bachelier', 'admin']).withMessage('Rôle invalide'),
  validate
], ctrl.getUsers);

router.post('/users', [
  body('nom').notEmpty().isLength({ min: 2 }).withMessage('Le nom doit contenir au moins 2 caractères'),
  body('prenom').notEmpty().isLength({ min: 2 }).withMessage('Le prénom doit contenir au moins 2 caractères'),
  body('email').isEmail().withMessage('Email invalide'),
  body('mot_de_passe').isLength({ min: 6 }).withMessage('Le mot de passe doit contenir au moins 6 caractères'),
  body('role').optional().isIn(['bachelier', 'admin']).withMessage('Rôle invalide'),
  body('serie_bac').optional().isString(),
  body('ville').optional().isString(),
  body('budget_mensuel').optional().isFloat({ min: 0 }),
  body('actif').optional().isBoolean(),
  validate
], ctrl.createUser);

router.put('/users/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  body('nom').optional().isLength({ min: 2 }).withMessage('Le nom doit contenir au moins 2 caractères'),
  body('prenom').optional().isLength({ min: 2 }).withMessage('Le prénom doit contenir au moins 2 caractères'),
  body('email').optional().isEmail().withMessage('Email invalide'),
  body('mot_de_passe').optional().isLength({ min: 6 }).withMessage('Le mot de passe doit contenir au moins 6 caractères'),
  body('role').optional().isIn(['bachelier', 'admin']).withMessage('Rôle invalide'),
  body('serie_bac').optional().isString(),
  body('ville').optional().isString(),
  body('budget_mensuel').optional().isFloat({ min: 0 }),
  body('actif').optional().isBoolean(),
  validate
], ctrl.updateUser);

router.delete('/users/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.deleteUser);

router.patch('/users/:id/toggle', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.toggleUser);

router.post('/questions', [
  body('texte').notEmpty().isLength({ min: 10 }).withMessage('Le texte doit contenir au moins 10 caractères'),
  body('categorie').optional().isString().trim(),
  body('series_bac_cibles').optional().isArray().withMessage('Doit être un tableau'),
  body('ordre').optional().isInt().withMessage('L\'ordre doit être un entier'),
  body('options').isArray({ min: 2 }).withMessage('Au moins 2 options requises'),
  body('options.*.texte').notEmpty().isLength({ min: 2 }).withMessage('Le texte de l\'option doit contenir au moins 2 caractères'),
  body('options.*.poids').optional().isObject().withMessage('Les poids doivent être un objet'),
  validate
], ctrl.creerQuestion);

router.put('/questions/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  body('texte').optional().isLength({ min: 10 }).withMessage('Le texte doit contenir au moins 10 caractères'),
  body('categorie').optional().isString().trim(),
  body('actif').optional().isBoolean().withMessage('Doit être booléen'),
  validate
], ctrl.modifierQuestion);

router.delete('/questions/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.supprimerQuestion);

// ─── Routes pour les règles de recommandation ───────────────────────────────

router.get('/recommendation-rules', ctrl.getRulesRecommandation);

router.get('/recommendation-rules/active', ctrl.getActiveRule);

router.get('/recommendation-rules/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.getRuleRecommandation);

router.post('/recommendation-rules', [
  body('nom').optional().isString().trim().isLength({ min: 3 }),
  body('poids_serie').optional().isInt({ min: 0, max: 100 }),
  body('poids_moyenne').optional().isInt({ min: 0, max: 100 }),
  body('poids_interet').optional().isInt({ min: 0, max: 100 }),
  body('poids_competences').optional().isInt({ min: 0, max: 100 }),
  body('poids_budget').optional().isInt({ min: 0, max: 100 }),
  body('poids_duree').optional().isInt({ min: 0, max: 100 }),
  body('poids_test').optional().isInt({ min: 0, max: 100 }),
  body('moyenne_min_acceptable').optional().isFloat({ min: 0, max: 20 }),
  body('methode_scoring').optional().isIn(['pondere', 'knn', 'decision_tree', 'hybrid']),
  validate
], ctrl.creerRuleRecommandation);

router.put('/recommendation-rules/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  body('nom').optional().isString().trim().isLength({ min: 3 }),
  body('poids_serie').optional().isInt({ min: 0, max: 100 }),
  body('poids_moyenne').optional().isInt({ min: 0, max: 100 }),
  body('poids_interet').optional().isInt({ min: 0, max: 100 }),
  body('poids_competences').optional().isInt({ min: 0, max: 100 }),
  body('poids_budget').optional().isInt({ min: 0, max: 100 }),
  body('poids_duree').optional().isInt({ min: 0, max: 100 }),
  body('poids_test').optional().isInt({ min: 0, max: 100 }),
  body('moyenne_min_acceptable').optional().isFloat({ min: 0, max: 20 }),
  body('methode_scoring').optional().isIn(['pondere', 'knn', 'decision_tree', 'hybrid']),
  validate
], ctrl.mettreAJourRule);

router.patch('/recommendation-rules/:id/activate', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.activerRule);

router.delete('/recommendation-rules/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.supprimerRule);

// ─── Routes pour les témoignages ───────────────────────────────────────

router.get('/testimonials', [
  query('page').optional().isInt({ min: 1 }).withMessage('La page doit être > 0'),
  query('limit').optional().isInt({ min: 1, max: 10000 }).withMessage('La limite doit être entre 1 et 10000'),
  query('status').optional().isIn(['Approuvé', 'En attente', 'Rejeté']).withMessage('Statut invalide'),
  validate
], ctrl.getTestimonials);

router.post('/testimonials', [
  body('student_name').notEmpty().isLength({ min: 2 }).withMessage('Nom requis'),
  body('student_serie').optional().isString(),
  body('university_name').notEmpty().isLength({ min: 2 }).withMessage('Université requise'),
  body('course_name').notEmpty().isLength({ min: 2 }).withMessage('Filière requise'),
  body('text').notEmpty().isLength({ min: 10 }).withMessage('Le texte doit contenir au moins 10 caractères'),
  body('rating').isInt({ min: 1, max: 5 }).withMessage('La note doit être entre 1 et 5'),
  validate
], ctrl.createTestimonial);

router.put('/testimonials/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  body('student_name').optional().isLength({ min: 2 }),
  body('text').optional().isLength({ min: 10 }),
  body('rating').optional().isInt({ min: 1, max: 5 }),
  validate
], ctrl.updateTestimonial);

router.delete('/testimonials/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.deleteTestimonial);

router.patch('/testimonials/:id/approve', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.approveTestimonial);

router.patch('/testimonials/:id/reject', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.rejectTestimonial);

// ─── Routes pour les paramètres ───────────────────────────────────────

router.get('/settings', ctrl.getSettings);

router.put('/settings', [
  body('platform_name').optional().isString(),
  body('platform_description').optional().isString(),
  body('contact_email').optional().isEmail(),
  body('email_notifications').optional().isBoolean(),
  body('moderation_alerts').optional().isBoolean(),
  body('weekly_reports').optional().isBoolean(),
  body('two_factor_auth').optional().isBoolean(),
  body('open_registration').optional().isBoolean(),
  body('email_verification').optional().isBoolean(),
  body('maintenance_mode').optional().isBoolean(),
  validate
], ctrl.updateSettings);

module.exports = router;
