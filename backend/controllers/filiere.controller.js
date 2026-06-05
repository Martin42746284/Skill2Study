const { Op } = require('sequelize');
const { Filiere, Universite, Parcours } = require('../models');
const { notifyAllUsersNewField } = require('../services/notification.service');

// GET /api/filieres
exports.getFilieres = async (req, res, next) => {
  try {
    const { domaine, niveau, difficulte, serie_bac, search, page = 1, limit = 10000 } = req.query;
    const where = { actif: true };
    if (domaine) where.domaine = { [Op.like]: `%${domaine}%` };
    if (niveau) where.niveau = niveau;
    if (difficulte) where.difficulte = difficulte;
    if (search) where.nom = { [Op.like]: `%${search}%` };
    if (serie_bac) {
      where.series_bac_acceptees = { [Op.like]: `%${serie_bac}%` };
    }

    const { count, rows } = await Filiere.findAndCountAll({
      where,
      include: [
        { model: Universite, as: 'universite', attributes: ['id', 'nom', 'ville', 'type'] },
        { model: Parcours, as: 'parcours', where: { actif: true }, required: false }
      ],
      limit: parseInt(limit),
      offset: (parseInt(page) - 1) * parseInt(limit),
      order: [['nom', 'ASC']]
    });

    res.json({ success: true, total: count, page: parseInt(page), pages: Math.ceil(count / limit), filieres: rows });
  } catch (err) { next(err); }
};

// GET /api/filieres/:id
exports.getFiliere = async (req, res, next) => {
  try {
    const filiere = await Filiere.findOne({
      where: { id: req.params.id, actif: true },
      include: [
        { model: Universite, as: 'universite' },
        { model: Parcours, as: 'parcours', where: { actif: true }, required: false }
      ]
    });
    if (!filiere) return res.status(404).json({ success: false, message: 'Filière introuvable.' });
    res.json({ success: true, filiere });
  } catch (err) { next(err); }
};

// POST /api/filieres (admin)
exports.creerFiliere = async (req, res, next) => {
  try {
    const { parcours, ...filiereData } = req.body;
    const filiere = await Filiere.create(filiereData);

    if (parcours && Array.isArray(parcours) && parcours.length > 0) {
      const parcoursData = parcours.map(p => ({
        nom: p.nom,
        specialisation: p.specialisation || null,
        description: p.description || null,
        duree_mois: p.duree_mois || null,
        filiere_id: filiere.id,
        actif: true
      }));
      await Parcours.bulkCreate(parcoursData);
      await filiere.reload({ include: [{ model: Parcours, as: 'parcours', where: { actif: true }, required: false }] });
    }

    // Get university name for notification
    const universite = await Universite.findByPk(filiere.universite_id);
    if (universite) {
      await notifyAllUsersNewField(filiere.nom, universite.nom);
    }

    res.status(201).json({ success: true, filiere });
  } catch (err) { next(err); }
};

// PUT /api/filieres/:id (admin)
exports.modifierFiliere = async (req, res, next) => {
  try {
    const filiere = await Filiere.findByPk(req.params.id);
    if (!filiere) return res.status(404).json({ success: false, message: 'Filière introuvable.' });

    const { parcours, ...filiereData } = req.body;

    await filiere.update(filiereData, { validate: true });

    if (parcours && Array.isArray(parcours)) {
      await Parcours.destroy({ where: { filiere_id: filiere.id } });
      if (parcours.length > 0) {
        const parcoursData = parcours.map(p => ({
          nom: p.nom,
          specialisation: p.specialisation || null,
          description: p.description || null,
          duree_mois: p.duree_mois || null,
          filiere_id: filiere.id,
          actif: true
        }));
        await Parcours.bulkCreate(parcoursData);
      }
    }

    await filiere.reload({ include: [{ model: Parcours, as: 'parcours', where: { actif: true }, required: false }] });
    res.json({ success: true, filiere });
  } catch (err) { next(err); }
};

// DELETE /api/filieres/:id (admin)
exports.supprimerFiliere = async (req, res, next) => {
  try {
    await Filiere.update({ actif: false }, { where: { id: req.params.id } });
    res.json({ success: true, message: 'Filière désactivée.' });
  } catch (err) { next(err); }
};
