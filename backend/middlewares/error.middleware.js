const logger = require('../utils/logger');

/**
 * Comprehensive error handler middleware
 * Handles all types of errors with proper status codes and messages
 */
const errorHandler = (err, req, res, next) => {
  logger.error(`${err.message} - ${req.originalUrl} - ${req.method}`, {
    stack: err.stack,
    statusCode: err.statusCode || 500,
    name: err.name
  });

  let statusCode = 500;
  let message = 'Une erreur interne du serveur est survenue.';
  let code = 'INTERNAL_SERVER_ERROR';

  // Handle Sequelize validation errors
  if (err.name === 'SequelizeValidationError') {
    statusCode = 422;
    message = 'Données invalides.';
    code = 'VALIDATION_ERROR';
  }
  // Handle Sequelize unique constraint errors
  else if (err.name === 'SequelizeUniqueConstraintError') {
    statusCode = 409;
    message = 'Cette valeur existe déjà.';
    code = 'DUPLICATE_ENTRY';
  }
  // Handle Sequelize foreign key constraint errors
  else if (err.name === 'SequelizeForeignKeyConstraintError') {
    statusCode = 400;
    message = 'Référence invalide vers une autre entité.';
    code = 'INVALID_REFERENCE';
  }
  // Handle JWT errors
  else if (err.name === 'JsonWebTokenError') {
    statusCode = 401;
    message = 'Token invalide.';
    code = 'INVALID_TOKEN';
  }
  else if (err.name === 'TokenExpiredError') {
    statusCode = 401;
    message = 'Token expiré.';
    code = 'EXPIRED_TOKEN';
  }
  // Handle custom errors
  else if (err.statusCode) {
    statusCode = err.statusCode;
    message = err.message || message;
    code = err.code || code;
  }
  // Handle other errors
  else if (err.message) {
    message = err.message;
  }

  // Build response
  const response = {
    success: false,
    message,
    code
  };

  // Include error details in development
  if (process.env.NODE_ENV === 'development') {
    response.stack = err.stack;
    response.details = err.details || null;
  }

  res.status(statusCode).json(response);
};

/**
 * Not found handler - Called when no route matches
 */
const notFound = (req, res, next) => {
  const error = new Error(`Route non trouvée: ${req.originalUrl}`);
  res.status(404);
  next(error);
};

module.exports = { errorHandler, notFound };
