const router = require('express').Router();
const { Settings } = require('../models');

// GET /api/settings/public - Get public settings (no auth required)
router.get('/public', async (req, res, next) => {
  try {
    const settings = await Settings.findOne();
    if (!settings) {
      return res.json({
        success: true,
        settings: {
          maintenance_mode: false,
          platform_name: 'Skill2Study',
          platform_description: 'Plateforme d\'aide à l\'orientation universitaire',
        }
      });
    }

    // Return public settings (all settings except those that don't affect public UI)
    res.json({
      success: true,
      settings: {
        platform_name: settings.platform_name,
        platform_description: settings.platform_description,
        contact_email: settings.contact_email,
        maintenance_mode: settings.maintenance_mode,
        maintenance_message: settings.maintenance_message,
        open_registration: settings.open_registration,
        email_verification: settings.email_verification,
        theme_color: settings.theme_color,
      }
    });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
