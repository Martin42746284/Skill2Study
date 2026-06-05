const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const Universite = sequelize.define('Universite', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nom: { type: DataTypes.STRING(200), allowNull: false },
  type: { type: DataTypes.ENUM('publique', 'privee'), allowNull: false },
  ville: { type: DataTypes.STRING(100), allowNull: false },
  wilaya: { type: DataTypes.STRING(100) },
  adresse: { type: DataTypes.TEXT },
  site_web: { type: DataTypes.STRING(255) },
  email_contact: { type: DataTypes.STRING(150) },
  telephone: { type: DataTypes.STRING(60) },
  description: { type: DataTypes.TEXT },
  duree_etudes: { type: DataTypes.STRING(100) },
  cout_estimatif: { type: DataTypes.STRING(100) },
  logo_url: { type: DataTypes.TEXT },
  date_fondation: { type: DataTypes.INTEGER },
  actif: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'universites' });

module.exports = Universite;
