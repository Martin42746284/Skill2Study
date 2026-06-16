/**
 * Script pour nettoyer et réinitialiser les modèles ML sauvegardés
 * Supprime les fichiers .pkl du répertoire ai-service/models/
 * 
 * Usage: node scripts/reset-models.js
 */

const fs = require('fs');
const path = require('path');
const logger = require('../utils/logger');

const MODELS_DIR = path.join(__dirname, '../../ai-service/models');

async function resetModels() {
  try {
    console.log('\n' + '='.repeat(70));
    console.log('🔄 RÉINITIALISATION DES MODÈLES ML');
    console.log('='.repeat(70) + '\n');

    // Vérifier si le répertoire existe
    if (!fs.existsSync(MODELS_DIR)) {
      logger.info(`✓ Répertoire ${MODELS_DIR} n'existe pas (rien à nettoyer)`);
      console.log('='.repeat(70) + '\n');
      return;
    }

    // Lister les fichiers
    const files = fs.readdirSync(MODELS_DIR);
    logger.info(`Fichiers trouvés: ${files.length}`);

    // Filtrer les fichiers .pkl et .joblib
    const modelFiles = files.filter(f => f.endsWith('.pkl') || f.endsWith('.joblib'));
    
    if (modelFiles.length === 0) {
      logger.info('✓ Aucun modèle trouvé à supprimer');
      console.log('='.repeat(70) + '\n');
      return;
    }

    console.log('\n📁 Fichiers à supprimer:\n');
    for (const file of modelFiles) {
      const filePath = path.join(MODELS_DIR, file);
      const stats = fs.statSync(filePath);
      console.log(`  ❌ ${file} (${(stats.size / 1024).toFixed(2)} KB)`);
    }

    // Supprimer les fichiers
    console.log('\n🗑️  Suppression des fichiers...\n');
    for (const file of modelFiles) {
      const filePath = path.join(MODELS_DIR, file);
      fs.unlinkSync(filePath);
      logger.info(`  ✓ ${file} supprimé`);
    }

    console.log('\n' + '='.repeat(70));
    console.log('✅ MODÈLES RÉINITIALISÉS!');
    console.log('='.repeat(70));
    console.log('\n💡 Prochaine étape:');
    console.log('   node scripts/train-with-augmented-data.js 4');
    console.log('   Les nouveaux modèles seront générés lors de l\'entraînement.\n');

  } catch (err) {
    logger.error(`Erreur: ${err.message}`);
    process.exit(1);
  }
}

resetModels();
