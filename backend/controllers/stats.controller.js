const { sequelize } = require('../config/database');
const { User, Filiere, Universite, Recommendation, ProfilAcademique } = require('../models');

const DOMAINE_MAPPING = {
  'Sciences et Technologies': 'Sciences et Technologies',
  'Informatique et Technologies': 'Sciences et Technologies',
  'Sciences de l\'Ingénieur': 'Sciences et Technologies',
  'Géosciences': 'Sciences et Technologies',
  'Sciences Fondamentales et Appliquées': 'Sciences et Technologies',
  'TIC': 'Sciences et Technologies',
  'Technologie': 'Sciences et Technologies',
  'Technologie Industrielle': 'Sciences et Technologies',
  'BTP': 'Sciences et Technologies',
  'Chimie': 'Sciences et Technologies',
  'Biologie': 'Sciences et Technologies',
  'Physique': 'Sciences et Technologies',
  'Mathématiques': 'Sciences et Technologies',
  'Sciences Informatiques': 'Sciences et Technologies',
  'Sciences de la Vie et Terre': 'Sciences et Technologies',
  'Sciences de Gestion': 'Sciences de Gestion',
  'Management': 'Sciences de Gestion',
  'Gestion': 'Sciences de Gestion',
  'Commerce': 'Sciences de Gestion',
  'Commerce et Gestion': 'Sciences de Gestion',
  'Comptabilité, Finance et Gestion': 'Sciences de Gestion',
  'Finance': 'Sciences de Gestion',
  'Entrepreneuriat': 'Sciences de Gestion',
  'Marketing': 'Sciences de Gestion',
  'Droit et Sciences Politiques': 'Droit et Sciences Politiques',
  'Sciences Juridiques': 'Droit et Sciences Politiques',
  'Sciences Juridiques et Politiques': 'Droit et Sciences Politiques',
  'Sciences Politiques': 'Droit et Sciences Politiques',
  'Sciences Sociales': 'Droit et Sciences Politiques',
  'Droit': 'Droit et Sciences Politiques',
  'Arts et Lettres': 'Arts, Lettres et Communication',
  'Communication': 'Arts, Lettres et Communication',
  'Sciences de la Communication': 'Arts, Lettres et Communication',
  'Tourisme': 'Arts, Lettres et Communication',
  'Philosophie': 'Arts, Lettres et Communication',
  'Théologie': 'Arts, Lettres et Communication',
  'Sciences de la Santé': 'Santé et Paramédical',
  'Santé maternelle et infantile': 'Santé et Paramédical',
  'Santé Publique': 'Santé et Paramédical',
  'Paramédical': 'Santé et Paramédical',
  'Infirmier': 'Santé et Paramédical',
  'Sage-femme': 'Santé et Paramédical',
  'Santé et Paramédical': 'Santé et Paramédical',
  'Agriculture': 'Agriculture et Environnement',
  'Environnement': 'Agriculture et Environnement',
  'Agriculture et Environnement': 'Agriculture et Environnement',
  'Sciences de l\'Environnement': 'Agriculture et Environnement',
  'Agronomie': 'Agriculture et Environnement',
  'Sciences Agronomiques': 'Agriculture et Environnement',
  'Sciences Humaines et Sociales': 'Sciences Humaines et Sociales',
  'Sciences de l\'Education': 'Sciences Humaines et Sociales',
  'Recherche': 'Sciences Humaines et Sociales',
  'Défense et Sécurité': 'Défense et Sécurité',
  'Défense': 'Défense et Sécurité',
  'Sécurité': 'Défense et Sécurité',
};

// GET /api/stats/dashboard (admin)
exports.dashboardAdmin = async (req, res, next) => {
  try {
    const [totalUsers, totalFilieres, totalUniversites, totalRecommendations] = await Promise.all([
      User.count({ where: { role: 'bachelier' } }),
      Filiere.count({ where: { actif: true } }),
      Universite.count({ where: { actif: true } }),
      Recommendation.count()
    ]);

    // Filières les plus recommandées - avec taux complet
    const topFilieres = await sequelize.query(`
      SELECT
        f.id,
        f.nom,
        f.domaine,
        COUNT(r.id) as taux_recommandation,
        ROUND(CAST(AVG(r.score_compatibilite) AS NUMERIC), 2) as score_moyen
      FROM filieres f
      LEFT JOIN recommendations r ON f.id = r.filiere_id
      WHERE f.actif = true
      GROUP BY f.id, f.nom, f.domaine
      ORDER BY taux_recommandation DESC
      LIMIT 10
    `, { type: sequelize.QueryTypes.SELECT });

    // Répartition par série bac
    const repartitionSeries = await sequelize.query(`
      SELECT
        COALESCE(u.serie_bac, 'Non spécifiée') as serie,
        COUNT(u.id) as nombre_utilisateurs,
        ROUND(CAST((COUNT(u.id) * 100.0 / (SELECT COUNT(*) FROM users WHERE role = 'bachelier')) AS NUMERIC), 1) as pourcentage
      FROM users u
      WHERE u.role = 'bachelier'
      GROUP BY u.serie_bac
      ORDER BY nombre_utilisateurs DESC
    `, { type: sequelize.QueryTypes.SELECT });

    // Taux moyen de compatibilité
    const tauxMoyen = await Recommendation.findOne({
      attributes: [[sequelize.fn('AVG', sequelize.col('score_compatibilite')), 'moyenne']]
    });

    // Taux de recommandation par filière (pour le graphique)
    const tauxParFiliere = await sequelize.query(`
      SELECT
        f.id,
        f.nom,
        COUNT(r.id) as taux,
        ROUND(CAST((COUNT(r.id) * 100.0 / NULLIF((SELECT COUNT(*) FROM recommendations), 0)) AS NUMERIC), 1) as pourcentage
      FROM filieres f
      LEFT JOIN recommendations r ON f.id = r.filiere_id
      WHERE f.actif = true
      GROUP BY f.id, f.nom
      ORDER BY taux DESC
      LIMIT 15
    `, { type: sequelize.QueryTypes.SELECT });

    // Répartition par domaine - avec mapping
    const allDomaines = await sequelize.query(`
      SELECT
        COALESCE(domaine, 'Autre') as domaine,
        COUNT(*) as nombre_filieres
      FROM filieres
      WHERE actif = true
      GROUP BY domaine
    `, { type: sequelize.QueryTypes.SELECT });

    // Apply mapping and aggregate
    const mappedDomaines = {};
    let totalFilieresDomaines = 0;

    allDomaines.forEach((item) => {
      const mappedName = DOMAINE_MAPPING[item.domaine] || 'Autre';
      const count = parseInt(item.nombre_filieres) || 0;
      if (!mappedDomaines[mappedName]) {
        mappedDomaines[mappedName] = 0;
      }
      mappedDomaines[mappedName] += count;
      totalFilieresDomaines += count;
    });

    const repartitionDomaines = Object.entries(mappedDomaines)
      .map(([domaine, count]) => ({
        domaine,
        nombre_filieres: count,
        pourcentage: totalFilieresDomaines > 0 ? Math.round((count / totalFilieresDomaines) * 1000) / 10 : 0
      }))
      .sort((a, b) => b.nombre_filieres - a.nombre_filieres);

    // Profils d'utilisateurs par niveau d'études
    const profilsNiveaux = await sequelize.query(`
      SELECT
        COUNT(DISTINCT u.id) as nombre_utilisateurs,
        ROUND(CAST(AVG(COALESCE(pa.moyenne_generale, 0)) AS NUMERIC), 2) as moyenne_generale_moyenne,
        ROUND(CAST(AVG(COALESCE(pa.budget_max_mensuel, 0)) AS NUMERIC), 0) as budget_moyen
      FROM users u
      LEFT JOIN profils_academiques pa ON u.id = pa.user_id
      WHERE u.role = 'bachelier'
    `, { type: sequelize.QueryTypes.SELECT });

    res.json({
      success: true,
      stats: {
        totalUsers,
        totalFilieres,
        totalUniversites,
        totalRecommendations,
        tauxCompatibiliteMoyen: Math.round(tauxMoyen?.dataValues?.moyenne || 0),
        topFilieres,
        repartitionSeries,
        tauxParFiliere,
        repartitionDomaines,
        profilsNiveaux: profilsNiveaux[0] || {}
      }
    });
  } catch (err) { next(err); }
};

// GET /api/stats/filieres/:id
exports.statsFiliere = async (req, res, next) => {
  try {
    const { id } = req.params;
    const count = await Recommendation.count({ where: { filiere_id: id } });
    const scoreMoyen = await Recommendation.findOne({
      where: { filiere_id: id },
      attributes: [[sequelize.fn('AVG', sequelize.col('score_compatibilite')), 'moyenne']]
    });
    res.json({ success: true, filiere_id: id, nombre_recommendations: count, score_moyen: Math.round(scoreMoyen?.dataValues?.moyenne || 0) });
  } catch (err) { next(err); }
};

// GET /api/stats/moi (utilisateur connecté)
exports.statsMoi = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const nbRecs = await Recommendation.count({ where: { user_id: userId } });
    const meilleure = await Recommendation.findOne({
      where: { user_id: userId },
      order: [['score_compatibilite', 'DESC']],
      include: [{ model: Filiere, as: 'filiere', attributes: ['nom', 'domaine'] }]
    });
    res.json({ success: true, nb_recommendations: nbRecs, meilleure_compatibilite: meilleure });
  } catch (err) { next(err); }
};
