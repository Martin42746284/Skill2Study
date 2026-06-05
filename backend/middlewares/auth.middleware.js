const jwt = require('jsonwebtoken');
const { User } = require('../models');

/**
 * Middleware de protection - Vérifie l'authentification
 * Ajoute l'utilisateur à req.user
 */
const protect = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({
        success: false,
        message: 'Accès refusé. Token manquant.',
        code: 'NO_TOKEN'
      });
    }

    const token = authHeader.split(' ')[1];
    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'secret_key');

    const user = await User.findByPk(decoded.id);
    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Utilisateur introuvable.'
      });
    }

    if (!user.actif) {
      return res.status(403).json({
        success: false,
        message: 'Compte désactivé.'
      });
    }

    req.user = user;
    next();
  } catch (err) {
    if (err.name === 'JsonWebTokenError') {
      return res.status(401).json({
        success: false,
        message: 'Token invalide.',
        code: 'INVALID_TOKEN'
      });
    }
    if (err.name === 'TokenExpiredError') {
      return res.status(401).json({
        success: false,
        message: 'Token expiré.',
        code: 'EXPIRED_TOKEN'
      });
    }
    return res.status(401).json({
      success: false,
      message: 'Erreur d\'authentification.'
    });
  }
};

/**
 * Middleware Admin Only - Réserve l'accès aux administrateurs
 */
const adminOnly = (req, res, next) => {
  if (req.user?.role !== 'admin') {
    return res.status(403).json({
      success: false,
      message: 'Accès réservé aux administrateurs.',
      code: 'ADMIN_REQUIRED'
    });
  }
  next();
};

/**
 * Middleware Bachelier Only - Réserve l'accès aux étudiants (bacheliers)
 */
const bacheliersOnly = (req, res, next) => {
  if (req.user?.role !== 'bachelier') {
    return res.status(403).json({
      success: false,
      message: 'Accès réservé aux bacheliers.',
      code: 'BACHELIER_REQUIRED'
    });
  }
  next();
};

/**
 * Middleware de vérification optionnelle - Ne rejette pas sans token
 * Ajoute req.user si le token est valide
 */
const optionalAuth = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return next();
    }

    const token = authHeader.split(' ')[1];
    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'secret_key');

    const user = await User.findByPk(decoded.id);
    if (user && user.actif) {
      req.user = user;
    }
    next();
  } catch (err) {
    // Silencieusement ignorer les erreurs de token optionnel
    next();
  }
};

module.exports = {
  protect,
  adminOnly,
  bacheliersOnly,
  optionalAuth
};
