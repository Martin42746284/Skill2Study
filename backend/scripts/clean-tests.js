require('dotenv').config({ path: __dirname + '/../.env' });
const { Test, TestQuestion, Question, OptionReponse, SessionTestMulti } = require('../models');

async function cleanTests() {
  try {
    console.log('🧹 Cleaning test data...\n');

    // 1. Delete all sessions first (they reference tests)
    await SessionTestMulti.destroy({ where: {} });
    console.log('✅ Deleted all test sessions');

    // 2. Delete all test questions and tests
    await TestQuestion.destroy({ where: {} });
    console.log('✅ Deleted all test questions');

    await Test.destroy({ where: {} });
    console.log('✅ Deleted all tests');

    // 2. Keep only 10 most important questions from 22
    // Select the first 10 questions (they're the most general)
    const questionsToKeep = await Question.findAll({
      limit: 10,
      order: [['id', 'ASC']]
    });

    console.log(`\n📝 Keeping ${questionsToKeep.length} questions for test d'orientation`);

    // 3. Create a single test d'orientation général
    const orientationTest = await Test.create({
      nom: 'Test d\'Orientation Général',
      description: 'Test complet pour déterminer vos préférences académiques',
      type: 'diagnostic',
      domaine: 'general',
      duree_minutes: 15,
      ordre: 0,
      actif: true
    });

    console.log(`✅ Created orientation test: ${orientationTest.nom}`);

    // 4. Link the 10 questions to the orientation test
    for (let i = 0; i < questionsToKeep.length; i++) {
      await TestQuestion.create({
        test_id: orientationTest.id,
        question_id: questionsToKeep[i].id,
        ordre: i + 1,
        poids_importance: 1.0
      });
    }

    console.log(`✅ Linked ${questionsToKeep.length} questions to orientation test`);

    // 5. Keep the 3 specialized tests (Maths, Sciences, Langues)
    const specializedTests = await Test.create({
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

    console.log('✅ Created specialized tests');

    // 6. Link specialized test questions (the last 12 questions)
    const specializedQuestions = await Question.findAll({
      offset: 10,
      limit: 12,
      order: [['id', 'ASC']]
    });

    // 4 questions per specialized test (Maths, Sciences, Langues)
    const mathQuestions = specializedQuestions.slice(0, 4);
    const scienceQuestions = specializedQuestions.slice(4, 8);
    const languesQuestions = specializedQuestions.slice(8, 12);

    for (let i = 0; i < mathQuestions.length; i++) {
      await TestQuestion.create({
        test_id: specializedTests.id,
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

    console.log('✅ Linked specialized test questions');

    console.log('\n🎉 Test data cleaned successfully!');
    console.log('Summary:');
    console.log('  - 1 Orientation Test (10 questions)');
    console.log('  - 3 Specialized Tests (4 questions each)');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

cleanTests();
