const { sequelize } = require('../config/database');
const { User, Filiere, Universite, Recommendation, ProfilAcademique } = require('../models');

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

    // Répartition par domaine
    const repartitionDomaines = await sequelize.query(`
      SELECT
        COALESCE(domaine, 'Autre') as domaine,
        COUNT(*) as nombre_filieres,
        ROUND(CAST((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM filieres WHERE actif = true)) AS NUMERIC), 1) as pourcentage
      FROM filieres
      WHERE actif = true
      GROUP BY domaine
      ORDER BY nombre_filieres DESC
    `, { type: sequelize.QueryTypes.SELECT });

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
