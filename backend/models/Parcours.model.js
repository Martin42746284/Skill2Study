const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const Parcours = sequelize.define('Parcours', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  filiere_id: { type: DataTypes.INTEGER, allowNull: false, references: { model: 'filieres', key: 'id' } },
  nom: { type: DataTypes.STRING(200), allowNull: false },
  code: { type: DataTypes.STRING(50) },
  description: { type: DataTypes.TEXT },
  duree_mois: { type: DataTypes.INTEGER },
  specialisation: { type: DataTypes.STRING(150) },
  competences_acquises: { type: DataTypes.JSON },  // liste des compétences
  debouches_professionnels: { type: DataTypes.JSON }, // métiers possibles
  actif: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'parcours' });

module.exports = Parcours;
