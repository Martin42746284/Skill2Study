const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const Filiere = sequelize.define('Filiere', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  universite_id: { type: DataTypes.INTEGER, allowNull: false, references: { model: 'universites', key: 'id' } },
  nom: { type: DataTypes.STRING(200), allowNull: false },
  code: { type: DataTypes.STRING(50), unique: true },
  domaine: { type: DataTypes.STRING(100) },           // ex: Sciences, Lettres, Droit
  specialite: { type: DataTypes.STRING(150) },
  niveaux: { type: DataTypes.JSON, defaultValue: [] },  // ex: ["Licence", "Master", "Doctorat"]
  duree_annees: { type: DataTypes.STRING(50) },  // ex: "3 - 5", "2 ans", "4"
  cout_annuel: { type: DataTypes.FLOAT },
  cout_description: { type: DataTypes.STRING(255) },  // ex: "Gratuit", "Généralement pris en charge par l'État"
  langue: { type: DataTypes.STRING(50), defaultValue: 'Arabe/Français' },
  // Conditions d'admission
  series_bac_acceptees: { type: DataTypes.JSON },     // ["Sciences", "Mathématiques", "Technique"]
  moyenne_min_requise: { type: DataTypes.FLOAT },
  // Caractéristiques pour l'IA
  competences_requises: { type: DataTypes.JSON },     // ["mathématiques", "analyse", "logique"]
  centres_interet: { type: DataTypes.JSON },           // ["technologie", "innovation", "recherche"]
  difficulte: { type: DataTypes.ENUM('facile', 'moyen', 'difficile', 'tres_difficile') },
  taux_emploi: { type: DataTypes.FLOAT },
  salaire_moyen_debutant: { type: DataTypes.FLOAT },
  debouches: { type: DataTypes.JSON },                 // liste des métiers
  description: { type: DataTypes.TEXT },
  actif: { type: DataTypes.BOOLEAN, defaultValue: true }
}, { tableName: 'filieres' });

module.exports = Filiere;
