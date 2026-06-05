require('dotenv').config({ path: __dirname + '/../.env' });
const { sequelize } = require('../config/database');
const { Test, TestQuestion, SessionTestMulti, Question } = require('../models');

async function resetTests() {
  try {
    console.log('🔄 Resetting tests...\n');

    // Delete all sessions
    await sequelize.query('TRUNCATE TABLE sessions_test_multi CASCADE');
    console.log('✅ Deleted all sessions');

    // Delete all test questions
    await sequelize.query('TRUNCATE TABLE test_questions CASCADE');
    console.log('✅ Deleted all test questions');

    // Delete all tests
    await sequelize.query('TRUNCATE TABLE tests CASCADE');
    console.log('✅ Deleted all tests');

    // Get all questions
    const allQuestions = await Question.findAll({
      order: [['id', 'ASC']]
    });

    console.log(`\n📝 Found ${allQuestions.length} questions in database\n`);

    if (allQuestions.length < 10) {
      console.log('❌ Not enough questions! Need at least 10');
      process.exit(1);
    }

    // Create ONE test d'orientation with only first 10 questions
    const orientationTest = await Test.create({
      nom: 'Test d\'Orientation',
      description: 'Test général pour déterminer vos préférences académiques',
      type: 'diagnostic',
      domaine: 'general',
      duree_minutes: 15,
      ordre: 0,
      actif: true
    });

    console.log(`✅ Created: ${orientationTest.nom}`);

    // Link only first 10 questions
    const questionsFor0rientationTest = allQuestions.slice(0, 10);
    for (let i = 0; i < questionsFor0rientationTest.length; i++) {
      await TestQuestion.create({
        test_id: orientationTest.id,
        question_id: questionsFor0rientationTest[i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    console.log(`✅ Linked 10 questions to orientation test`);

    // Create 3 specialized tests with remaining 12 questions
    const mathTest = await Test.create({
      nom: 'Test de Mathématiques',
      description: 'Évaluez vos compétences en mathématiques',
      type: 'specialise',
      domaine: 'mathematiques',
      duree_minutes: 10,
      ordre: 1,
      actif: true
    });

    const scienceTest = await Test.create({
      nom: 'Test de Sciences',
      description: 'Testez vos connaissances en sciences naturelles',
      type: 'specialise',
      domaine: 'sciences',
      duree_minutes: 10,
      ordre: 2,
      actif: true
    });

    const languesTest = await Test.create({
      nom: 'Test de Langues',
      description: 'Mesurez votre aptitude aux langues étrangères',
      type: 'specialise',
      domaine: 'langues',
      duree_minutes: 8,
      ordre: 3,
      actif: true
    });

    console.log(`✅ Created: ${mathTest.nom}`);
    console.log(`✅ Created: ${scienceTest.nom}`);
    console.log(`✅ Created: ${languesTest.nom}`);

    // Link remaining 12 questions to specialized tests (4 each)
    const mathQuestions = allQuestions.slice(10, 14);
    const scienceQuestions = allQuestions.slice(14, 18);
    const languesQuestions = allQuestions.slice(18, 22);

    for (let i = 0; i < mathQuestions.length; i++) {
      await TestQuestion.create({
        test_id: mathTest.id,
        question_id: mathQuestions[i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    for (let i = 0; i < scienceQuestions.length; i++) {
      await TestQuestion.create({
        test_id: scienceTest.id,
        question_id: scienceQuestions[i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    for (let i = 0; i < languesQuestions.length; i++) {
      await TestQuestion.create({
        test_id: languesTest.id,
        question_id: languesQuestions[i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    console.log(`✅ Linked 4 questions to Math test`);
    console.log(`✅ Linked 4 questions to Science test`);
    console.log(`✅ Linked 4 questions to Languages test`);

    console.log('\n🎉 Tests reset successfully!');
    console.log(`📊 Summary:`);
    console.log(`  - 1 Orientation Test (10 questions)`);
    console.log(`  - 3 Specialized Tests (4 questions each)`);
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

resetTests();
