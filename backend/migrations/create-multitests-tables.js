const { DataTypes } = require('sequelize');

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Create tests table
    await queryInterface.createTable('tests', {
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
    }, { ifNotExists: true });

    // Create test_questions table
    await queryInterface.createTable('test_questions', {
      id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
      test_id: { type: DataTypes.INTEGER, allowNull: false },
      question_id: { type: DataTypes.INTEGER, allowNull: false },
      ordre: { type: DataTypes.INTEGER },
      poids_importance: { type: DataTypes.FLOAT, defaultValue: 1.0 }
    }, { ifNotExists: true });

    // Create sessions_test_multi table
    await queryInterface.createTable('sessions_test_multi', {
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
    }, { ifNotExists: true });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('sessions_test_multi', { ifExists: true });
    await queryInterface.dropTable('test_questions', { ifExists: true });
    await queryInterface.dropTable('tests', { ifExists: true });
  }
};
