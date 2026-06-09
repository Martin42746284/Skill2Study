/**
 * Script pour corriger la structure de la table Filiere
 * Ajoute les colonnes manquantes si nécessaire
 */

require('dotenv').config();
const { sequelize } = require('../config/database');
const { Filiere } = require('../models');
const logger = require('../utils/logger');

async function fixFilierSchema() {
  try {
    logger.info('🔧 Vérification et correction du schéma Filiere...\n');

    // Obtenir la description de la table
    const result = await sequelize.query(`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = 'filieres'
      ORDER BY ordinal_position
    `);

    const columns = result[0];
    const columnNames = columns.map(c => c.column_name);

    console.log('📋 Colonnes actuelles de la table filieres:');
    console.log('=' .repeat(50));
    columns.forEach(col => {
      console.log(`  • ${col.column_name}: ${col.data_type}`);
    });
    console.log('=' .repeat(50) + '\n');

    // Vérifier les colonnes manquantes
    const requiredColumns = [
      'series_bac_acceptees',
      'moyenne_min_requise',
      'duree_annees',
      'debouches',
      'taux_emploi',
      'salaire_moyen_debutant',
      'cout_annuel',
      'langue',
      'difficulte'
    ];

    const missingColumns = requiredColumns.filter(col => !columnNames.includes(col));

    if (missingColumns.length === 0) {
      logger.info('✅ Toutes les colonnes nécessaires sont présentes !');
      return;
    }

    console.log('⚠️  Colonnes manquantes:');
    missingColumns.forEach(col => console.log(`  • ${col}`));
    console.log();

    // Ajouter les colonnes manquantes
    for (const col of missingColumns) {
      try {
        logger.info(`➕ Ajout de la colonne: ${col}`);

        let query = `ALTER TABLE filieres ADD COLUMN IF NOT EXISTS ${col}`;

        switch (col) {
          case 'series_bac_acceptees':
            query += ` TEXT[] DEFAULT '{C,D,S,A1,A2,G,L}'`;
            break;
          case 'moyenne_min_requise':
            query += ` NUMERIC(5,2) DEFAULT 10`;
            break;
          case 'duree_annees':
            query += ` INTEGER DEFAULT 3`;
            break;
          case 'debouches':
            query += ` TEXT[] DEFAULT '{}'`;
            break;
          case 'taux_emploi':
            query += ` NUMERIC(5,2) DEFAULT 70`;
            break;
          case 'salaire_moyen_debutant':
            query += ` NUMERIC(10,0) DEFAULT 1500000`;
            break;
          case 'cout_annuel':
            query += ` NUMERIC(10,0)`;
            break;
          case 'langue':
            query += ` VARCHAR(50) DEFAULT 'Français'`;
            break;
          case 'difficulte':
            query += ` VARCHAR(50) DEFAULT 'moyen'`;
            break;
        }

        await sequelize.query(query);
        logger.info(`  ✓ ${col} ajoutée avec succès`);

      } catch (err) {
        logger.warn(`  ⚠️  Erreur lors de l'ajout de ${col}: ${err.message}`);
      }
    }

    // Vérifier à nouveau
    console.log('\n📋 Vérification finale...');
    const result2 = await sequelize.query(`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = 'filieres'
      ORDER BY ordinal_position
    `);

    console.log(`✅ La table filieres a maintenant ${result2[0].length} colonnes`);

    // Afficher un résumé
    logger.info('\n✅ Schéma corrigé avec succès !');
    console.log('=' .repeat(50));
    console.log('Vous pouvez maintenant relancer le script de génération de données');
    console.log('=' .repeat(50));

  } catch (err) {
    logger.error(`Erreur fatale: ${err.message}`);
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

fixFilierSchema();
