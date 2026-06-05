const { Op } = require('sequelize');
const { Universite, Filiere, Parcours } = require('../models');
const { notifyAllUsersNewUniversity } = require('../services/notification.service');

// GET /api/universites
exports.getUniversites = async (req, res, next) => {
  try {
    const { ville, type, search, page = 1, limit = 10000 } = req.query;
    const where = { actif: true };
    if (ville) where.ville = { [Op.like]: `%${ville}%` };
    if (type) where.type = type;
    if (search) where.nom = { [Op.like]: `%${search}%` };

    const { count, rows } = await Universite.findAndCountAll({
      where,
      include: [{
        model: Filiere,
        as: 'filieres',
        attributes: ['id', 'nom', 'domaine', 'niveau'],
        where: { actif: true },
        required: false,
        include: [{
          model: Parcours,
          as: 'parcours',
          attributes: ['id', 'nom', 'specialisation'],
          where: { actif: true },
          required: false
        }]
      }],
      limit: parseInt(limit),
      offset: (parseInt(page) - 1) * parseInt(limit),
      order: [['nom', 'ASC']]
    });

    res.json({ success: true, total: count, page: parseInt(page), pages: Math.ceil(count / limit), universites: rows });
  } catch (err) { next(err); }
};

// GET /api/universites/:id
exports.getUniversite = async (req, res, next) => {
  try {
    const univ = await Universite.findOne({
      where: { id: req.params.id, actif: true },
      include: [{
        model: Filiere,
        as: 'filieres',
        where: { actif: true },
        required: false,
        include: [{
          model: Parcours,
          as: 'parcours',
          where: { actif: true },
          required: false
        }]
      }]
    });
    if (!univ) return res.status(404).json({ success: false, message: 'Université introuvable.' });
    res.json({ success: true, universite: univ });
  } catch (err) { next(err); }
};

// POST /api/universites (admin)
exports.creerUniversite = async (req, res, next) => {
  try {
    const data = { ...req.body };
    const univ = await Universite.create(data);

    // Send notifications to all users
    await notifyAllUsersNewUniversity(univ.nom);

    res.status(201).json({ success: true, universite: univ });
  } catch (err) { next(err); }
};

// PUT /api/universites/:id (admin)
exports.modifierUniversite = async (req, res, next) => {
  try {
    const univ = await Universite.findByPk(req.params.id);
    if (!univ) return res.status(404).json({ success: false, message: 'Université introuvable.' });

    const data = { ...req.body };

    const updated = await univ.update(data, { validate: true });

    await univ.reload();

    res.json({ success: true, universite: univ });
  } catch (err) { next(err); }
};

// DELETE /api/universites/:id (admin - soft delete)
exports.supprimerUniversite = async (req, res, next) => {
  try {
    await Universite.update({ actif: false }, { where: { id: req.params.id } });
    res.json({ success: true, message: 'Université désactivée.' });
  } catch (err) { next(err); }
};
