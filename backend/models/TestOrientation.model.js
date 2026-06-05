const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

// --- Question du test ---
const Question = sequelize.define('Question', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  texte: { type: DataTypes.TEXT, allowNull: false },
  categorie: { type: DataTypes.STRING(100) }, // competence, interet, personnalite
  series_bac_cibles: { type: DataTypes.JSON },  // null = pour tous
  ordre: { type: DataTypes.INTEGER },
  actif: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'questions' });

// --- Option de réponse ---
const OptionReponse = sequelize.define('OptionReponse', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  question_id: { type: DataTypes.INTEGER, allowNull: false },
  texte: { type: DataTypes.STRING(300), allowNull: false },
  poids: { type: DataTypes.JSON } // ex: { "mathematiques": 2, "sciences": 1 }
}, { tableName: 'options_reponses' });

// --- Session de test ---
const SessionTest = sequelize.define('SessionTest', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  user_id: { type: DataTypes.INTEGER, allowNull: false },
  reponses: { type: DataTypes.JSON },   // { question_id: option_id, ... }
  scores: { type: DataTypes.JSON },      // scores calculés par catégorie
  complete: { type: DataTypes.BOOLEAN, defaultValue: false },
  date_completion: { type: DataTypes.DATE }
}, { tableName: 'sessions_test' });

// --- Recommandation ---
const Recommendation = sequelize.define('Recommendation', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  user_id: { type: DataTypes.INTEGER, allowNull: false },
  session_test_id: { type: DataTypes.INTEGER },
  filiere_id: { type: DataTypes.INTEGER, allowNull: false },
  score_compatibilite: { type: DataTypes.FLOAT }, // 0-100
  rang: { type: DataTypes.INTEGER },
  justification: { type: DataTypes.JSON },  // explications détaillées
  // ex: { "points_forts": [...], "points_attention": [...], "raisons": "..." }
  sauvegardee: { type: DataTypes.BOOLEAN, defaultValue: false }
}, { tableName: 'recommendations' });

// --- Favori ---
const Favori = sequelize.define('Favori', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  user_id: { type: DataTypes.INTEGER, allowNull: false },
  filiere_id: { type: DataTypes.INTEGER, allowNull: false }
}, { tableName: 'favoris' });

// --- Règles de recommandation (poids et seuils) ---
const RecommendationRules = sequelize.define('RecommendationRules', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nom: { type: DataTypes.STRING(150), allowNull: false, defaultValue: 'Règles par défaut' },
  description: { type: DataTypes.TEXT },
  // Poids des critères (en %)
  poids_serie: { type: DataTypes.INTEGER, defaultValue: 25 },
  poids_moyenne: { type: DataTypes.INTEGER, defaultValue: 20 },
  poids_interet: { type: DataTypes.INTEGER, defaultValue: 20 },
  poids_competences: { type: DataTypes.INTEGER, defaultValue: 15 },
  poids_budget: { type: DataTypes.INTEGER, defaultValue: 10 },
  poids_duree: { type: DataTypes.INTEGER, defaultValue: 5 },
  poids_test: { type: DataTypes.INTEGER, defaultValue: 5 },
  // Seuils et filtres
  moyenne_min_acceptable: { type: DataTypes.FLOAT, defaultValue: 10.0 },  // moyenne générale minimale acceptée
  filtre_eliminer_hors_serie: { type: DataTypes.BOOLEAN, defaultValue: true }, // éliminer si série non acceptée
  filtre_eliminer_hors_budget: { type: DataTypes.BOOLEAN, defaultValue: false }, // éliminer si coût dépasse budget
  // Nombre de recommandations à retourner
  top_n_recommendations: { type: DataTypes.INTEGER, defaultValue: 10 },
  // Algorithme utilisé
  methode_scoring: { type: DataTypes.ENUM('pondere', 'knn', 'decision_tree', 'hybrid'), defaultValue: 'pondere' },
  // Statut
  actif: { type: DataTypes.BOOLEAN, defaultValue: true },
  est_default: { type: DataTypes.BOOLEAN, defaultValue: false },
  // Métadonnées
  version: { type: DataTypes.STRING(50), defaultValue: '1.0' },
  notes_modifications: { type: DataTypes.TEXT },
  date_creation: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  date_modification: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { tableName: 'recommendation_rules' });

module.exports = { Question, OptionReponse, SessionTest, Recommendation, Favori, RecommendationRules };
