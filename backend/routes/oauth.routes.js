const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/oauth.controller');
const { protect } = require('../middlewares/auth.middleware');
const { body, validationResult } = require('express-validator');

const validate = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ success: false, errors: errors.array() });
  }
  next();
};

// Public routes
router.get('/google/authorization-url', ctrl.getGoogleAuthUrl);
router.post('/google/callback', [
  body('code').notEmpty().withMessage('Authorization code is required')
], validate, ctrl.googleCallback);

// Protected routes
router.post('/google/link-account', protect, [
  body('code').notEmpty().withMessage('Authorization code is required')
], validate, ctrl.linkGoogleAccount);

module.exports = router;
