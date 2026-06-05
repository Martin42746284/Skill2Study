const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

// --- Test (Entité maître pour tests spécialisés) ---
const Test = sequelize.define('Test', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nom: { type: DataTypes.STRING(150), allowNull: false }, // ex: "Test de Mathématiques"
  description: { type: DataTypes.TEXT },
  type: { type: DataTypes.ENUM('diagnostic', 'specialise', 'competence'), defaultValue: 'specialise' },
  domaine: { type: DataTypes.STRING(100) }, // ex: "mathematiques", "sciences", "langues"
  duree_minutes: { type: DataTypes.INTEGER, defaultValue: 15 },
  ordre: { type: DataTypes.INTEGER }, // pour l'affichage
  actif: { type: DataTypes.BOOLEAN, defaultValue: true },
  createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { tableName: 'tests' });

// --- TestQuestion (Relation many-to-many entre Test et Question) ---
const TestQuestion = sequelize.define('TestQuestion', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  test_id: { type: DataTypes.INTEGER, allowNull: false },
  question_id: { type: DataTypes.INTEGER, allowNull: false },
  ordre: { type: DataTypes.INTEGER }, // ordre des questions dans le test
  poids_importance: { type: DataTypes.FLOAT, defaultValue: 1.0 } // poids pour le calcul du score
}, { tableName: 'test_questions' });

// --- SessionTestMulti (Sessions de test spécialisés par utilisateur) ---
const SessionTestMulti = sequelize.define('SessionTestMulti', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  user_id: { type: DataTypes.INTEGER, allowNull: false },
  test_id: { type: DataTypes.INTEGER, allowNull: false },
  reponses: { type: DataTypes.JSON, defaultValue: {} }, // { question_id: option_id, ... }
  score: { type: DataTypes.FLOAT }, // Score final du test (0-100)
  scores_par_domaine: { type: DataTypes.JSON }, // { domaine: score, ... }
  complete: { type: DataTypes.BOOLEAN, defaultValue: false },
  date_completion: { type: DataTypes.DATE },
  createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { tableName: 'sessions_test_multi' });

module.exports = { Test, TestQuestion, SessionTestMulti };
