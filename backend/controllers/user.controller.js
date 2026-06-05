const { User, ProfilAcademique, Favori, Filiere, Universite } = require('../models');
const { notifyProfileUpdated, createNotification } = require('../services/notification.service');

// GET /api/users/profil
exports.getProfil = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.user.id, { include: [{ association: 'profil' }] });
    if (!user) {
      return res.status(404).json({ success: false, message: 'Utilisateur non trouvé' });
    }
    const response = user.toJSON();
    // Rename 'profil' to 'profil_academique' for frontend consistency
    response.profil_academique = response.profil;
    delete response.profil;
    res.json(response);
  } catch (err) { next(err); }
};

// PUT /api/users/profil/avatar
exports.modifierAvatar = async (req, res, next) => {
  try {
    const { avatar_url } = req.body;
    await req.user.update({ avatar_url });
    const user = await User.findByPk(req.user.id, { include: [{ association: 'profil' }] });
    const response = user.toJSON();
    response.profil_academique = response.profil;
    delete response.profil;
    res.json(response);
  } catch (err) { next(err); }
};

// PUT /api/users/profil
exports.modifierProfil = async (req, res, next) => {
  try {
    // Filter out null and undefined values
    const dataToUpdate = Object.fromEntries(
      Object.entries(req.body).filter(([_, v]) => v !== null && v !== undefined && v !== '')
    );

    await req.user.update(dataToUpdate);

    // Send notification
    await notifyProfileUpdated(req.user.id);

    const user = await User.findByPk(req.user.id, { include: [{ association: 'profil' }] });
    const response = user.toJSON();
    response.profil_academique = response.profil;
    delete response.profil;
    res.json(response);
  } catch (err) { next(err); }
};

// PUT /api/users/profil/academique
exports.modifierProfilAcademique = async (req, res, next) => {
  try {
    // Filter out null and undefined values
    const dataToUpdate = Object.fromEntries(
      Object.entries(req.body).filter(([_, v]) => v !== null && v !== undefined && v !== '')
    );

    const [profil] = await ProfilAcademique.findOrCreate({ where: { user_id: req.user.id }, defaults: { serie_bac: '' } });
    await profil.update(dataToUpdate);

    // Send notification
    await notifyProfileUpdated(req.user.id);

    const user = await User.findByPk(req.user.id, { include: [{ association: 'profil' }] });
    const response = user.toJSON();
    response.profil_academique = response.profil;
    delete response.profil;
    res.json(response);
  } catch (err) { next(err); }
};

// GET /api/users/favoris
exports.getFavoris = async (req, res, next) => {
  try {
    const favoris = await Favori.findAll({
      where: { user_id: req.user.id },
      include: [{ model: Filiere, as: 'filiere', include: [{ model: Universite, as: 'universite' }] }]
    });
    res.json({ success: true, favoris });
  } catch (err) { next(err); }
};

// POST /api/users/favoris/:filiereId
exports.ajouterFavori = async (req, res, next) => {
  try {
    const [favori, created] = await Favori.findOrCreate({ where: { user_id: req.user.id, filiere_id: req.params.filiereId } });

    // Send notification if newly added
    if (created) {
      const filiere = await Filiere.findByPk(req.params.filiereId, { include: [{ model: Universite, as: 'universite' }] });
      if (filiere) {
        await createNotification(
          req.user.id,
          'success',
          '❤️ Favori ajouté',
          `${filiere.nom} a été ajoutée à vos favoris`,
          { filiere_id: filiere.id, filiere_name: filiere.nom }
        );
      }
    }

    res.status(created ? 201 : 200).json({ success: true, created, favori });
  } catch (err) { next(err); }
};

// DELETE /api/users/favoris/:filiereId
exports.supprimerFavori = async (req, res, next) => {
  try {
    // Get filiere info before deleting
    const filiere = await Filiere.findByPk(req.params.filiereId);

    await Favori.destroy({ where: { user_id: req.user.id, filiere_id: req.params.filiereId } });

    // Send notification
    if (filiere) {
      await createNotification(
        req.user.id,
        'info',
        '💔 Favori supprimé',
        `${filiere.nom} a été supprimée de vos favoris`,
        { filiere_id: filiere.id, filiere_name: filiere.nom }
      );
    }

    res.json({ success: true, message: 'Favori supprimé.' });
  } catch (err) { next(err); }
};
