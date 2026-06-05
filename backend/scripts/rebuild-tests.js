require('dotenv').config({ path: __dirname + '/../.env' });
const { sequelize } = require('../config/database');
const { Test, TestQuestion, SessionTestMulti, Question } = require('../models');

async function rebuildTests() {
  try {
    console.log('🔨 Rebuilding tests from scratch...\n');

    // 1. Delete all sessions
    await SessionTestMulti.destroy({ where: {} });
    console.log('✅ Deleted all sessions');

    // 2. Delete all test questions
    await TestQuestion.destroy({ where: {} });
    console.log('✅ Deleted all test questions');

    // 3. Delete all tests
    await Test.destroy({ where: {} });
    console.log('✅ Deleted all tests');

    // 4. Get all questions
    const allQuestions = await Question.findAll({
      order: [['id', 'ASC']]
    });

    console.log(`\n📝 Found ${allQuestions.length} questions\n`);

    if (allQuestions.length < 22) {
      console.log('❌ Not enough questions! Need at least 22');
      process.exit(1);
    }

    // 5. Create 4 tests
    const orientationTest = await Test.create({
      nom: 'Orientation Test',
      description: 'Test général d\'orientation universitaire pour déterminer vos préférences',
      type: 'diagnostic',
      domaine: 'general',
      duree_minutes: 15,
      ordre: 0,
      actif: true
    });

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

    console.log('✅ Created: Orientation Test');
    console.log('✅ Created: Test de Mathématiques');
    console.log('✅ Created: Test de Sciences');
    console.log('✅ Created: Test de Langues');

    // 6. Link questions to tests
    // Orientation: 0-9
    for (let i = 0; i < 10; i++) {
      await TestQuestion.create({
        test_id: orientationTest.id,
        question_id: allQuestions[i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    // Math: 10-13
    for (let i = 0; i < 4; i++) {
      await TestQuestion.create({
        test_id: mathTest.id,
        question_id: allQuestions[10 + i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    // Science: 14-17
    for (let i = 0; i < 4; i++) {
      await TestQuestion.create({
        test_id: scienceTest.id,
        question_id: allQuestions[14 + i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    // Languages: 18-21
    for (let i = 0; i < 4; i++) {
      await TestQuestion.create({
        test_id: languesTest.id,
        question_id: allQuestions[18 + i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    console.log('\n✅ Linked 10 questions to Orientation Test');
    console.log('✅ Linked 4 questions to Test de Mathématiques');
    console.log('✅ Linked 4 questions to Test de Sciences');
    console.log('✅ Linked 4 questions to Test de Langues');

    console.log('\n🎉 Tests rebuilt successfully!');
    console.log('\nSummary:');
    console.log('  - 1 Orientation Test (10 questions)');
    console.log('  - 3 Specialized Tests (4 questions each)');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

rebuildTests();
