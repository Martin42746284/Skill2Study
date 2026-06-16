/**
 * Script pour tester et afficher les métriques du modèle ML
 * Utilisation: node scripts/test-model-metrics.js
 */

const axios = require('axios');
const chalk = require('chalk');

const BASE_URL = 'http://localhost:3000/api';

const metricsAPI = axios.create({
  baseURL: BASE_URL,
  timeout: 30000
});

async function getModelPerformance() {
  console.log(chalk.blue('\n📊 MÉTRIQUES DE PERFORMANCE DU MODÈLE'));
  console.log(chalk.gray('=' .repeat(60)));
  
  try {
    const response = await metricsAPI.get('/metrics/model/performance');
    const { metrics } = response.data;

    if (!metrics) {
      console.log(chalk.yellow('⚠️  Pas assez de données de recommandation'));
      return;
    }

    console.log(chalk.white(`\nÉchantillons analysés: ${chalk.cyan(metrics.samples_analyzed)}`));
    console.log(chalk.white(`Score moyen: ${chalk.cyan(metrics.average_score + '/100')}`));
    console.log(chalk.white(`Score médian: ${chalk.cyan(metrics.median_score + '/100')}`));
    console.log(chalk.white(`Écart-type: ${chalk.cyan(metrics.std_deviation)}`));
    console.log(chalk.white(`Plage: ${chalk.cyan(metrics.min_score)} - ${chalk.cyan(metrics.max_score)}`));

    console.log(chalk.white('\n📈 Distribution des scores:'));
    console.log(chalk.green(`  ✓ Excellent (85+): ${metrics.score_distribution.excellent_85_plus} (${metrics.score_quality.percentage_85_plus}%)`));
    console.log(chalk.cyan(`  ○ Bon (70-85): ${metrics.score_distribution.good_70_to_85} (${metrics.score_quality.percentage_70_plus - metrics.score_quality.percentage_85_plus}%)`));
    console.log(chalk.yellow(`  ◐ Acceptable (50-70): ${metrics.score_distribution.fair_50_to_70}`));
    console.log(chalk.red(`  ✗ Faible (<50): ${metrics.score_distribution.poor_below_50}`));

    console.log(chalk.white('\n🎯 Qualité du modèle:'));
    console.log(chalk.white(`  Score de santé: ${_getHealthColor(metrics.model_health)(metrics.model_health)}/100`));
    console.log(chalk.white(`  ${metrics.score_quality.percentage_70_plus}% des scores ≥ 70`));
    console.log(chalk.white(`  ${metrics.score_quality.percentage_50_plus}% des scores ≥ 50`));

    return metrics;

  } catch (err) {
    console.error(chalk.red(`✗ Erreur: ${err.message}`));
  }
}

async function getFeatureImportance() {
  console.log(chalk.blue('\n📈 IMPORTANCE DES FEATURES'));
  console.log(chalk.gray('=' .repeat(60)));
  
  try {
    const response = await metricsAPI.get('/metrics/model/feature-importance');
    const { feature_importance } = response.data;

    console.log(chalk.white('\n🤖 Random Forest:'));
    feature_importance.random_forest.slice(0, 5).forEach(f => {
      const bar = '█'.repeat(Math.round(f.importance / 2));
      console.log(chalk.white(`  ${f.feature.padEnd(25)} ${chalk.cyan(bar)} ${f.importance_percentage}`));
    });

    console.log(chalk.white('\n⚖️  Scoring Pondéré:'));
    feature_importance.weighted_scoring.slice(0, 5).forEach(f => {
      const bar = '█'.repeat(Math.round(parseInt(f.weight) / 2));
      console.log(chalk.white(`  ${f.feature.padEnd(25)} ${chalk.cyan(bar)} ${f.weight}`));
    });

    return feature_importance;

  } catch (err) {
    console.error(chalk.red(`✗ Erreur: ${err.message}`));
  }
}

async function getRecommendationQuality() {
  console.log(chalk.blue('\n🎯 QUALITÉ DES RECOMMANDATIONS'));
  console.log(chalk.gray('=' .repeat(60)));
  
  try {
    // Note: Nécessite l'authentification
    const response = await metricsAPI.get('/metrics/recommendations/quality');
    const { quality_metrics } = response.data;

    if (!quality_metrics) {
      console.log(chalk.yellow('⚠️  Pas assez de données'));
      return;
    }

    console.log(chalk.white(`\nTotal recommandations: ${chalk.cyan(quality_metrics.total_recommendations)}`));
    console.log(chalk.white(`Score de compatibilité moyen: ${chalk.cyan(quality_metrics.compatibility_score_avg + '/100')}`));
    console.log(chalk.white(`Taux de matching série bac: ${chalk.green(quality_metrics.serie_bac_match_rate + '%')}`));
    console.log(chalk.white(`Taux de matching moyenne: ${chalk.green(quality_metrics.moyenne_match_rate + '%')}`));
    console.log(chalk.white(`\nScore de qualité global: ${_getQualityColor(quality_metrics.overall_quality_score)(quality_metrics.overall_quality_score)}/100`));

    return quality_metrics;

  } catch (err) {
    if (err.response?.status === 401) {
      console.log(chalk.yellow('⚠️  Authentification requise'));
    } else {
      console.error(chalk.red(`✗ Erreur: ${err.message}`));
    }
  }
}

function _getHealthColor(score) {
  if (score >= 80) return chalk.green;
  if (score >= 60) return chalk.yellow;
  return chalk.red;
}

function _getQualityColor(score) {
  if (score >= 80) return chalk.green;
  if (score >= 60) return chalk.cyan;
  if (score >= 40) return chalk.yellow;
  return chalk.red;
}

async function main() {
  console.log(chalk.bold.cyan('\n🤖 ÉVALUATION DU MODÈLE DE RECOMMANDATION\n'));
  
  await getModelPerformance();
  await getFeatureImportance();
  
  // Décommenter pour tester la qualité (nécessite l'authentification)
  // await getRecommendationQuality();
  
  console.log(chalk.gray('\n' + '=' .repeat(60)));
  console.log(chalk.green('✓ Évaluation terminée\n'));
}

main().catch(err => {
  console.error(chalk.red('Erreur fatale:'), err);
  process.exit(1);
});
