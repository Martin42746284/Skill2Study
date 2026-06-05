const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const UserSettings = sequelize.define('UserSettings', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  user_id: { type: DataTypes.INTEGER, allowNull: false, unique: true, references: { model: 'users', key: 'id' } },
  
  // Notification preferences
  email_notifications: { type: DataTypes.BOOLEAN, defaultValue: true },
  new_university_notifications: { type: DataTypes.BOOLEAN, defaultValue: true },
  test_updates_notifications: { type: DataTypes.BOOLEAN, defaultValue: true },
  recommendations_notifications: { type: DataTypes.BOOLEAN, defaultValue: true },
  
  // Display preferences
  theme: { type: DataTypes.ENUM('light', 'dark', 'system'), defaultValue: 'system' },
  language: { type: DataTypes.STRING(10), defaultValue: 'fr' },
  
  // Privacy
  profile_visibility: { type: DataTypes.ENUM('public', 'private'), defaultValue: 'private' }
}, { 
  tableName: 'user_settings',
  indexes: [
    { fields: ['user_id'] }
  ]
});

module.exports = UserSettings;
