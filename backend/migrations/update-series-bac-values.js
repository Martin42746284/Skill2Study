const { DataTypes } = require('sequelize');

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Map des anciennes valeurs vers les nouvelles
    const mapping = {
      'A': 'A1',
      'B': 'B',  // B n'existe plus, on le garde comme est pour la vérification
      'STI': 'Technique',
      'STG': 'Technique',
      'Autre': null  // Sera supprimé
    };

    // Mettre à jour les séries bac des utilisateurs
    // Remplacer les anciennes valeurs par les nouvelles
    await queryInterface.sequelize.query(`
      UPDATE users SET serie_bac = 'A1' WHERE serie_bac = 'A';
    `);

    await queryInterface.sequelize.query(`
      UPDATE users SET serie_bac = NULL WHERE serie_bac = 'Autre';
    `);

    // Mettre à jour les séries bac acceptées dans filieres (JSON)
    // Cette partie dépend du contenu exact, mais on peut faire une mise à jour générale
    const filieres = await queryInterface.sequelize.query(
      'SELECT id, series_bac_acceptees FROM filieres WHERE series_bac_acceptees IS NOT NULL',
      { type: Sequelize.QueryTypes.SELECT }
    );

    for (const filiere of filieres) {
      if (filiere.series_bac_acceptees && Array.isArray(filiere.series_bac_acceptees)) {
        const updated = filiere.series_bac_acceptees.map(serie => {
          if (serie === 'A') return 'A1';
          if (serie === 'STI' || serie === 'STG') return 'Technique';
          if (serie === 'Autre') return null;
          return serie;
        }).filter(serie => serie !== null);

        await queryInterface.sequelize.query(
          'UPDATE filieres SET series_bac_acceptees = ? WHERE id = ?',
          {
            replacements: [JSON.stringify(updated), filiere.id],
            type: Sequelize.QueryTypes.UPDATE
          }
        );
      }
    }
  },

  down: async (queryInterface, Sequelize) => {
    // Revert: Remapper les valeurs vers les anciennes
    await queryInterface.sequelize.query(`
      UPDATE users SET serie_bac = 'A' WHERE serie_bac = 'A1';
    `);
  }
};
