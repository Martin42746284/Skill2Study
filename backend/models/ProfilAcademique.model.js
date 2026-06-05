const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const ProfilAcademique = sequelize.define('ProfilAcademique', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  user_id: { type: DataTypes.INTEGER, allowNull: false, unique: true, references: { model: 'users', key: 'id' } },
  serie_bac: { type: DataTypes.STRING(50), allowNull: false },
  annee_bac: { type: DataTypes.INTEGER },
  mention: { type: DataTypes.ENUM('Passable', 'Assez bien', 'Bien', 'Très bien') },
  moyenne_generale: { type: DataTypes.FLOAT },
  // Notes par matière (stockées en JSON)
  notes_matieres: { type: DataTypes.JSON },
  // ex: { "mathematiques": 16.5, "physique": 14, "histoire": 12, ... }

  // Compétences perçues (auto-évaluation 1-5)
  competences: { type: DataTypes.JSON },
  // ex: { "logique": 4, "communication": 3, "creativite": 5, "organisation": 4 }

  // Centres d'intérêt (liste)
  centres_interet: { type: DataTypes.JSON },
  // ex: ["informatique", "médecine", "art", "commerce"]

  // Scores du test d'orientation par catégorie (objet)
  scores_test: { type: DataTypes.JSON },
  // ex: {"informatique": 85, "sciences": 90, "gestion": 70}

  objectifs_professionnels: { type: DataTypes.TEXT },
  secteur_vise: { type: DataTypes.STRING(100) },

  // Contraintes
  budget_max_mensuel: { type: DataTypes.FLOAT },
  distance_max_km: { type: DataTypes.INTEGER },
  duree_max_etudes: { type: DataTypes.INTEGER },
  preference_type_univ: { type: DataTypes.ENUM('publique', 'privee', 'indifferent'), defaultValue: 'indifferent' },
  ville_preference: { type: DataTypes.STRING(100) }
}, { tableName: 'profils_academiques' });

module.exports = ProfilAcademique;
