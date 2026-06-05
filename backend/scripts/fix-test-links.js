require('dotenv').config({ path: __dirname + '/../.env' });
const { sequelize } = require('../config/database');
const { Test, TestQuestion, Question } = require('../models');

async function fixTestLinks() {
  try {
    console.log('🔧 Fixing test links...\n');

    // Get all tests
    const tests = await Test.findAll({ order: [['id', 'ASC']] });
    console.log(`Found ${tests.length} tests`);

    // Get all questions
    const allQuestions = await Question.findAll({ order: [['id', 'ASC']] });
    console.log(`Found ${allQuestions.length} questions\n`);

    // Delete existing test questions
    await TestQuestion.destroy({ where: {} });
    console.log('✅ Cleared all test question links\n');

    // Recreate links
    let questionIndex = 0;

    for (const test of tests) {
      let questionsForTest = [];
      
      if (test.nom.includes('Orientation')) {
        // Orientation test: first 10 questions
        questionsForTest = allQuestions.slice(0, 10);
      } else if (test.nom.includes('Mathématiques')) {
        // Math test: questions 10-13
        questionsForTest = allQuestions.slice(10, 14);
      } else if (test.nom.includes('Sciences')) {
        // Science test: questions 14-17
        questionsForTest = allQuestions.slice(14, 18);
      } else if (test.nom.includes('Langues')) {
        // Languages test: questions 18-21
        questionsForTest = allQuestions.slice(18, 22);
      }

      // Create test question links
      for (let i = 0; i < questionsForTest.length; i++) {
        await TestQuestion.create({
          test_id: test.id,
          question_id: questionsForTest[i].id,
          ordre: i + 1,
          poids_importance: 1.0
        });
      }

      console.log(`✅ Linked ${questionsForTest.length} questions to "${test.nom}"`);
    }

    console.log('\n🎉 Test links fixed successfully!');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

fixTestLinks();
