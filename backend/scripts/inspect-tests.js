const { sequelize, Test } = require('../models');

(async () => {
  try {
    const tests = await Test.findAll({ raw: true });
    console.log('All tests in database:');
    tests.forEach(test => {
      console.log(`  - ID: ${test.id}, Nom: "${test.nom}", Type: "${test.type}", Actif: ${test.actif}`);
    });
  } catch (err) {
    console.error('Error:', err.message);
  } finally {
    await sequelize.close();
  }
})();
