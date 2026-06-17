const { User, Question, OptionReponse, RecommendationRules, Testimonial, Settings } = require('../models');

// ═══════════════════════════════════════════════════════════════════════
// GESTION DES UTILISATEURS
// ═══════════════════════════════════════════════════════════════════════

// GET /api/admin/users
exports.getUsers = async (req, res, next) => {
  try {
    const { page = 1, limit = 20, role } = req.query;
    const where = {};
    if (role) where.role = role;
    const { count, rows } = await User.findAndCountAll({
      where,
      limit: parseInt(limit),
      offset: (parseInt(page) - 1) * parseInt(limit),
      order: [['createdAt', 'DESC']]
    });
    res.json({ success: true, total: count, users: rows });
  } catch (err) { next(err); }
};

// POST /api/admin/users - Créer un nouvel utilisateur
exports.createUser = async (req, res, next) => {
  try {
    const { nom, prenom, email, mot_de_passe, role = 'bachelier', serie_bac, ville, budget_mensuel, actif = true } = req.body;
    const { validatePassword } = require('../utils/passwordValidator');

    // Validate password strength
    const passwordValidation = validatePassword(mot_de_passe);
    if (!passwordValidation.valid) {
      return res.status(400).json({ success: false, message: passwordValidation.message });
    }

    // Vérifier que l'email n'existe pas déjà
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ success: false, message: 'Cet email est déjà utilisé.' });
    }

    const user = await User.create({
      nom,
      prenom,
      email,
      mot_de_passe,
      role,
      serie_bac,
      ville,
      budget_mensuel,
      actif
    });

    res.status(201).json({ success: true, user });
  } catch (err) { next(err); }
};

// PUT /api/admin/users/:id - Mettre à jour un utilisateur
exports.updateUser = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.params.id);
    if (!user) return res.status(404).json({ success: false, message: 'Utilisateur introuvable.' });

    const { nom, prenom, email, role, serie_bac, ville, budget_mensuel, actif, mot_de_passe } = req.body;

    // Vérifier que le nouvel email n'existe pas (s'il change)
    if (email && email !== user.email) {
      const existingUser = await User.findOne({ where: { email } });
      if (existingUser) {
        return res.status(400).json({ success: false, message: 'Cet email est déjà utilisé.' });
      }
    }

    await user.update({
      nom: nom !== undefined ? nom : user.nom,
      prenom: prenom !== undefined ? prenom : user.prenom,
      email: email !== undefined ? email : user.email,
      role: role !== undefined ? role : user.role,
      serie_bac: serie_bac !== undefined ? serie_bac : user.serie_bac,
      ville: ville !== undefined ? ville : user.ville,
      budget_mensuel: budget_mensuel !== undefined ? budget_mensuel : user.budget_mensuel,
      actif: actif !== undefined ? actif : user.actif,
      ...(mot_de_passe && { mot_de_passe })
    });

    res.json({ success: true, user });
  } catch (err) { next(err); }
};

// DELETE /api/admin/users/:id - Supprimer un utilisateur
exports.deleteUser = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.params.id);
    if (!user) return res.status(404).json({ success: false, message: 'Utilisateur introuvable.' });
    await user.destroy();
    res.json({ success: true, message: 'Utilisateur supprimé avec succès.' });
  } catch (err) { next(err); }
};

// PATCH /api/admin/users/:id/toggle
exports.toggleUser = async (req, res, next) => {
  try {
    const user = await User.findByPk(req.params.id);
    if (!user) return res.status(404).json({ success: false, message: 'Utilisateur introuvable.' });
    await user.update({ actif: !user.actif });
    res.json({ success: true, actif: user.actif });
  } catch (err) { next(err); }
};

// POST /api/admin/questions
exports.creerQuestion = async (req, res, next) => {
  try {
    const { texte, categorie, series_bac_cibles, ordre, options } = req.body;
    const question = await Question.create({ texte, categorie, series_bac_cibles, ordre });
    if (options?.length) {
      await OptionReponse.bulkCreate(options.map(o => ({ ...o, question_id: question.id })));
    }
    const full = await Question.findByPk(question.id, { include: [{ model: OptionReponse, as: 'options' }] });
    res.status(201).json({ success: true, question: full });
  } catch (err) { next(err); }
};

// PUT /api/admin/questions/:id
exports.modifierQuestion = async (req, res, next) => {
  try {
    const question = await Question.findByPk(req.params.id);
    if (!question) return res.status(404).json({ success: false, message: 'Question introuvable.' });

    const { texte, categorie, series_bac_cibles, ordre, options } = req.body;

    // Mettre à jour les champs de la question
    await question.update({
      texte: texte !== undefined ? texte : question.texte,
      categorie: categorie !== undefined ? categorie : question.categorie,
      series_bac_cibles: series_bac_cibles !== undefined ? series_bac_cibles : question.series_bac_cibles,
      ordre: ordre !== undefined ? ordre : question.ordre,
    });

    // Gérer les options si fournis
    if (options && Array.isArray(options)) {
      // Supprimer les anciennes options
      await OptionReponse.destroy({ where: { question_id: question.id } });
      // Créer les nouvelles options
      if (options.length > 0) {
        await OptionReponse.bulkCreate(options.map(o => ({ texte: o.texte, poids: o.poids, question_id: question.id })));
      }
    }

    // Retourner la question avec ses options
    const updatedQuestion = await Question.findByPk(question.id, { include: [{ model: OptionReponse, as: 'options' }] });
    res.json({ success: true, question: updatedQuestion });
  } catch (err) { next(err); }
};

// DELETE /api/admin/questions/:id
exports.supprimerQuestion = async (req, res, next) => {
  try {
    await Question.update({ actif: false }, { where: { id: req.params.id } });
    res.json({ success: true, message: 'Question désactivée.' });
  } catch (err) { next(err); }
};

// ═══════════════════════════════════════════════════════════════════════
// GESTION DES RÈGLES DE RECOMMANDATION
// ═══════════════════════════════════════════════════════════════════════

// GET /api/admin/recommendation-rules - Lister toutes les règles
exports.getRulesRecommandation = async (req, res, next) => {
  try {
    const rules = await RecommendationRules.findAll({
      order: [['date_modification', 'DESC']]
    });
    res.json({ success: true, rules });
  } catch (err) { next(err); }
};

// GET /api/admin/recommendation-rules/:id - Obtenir une règle spécifique
exports.getRuleRecommandation = async (req, res, next) => {
  try {
    const rule = await RecommendationRules.findByPk(req.params.id);
    if (!rule) return res.status(404).json({ success: false, message: 'Règle introuvable.' });
    res.json({ success: true, rule });
  } catch (err) { next(err); }
};

// GET /api/admin/recommendation-rules/active - Obtenir la règle active (défaut)
exports.getActiveRule = async (req, res, next) => {
  try {
    const rule = await RecommendationRules.findOne({ where: { est_default: true, actif: true } });
    if (!rule) {
      // Créer la règle par défaut si elle n'existe pas
      const defaultRule = await RecommendationRules.create({
        nom: 'Règles par défaut',
        description: 'Configuration standard du système de recommandation',
        est_default: true,
        actif: true
      });
      return res.json({ success: true, rule: defaultRule, created: true });
    }
    res.json({ success: true, rule });
  } catch (err) { next(err); }
};

// POST /api/admin/recommendation-rules - Créer une nouvelle règle
exports.creerRuleRecommandation = async (req, res, next) => {
  try {
    const {
      nom, description, poids_serie, poids_moyenne, poids_interet, poids_competences,
      poids_budget, poids_duree, poids_test, moyenne_min_acceptable,
      filtre_eliminer_hors_serie, filtre_eliminer_hors_budget, top_n_recommendations,
      methode_scoring, notes_modifications
    } = req.body;

    // Valider que les poids totalisent 100
    const totalPoids = (poids_serie || 25) + (poids_moyenne || 20) + (poids_interet || 20) +
                       (poids_competences || 15) + (poids_budget || 10) + (poids_duree || 5) + (poids_test || 5);

    if (totalPoids !== 100) {
      return res.status(400).json({
        success: false,
        message: `La somme des poids doit égaler 100. Actuellement: ${totalPoids}`
      });
    }

    const rule = await RecommendationRules.create({
      nom, description, poids_serie, poids_moyenne, poids_interet, poids_competences,
      poids_budget, poids_duree, poids_test, moyenne_min_acceptable,
      filtre_eliminer_hors_serie, filtre_eliminer_hors_budget, top_n_recommendations,
      methode_scoring, notes_modifications
    });

    res.status(201).json({ success: true, rule, message: 'Règle créée avec succès.' });
  } catch (err) { next(err); }
};

// PUT /api/admin/recommendation-rules/:id - Mettre à jour une règle
exports.mettreAJourRule = async (req, res, next) => {
  try {
    const rule = await RecommendationRules.findByPk(req.params.id);
    if (!rule) return res.status(404).json({ success: false, message: 'Règle introuvable.' });

    const {
      nom, description, poids_serie, poids_moyenne, poids_interet, poids_competences,
      poids_budget, poids_duree, poids_test, moyenne_min_acceptable,
      filtre_eliminer_hors_serie, filtre_eliminer_hors_budget, top_n_recommendations,
      methode_scoring, notes_modifications
    } = req.body;

    // Valider que les poids totalisent 100 si modifiés
    const newPoids = {
      serie: poids_serie !== undefined ? poids_serie : rule.poids_serie,
      moyenne: poids_moyenne !== undefined ? poids_moyenne : rule.poids_moyenne,
      interet: poids_interet !== undefined ? poids_interet : rule.poids_interet,
      competences: poids_competences !== undefined ? poids_competences : rule.poids_competences,
      budget: poids_budget !== undefined ? poids_budget : rule.poids_budget,
      duree: poids_duree !== undefined ? poids_duree : rule.poids_duree,
      test: poids_test !== undefined ? poids_test : rule.poids_test
    };

    const totalPoids = Object.values(newPoids).reduce((a, b) => a + b, 0);
    if (totalPoids !== 100) {
      return res.status(400).json({
        success: false,
        message: `La somme des poids doit égaler 100. Actuellement: ${totalPoids}`
      });
    }

    await rule.update({
      nom: nom !== undefined ? nom : rule.nom,
      description: description !== undefined ? description : rule.description,
      poids_serie: newPoids.serie,
      poids_moyenne: newPoids.moyenne,
      poids_interet: newPoids.interet,
      poids_competences: newPoids.competences,
      poids_budget: newPoids.budget,
      poids_duree: newPoids.duree,
      poids_test: newPoids.test,
      moyenne_min_acceptable: moyenne_min_acceptable !== undefined ? moyenne_min_acceptable : rule.moyenne_min_acceptable,
      filtre_eliminer_hors_serie: filtre_eliminer_hors_serie !== undefined ? filtre_eliminer_hors_serie : rule.filtre_eliminer_hors_serie,
      filtre_eliminer_hors_budget: filtre_eliminer_hors_budget !== undefined ? filtre_eliminer_hors_budget : rule.filtre_eliminer_hors_budget,
      top_n_recommendations: top_n_recommendations !== undefined ? top_n_recommendations : rule.top_n_recommendations,
      methode_scoring: methode_scoring !== undefined ? methode_scoring : rule.methode_scoring,
      notes_modifications: notes_modifications,
      date_modification: new Date()
    });

    res.json({ success: true, rule, message: 'Règle mise à jour avec succès.' });
  } catch (err) { next(err); }
};

// PATCH /api/admin/recommendation-rules/:id/activate - Activer une règle comme défaut
exports.activerRule = async (req, res, next) => {
  try {
    const rule = await RecommendationRules.findByPk(req.params.id);
    if (!rule) return res.status(404).json({ success: false, message: 'Règle introuvable.' });

    // Désactiver l'ancienne règle par défaut
    await RecommendationRules.update({ est_default: false }, { where: { est_default: true } });

    // Activer la nouvelle
    await rule.update({ est_default: true, actif: true });

    res.json({ success: true, rule, message: 'Règle activée comme défaut.' });
  } catch (err) { next(err); }
};

// DELETE /api/admin/recommendation-rules/:id - Supprimer une règle
exports.supprimerRule = async (req, res, next) => {
  try {
    const rule = await RecommendationRules.findByPk(req.params.id);
    if (!rule) return res.status(404).json({ success: false, message: 'Règle introuvable.' });

    // Empêcher la suppression de la règle par défaut
    if (rule.est_default) {
      return res.status(400).json({
        success: false,
        message: 'Impossible de supprimer la règle par défaut. Activez d\'abord une autre règle.'
      });
    }

    await rule.destroy();
    res.json({ success: true, message: 'Règle supprimée avec succès.' });
  } catch (err) { next(err); }
};

// ═══════════════════════════════════════════════════════════════════════
// GESTION DES TÉMOIGNAGES
// ═══════════════════════════════════════════════════════════════════════

// GET /api/admin/testimonials
exports.getTestimonials = async (req, res, next) => {
  try {
    const { page = 1, limit = 20, status } = req.query;
    const where = {};
    if (status) where.status = status;
    const { count, rows } = await Testimonial.findAndCountAll({
      where,
      limit: parseInt(limit),
      offset: (parseInt(page) - 1) * parseInt(limit),
      order: [['createdAt', 'DESC']]
    });
    res.json({ success: true, total: count, testimonials: rows });
  } catch (err) { next(err); }
};

// POST /api/admin/testimonials
exports.createTestimonial = async (req, res, next) => {
  try {
    const { student_name, student_serie, university_name, course_name, text, rating, status = 'En attente' } = req.body;
    const testimonial = await Testimonial.create({
      student_name, student_serie, university_name, course_name, text, rating, status
    });
    res.status(201).json({ success: true, testimonial });
  } catch (err) { next(err); }
};

// PUT /api/admin/testimonials/:id
exports.updateTestimonial = async (req, res, next) => {
  try {
    const testimonial = await Testimonial.findByPk(req.params.id);
    if (!testimonial) return res.status(404).json({ success: false, message: 'Témoignage introuvable.' });
    await testimonial.update(req.body);
    res.json({ success: true, testimonial });
  } catch (err) { next(err); }
};

// DELETE /api/admin/testimonials/:id
exports.deleteTestimonial = async (req, res, next) => {
  try {
    const testimonial = await Testimonial.findByPk(req.params.id);
    if (!testimonial) return res.status(404).json({ success: false, message: 'Témoignage introuvable.' });
    await testimonial.destroy();
    res.json({ success: true, message: 'Témoignage supprimé.' });
  } catch (err) { next(err); }
};

// PATCH /api/admin/testimonials/:id/approve
exports.approveTestimonial = async (req, res, next) => {
  try {
    const testimonial = await Testimonial.findByPk(req.params.id);
    if (!testimonial) return res.status(404).json({ success: false, message: 'Témoignage introuvable.' });
    await testimonial.update({ status: 'Approuvé' });
    res.json({ success: true, testimonial });
  } catch (err) { next(err); }
};

// PATCH /api/admin/testimonials/:id/reject
exports.rejectTestimonial = async (req, res, next) => {
  try {
    const testimonial = await Testimonial.findByPk(req.params.id);
    if (!testimonial) return res.status(404).json({ success: false, message: 'Témoignage introuvable.' });
    await testimonial.update({ status: 'Rejeté' });
    res.json({ success: true, testimonial });
  } catch (err) { next(err); }
};

// ═══════════════════════════════════════════════════════════════════════
// GESTION DES PARAMÈTRES
// ═══════════════════════════════════════════════════════════════════════

// GET /api/admin/settings
exports.getSettings = async (req, res, next) => {
  try {
    const settings = await Settings.findOne() || await Settings.create({});
    res.json({ success: true, settings });
  } catch (err) { next(err); }
};

// PUT /api/admin/settings
exports.updateSettings = async (req, res, next) => {
  try {
    let settings = await Settings.findOne();
    if (!settings) {
      settings = await Settings.create(req.body);
    } else {
      await settings.update(req.body);
    }
    res.json({ success: true, settings });
  } catch (err) { next(err); }
};
