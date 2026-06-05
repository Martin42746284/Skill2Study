#!/usr/bin/env node
require('dotenv').config();
const { sequelize } = require('../config/database');
const { User, Notification } = require('../models');
const { notifyTestCompleted, notifyRecommendationsReady, notifyNewField } = require('../services/notification.service');

const seedNotifications = async () => {
  try {
    console.log('🔄 Seeding test notifications...\n');
    
    // Get test users
    const users = await User.findAll({ 
      where: { role: 'bachelier' },
      limit: 3 
    });

    if (users.length === 0) {
      console.log('❌ No test users found');
      await sequelize.close();
      process.exit(1);
    }

    let notificationsCreated = 0;

    for (const user of users) {
      // Create various types of notifications
      
      // Test completion notification
      await notifyTestCompleted(user.id, 1, 85);
      notificationsCreated++;
      
      // Recommendation notification
      await notifyRecommendationsReady(user.id, 5);
      notificationsCreated++;
      
      // New field notification
      await notifyNewField(user.id, 'Informatique - Développement Web', 'Université de Tananarive');
      notificationsCreated++;
      
      // Info notification
      await Notification.create({
        user_id: user.id,
        type: 'info',
        title: '📌 Conseil',
        message: 'Mettez à jour votre profil académique pour obtenir de meilleures recommandations',
        createdAt: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000) // 2 days ago
      });
      notificationsCreated++;
      
      // Some read notifications
      const readNotif = await Notification.create({
        user_id: user.id,
        type: 'success',
        title: '✅ Profil mis à jour',
        message: 'Vos informations ont été mises à jour avec succès',
        read: true,
        read_at: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000),
        createdAt: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000)
      });
      notificationsCreated++;
    }

    console.log(`✅ ${notificationsCreated} notifications créées!\n`);
    
    // Show summary
    const totalNotifications = await Notification.count();
    const unreadCount = await Notification.count({ where: { read: false } });
    
    console.log('📊 RÉSUMÉ:');
    console.log(`   Total notifications: ${totalNotifications}`);
    console.log(`   Non lues: ${unreadCount}`);
    console.log(`   Lues: ${totalNotifications - unreadCount}`);
    
    await sequelize.close();
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    await sequelize.close();
    process.exit(1);
  }
};

seedNotifications();
