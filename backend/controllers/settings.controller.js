const { User, UserSettings } = require('../models');
const { createNotification } = require('../services/notification.service');

// GET /api/users/settings
exports.getSettings = async (req, res, next) => {
  try {
    let settings = await UserSettings.findOne({ where: { user_id: req.user.id } });
    
    // Create default settings if not exist
    if (!settings) {
      settings = await UserSettings.create({ user_id: req.user.id });
    }
    
    res.json(settings);
  } catch (err) { next(err); }
};

// PUT /api/users/settings
exports.updateSettings = async (req, res, next) => {
  try {
    // Filter out null and undefined values
    const dataToUpdate = Object.fromEntries(
      Object.entries(req.body).filter(([_, v]) => v !== null && v !== undefined && v !== '')
    );

    let settings = await UserSettings.findOne({ where: { user_id: req.user.id } });
    
    // Create if not exist
    if (!settings) {
      settings = await UserSettings.create({ user_id: req.user.id, ...dataToUpdate });
    } else {
      await settings.update(dataToUpdate);
    }

    res.json(settings);
  } catch (err) { next(err); }
};

// PUT /api/users/change-password
exports.changePassword = async (req, res, next) => {
  try {
    const { current_password, new_password, confirm_password } = req.body;
    const { validatePassword } = require('../utils/passwordValidator');

    // Validate input
    if (!current_password || !new_password || !confirm_password) {
      return res.status(400).json({
        success: false,
        message: 'Tous les champs sont obligatoires'
      });
    }

    if (new_password !== confirm_password) {
      return res.status(400).json({
        success: false,
        message: 'Les mots de passe ne correspondent pas'
      });
    }

    // Validate password strength
    const passwordValidation = validatePassword(new_password);
    if (!passwordValidation.valid) {
      return res.status(400).json({
        success: false,
        message: passwordValidation.message
      });
    }

    // Verify current password
    const isPasswordValid = await req.user.verifierMotDePasse(current_password);
    if (!isPasswordValid) {
      return res.status(401).json({
        success: false,
        message: 'Mot de passe actuel incorrect'
      });
    }

    // Update password
    await req.user.update({ mot_de_passe: new_password });

    // Send notification
    await createNotification(
      req.user.id,
      'success',
      '🔐 Mot de passe changé',
      'Votre mot de passe a été changé avec succès'
    );

    res.json({
      success: true,
      message: 'Mot de passe changé avec succès'
    });
  } catch (err) { next(err); }
};

// DELETE /api/users/account
exports.deleteAccount = async (req, res, next) => {
  try {
    const { password } = req.body;

    if (!password) {
      return res.status(400).json({ 
        success: false, 
        message: 'Le mot de passe est requis' 
      });
    }

    // Verify password
    const isPasswordValid = await req.user.verifierMotDePasse(password);
    if (!isPasswordValid) {
      return res.status(401).json({ 
        success: false, 
        message: 'Mot de passe incorrect' 
      });
    }

    // Delete user (cascade delete will handle related data)
    await req.user.destroy();

    res.json({ 
      success: true, 
      message: 'Compte supprimé avec succès' 
    });
  } catch (err) { next(err); }
};
