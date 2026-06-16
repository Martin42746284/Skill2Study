/**
 * Script de diagnostic: Vérifier le déséquilibre de classes
 * et la santé du modèle
 * 
 * Usage: node scripts/diagnose-overfitting.js
 */

require('dotenv').config();
const { sequelize } = require('../config/database');
const { Recommendation, ProfilAcademique } = require('../models');
const logger = require('../utils/logger');

async function diagnoseData() {
  try {
    console.log('\n' + '='.repeat(70));
    console.log('🔍 DIAGNOSTIC: État des données d\'entraînement');
    console.log('='.repeat(70) + '\n');

    // Récupérer toutes les recommandations
    const recommendations = await Recommendation.findAll({
      limit: 100000
    });

    logger.info(`Total recommandations: ${recommendations.length}`);

    // Analyser les scores
    const scores = recommendations.map(r => r.score_compatibilite);
    const acceptedCount = scores.filter(s => s >= 70).length;
    const rejectedCount = scores.filter(s => s < 70).length;

    console.log('\n📊 DISTRIBUTION DES CLASSES:\n');
    console.log(`  Acceptés (score ≥ 70):  ${acceptedCount} (${(acceptedCount/scores.length*100).toFixed(1)}%)`);
    console.log(`  Rejetés (score < 70):   ${rejectedCount} (${(rejectedCount/scores.length*100).toFixed(1)}%)`);
    console.log(`  Ratio: 1:${(acceptedCount / rejectedCount).toFixed(2)}`);

    // Vérifier l'équilibre
    const ratio = Math.max(acceptedCount, rejectedCount) / Math.min(acceptedCount, rejectedCount);
    console.log('\n⚖️  ÉQUILIBRE:\n');
    if (ratio > 4) {
      console.log(`  ❌ DÉSÉQUILIBRÉ (ratio ${ratio.toFixed(2)}:1)`);
      console.log(`     → Risque d'overfitting: modèle apprend juste la classe majoritaire`);
      console.log(`     → Solution: Utiliser SMOTE ou class_weight='balanced'`);
    } else if (ratio > 2) {
      console.log(`  ⚠️  LÉGÈREMENT DÉSÉQUILIBRÉ (ratio ${ratio.toFixed(2)}:1)`);
      console.log(`     → Acceptable avec ajustement hyperparamètres`);
    } else {
      console.log(`  ✅ BIEN ÉQUILIBRÉ (ratio ${ratio.toFixed(2)}:1)`);
    }

    // Analyser les scores
    const scoreStats = {
      min: Math.min(...scores),
      max: Math.max(...scores),
      mean: scores.reduce((a, b) => a + b) / scores.length,
      median: scores.sort((a, b) => a - b)[Math.floor(scores.length / 2)]
    };

    console.log('\n📈 STATISTIQUES DES SCORES:\n');
    console.log(`  Min:    ${scoreStats.min.toFixed(2)}`);
    console.log(`  Max:    ${scoreStats.max.toFixed(2)}`);
    console.log(`  Moyen:  ${scoreStats.mean.toFixed(2)}`);
    console.log(`  Médian: ${scoreStats.median.toFixed(2)}`);

    // Vérifier la variance
    const variance = scores.reduce((sum, s) => sum + Math.pow(s - scoreStats.mean, 2), 0) / scores.length;
    const stdDev = Math.sqrt(variance);
    console.log(`  Écart-type: ${stdDev.toFixed(2)}`);

    if (stdDev < 5) {
      console.log(`\n  ⚠️  FAIBLE VARIANCE: Scores trop similaires`);
      console.log(`     → Problème: Données trop synthétiques/uniformes`);
      console.log(`     → Solution: Augmenter la diversité avec plus grandes perturbations`);
    }

    // Analyse des features
    console.log('\n\n🔧 VÉRIFICATION DES FEATURES:\n');
    
    const profils = await ProfilAcademique.findAll({
      limit: 1000
    });

    if (profils.length === 0) {
      console.log('  ❌ Aucun profil trouvé!');
    } else {
      let completeness = 0;
      let missingMoyenne = 0;
      let missingInteret = 0;
      let missingCompetences = 0;

      for (const p of profils) {
        if (p.moyenne_generale) completeness++;
        if (!p.centres_interet || p.centres_interet.length === 0) missingInteret++;
        if (!p.competences || Object.keys(p.competences).length === 0) missingCompetences++;
      }

      console.log(`  Profils analysés: ${profils.length}`);
      console.log(`  Moyenne générale remplie: ${completeness}/${profils.length} (${(completeness/profils.length*100).toFixed(1)}%)`);
      console.log(`  Centres d'intérêt manquants: ${missingInteret} (${(missingInteret/profils.length*100).toFixed(1)}%)`);
      console.log(`  Compétences manquantes: ${missingCompetences} (${(missingCompetences/profils.length*100).toFixed(1)}%)`);

      if (completeness < profils.length * 0.8) {
        console.log(`\n  ⚠️  DONNÉES INCOMPLÈTES: ${100 - (completeness/profils.length*100).toFixed(1)}% valeurs manquantes`);
        console.log(`     → Affecte la qualité du modèle`);
      }
    }

    // Recommandations
    console.log('\n\n✅ RECOMMANDATIONS:\n');

    const issues = [];
    if (ratio > 2) issues.push('Déséquilibre de classes');
    if (stdDev < 5) issues.push('Faible variance');
    if (completeness < profils.length * 0.9) issues.push('Données incomplètes');

    if (issues.length === 0) {
      console.log('  ✅ Pas de problèmes majeurs détectés!');
      console.log('  → Réessayez l\'entraînement avec les hyperparamètres optimisés');
    } else {
      console.log(`  ${issues.join(', ')} détecté(s).`);
      console.log('\n  Actions à prendre:');
      console.log('  1. Utiliser SMOTE pour équilibrer les classes');
      console.log('  2. Réduire max_depth pour moins d\'overfitting');
      console.log('  3. Ajouter class_weight="balanced"');
      console.log('  4. Augmenter min_samples_split et min_samples_leaf');
    }

    console.log('\n' + '='.repeat(70) + '\n');

  } catch (err) {
    logger.error(`Erreur: ${err.message}`);
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

diagnoseData();
