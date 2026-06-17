const router = require('express').Router();
const { query } = require('express-validator');
const { validate } = require('../middlewares/validate.middleware');
const Testimonial = require('../models/Testimonial.model');

router.get('/approved', [
  query('limit').optional().isInt({ min: 1, max: 1000 }).withMessage('La limite doit être entre 1 et 1000'),
  query('page').optional().isInt({ min: 1 }).withMessage('La page doit être > 0'),
  validate
], async (req, res, next) => {
  try {
    const { page = 1, limit = 100 } = req.query;
    const { count, rows } = await Testimonial.findAndCountAll({
      where: { status: 'Approuvé' },
      limit: parseInt(limit),
      offset: (parseInt(page) - 1) * parseInt(limit),
      order: [['createdAt', 'DESC']]
    });
    res.json({ success: true, total: count, testimonials: rows });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
