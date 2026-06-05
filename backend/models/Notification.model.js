const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const Notification = sequelize.define('Notification', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  user_id: { type: DataTypes.INTEGER, allowNull: false, references: { model: 'users', key: 'id' } },
  type: { type: DataTypes.ENUM('test', 'candidature', 'info', 'success', 'warning'), allowNull: false },
  title: { type: DataTypes.STRING(255), allowNull: false },
  message: { type: DataTypes.TEXT, allowNull: false },
  data: { type: DataTypes.JSON }, // Additional data (e.g., test_id, filiere_id)
  read: { type: DataTypes.BOOLEAN, defaultValue: false },
  read_at: { type: DataTypes.DATE }
}, { 
  tableName: 'notifications',
  indexes: [
    { fields: ['user_id'] },
    { fields: ['user_id', 'read'] }
  ]
});

module.exports = Notification;
