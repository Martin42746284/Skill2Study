/**
 * Script pour créer une table de feedback utilisateur
 * Cela permettra de tracker si les recommandations étaient bonnes
 */

require('dotenv').config();
const { sequelize } = require('../config/database');
const logger = require('../utils/logger');

async function createFeedbackTable() {
  try {
    logger.info('🔧 Création de la table de feedback utilisateur...\n');

    // Créer la table directement via SQL
    await sequelize.query(`
      CREATE TABLE IF NOT EXISTS recommendation_feedback (
        id SERIAL PRIMARY KEY,
        recommendation_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        
        -- Feedback utilisateur immédiat
        user_satisfaction INTEGER,        -- 1-10
        user_accepted BOOLEAN DEFAULT false,
        user_enrolled BOOLEAN DEFAULT false,
        notes TEXT,
        
        -- Résultats réels (suivi 6+ mois après)
        enrollment_date DATE,
        completion_date DATE,
        actual_grades NUMERIC,
        dropped_out BOOLEAN DEFAULT false,
        
        -- Engagement
        engagement_score NUMERIC,         -- 0-1
        
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (recommendation_id) REFERENCES recommendations(id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      );
    `);

    logger.info('✅ Table de feedback créée avec succès !');

    // Créer les indexes
    await sequelize.query(`
      CREATE INDEX IF NOT EXISTS idx_feedback_user ON recommendation_feedback(user_id);
      CREATE INDEX IF NOT EXISTS idx_feedback_recommendation ON recommendation_feedback(recommendation_id);
      CREATE INDEX IF NOT EXISTS idx_feedback_created ON recommendation_feedback(created_at DESC);
    `);

    logger.info('✅ Indexes créés\n');

    // Afficher le schéma
    const result = await sequelize.query(`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = 'recommendation_feedback'
      ORDER BY ordinal_position
    `);

    console.log('📋 Structure de la table recommendation_feedback:');
    console.log('=' .repeat(50));
    result[0].forEach(col => {
      console.log(`  • ${col.column_name}: ${col.data_type}`);
    });
    console.log('=' .repeat(50) + '\n');

    logger.info('✅ Table prête à collecter le feedback utilisateur !');

  } catch (err) {
    logger.error(`Erreur: ${err.message}`);
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

createFeedbackTable();
