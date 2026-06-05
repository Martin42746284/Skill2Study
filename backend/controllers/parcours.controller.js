const { Op } = require('sequelize');
const { Parcours, Filiere, Universite } = require('../models');

// GET /api/parcours - Get all parcours
exports.getParcours = async (req, res, next) => {
  try {
    const { filiere_id, search, page = 1, limit = 10000 } = req.query;
    const where = { actif: true };
    if (filiere_id) where.filiere_id = parseInt(filiere_id);
    if (search) where.nom = { [Op.like]: `%${search}%` };

    const { count, rows } = await Parcours.findAndCountAll({
      where,
      include: [
        {
          model: Filiere,
          as: 'filiere',
          attributes: ['id', 'nom', 'domaine'],
          include: [{ model: Universite, as: 'universite', attributes: ['id', 'nom', 'ville'] }]
        }
      ],
      limit: parseInt(limit),
      offset: (parseInt(page) - 1) * parseInt(limit),
      order: [['nom', 'ASC']]
    });

    res.json({ success: true, total: count, page: parseInt(page), pages: Math.ceil(count / limit), parcours: rows });
  } catch (err) {
    next(err);
  }
};

// GET /api/parcours/:id
exports.getParcourById = async (req, res, next) => {
  try {
    const parcour = await Parcours.findOne({
      where: { id: req.params.id, actif: true },
      include: [
        {
          model: Filiere,
          as: 'filiere',
          include: [{ model: Universite, as: 'universite' }]
        }
      ]
    });
    if (!parcour) return res.status(404).json({ success: false, message: 'Parcours introuvable.' });
    res.json({ success: true, parcour });
  } catch (err) {
    next(err);
  }
};

// POST /api/parcours - Create new parcours (admin)
exports.creerParcours = async (req, res, next) => {
  try {
    // Verify filiere exists
    const filiere = await Filiere.findByPk(req.body.filiere_id);
    if (!filiere) {
      return res.status(400).json({ success: false, message: 'Filière inexistante.' });
    }

    const parcour = await Parcours.create(req.body);
    const result = await Parcours.findByPk(parcour.id, {
      include: [
        {
          model: Filiere,
          as: 'filiere',
          include: [{ model: Universite, as: 'universite' }]
        }
      ]
    });
    res.status(201).json({ success: true, parcour: result });
  } catch (err) {
    next(err);
  }
};

// PUT /api/parcours/:id - Update parcours (admin)
exports.modifierParcours = async (req, res, next) => {
  try {
    const parcour = await Parcours.findByPk(req.params.id);
    if (!parcour) return res.status(404).json({ success: false, message: 'Parcours introuvable.' });

    // If changing filiere, verify new filiere exists
    if (req.body.filiere_id && req.body.filiere_id !== parcour.filiere_id) {
      const filiere = await Filiere.findByPk(req.body.filiere_id);
      if (!filiere) {
        return res.status(400).json({ success: false, message: 'Filière inexistante.' });
      }
    }

    await parcour.update(req.body);
    const result = await Parcours.findByPk(req.params.id, {
      include: [
        {
          model: Filiere,
          as: 'filiere',
          include: [{ model: Universite, as: 'universite' }]
        }
      ]
    });
    res.json({ success: true, parcour: result });
  } catch (err) {
    next(err);
  }
};

// DELETE /api/parcours/:id - Delete parcours (admin - soft delete)
exports.supprimerParcours = async (req, res, next) => {
  try {
    const parcour = await Parcours.findByPk(req.params.id);
    if (!parcour) return res.status(404).json({ success: false, message: 'Parcours introuvable.' });

    await Parcours.update({ actif: false }, { where: { id: req.params.id } });
    res.json({ success: true, message: 'Parcours désactivé.' });
  } catch (err) {
    next(err);
  }
};

// GET /api/parcours/filiere/:filiere_id - Get all parcours for a filiere
exports.getParcoursParFiliere = async (req, res, next) => {
  try {
    const parcours = await Parcours.findAll({
      where: { filiere_id: req.params.filiere_id, actif: true },
      order: [['nom', 'ASC']]
    });
    res.json({ success: true, parcours });
  } catch (err) {
    next(err);
  }
};
