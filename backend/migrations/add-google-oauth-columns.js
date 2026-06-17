require('dotenv').config({ path: '.env' });
const { sequelize } = require('../config/database');
const { DataTypes } = require('sequelize');

module.exports = {
  up: async (queryInterface) => {
    try {
      // Check if columns exist
      const table = await queryInterface.describeTable('users');
      
      if (!table.google_id) {
        await queryInterface.addColumn('users', 'google_id', {
          type: DataTypes.STRING(255),
          unique: true,
          allowNull: true
        });
        console.log('✓ Added google_id column');
      }

      if (!table.auth_provider) {
        await queryInterface.addColumn('users', 'auth_provider', {
          type: DataTypes.ENUM('local', 'google'),
          defaultValue: 'local'
        });
        console.log('✓ Added auth_provider column');
      }

      // Make mot_de_passe nullable
      if (table.mot_de_passe && !table.mot_de_passe.allowNull) {
        await queryInterface.changeColumn('users', 'mot_de_passe', {
          type: DataTypes.STRING(255),
          allowNull: true
        });
        console.log('✓ Made mot_de_passe nullable');
      }

      console.log('✓ Migration completed successfully');
    } catch (error) {
      console.error('✗ Migration error:', error.message);
      throw error;
    }
  },

  down: async (queryInterface) => {
    try {
      const table = await queryInterface.describeTable('users');
      if (table.google_id) {
        await queryInterface.removeColumn('users', 'google_id');
      }
      if (table.auth_provider) {
        await queryInterface.removeColumn('users', 'auth_provider');
      }
      await queryInterface.changeColumn('users', 'mot_de_passe', {
        type: DataTypes.STRING(255),
        allowNull: false
      });
    } catch (error) {
      console.error('Rollback error:', error.message);
    }
  }
};
