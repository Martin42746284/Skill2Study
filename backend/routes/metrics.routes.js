const express = require('express');
const router = express.Router();
const metricsController = require('../controllers/model-metrics.controller');
const { authenticateToken } = require('../middlewares/auth.middleware');

/**
 * Métriques et Évaluation du Modèle ML
 * Endpoints pour évaluer la performance du modèle de recommandation
 */

// GET /api/metrics/model/performance
// Récupérer les métriques de performance du modèle basées sur les recommandations existantes
router.get('/model/performance', metricsController.getModelPerformance);

// POST /api/metrics/model/evaluate
// Évaluer le modèle avec des données de test
router.post('/model/evaluate', metricsController.evaluateModel);

// GET /api/metrics/model/feature-importance
// Récupérer l'importance de chaque feature utilisée par le modèle
router.get('/model/feature-importance', metricsController.getFeatureImportance);

// GET /api/metrics/recommendations/quality
// Analyser la qualité des recommandations générées
router.get('/recommendations/quality', metricsController.getRecommendationQuality);

module.exports = router;
