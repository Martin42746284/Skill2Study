const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./config/swagger');

const authRoutes = require('./routes/auth.routes');
const userRoutes = require('./routes/user.routes');
const universiteRoutes = require('./routes/universite.routes');
const filiereRoutes = require('./routes/filiere.routes');
const parcoursRoutes = require('./routes/parcours.routes');
const testRoutes = require('./routes/test.routes');
const notificationRoutes = require('./routes/notification.routes');
const recommendationRoutes = require('./routes/recommendation.routes');
const comparateurRoutes = require('./routes/comparateur.routes');
const statsRoutes = require('./routes/stats.routes');
const adminRoutes = require('./routes/admin.routes');
const settingsRoutes = require('./routes/settings.routes');
const metricsRoutes = require('./routes/metrics.routes');
const testimonialsRoutes = require('./routes/testimonials.routes');

const { errorHandler } = require('./middlewares/error.middleware');
const { notFound } = require('./middlewares/notFound.middleware');

const app = express();

// Sécurité
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", 'data:', 'https:'],
    },
  },
  hsts: { maxAge: 31536000, includeSubDomains: true, preload: true },
  frameguard: { action: 'deny' },
  noSniff: true,
  xssFilter: true,
}));

// CORS - restringir strict a CLIENT_URL
const allowedOrigin = process.env.CLIENT_URL;
if (!allowedOrigin) {
  throw new Error('CLIENT_URL env variable is required');
}

app.use(cors({
  origin: allowedOrigin,
  credentials: true,
  optionsSuccessStatus: 200
}));

// Limite de requêtes globale
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  keyGenerator: (req) => req.user?.id || req.ip,
  message: 'Trop de requêtes, réessayez plus tard.'
});

// Limiter plus strict pour les POST/PUT/DELETE (modifications)
const strictLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100, // Strict pour les modifications
  keyGenerator: (req) => req.user?.id || req.ip,
  message: 'Trop de modifications, réessayez plus tard.'
});

app.use('/api/', limiter);
// Appliquer le strict limiter sur les routes sensibles
app.use('/api/auth/register', strictLimiter);
app.use('/api/auth/login', strictLimiter);

// Parsing
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));
// Disable morgan logging for cleaner development experience
// Uncomment below to enable HTTP logging
// app.use(morgan('dev'));

// Documentation API
app.use('/api/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/universites', universiteRoutes);
app.use('/api/filieres', filiereRoutes);
app.use('/api/parcours', parcoursRoutes);
app.use('/api/test', testRoutes);
app.use('/api/notifications', notificationRoutes);
app.use('/api/recommendations', recommendationRoutes);
app.use('/api/comparateur', comparateurRoutes);
app.use('/api/stats', statsRoutes);
app.use('/api/testimonials', testimonialsRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/settings', settingsRoutes);
app.use('/api/metrics', metricsRoutes);

// Health check
app.get('/api/health', (req, res) => res.json({ status: 'OK', timestamp: new Date() }));

// Gestion des erreurs
app.use(notFound);
app.use(errorHandler);

module.exports = app;
