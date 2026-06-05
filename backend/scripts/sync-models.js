require('dotenv').config({ path: __dirname + '/../.env' });
const { sequelize } = require('../config/database');
const { Test, TestQuestion, SessionTestMulti } = require('../models');

async function syncModels() {
  try {
    console.log('🔄 Syncing models with database...');
    
    // Sync all models
    await sequelize.sync({ alter: true });
    
    console.log('✅ Models synced successfully!');
    console.log('📊 Tables created/updated:');
    console.log('  - tests');
    console.log('  - test_questions');
    console.log('  - sessions_test_multi');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error syncing models:', error.message);
    process.exit(1);
  }
}

syncModels();
