const { Notification } = require('../models');

// GET /api/notifications
exports.getNotifications = async (req, res, next) => {
  try {
    const { limit = 50, offset = 0 } = req.query;
    const notifications = await Notification.findAndCountAll({
      where: { user_id: req.user.id },
      order: [['createdAt', 'DESC']],
      limit: parseInt(limit),
      offset: parseInt(offset)
    });
    res.json({
      total: notifications.count,
      notifications: notifications.rows
    });
  } catch (err) { next(err); }
};

// GET /api/notifications/unread-count
exports.getUnreadCount = async (req, res, next) => {
  try {
    const count = await Notification.count({
      where: { user_id: req.user.id, read: false }
    });
    res.json({ unreadCount: count });
  } catch (err) { next(err); }
};

// PUT /api/notifications/:id/read
exports.markAsRead = async (req, res, next) => {
  try {
    const notification = await Notification.findOne({
      where: { id: req.params.id, user_id: req.user.id }
    });
    if (!notification) {
      return res.status(404).json({ success: false, message: 'Notification non trouvée' });
    }
    await notification.update({ read: true, read_at: new Date() });
    res.json(notification);
  } catch (err) { next(err); }
};

// PUT /api/notifications/mark-all-read
exports.markAllRead = async (req, res, next) => {
  try {
    await Notification.update(
      { read: true, read_at: new Date() },
      { where: { user_id: req.user.id, read: false } }
    );
    res.json({ success: true, message: 'Toutes les notifications marquées comme lues' });
  } catch (err) { next(err); }
};

// DELETE /api/notifications/:id
exports.deleteNotification = async (req, res, next) => {
  try {
    const notification = await Notification.findOne({
      where: { id: req.params.id, user_id: req.user.id }
    });
    if (!notification) {
      return res.status(404).json({ success: false, message: 'Notification non trouvée' });
    }
    await notification.destroy();
    res.json({ success: true, message: 'Notification supprimée' });
  } catch (err) { next(err); }
};

// POST /api/notifications (Internal - for creating notifications)
exports.createNotification = async (user_id, type, title, message, data = null) => {
  try {
    return await Notification.create({
      user_id,
      type,
      title,
      message,
      data
    });
  } catch (err) {
    console.error('Error creating notification:', err);
  }
};

// DELETE /api/notifications (delete all read notifications for user)
exports.deleteAllRead = async (req, res, next) => {
  try {
    const result = await Notification.destroy({
      where: { user_id: req.user.id, read: true }
    });
    res.json({ success: true, message: `${result} notifications supprimées` });
  } catch (err) { next(err); }
};
