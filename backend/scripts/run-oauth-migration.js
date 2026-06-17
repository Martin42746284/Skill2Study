require('dotenv').config({ path: '.env' });
const { sequelize } = require('../config/database');
const { DataTypes } = require('sequelize');

async function runMigration() {
  try {
    const queryInterface = sequelize.getQueryInterface();
    const table = await queryInterface.describeTable('users');
    
    if (!table.google_id) {
      await queryInterface.addColumn('users', 'google_id', {
        type: DataTypes.STRING(255),
        unique: true,
        allowNull: true
      });
      console.log('✓ Added google_id column');
    } else {
      console.log('✓ google_id column already exists');
    }

    if (!table.auth_provider) {
      await queryInterface.addColumn('users', 'auth_provider', {
        type: DataTypes.ENUM('local', 'google'),
        defaultValue: 'local'
      });
      console.log('✓ Added auth_provider column');
    } else {
      console.log('✓ auth_provider column already exists');
    }

    if (table.mot_de_passe && !table.mot_de_passe.allowNull) {
      await queryInterface.changeColumn('users', 'mot_de_passe', {
        type: DataTypes.STRING(255),
        allowNull: true
      });
      console.log('✓ Made mot_de_passe nullable');
    } else {
      console.log('✓ mot_de_passe is already nullable');
    }

    console.log('✓ Migration completed successfully');
    process.exit(0);
  } catch (error) {
    console.error('✗ Migration error:', error.message);
    process.exit(1);
  }
}

runMigration();
