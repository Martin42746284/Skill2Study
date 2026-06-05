const router = require('express').Router();
const { param } = require('express-validator');
const { protect, bacheliersOnly } = require('../middlewares/auth.middleware');
const { validate } = require('../middlewares/validate.middleware');
const ctrl = require('../controllers/notification.controller');

// All notification routes require authentication
router.use(protect, bacheliersOnly);

// Get all notifications for authenticated user
router.get('/', ctrl.getNotifications);

// Get unread count
router.get('/unread-count', ctrl.getUnreadCount);

// Mark specific notification as read
router.put('/:id/read', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.markAsRead);

// Mark all notifications as read
router.put('/mark-all-read', ctrl.markAllRead);

// Delete specific notification
router.delete('/:id', [
  param('id').isInt().withMessage('L\'ID doit être un entier'),
  validate
], ctrl.deleteNotification);

// Delete all read notifications
router.delete('/', ctrl.deleteAllRead);

module.exports = router;
