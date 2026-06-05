require('dotenv').config({ path: __dirname + '/../.env' });
const { Test, TestQuestion, Question, OptionReponse } = require('../models');

async function checkData() {
  try {
    console.log('🔍 Checking multi-tests data...\n');

    // Check tests
    const tests = await Test.findAll();
    console.log(`📝 Tests: ${tests.length}`);

    for (const test of tests) {
      const count = await TestQuestion.count({ where: { test_id: test.id } });
      console.log(`  - ${test.nom} (${count} questions)`);
    }

    console.log('\n');

    // Check test-questions
    const testQuestions = await TestQuestion.findAll();
    console.log(`🔗 Test Questions: ${testQuestions.length}`);

    console.log('\n');

    // Check questions with options
    const questions = await Question.findAll({
      include: [{ model: OptionReponse, as: 'options' }]
    });
    console.log(`❓ Questions: ${questions.length}`);
    questions.forEach(q => {
      console.log(`  - ${q.texte} (${q.options?.length || 0} options)`);
      q.options?.forEach(opt => console.log(`    • ${opt.texte}`));
    });

    console.log('\n');

    // Check options
    const options = await OptionReponse.findAll();
    console.log(`✅ Options: ${options.length}`);

    console.log('\n✅ Data check complete!');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

checkData();
