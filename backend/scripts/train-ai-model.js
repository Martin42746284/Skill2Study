/**
 * Script pour réentraîner le modèle IA avec les données générées
 * 
 * Usage: node scripts/train-ai-model.js
 */

require('dotenv').config();
const axios = require('axios');
const { Recommendation, User, ProfilAcademique, Filiere } = require('../models');
const logger = require('../utils/logger');

const AI_SERVICE_URL = process.env.AI_SERVICE_URL || 'http://ai-service:5000';

async function trainAIModel() {
  try {
    logger.info('\n🚀 Début de l\'entraînement du modèle IA...\n');

    // 1. Récupérer les recommandations avec les profils associés
    logger.info('📂 Récupération des données d\'entraînement...');
    
    const recommendations = await Recommendation.findAll({
      include: [
        {
          model: User,
          attributes: ['id']
        },
        {
          model: Filiere,
          as: 'filiere',
          attributes: ['id', 'nom']
        }
      ],
      limit: 5000
    });

    logger.info(`✓ ${recommendations.length} recommandations trouvées`);

    // 2. Récupérer les profils académiques
    const profils = await ProfilAcademique.findAll({
      attributes: [
        'user_id', 'serie_bac', 'moyenne_generale', 'centres_interet',
        'competences', 'budget_max_mensuel', 'duree_max_etudes'
      ]
    });

    logger.info(`✓ ${profils.length} profils académiques trouvés`);

    // 3. Préparer les données d'entraînement
    logger.info('\n🔧 Préparation des données pour l\'IA...');
    
    const trainingData = [];

    for (const rec of recommendations) {
      const profil = profils.find(p => p.user_id === rec.user_id);
      
      if (!profil) continue;

      // Convertir le profil en features
      const features = [
        profil.moyenne_generale * 5, // Score 0-100
        (profil.centres_interet?.length || 0) / 10, // Match 0-1
        Object.values(profil.competences || {}).reduce((a, b) => a + b, 0) / 25 * 10, // Score 0-100
        (profil.budget_max_mensuel || 0) / 1000000, // Normaliser
        profil.duree_max_etudes || 3
      ];

      trainingData.push({
        profil_features: features,
        filiere_id: rec.filiere_id,
        accepted: rec.score_compatibilite >= 70,
        success: rec.score_compatibilite >= 80,
        engagement: rec.score_compatibilite / 100
      });
    }

    logger.info(`✓ ${trainingData.length} exemples d'entraînement préparés\n`);

    // 4. Envoyer les données au service IA pour entraînement
    logger.info('🤖 Envoi des données au service IA pour entraînement...');
    
    const response = await axios.post(
      `${AI_SERVICE_URL}/api/model/train`,
      { training_data: trainingData },
      { timeout: 60000 }
    );

    if (!response.data.success) {
      logger.error(`✗ Erreur lors de l'entraînement: ${response.data.message}`);
      return;
    }

    logger.info('✅ Modèle entraîné avec succès !\n');

    // 5. Afficher les métriques
    const metrics = response.data.metrics || {};
    console.log('📊 Métriques d\'entraînement:');
    console.log('=' .repeat(60));
    
    if (metrics.classifier_metrics) {
      console.log('\n🎯 Classificateur (Accepté/Rejeté):');
      console.log(`  Accuracy: ${(metrics.classifier_metrics.accuracy * 100).toFixed(2)}%`);
      console.log(`  Precision: ${(metrics.classifier_metrics.precision * 100).toFixed(2)}%`);
      console.log(`  Recall: ${(metrics.classifier_metrics.recall * 100).toFixed(2)}%`);
      console.log(`  F1-Score: ${(metrics.classifier_metrics.f1 * 100).toFixed(2)}%`);
    }

    if (metrics.regressor_metrics) {
      console.log('\n📈 Régresseur (Score de compatibilité):');
      console.log(`  R² Score: ${metrics.regressor_metrics.r2?.toFixed(4)}`);
      console.log(`  MAE: ${metrics.regressor_metrics.mae?.toFixed(2)}`);
      console.log(`  RMSE: ${metrics.regressor_metrics.rmse?.toFixed(2)}`);
    }

    if (metrics.cross_val_scores) {
      console.log('\n🔄 Validation croisée (5-fold):');
      console.log(`  Classifier CV: ${(metrics.cross_val_scores.classifier_cv_score * 100).toFixed(2)}%`);
      console.log(`  Regressor CV: ${(metrics.cross_val_scores.regressor_cv_score * 100).toFixed(2)}%`);
    }

    if (metrics.feature_importance) {
      console.log('\n⭐ Importance des features:');
      Object.entries(metrics.feature_importance).forEach(([feature, importance]) => {
        const bar = '█'.repeat(Math.round(importance * 20));
        console.log(`  ${feature.padEnd(20)} ${bar} ${(importance * 100).toFixed(1)}%`);
      });
    }

    console.log('=' .repeat(60));
    console.log('\n✅ Entraînement terminé avec succès !\n');

  } catch (err) {
    logger.error(`Erreur fatale: ${err.message}`);
    if (err.response?.data) {
      logger.error(`Détails: ${JSON.stringify(err.response.data)}`);
    }
    process.exit(1);
  }
}

trainAIModel();
