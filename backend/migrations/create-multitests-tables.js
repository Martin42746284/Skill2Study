const { sequelize } = require('../config/database');
const { DataTypes } = require('sequelize');

async function createMultiTestsTables() {
  try {
    console.log('Creating multi-tests tables...');

    // Create tests table
    await sequelize.define('Test', {
      id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
      nom: { type: DataTypes.STRING(150), allowNull: false },
      description: { type: DataTypes.TEXT },
      type: { type: DataTypes.ENUM('diagnostic', 'specialise', 'competence'), defaultValue: 'specialise' },
      domaine: { type: DataTypes.STRING(100) },
      duree_minutes: { type: DataTypes.INTEGER, defaultValue: 15 },
      ordre: { type: DataTypes.INTEGER },
      actif: { type: DataTypes.BOOLEAN, defaultValue: true },
      createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
      updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
    }, { tableName: 'tests' }).sync({ alter: false });

    console.log('✅ tests table created');

    // Create test_questions table
    await sequelize.define('TestQuestion', {
      id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
      test_id: { type: DataTypes.INTEGER, allowNull: false },
      question_id: { type: DataTypes.INTEGER, allowNull: false },
      ordre: { type: DataTypes.INTEGER },
      poids_importance: { type: DataTypes.FLOAT, defaultValue: 1.0 }
    }, { tableName: 'test_questions' }).sync({ alter: false });

    console.log('✅ test_questions table created');

    // Create sessions_test_multi table
    await sequelize.define('SessionTestMulti', {
      id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
      user_id: { type: DataTypes.INTEGER, allowNull: false },
      test_id: { type: DataTypes.INTEGER, allowNull: false },
      reponses: { type: DataTypes.JSON, defaultValue: {} },
      score: { type: DataTypes.FLOAT },
      scores_par_domaine: { type: DataTypes.JSON },
      complete: { type: DataTypes.BOOLEAN, defaultValue: false },
      date_completion: { type: DataTypes.DATE },
      createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
      updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
    }, { tableName: 'sessions_test_multi' }).sync({ alter: false });

    console.log('✅ sessions_test_multi table created');

    console.log('🎉 All multi-tests tables created successfully!');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error creating tables:', error);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  createMultiTestsTables();
}

module.exports = createMultiTestsTables;
