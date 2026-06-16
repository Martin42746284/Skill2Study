/**
 * Script complet: Augmenter les données existantes et entraîner le modèle
 * 
 * Pipeline:
 * 1. Augmenter les données existantes (1000 → 4000)
 * 2. Entraîner le modèle IA
 * 3. Tester les métriques
 * 
 * Usage: node scripts/train-with-augmented-data.js [multiplicateur]
 * Exemple: node scripts/train-with-augmented-data.js 4
 */

require('dotenv').config();
const axios = require('axios');
const chalk = require('chalk');
const fs = require('fs');
const path = require('path');
const { sequelize } = require('../config/database');
const { Recommendation, User, ProfilAcademique, Filiere } = require('../models');
const logger = require('../utils/logger');

const AI_SERVICE_URL = process.env.AI_SERVICE_URL || 'http://ai-service:5000';
const MODELS_DIR = path.join(__dirname, '../..', 'ai-service/models');

let stats = {
  original_samples: 0,
  augmented_samples: 0,
  total_samples: 0,
  training_time: 0,
  metrics: {}
};

async function cleanOldModels() {
  try {
    if (!fs.existsSync(MODELS_DIR)) {
      return;
    }

    const files = fs.readdirSync(MODELS_DIR);
    const modelFiles = files.filter(f => f.endsWith('.pkl') || f.endsWith('.joblib'));

    for (const file of modelFiles) {
      const filePath = path.join(MODELS_DIR, file);
      try {
        fs.unlinkSync(filePath);
        logger.info(`🗑️  Ancien modèle supprimé: ${file}`);
      } catch (err) {
        logger.warn(`⚠️  Impossible de supprimer ${file}: ${err.message}`);
      }
    }
  } catch (err) {
    logger.warn(`Nettoyage des anciens modèles échoué: ${err.message}`);
  }
}

async function augmentAndTrain(multiplier = 4) {
  try {
    console.log('\n' + '='.repeat(70));
    console.log('🤖 PIPELINE: AUGMENTATION + ENTRAÎNEMENT DU MODÈLE');
    console.log('='.repeat(70) + '\n');

    // ========================================================================
    // ÉTAPE 0: NETTOYER LES ANCIENS MODÈLES
    // ========================================================================

    console.log('🧹 ÉTAPE 0: Nettoyage des anciens modèles\n');
    await cleanOldModels();

    // ========================================================================
    // ÉTAPE 1: AUGMENTER LES DONNÉES
    // ========================================================================

    console.log('📊 ÉTAPE 1: Récupération et augmentation des données\n');
    
    // Récupérer toutes les recommandations existantes
    logger.info('Récupération des recommandations existantes...');
    const existingRecommendations = await Recommendation.findAll({
      limit: 5000
    });

    stats.original_samples = existingRecommendations.length;
    logger.info(`✓ ${stats.original_samples} recommandations originales trouvées`);

    if (stats.original_samples === 0) {
      logger.error('✗ Aucune recommandation existante. Veuillez générer des données d\'abord.');
      logger.info('💡 Lancez: node scripts/generate-training-data.js 500');
      process.exit(1);
    }

    // Créer les variations
    logger.info(`\nCréation de ${multiplier - 1} variations par recommandation...`);
    const augmentedData = [];
    
    for (const rec of existingRecommendations) {
      augmentedData.push(rec);
      
      for (let i = 1; i < multiplier; i++) {
        augmentedData.push(createDataVariation(rec, i));
      }
    }

    stats.augmented_samples = augmentedData.length - stats.original_samples;
    stats.total_samples = augmentedData.length;
    
    logger.info(`✓ ${stats.augmented_samples} variations créées`);
    logger.info(`✓ Total: ${stats.total_samples} recommandations\n`);

    // ========================================================================
    // ÉTAPE 2: PRÉPARER LES DONNÉES POUR LE ML
    // ========================================================================

    console.log('🔧 ÉTAPE 2: Préparation des données pour le modèle IA\n');

    logger.info('Récupération des profils académiques associés...');
    
    // Récupérer les profils pour enrichir les données
    const profils = await ProfilAcademique.findAll({
      attributes: [
        'user_id', 'serie_bac', 'moyenne_generale', 'centres_interet',
        'competences', 'budget_max_mensuel', 'duree_max_etudes'
      ]
    });

    logger.info(`✓ ${profils.length} profils académiques trouvés`);

    // Créer une map user_id -> profil pour accès rapide
    const profilMap = {};
    for (const profil of profils) {
      profilMap[profil.user_id] = profil;
    }

    // Préparer les données d'entraînement enrichies
    logger.info('\nPréparation des features pour l\'entraînement...');
    
    const trainingData = [];
    let validSamples = 0;
    let skippedSamples = 0;

    for (const rec of augmentedData) {
      const profil = profilMap[rec.user_id];
      
      if (!profil) {
        skippedSamples++;
        continue;
      }

      // Extraire les features normalisées (0-100 pour toutes)
      const features = [
        Math.min(100, (profil.moyenne_generale || 10) * 5),                         // Moyenne: 0-100
        Math.min(100, (profil.centres_interet?.length || 0) * 20),                  // Intérêts: 0-100
        Math.min(100, Object.values(profil.competences || {}).reduce((a, b) => a + b, 0) / 5), // Compétences: 0-100
        Math.min(100, (profil.budget_max_mensuel || 0) / 10000),                    // Budget: 0-100
        Math.min(100, (profil.duree_max_etudes || 3) * 20)                          // Durée: 0-100
      ];

      trainingData.push({
        profil_features: features,
        filiere_id: rec.filiere_id,
        accepted: rec.score_compatibilite >= 70,
        success: rec.score_compatibilite >= 80,
        engagement: Math.max(0, Math.min(1, rec.score_compatibilite / 100))
      });

      validSamples++;
    }

    logger.info(`✓ ${validSamples} exemples d'entraînement valides`);
    logger.info(`⚠️  ${skippedSamples} exemples ignorés (profil manquant)\n`);

    // ========================================================================
    // ÉTAPE 3: ENTRAÎNER LE MODÈLE
    // ========================================================================

    console.log('🚀 ÉTAPE 3: Entraînement du modèle IA\n');

    logger.info('Envoi des données au service IA pour entraînement...');
    const startTime = Date.now();

    const response = await axios.post(
      `${AI_SERVICE_URL}/api/model/train`,
      { training_data: trainingData },
      { timeout: 120000 }  // 2 minutes timeout
    );

    stats.training_time = (Date.now() - startTime) / 1000;

    if (!response.data.success) {
      logger.error(`✗ Erreur lors de l'entraînement: ${response.data.message}`);
      process.exit(1);
    }

    logger.info(`✓ Modèle entraîné avec succès en ${stats.training_time.toFixed(2)}s\n`);

    // ========================================================================
    // ÉTAPE 4: AFFICHER LES RÉSULTATS
    // ========================================================================

    console.log('📈 ÉTAPE 4: Résultats et Métriques\n');

    const metrics = response.data.metrics || {};
    stats.metrics = metrics;

    if (metrics.classifier_metrics) {
      console.log(chalk.bold.cyan('🎯 Classificateur (Accepté/Rejeté):'));
      console.log(`  Accuracy:  ${(metrics.classifier_metrics.accuracy * 100).toFixed(2)}%`);
      console.log(`  Precision: ${(metrics.classifier_metrics.precision * 100).toFixed(2)}%`);
      console.log(`  Recall:    ${(metrics.classifier_metrics.recall * 100).toFixed(2)}%`);
      console.log(`  F1-Score:  ${(metrics.classifier_metrics.f1 * 100).toFixed(2)}%\n`);
    }

    if (metrics.regressor_metrics) {
      console.log(chalk.bold.cyan('📊 Régresseur (Score de compatibilité):'));
      console.log(`  R² Score: ${metrics.regressor_metrics.r2?.toFixed(4)}`);
      console.log(`  MAE:      ${metrics.regressor_metrics.mae?.toFixed(2)}`);
      console.log(`  RMSE:     ${metrics.regressor_metrics.rmse?.toFixed(2)}\n`);
    }

    if (metrics.cross_val_scores) {
      console.log(chalk.bold.cyan('🔄 Validation croisée (5-fold):'));
      console.log(`  Classifier CV: ${(metrics.cross_val_scores.classifier_cv_score * 100).toFixed(2)}%`);
      console.log(`  Regressor CV:  ${(metrics.cross_val_scores.regressor_cv_score * 100).toFixed(2)}%\n`);
    }

    if (metrics.feature_importance) {
      console.log(chalk.bold.cyan('⭐ Importance des features:'));
      Object.entries(metrics.feature_importance).forEach(([feature, importance]) => {
        const bar = '█'.repeat(Math.round(importance * 20));
        console.log(`  ${feature.padEnd(20)} ${bar} ${(importance * 100).toFixed(1)}%`);
      });
      console.log('');
    }

    // ========================================================================
    // RÉSUMÉ FINAL
    // ========================================================================

    console.log('='.repeat(70));
    console.log(chalk.bold.green('✅ PIPELINE COMPLÉTÉ AVEC SUCCÈS!'));
    console.log('='.repeat(70) + '\n');

    console.log(chalk.bold('📊 RÉSUMÉ STATISTIQUES:\n'));
    console.log(`  Données originales:     ${stats.original_samples} recommandations`);
    console.log(`  Données augmentées:     +${stats.augmented_samples} variations`);
    console.log(`  Total utilisé:          ${stats.total_samples} recommandations`);
    console.log(`  Multiplicateur:         ${(stats.total_samples / stats.original_samples).toFixed(2)}x`);
    console.log(`  Temps d'entraînement:   ${stats.training_time.toFixed(2)}s`);
    console.log(`  Exemples entraînés:     ${validSamples}`);
    console.log('\n' + '='.repeat(70) + '\n');

  } catch (err) {
    logger.error(`Erreur fatale: ${err.message}`);
    if (err.response?.data) {
      logger.error(`Détails: ${JSON.stringify(err.response.data)}`);
    }
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

/**
 * Créer une variation d'une recommandation
 */
function createDataVariation(originalRec, variationType) {
  const rec = originalRec.toJSON();
  let scoreVariation;
  
  switch (variationType % 3) {
    case 1:
      const moyenneDelta = (Math.random() - 0.5) * 2;
      scoreVariation = Math.max(0, Math.min(100, 
        rec.score_compatibilite + moyenneDelta * 2
      ));
      break;
    
    case 2:
      const interestDelta = (Math.random() - 0.5) * 8;
      scoreVariation = Math.max(0, Math.min(100,
        rec.score_compatibilite + interestDelta
      ));
      break;
    
    case 0:
    default:
      const budgetDelta = (Math.random() - 0.5) * 6;
      scoreVariation = Math.max(0, Math.min(100,
        rec.score_compatibilite + budgetDelta
      ));
  }

  return {
    user_id: rec.user_id,
    session_test_id: rec.session_test_id,
    filiere_id: rec.filiere_id,
    score_compatibilite: Math.round(scoreVariation * 100) / 100,
    rang: rec.rang,
    justification: {
      ...rec.justification,
      source: 'augmented_data',
      variation_type: variationType % 3
    },
    created_at: new Date(),
    updated_at: new Date()
  };
}

// Récupérer le multiplicateur depuis les arguments
const multiplier = parseInt(process.argv[2]) || 4;

// Lancer le pipeline
augmentAndTrain(multiplier);
