const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');
const bcrypt = require('bcryptjs');

const SERIES_BAC_VALIDES = ['A1', 'A2', 'C', 'D', 'S', 'OSE', 'L', 'Technique', 'Toutes séries'];

const User = sequelize.define('User', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  nom: { type: DataTypes.STRING(100), allowNull: false },
  prenom: { type: DataTypes.STRING(100), allowNull: false },
  email: { type: DataTypes.STRING(150), allowNull: false, unique: true, validate: { isEmail: true } },
  mot_de_passe: { type: DataTypes.STRING(255), allowNull: false },
  role: { type: DataTypes.ENUM('bachelier', 'admin'), defaultValue: 'bachelier' },
  serie_bac: {
    type: DataTypes.ENUM(...SERIES_BAC_VALIDES),
    allowNull: true
  },
  moyenne_generale: { type: DataTypes.FLOAT },
  ville: { type: DataTypes.STRING(100) },
  budget_mensuel: { type: DataTypes.FLOAT },
  avatar_url: { type: DataTypes.TEXT },
  // Email verification
  email_verified: { type: DataTypes.BOOLEAN, defaultValue: false },
  email_verification_token: { type: DataTypes.STRING(255) },
  email_verification_token_expires: { type: DataTypes.DATE },
  // Password reset
  password_reset_token: { type: DataTypes.STRING(255) },
  password_reset_token_expires: { type: DataTypes.DATE },
  // Legacy token field (deprecated, keep for backward compatibility)
  verification_token: { type: DataTypes.STRING(255) },
  verification_token_expires: { type: DataTypes.DATE },
  actif: { type: DataTypes.BOOLEAN, defaultValue: true }
}, {
  tableName: 'users',
  hooks: {
    beforeCreate: async (user) => {
      if (user.mot_de_passe) user.mot_de_passe = await bcrypt.hash(user.mot_de_passe, 12);
    },
    beforeUpdate: async (user) => {
      if (user.changed('mot_de_passe')) user.mot_de_passe = await bcrypt.hash(user.mot_de_passe, 12);
    }
  }
});

User.prototype.verifierMotDePasse = async function(mdp) {
  return bcrypt.compare(mdp, this.mot_de_passe);
};

User.prototype.toJSON = function() {
  const values = { ...this.get() };
  delete values.mot_de_passe;
  return values;
};

module.exports = User;
