#!/usr/bin/env node
require('dotenv').config();
const { sequelize } = require('../config/database');

const addUserSettingsTable = async () => {
  try {
    console.log('🔄 Creating user_settings table...');
    
    // Check if table already exists
    const tables = await sequelize.query(`
      SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'user_settings'
      );
    `);

    if (tables[0][0].exists) {
      console.log('✅ User settings table already exists!');
      await sequelize.close();
      process.exit(0);
    }

    // Create the table
    await sequelize.query(`
      CREATE TABLE user_settings (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
        email_notifications BOOLEAN DEFAULT true,
        new_university_notifications BOOLEAN DEFAULT true,
        test_updates_notifications BOOLEAN DEFAULT true,
        recommendations_notifications BOOLEAN DEFAULT true,
        theme VARCHAR(20) DEFAULT 'system' CHECK (theme IN ('light', 'dark', 'system')),
        language VARCHAR(10) DEFAULT 'fr',
        profile_visibility VARCHAR(20) DEFAULT 'private' CHECK (profile_visibility IN ('public', 'private')),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    // Create index
    await sequelize.query(`
      CREATE INDEX idx_user_settings_user_id ON user_settings(user_id);
    `);

    console.log('✅ User settings table created successfully!');
    await sequelize.close();
    process.exit(0);
  } catch (error) {
    console.error('❌ Error creating table:', error.message);
    await sequelize.close();
    process.exit(1);
  }
};

addUserSettingsTable();
