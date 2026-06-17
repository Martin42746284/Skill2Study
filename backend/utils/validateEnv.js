const logger = require('./logger');

const REQUIRED_VARS = [
  'DATABASE_URL',
  'JWT_SECRET',
  'CLIENT_URL'
];

function validateEnv() {
  const missing = REQUIRED_VARS.filter(varName => !process.env[varName]);
  
  if (missing.length > 0) {
    logger.error(`Missing required environment variables: ${missing.join(', ')}`);
    process.exit(1);
  }

  if (process.env.JWT_SECRET && process.env.JWT_SECRET.length < 32) {
    logger.warn('JWT_SECRET is too short. Use at least 32 characters for security.');
  }

  logger.info('Environment variables validation passed.');
}

module.exports = validateEnv;
