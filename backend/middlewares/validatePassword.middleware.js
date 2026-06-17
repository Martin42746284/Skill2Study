const { body, validationResult } = require('express-validator');
const { PASSWORD_REGEX } = require('../utils/passwordValidator');

const validatePasswordStrength = [
  body('mot_de_passe')
    .matches(PASSWORD_REGEX)
    .withMessage('Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial (!@#$%^&*).')
    .trim(),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ success: false, message: errors.array()[0].msg });
    }
    next();
  }
];

const validateNewPasswordStrength = [
  body('new_password')
    .matches(PASSWORD_REGEX)
    .withMessage('Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial (!@#$%^&*).')
    .trim(),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ success: false, message: errors.array()[0].msg });
    }
    next();
  }
];

const validateResetPasswordStrength = [
  body('nouveau_mot_de_passe')
    .matches(PASSWORD_REGEX)
    .withMessage('Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial (!@#$%^&*).')
    .trim(),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ success: false, message: errors.array()[0].msg });
    }
    next();
  }
];

module.exports = {
  validatePasswordStrength,
  validateNewPasswordStrength,
  validateResetPasswordStrength
};
