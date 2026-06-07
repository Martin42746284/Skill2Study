const { DataTypes } = require('sequelize');

const DOMAINE_MAPPING = {
  // Sciences et Technologies
  'Sciences et Technologies': 'Sciences et Technologies',
  'Informatique et Technologies': 'Sciences et Technologies',
  'Sciences de l\'Ingénieur': 'Sciences et Technologies',
  'Géosciences': 'Sciences et Technologies',
  'Sciences Fondamentales et Appliquées': 'Sciences et Technologies',
  'TIC': 'Sciences et Technologies',
  'Sciences Agronomiques': 'Agriculture et Environnement',
  'Technologie': 'Sciences et Technologies',
  'Technologie Industrielle': 'Sciences et Technologies',
  'BTP': 'Sciences et Technologies',
  'Chimie': 'Sciences et Technologies',
  'Biologie': 'Sciences et Technologies',
  'Physique': 'Sciences et Technologies',
  'Mathématiques': 'Sciences et Technologies',
  'Sciences Informatiques': 'Sciences et Technologies',
  'Sciences de la Vie et Terre': 'Sciences et Technologies',

  // Sciences de Gestion
  'Sciences de Gestion': 'Sciences de Gestion',
  'Management': 'Sciences de Gestion',
  'Gestion': 'Sciences de Gestion',
  'Commerce': 'Sciences de Gestion',
  'Commerce et Gestion': 'Sciences de Gestion',
  'Comptabilité, Finance et Gestion': 'Sciences de Gestion',
  'Finance': 'Sciences de Gestion',
  'Entrepreneuriat': 'Sciences de Gestion',
  'Marketing': 'Sciences de Gestion',

  // Droit et Sciences Politiques
  'Droit et Sciences Politiques': 'Droit et Sciences Politiques',
  'Sciences Juridiques': 'Droit et Sciences Politiques',
  'Sciences Juridiques et Politiques': 'Droit et Sciences Politiques',
  'Sciences Politiques': 'Droit et Sciences Politiques',
  'Sciences Sociales': 'Droit et Sciences Politiques',
  'Droit': 'Droit et Sciences Politiques',

  // Arts, Lettres et Communication
  'Arts et Lettres': 'Arts, Lettres et Communication',
  'Communication': 'Arts, Lettres et Communication',
  'Sciences de la Communication': 'Arts, Lettres et Communication',
  'Tourisme': 'Arts, Lettres et Communication',
  'Philosophie': 'Arts, Lettres et Communication',
  'Théologie': 'Arts, Lettres et Communication',

  // Santé et Paramédical
  'Sciences de la Santé': 'Santé et Paramédical',
  'Santé maternelle et infantile': 'Santé et Paramédical',
  'Santé Publique': 'Santé et Paramédical',
  'Paramédical': 'Santé et Paramédical',
  'Infirmier': 'Santé et Paramédical',
  'Sage-femme': 'Santé et Paramédical',
  'Santé et Paramédical': 'Santé et Paramédical',

  // Agriculture et Environnement
  'Agriculture': 'Agriculture et Environnement',
  'Environnement': 'Agriculture et Environnement',
  'Agriculture et Environnement': 'Agriculture et Environnement',
  'Sciences de l\'Environnement': 'Agriculture et Environnement',
  'Agronomie': 'Agriculture et Environnement',

  // Sciences Humaines et Sociales
  'Sciences Humaines et Sociales': 'Sciences Humaines et Sociales',
  'Sciences de l\'Education': 'Sciences Humaines et Sociales',
  'Recherche': 'Sciences Humaines et Sociales',

  // Défense et Sécurité
  'Défense et Sécurité': 'Défense et Sécurité',
  'Défense': 'Défense et Sécurité',
  'Sécurité': 'Défense et Sécurité'
};

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Récupérer tous les domaines uniques
    const filieres = await queryInterface.sequelize.query(
      'SELECT DISTINCT domaine FROM filieres WHERE domaine IS NOT NULL',
      { type: Sequelize.QueryTypes.SELECT }
    );

    // Mettre à jour chaque domaine selon le mapping
    for (const { domaine } of filieres) {
      const newDomaine = DOMAINE_MAPPING[domaine] || domaine;
      if (newDomaine !== domaine) {
        await queryInterface.sequelize.query(
          'UPDATE filieres SET domaine = ? WHERE domaine = ?',
          {
            replacements: [newDomaine, domaine],
            type: Sequelize.QueryTypes.UPDATE
          }
        );
      }
    }
  },

  down: async (queryInterface, Sequelize) => {
    // Reverting this migration would be complex, so we don't provide down migration
  }
};
