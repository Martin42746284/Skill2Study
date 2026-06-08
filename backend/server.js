require('dotenv').config();
const app = require('./app');
const { sequelize } = require('./config/database');
const logger = require('./utils/logger');

const PORT = process.env.PORT || 3000;

async function startServer() {
  try {

    await sequelize.authenticate();
    logger.info('Connexion à la base de données réussie.');
    
    app.listen(PORT, () => {
      logger.info(`Serveur démarré sur le port ${PORT} [${process.env.NODE_ENV}]`);
    });
  } catch (error) {
    logger.error('Impossible de démarrer le serveur :', error);
    process.exit(1);
  }
}

startServer();
