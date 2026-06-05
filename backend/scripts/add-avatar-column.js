#!/usr/bin/env node
require('dotenv').config();
const { sequelize } = require('../config/database');

const addAvatarColumn = async () => {
  try {
    console.log('🔄 Adding avatar_url column to users table...');
    
    // Check if column already exists
    const result = await sequelize.query(`
      SELECT column_name 
      FROM information_schema.columns 
      WHERE table_name = 'users' AND column_name = 'avatar_url'
    `);

    if (result[0].length > 0) {
      console.log('✅ Column avatar_url already exists!');
      await sequelize.close();
      process.exit(0);
    }

    // Add the column
    await sequelize.query(`
      ALTER TABLE users 
      ADD COLUMN avatar_url TEXT
    `);

    console.log('✅ Column avatar_url added successfully!');
    await sequelize.close();
    process.exit(0);
  } catch (error) {
    console.error('❌ Error adding column:', error.message);
    await sequelize.close();
    process.exit(1);
  }
};

addAvatarColumn();
