const axios = require('axios');
const { Recommendation, Filiere, ProfilAcademique } = require('../models');
const logger = require('../utils/logger');

const AI_SERVICE_URL = process.env.AI_SERVICE_URL || 'http://ai-service:5000';

// GET /api/metrics/model/performance
exports.getModelPerformance = async (req, res, next) => {
  try {
    logger.info('📊 Calcul des métriques de performance du modèle...');

    // Récupérer les recommandations avec leurs justifications
    const recommendations = await Recommendation.findAll({
      attributes: ['id', 'score_compatibilite', 'filiere_id', 'user_id', 'justification'],
      limit: 1000,
      order: [['createdAt', 'DESC']]
    });

    if (recommendations.length === 0) {
      return res.json({
        success: true,
        message: 'Pas assez de données de recommandation',
        metrics: null,
        samples_count: 0
      });
    }

    // Calculer des métriques basées sur les recommandations
    const scores = recommendations.map(r => r.score_compatibilite);
    const avgScore = scores.reduce((a, b) => a + b, 0) / scores.length;
    const minScore = Math.min(...scores);
    const maxScore = Math.max(...scores);
    
    // Distribution des scores
    const scoreDistribution = {
      excellent: scores.filter(s => s >= 85).length,
      good: scores.filter(s => s >= 70 && s < 85).length,
      fair: scores.filter(s => s >= 50 && s < 70).length,
      poor: scores.filter(s => s < 50).length
    };

    // Calculer la variance et écart-type
    const variance = scores.reduce((sum, score) => sum + Math.pow(score - avgScore, 2), 0) / scores.length;
    const stdDev = Math.sqrt(variance);

    // Métriques de confiance
    const metrics = {
      samples_analyzed: recommendations.length,
      average_score: Math.round(avgScore * 100) / 100,
      median_score: Math.round(scores.sort((a, b) => a - b)[Math.floor(scores.length / 2)] * 100) / 100,
      min_score: minScore,
      max_score: maxScore,
      std_deviation: Math.round(stdDev * 100) / 100,
      score_distribution: {
        excellent_85_plus: scoreDistribution.excellent,
        good_70_to_85: scoreDistribution.good,
        fair_50_to_70: scoreDistribution.fair,
        poor_below_50: scoreDistribution.poor
      },
      score_quality: {
        percentage_85_plus: Math.round((scoreDistribution.excellent / recommendations.length) * 100),
        percentage_70_plus: Math.round(((scoreDistribution.excellent + scoreDistribution.good) / recommendations.length) * 100),
        percentage_50_plus: Math.round(((scoreDistribution.excellent + scoreDistribution.good + scoreDistribution.fair) / recommendations.length) * 100)
      },
      model_health: _calculateModelHealth(avgScore, stdDev, scoreDistribution, recommendations.length)
    };

    logger.info(`✓ Métriques calculées: ${recommendations.length} recommandations analysées`);

    res.json({
      success: true,
      metrics,
      timestamp: new Date().toISOString()
    });

  } catch (err) {
    logger.error(`Erreur lors du calcul des métriques: ${err.message}`);
    next(err);
  }
};

// POST /api/metrics/model/evaluate
exports.evaluateModel = async (req, res, next) => {
  try {
    const { test_data } = req.body;

    if (!test_data || !Array.isArray(test_data)) {
      return res.status(400).json({
        success: false,
        message: 'test_data requis (tableau)'
      });
    }

    logger.info(`🧪 Évaluation du modèle avec ${test_data.length} échantillons de test...`);

    // Appeler le service IA pour l'évaluation
    const response = await axios.post(
      `${AI_SERVICE_URL}/api/model/evaluate`,
      { test_data },
      { timeout: 30000 }
    );

    if (!response.data.success) {
      return res.status(400).json({
        success: false,
        message: response.data.message || 'Erreur lors de l\'évaluation'
      });
    }

    logger.info('✓ Évaluation du modèle terminée');

    res.json({
      success: true,
      evaluation: response.data.metrics,
      samples_evaluated: response.data.samples_evaluated,
      timestamp: new Date().toISOString()
    });

  } catch (err) {
    logger.error(`Erreur lors de l'évaluation: ${err.message}`);
    if (err.response?.data) {
      return res.status(err.response.status || 500).json({
        success: false,
        message: err.response.data.message || err.message
      });
    }
    next(err);
  }
};

// GET /api/metrics/model/feature-importance
exports.getFeatureImportance = async (req, res, next) => {
  try {
    logger.info('📈 Récupération de l\'importance des features...');

    // Appeler le service IA
    const response = await axios.get(
      `${AI_SERVICE_URL}/api/feature-importance`,
      { timeout: 10000 }
    );

    if (!response.data.success) {
      return res.status(400).json({
        success: false,
        message: 'Impossible de récupérer l\'importance des features'
      });
    }

    // Formater les résultats
    const featureImportance = response.data.feature_importance || {};
    
    // Normaliser les importances pour le Random Forest
    const rfImportance = featureImportance.random_forest || {};
    const weightedImportance = featureImportance.weighted_scoring || {};

    // Créer un classement
    const rfRanking = Object.entries(rfImportance)
      .sort((a, b) => b[1] - a[1])
      .map(([name, importance], index) => ({
        rank: index + 1,
        feature: name,
        importance: Math.round(importance * 10000) / 100,
        importance_percentage: Math.round(importance * 100) + '%'
      }));

    const weightedRanking = Object.entries(weightedImportance)
      .sort((a, b) => b[1] - a[1])
      .map(([name, importance], index) => ({
        rank: index + 1,
        feature: name,
        weight: Math.round(importance * 100) + '%'
      }));

    logger.info('✓ Importance des features récupérée');

    res.json({
      success: true,
      feature_importance: {
        random_forest: rfRanking,
        weighted_scoring: weightedRanking
      },
      timestamp: new Date().toISOString()
    });

  } catch (err) {
    logger.error(`Erreur lors de la récupération de l'importance: ${err.message}`);
    if (err.response?.data) {
      return res.status(err.response.status || 500).json({
        success: false,
        message: err.response.data.message || err.message
      });
    }
    next(err);
  }
};

// GET /api/metrics/recommendations/quality
exports.getRecommendationQuality = async (req, res, next) => {
  try {
    logger.info('🎯 Analyse de la qualité des recommandations...');

    // Récupérer les recommandations récentes
    const recommendations = await Recommendation.findAll({
      attributes: ['id', 'score_compatibilite', 'user_id', 'filiere_id', 'createdAt'],
      order: [['createdAt', 'DESC']],
      limit: 500
    });

    if (recommendations.length === 0) {
      return res.json({
        success: true,
        quality_metrics: null,
        message: 'Pas assez de recommandations'
      });
    }

    // Récupérer les profils et filières associées
    const userIds = [...new Set(recommendations.map(r => r.user_id))];
    const filiereIds = [...new Set(recommendations.map(r => r.filiere_id))];

    const profils = await ProfilAcademique.findAll({
      where: { user_id: userIds },
      attributes: ['user_id', 'serie_bac', 'moyenne_generale']
    });

    const filieres = await Filiere.findAll({
      where: { id: filiereIds },
      attributes: ['id', 'nom', 'moyenne_min_requise', 'series_bac_acceptees']
    });

    // Créer des maps pour accès rapide
    const profilMap = new Map(profils.map(p => [p.user_id, p]));
    const filiereMap = new Map(filieres.map(f => [f.id, f]));

    // Analyser la qualité
    let serieBacMatches = 0;
    let moyenneMatches = 0;
    let totalScore = 0;

    recommendations.forEach(rec => {
      totalScore += rec.score_compatibilite || 0;

      const profil = profilMap.get(rec.user_id);
      const filiere = filiereMap.get(rec.filiere_id);

      if (profil && filiere) {
        const serieProfil = profil.serie_bac;
        const seriesAcceptees = filiere.series_bac_acceptees || [];
        
        if (seriesAcceptees.includes(serieProfil)) {
          serieBacMatches++;
        }

        const moyenneProfil = profil.moyenne_generale || 0;
        const moyenneMin = filiere.moyenne_min_requise || 0;
        
        if (moyenneProfil >= moyenneMin) {
          moyenneMatches++;
        }
      }
    });

    const compatibilityAvg = Math.round((totalScore / recommendations.length) * 100) / 100;
    const serieBacRate = Math.round((serieBacMatches / recommendations.length) * 100);
    const moyenneRate = Math.round((moyenneMatches / recommendations.length) * 100);
    const overallScore = Math.round(
      (compatibilityAvg * 0.5 + serieBacRate * 0.25 + moyenneRate * 0.25) / 100 * 100
    );

    const qualityMetrics = {
      total_recommendations: recommendations.length,
      compatibility_score_avg: compatibilityAvg,
      serie_bac_match_rate: serieBacRate,
      moyenne_match_rate: moyenneRate,
      overall_quality_score: overallScore
    };

    logger.info(`✓ Qualité des recommandations analysée: ${overallScore}%`);

    res.json({
      success: true,
      quality_metrics: qualityMetrics,
      timestamp: new Date().toISOString()
    });

  } catch (err) {
    logger.error(`Erreur lors de l'analyse de qualité: ${err.message}`);
    next(err);
  }
};

// ────────────────────────────────────────────────────────────────────────────
// HELPERS
// ────────────────────────────────────────────────────────────────────────────

function _calculateModelHealth(avgScore, stdDev, distribution, sampleCount) {
  let health = 0;

  // 1. Score moyen (0-35 points)
  if (avgScore >= 70 && avgScore <= 85) {
    health += 35;
  } else if (avgScore >= 60 && avgScore < 70) {
    health += 25;
  } else if (avgScore >= 50 && avgScore < 60) {
    health += 15;
  } else if (avgScore >= 85) {
    health += 30;
  } else {
    health += 5;
  }

  // 2. Distribution équilibrée (0-30 points)
  const totalRecs = distribution.excellent + distribution.good + distribution.fair + distribution.poor;
  const excellentPct = distribution.excellent / totalRecs;
  const poorPct = distribution.poor / totalRecs;

  if (excellentPct < 0.3 && poorPct < 0.2) {
    health += 30;
  } else if (excellentPct < 0.4 && poorPct < 0.3) {
    health += 20;
  } else if (excellentPct > 0.6 || poorPct > 0.4) {
    health += 5;
  } else {
    health += 15;
  }

  // 3. Variation (0-20 points)
  if (stdDev >= 10 && stdDev <= 20) {
    health += 20;
  } else if (stdDev > 5 && stdDev < 30) {
    health += 10;
  } else {
    health += 5;
  }

  // 4. Données suffisantes (0-15 points)
  if (sampleCount >= 1000) {
    health += 15;
  } else if (sampleCount >= 500) {
    health += 10;
  } else if (sampleCount >= 100) {
    health += 5;
  }

  return Math.round(health);
}
