const { Sequelize } = require('sequelize');
const logger = require('../utils/logger');

const sequelize = new Sequelize(process.env.DATABASE_URL, {
  dialect: 'postgres',
  dialectOptions: {
    ssl: process.env.DB_SSL === 'true' ? { require: true, rejectUnauthorized: false } : false
  },
  // Disable Sequelize logging in development (comment out to enable for debugging)
  logging: false,
  // Alternative: Only log errors
  // logging: (msg) => { if (msg.includes('ERROR')) logger.error(msg); },
  pool: { max: 10, min: 0, acquire: 30000, idle: 10000 },
  define: { timestamps: true, underscored: true }
});

module.exports = { sequelize };
