const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const Settings = sequelize.define('Settings', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  // Platform info
  platform_name: { type: DataTypes.STRING(200), defaultValue: 'Skill2Study' },
  platform_description: { type: DataTypes.TEXT, defaultValue: 'Plateforme d\'aide à l\'orientation universitaire' },
  contact_email: { type: DataTypes.STRING(150), defaultValue: 'contact@orientai.mg' },
  // Notification settings
  email_notifications: { type: DataTypes.BOOLEAN, defaultValue: true },
  moderation_alerts: { type: DataTypes.BOOLEAN, defaultValue: true },
  weekly_reports: { type: DataTypes.BOOLEAN, defaultValue: false },
  // Security settings
  two_factor_auth: { type: DataTypes.BOOLEAN, defaultValue: false },
  open_registration: { type: DataTypes.BOOLEAN, defaultValue: true },
  email_verification: { type: DataTypes.BOOLEAN, defaultValue: true },
  // Platform status
  maintenance_mode: { type: DataTypes.BOOLEAN, defaultValue: false },
  maintenance_message: { type: DataTypes.TEXT },
  // Additional metadata
  logo_url: { type: DataTypes.STRING(255) },
  favicon_url: { type: DataTypes.STRING(255) },
  theme_color: { type: DataTypes.STRING(50), defaultValue: '#3b82f6' },
  // Timestamps
  createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { tableName: 'settings', timestamps: true });

module.exports = Settings;
