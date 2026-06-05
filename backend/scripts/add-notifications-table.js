#!/usr/bin/env node
require('dotenv').config();
const { sequelize } = require('../config/database');

const addNotificationsTable = async () => {
  try {
    console.log('🔄 Creating notifications table...');
    
    // Check if table already exists
    const tables = await sequelize.query(`
      SELECT EXISTS(
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'notifications'
      );
    `);

    if (tables[0][0].exists) {
      console.log('✅ Notifications table already exists!');
      await sequelize.close();
      process.exit(0);
    }

    // Create the table
    await sequelize.query(`
      CREATE TABLE notifications (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        type VARCHAR(50) NOT NULL CHECK (type IN ('test', 'candidature', 'info', 'success', 'warning')),
        title VARCHAR(255) NOT NULL,
        message TEXT NOT NULL,
        data JSONB,
        read BOOLEAN DEFAULT false,
        read_at TIMESTAMP,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    // Create indexes
    await sequelize.query(`
      CREATE INDEX idx_notifications_user_id ON notifications(user_id);
      CREATE INDEX idx_notifications_user_id_read ON notifications(user_id, read);
    `);

    console.log('✅ Notifications table created successfully!');
    await sequelize.close();
    process.exit(0);
  } catch (error) {
    console.error('❌ Error creating table:', error.message);
    await sequelize.close();
    process.exit(1);
  }
};

addNotificationsTable();
