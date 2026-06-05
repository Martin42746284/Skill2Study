#!/usr/bin/env node
/**
 * Database Seeding Script
 * 
 * Usage: npm run seed:fresh
 * 
 * This script seeds the database with realistic test data for:
 * - Admin and student users
 * - Universities and fields of study
 * - Study paths (Parcours)
 * - Test questions and options
 * - Testimonials
 * - Recommendation rules
 * - Platform settings
 */

require('dotenv').config();
const seedDatabase = require('./utils/seedDatabase');
const { sequelize } = require('./config/database');

const runSeed = async () => {
  try {
    // Test database connection first
    console.log('🔗 Test de la connexion à la base de données...');
    await sequelize.authenticate();
    console.log('✅ Connexion établie\n');

    // Run seeding
    await seedDatabase();

    // Close database connection
    await sequelize.close();
    console.log('🔌 Connexion fermée');
    process.exit(0);
  } catch (error) {
    console.error('❌ Erreur fatale:', error);
    process.exit(1);
  }
};

// Run the seeding
runSeed();
