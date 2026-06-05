const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const Testimonial = sequelize.define('Testimonial', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  student_name: { type: DataTypes.STRING(150), allowNull: false },
  student_serie: { type: DataTypes.STRING(100) },
  university_name: { type: DataTypes.STRING(200), allowNull: false },
  course_name: { type: DataTypes.STRING(200), allowNull: false },
  text: { type: DataTypes.TEXT, allowNull: false },
  rating: { type: DataTypes.INTEGER, allowNull: false }, // 1-5
  status: {
    type: DataTypes.ENUM('Approuvé', 'En attente', 'Rejeté'),
    defaultValue: 'En attente'
  },
  createdAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  updatedAt: { type: DataTypes.DATE, defaultValue: DataTypes.NOW }
}, { tableName: 'testimonials', timestamps: true });

module.exports = Testimonial;
