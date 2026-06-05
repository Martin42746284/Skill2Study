const { Notification } = require('../models');

/**
 * Service for managing notifications
 */

/**
 * Create a new notification for a user
 */
async function createNotification(userId, type, title, message, data = null) {
  try {
    return await Notification.create({
      user_id: userId,
      type,
      title,
      message,
      data
    });
  } catch (error) {
    console.error('Error creating notification:', error);
    throw error;
  }
}

/**
 * Send test completion notification
 */
async function notifyTestCompleted(userId, testSessionId, score) {
  return createNotification(
    userId,
    'success',
    '🎉 Test complété !',
    `Vous avez complété le test d'orientation. Votre score: ${score}%`,
    { test_session_id: testSessionId, score }
  );
}

/**
 * Send recommendation ready notification
 */
async function notifyRecommendationsReady(userId, recommendationCount) {
  return createNotification(
    userId,
    'info',
    '📋 Recommandations disponibles',
    `${recommendationCount} filière(s) vous ont été recommandée(s) basé sur vos réponses au test.`,
    { recommendation_count: recommendationCount }
  );
}

/**
 * Send profile update notification
 */
async function notifyProfileUpdated(userId) {
  return createNotification(
    userId,
    'success',
    '✅ Profil mis à jour',
    'Vos informations personnelles ont été mises à jour avec succès.'
  );
}

/**
 * Send new university notification
 */
async function notifyNewUniversity(userId, universityName) {
  return createNotification(
    userId,
    'info',
    '🏫 Nouvelle université',
    `Une nouvelle université a été ajoutée: ${universityName}`,
    { university_name: universityName }
  );
}

/**
 * Send new field notification
 */
async function notifyNewField(userId, fieldName, universityName) {
  return createNotification(
    userId,
    'info',
    '📚 Nouvelle filière',
    `Une nouvelle filière a été ajoutée: ${fieldName} à ${universityName}`,
    { field_name: fieldName, university_name: universityName }
  );
}

/**
 * Send warning notification
 */
async function notifyWarning(userId, title, message) {
  return createNotification(
    userId,
    'warning',
    title,
    message
  );
}

/**
 * Notify all users about a new university (for admin use)
 */
async function notifyAllUsersNewUniversity(universityName) {
  try {
    const { User } = require('../models');
    const users = await User.findAll({ where: { role: 'bachelier', actif: true } });

    const now = new Date();
    const notifications = users.map(user => ({
      user_id: user.id,
      type: 'info',
      title: '🏫 Nouvelle université',
      message: `Une nouvelle université a été ajoutée: ${universityName}`,
      data: { university_name: universityName },
      read: false,
      createdAt: now,
      updatedAt: now
    }));

    if (notifications.length > 0) {
      await Notification.bulkCreate(notifications);
    }
  } catch (error) {
    console.error('Error notifying users about new university:', error);
  }
}

/**
 * Notify all users about a new field (for admin use)
 */
async function notifyAllUsersNewField(fieldName, universityName) {
  try {
    const { User } = require('../models');
    const users = await User.findAll({ where: { role: 'bachelier', actif: true } });

    const now = new Date();
    const notifications = users.map(user => ({
      user_id: user.id,
      type: 'info',
      title: '📚 Nouvelle filière',
      message: `Une nouvelle filière a été ajoutée: ${fieldName} à ${universityName}`,
      data: { field_name: fieldName, university_name: universityName },
      read: false,
      createdAt: now,
      updatedAt: now
    }));

    if (notifications.length > 0) {
      await Notification.bulkCreate(notifications);
    }
  } catch (error) {
    console.error('Error notifying users about new field:', error);
  }
}

module.exports = {
  createNotification,
  notifyTestCompleted,
  notifyRecommendationsReady,
  notifyProfileUpdated,
  notifyNewUniversity,
  notifyNewField,
  notifyWarning,
  notifyAllUsersNewUniversity,
  notifyAllUsersNewField
};
