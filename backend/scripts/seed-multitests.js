require('dotenv').config({ path: __dirname + '/../.env' });
const { Test, TestQuestion, Question, OptionReponse } = require('../models');

async function seedMultiTests() {
  try {
    console.log('🌱 Seeding multi-tests...');

    // Create tests
    const mathTest = await Test.create({
      nom: 'Test de Mathématiques',
      description: 'Évaluez vos compétences en mathématiques',
      type: 'specialise',
      domaine: 'mathematiques',
      duree_minutes: 15,
      ordre: 1,
      actif: true
    });

    const scienceTest = await Test.create({
      nom: 'Test de Sciences',
      description: 'Testez vos connaissances en sciences naturelles',
      type: 'specialise',
      domaine: 'sciences',
      duree_minutes: 15,
      ordre: 2,
      actif: true
    });

    const languesTest = await Test.create({
      nom: 'Test de Langues',
      description: 'Mesurez votre aptitude aux langues étrangères',
      type: 'specialise',
      domaine: 'langues',
      duree_minutes: 12,
      ordre: 3,
      actif: true
    });

    console.log('✅ Tests créés');

    // Create questions for Math test
    const mathQ1 = await Question.create({
      texte: 'Résolvez: 2x + 5 = 13',
      categorie: 'mathematiques',
      ordre: 1,
      actif: true
    });

    const mathQ1Opt1 = await OptionReponse.create({
      question_id: mathQ1.id,
      texte: 'x = 4',
      poids: { mathematiques: 3, ingenierie: 1 }
    });

    const mathQ1Opt2 = await OptionReponse.create({
      question_id: mathQ1.id,
      texte: 'x = 3',
      poids: { mathematiques: 1 }
    });

    const mathQ1Opt3 = await OptionReponse.create({
      question_id: mathQ1.id,
      texte: 'x = 9',
      poids: { mathematiques: 0 }
    });

    const mathQ2 = await Question.create({
      texte: 'Quelle est la dérivée de x²?',
      categorie: 'mathematiques',
      ordre: 2,
      actif: true
    });

    const mathQ2Opt1 = await OptionReponse.create({
      question_id: mathQ2.id,
      texte: '2x',
      poids: { mathematiques: 3, ingenierie: 2, sciences: 1 }
    });

    const mathQ2Opt2 = await OptionReponse.create({
      question_id: mathQ2.id,
      texte: 'x',
      poids: { mathematiques: 1 }
    });

    const mathQ2Opt3 = await OptionReponse.create({
      question_id: mathQ2.id,
      texte: 'x³/3',
      poids: { mathematiques: 0 }
    });

    // Create questions for Science test
    const sciQ1 = await Question.create({
      texte: 'Quel est le symbole chimique de l\'oxygène?',
      categorie: 'sciences',
      ordre: 1,
      actif: true
    });

    const sciQ1Opt1 = await OptionReponse.create({
      question_id: sciQ1.id,
      texte: 'O',
      poids: { sciences: 3, sante: 2 }
    });

    const sciQ1Opt2 = await OptionReponse.create({
      question_id: sciQ1.id,
      texte: 'Ox',
      poids: { sciences: 0 }
    });

    const sciQ1Opt3 = await OptionReponse.create({
      question_id: sciQ1.id,
      texte: 'O2',
      poids: { sciences: 1 }
    });

    const sciQ2 = await Question.create({
      texte: 'Combien de chromosomes a un humain?',
      categorie: 'sciences',
      ordre: 2,
      actif: true
    });

    const sciQ2Opt1 = await OptionReponse.create({
      question_id: sciQ2.id,
      texte: '46',
      poids: { sciences: 3, sante: 3 }
    });

    const sciQ2Opt2 = await OptionReponse.create({
      question_id: sciQ2.id,
      texte: '23',
      poids: { sciences: 1, sante: 1 }
    });

    const sciQ2Opt3 = await OptionReponse.create({
      question_id: sciQ2.id,
      texte: '92',
      poids: { sciences: 0 }
    });

    // Create questions for Languages test
    const langQ1 = await Question.create({
      texte: 'Comment dit-on "bonjour" en anglais?',
      categorie: 'langues',
      ordre: 1,
      actif: true
    });

    const langQ1Opt1 = await OptionReponse.create({
      question_id: langQ1.id,
      texte: 'Hello / Good morning',
      poids: { langues: 3, commerce: 1 }
    });

    const langQ1Opt2 = await OptionReponse.create({
      question_id: langQ1.id,
      texte: 'Good night',
      poids: { langues: 0 }
    });

    const langQ1Opt3 = await OptionReponse.create({
      question_id: langQ1.id,
      texte: 'Goodbye',
      poids: { langues: 1 }
    });

    const langQ2 = await Question.create({
      texte: 'Quel est votre niveau d\'anglais?',
      categorie: 'langues',
      ordre: 2,
      actif: true
    });

    const langQ2Opt1 = await OptionReponse.create({
      question_id: langQ2.id,
      texte: 'Avancé (C1-C2)',
      poids: { langues: 3, commerce: 2, tourisme: 2 }
    });

    const langQ2Opt2 = await OptionReponse.create({
      question_id: langQ2.id,
      texte: 'Intermédiaire (B1-B2)',
      poids: { langues: 2, commerce: 1 }
    });

    const langQ2Opt3 = await OptionReponse.create({
      question_id: langQ2.id,
      texte: 'Débutant (A1-A2)',
      poids: { langues: 1 }
    });

    // Link questions to tests
    await TestQuestion.create({ test_id: mathTest.id, question_id: mathQ1.id, ordre: 1, poids_importance: 1.0 });
    await TestQuestion.create({ test_id: mathTest.id, question_id: mathQ2.id, ordre: 2, poids_importance: 1.0 });

    await TestQuestion.create({ test_id: scienceTest.id, question_id: sciQ1.id, ordre: 1, poids_importance: 1.0 });
    await TestQuestion.create({ test_id: scienceTest.id, question_id: sciQ2.id, ordre: 2, poids_importance: 1.0 });

    await TestQuestion.create({ test_id: languesTest.id, question_id: langQ1.id, ordre: 1, poids_importance: 1.0 });
    await TestQuestion.create({ test_id: languesTest.id, question_id: langQ2.id, ordre: 2, poids_importance: 1.0 });

    console.log('✅ Questions et options créées');
    console.log('✅ Tests et questions liés');
    console.log('🎉 Seeding multi-tests réussi!');
    process.exit(0);

  } catch (error) {
    console.error('❌ Erreur lors du seeding:', error);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  seedMultiTests();
}

module.exports = seedMultiTests;
