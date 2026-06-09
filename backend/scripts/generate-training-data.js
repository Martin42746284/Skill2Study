/**
 * Script de génération de données fictives pour entraîner le modèle IA
 * Génère des utilisateurs, profils académiques et recommandations réalistes
 * 
 * Usage: node scripts/generate-training-data.js [nombre_utilisateurs]
 * Exemple: node scripts/generate-training-data.js 500
 */

require('dotenv').config();
const { faker } = require('@faker-js/faker');
const { sequelize } = require('../config/database');
const { User, ProfilAcademique, Filiere, Recommendation, SessionTest } = require('../models');
const logger = require('../utils/logger');

const SERIES_BAC = ['C', 'D', 'S', 'A1', 'A2', 'G', 'L'];
const VILLES = ['Antananarivo', 'Antsirabe', 'Fianarantsoa', 'Toliara', 'Mahajanga', 'Toliara', 'Antalaha'];
const BUDGET_RANGES = [0, 50000, 100000, 200000, 500000, 1000000];
const DUREE_OPTIONS = [2, 3, 4, 5];

let generatedCount = {
  users: 0,
  profils: 0,
  sessions: 0,
  recommendations: 0
};

async function generateTrainingData(numberOfUsers = 100) {
  try {
    logger.info(`\n🚀 Début de la génération de ${numberOfUsers} utilisateurs avec données d'entraînement...`);

    // Charger toutes les filières disponibles
    const filieres = await Filiere.findAll({
      where: { actif: true }
    });

    logger.info(`✓ ${filieres.length} filières disponibles pour les recommandations`);

    if (filieres.length === 0) {
      logger.error('✗ Aucune filière trouvée. Impossible de générer les données.');
      process.exit(1);
    }

    // Générer les utilisateurs et leurs données associées
    for (let i = 0; i < numberOfUsers; i++) {
      try {
        // 1. Créer un utilisateur
        const user = await User.create({
          email: faker.internet.email(),
          mot_de_passe: 'Password123!',  // Le hook bcrypt va le hasher
          nom: faker.person.lastName(),
          prenom: faker.person.firstName(),
          avatar_url: faker.image.avatar(),
          email_verified: true,
          actif: true
        });
        generatedCount.users++;

        // 2. Créer un profil académique
        const serieBac = faker.helpers.arrayElement(SERIES_BAC);
        const moyenneGenerale = faker.number.float({ min: 8, max: 20, precision: 0.01 });
        const budget = faker.helpers.arrayElement(BUDGET_RANGES);
        const duree = faker.helpers.arrayElement(DUREE_OPTIONS);

        // Centres d'intérêt aléatoires
        const centresDisponibles = [
          'informatique', 'sciences', 'commerce', 'arts', 'ingénierie',
          'médecine', 'droit', 'gestion', 'économie', 'environnement',
          'architecture', 'tourisme', 'education', 'agriculture'
        ];
        const centres = faker.helpers.shuffle(centresDisponibles).slice(0, faker.number.int({ min: 2, max: 4 }));

        // Compétences aléatoires (en JSON comme dans la DB)
        const competences = {
          logique: faker.number.int({ min: 1, max: 5 }),
          communication: faker.number.int({ min: 1, max: 5 }),
          creativite: faker.number.int({ min: 1, max: 5 }),
          analyse: faker.number.int({ min: 1, max: 5 }),
          travail_equipe: faker.number.int({ min: 1, max: 5 })
        };

        const profil = await ProfilAcademique.create({
          user_id: user.id,
          serie_bac: serieBac,
          moyenne_generale: moyenneGenerale,
          centres_interet: centres,
          competences: competences,
          budget_max_mensuel: budget,
          duree_max_etudes: duree,
          distance_max_km: faker.number.int({ min: 50, max: 500 }),
          ville_preference: faker.helpers.arrayElement(VILLES),
          objectifs_professionnels: faker.company.buzzPhrase(),
          secteur_vise: faker.helpers.arrayElement(centresDisponibles),
          scores_test: generateTestScores(centres)
        });
        generatedCount.profils++;

        // 3. Créer une session test simulée
        const session = await SessionTest.create({
          user_id: user.id,
          reponses: generateTestResponses(),
          scores: profil.scores_test,
          complete: true,
          date_completion: faker.date.past({ years: 1 })
        });
        generatedCount.sessions++;

        // 4. Générer les recommandations basées sur le profil
        const recommendations = generateRecommendations(
          user.id,
          session.id,
          profil,
          filieres
        );

        // Sauvegarder les recommandations
        for (const rec of recommendations) {
          await Recommendation.create(rec);
          generatedCount.recommendations++;
        }

        // Afficher la progression
        if ((i + 1) % 50 === 0) {
          logger.info(`⏳ ${i + 1}/${numberOfUsers} utilisateurs générés...`);
        }

      } catch (err) {
        logger.warn(`⚠️  Erreur pour utilisateur ${i + 1}: ${err.message}`);
      }
    }

    // Résumé final
    console.log('\n' + '='.repeat(60));
    logger.info('✅ Génération de données terminée avec succès !');
    console.log('='.repeat(60));
    console.log(`📊 Statistiques générées:`);
    console.log(`  ✓ Utilisateurs: ${generatedCount.users}`);
    console.log(`  ✓ Profils académiques: ${generatedCount.profils}`);
    console.log(`  ✓ Sessions test: ${generatedCount.sessions}`);
    console.log(`  ✓ Recommandations: ${generatedCount.recommendations}`);
    console.log('='.repeat(60) + '\n');

  } catch (err) {
    logger.error(`Erreur fatale: ${err.message}`);
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

/**
 * Générer les scores du test d'orientation en fonction des centres d'intérêt
 */
function generateTestScores(centres) {
  const tousLesScores = {
    informatique: faker.number.float({ min: 20, max: 100 }),
    sciences: faker.number.float({ min: 20, max: 100 }),
    commerce: faker.number.float({ min: 20, max: 100 }),
    arts: faker.number.float({ min: 20, max: 100 }),
    ingénierie: faker.number.float({ min: 20, max: 100 }),
    médecine: faker.number.float({ min: 20, max: 100 }),
    droit: faker.number.float({ min: 20, max: 100 }),
    gestion: faker.number.float({ min: 20, max: 100 }),
    économie: faker.number.float({ min: 20, max: 100 }),
    environnement: faker.number.float({ min: 20, max: 100 }),
    architecture: faker.number.float({ min: 20, max: 100 }),
    tourisme: faker.number.float({ min: 20, max: 100 }),
    education: faker.number.float({ min: 20, max: 100 }),
    agriculture: faker.number.float({ min: 20, max: 100 })
  };

  // Augmenter les scores pour les centres d'intérêt du profil
  centres.forEach(centre => {
    tousLesScores[centre] = faker.number.float({ min: 60, max: 100 });
  });

  return tousLesScores;
}

/**
 * Générer des réponses de test aléatoires
 */
function generateTestResponses() {
  const responses = {};
  // Simuler 30 questions du test
  for (let i = 1; i <= 30; i++) {
    responses[`question_${i}`] = faker.number.int({ min: 1, max: 5 });
  }
  return responses;
}

/**
 * Générer les recommandations basées sur le scoring du profil
 */
function generateRecommendations(userId, sessionId, profil, filieres) {
  const recommendations = [];

  // Sélectionner aléatoirement 10-30 filières pour les recommander
  const nombrerRecommandations = faker.number.int({ min: 10, max: Math.min(30, filieres.length) });
  const filiereSelectionnees = faker.helpers.shuffle(filieres).slice(0, nombrerRecommandations);

  filiereSelectionnees.forEach((filiere, index) => {
    // Vérifier la compatibilité de la série bac
    let seriesAcceptees = [];
    if (filiere.series_bac_acceptees) {
      // Si c'est un JSON, le parser
      if (typeof filiere.series_bac_acceptees === 'string') {
        seriesAcceptees = JSON.parse(filiere.series_bac_acceptees);
      } else if (Array.isArray(filiere.series_bac_acceptees)) {
        seriesAcceptees = filiere.series_bac_acceptees;
      }
    }
    const serieCompatible = seriesAcceptees.includes(profil.serie_bac);
    
    // Vérifier la compatibilité de la moyenne
    const moyenneMin = filiere.moyenne_min_requise || 10;
    const moyenneCompatible = profil.moyenne_generale >= moyenneMin;

    // Calculer un score basé sur la compatibilité
    let score = faker.number.float({ min: 50, max: 95 });
    
    if (serieCompatible) score += 5;
    if (moyenneCompatible) score += 5;
    
    // Pénalité si incompatibilité majeure
    if (!serieCompatible) score -= 10;
    if (!moyenneCompatible) score -= 10;

    // Clamp entre 0 et 100
    score = Math.min(Math.max(score, 0), 100);

    recommendations.push({
      user_id: userId,
      session_test_id: sessionId,
      filiere_id: filiere.id,
      score_compatibilite: Math.round(score * 100) / 100,
      rang: index + 1,
      justification: {
        raison_principale: `Recommandation basée sur votre profil`,
        points_forts: generatePointsForts(profil, filiere),
        points_attention: generatePointsAttention(profil, filiere),
        raisons: [
          serieCompatible ? `Votre série bac est compatible` : `Série bac moins adaptée`,
          moyenneCompatible ? `Votre moyenne est suffisante` : `Moyenne légèrement en-dessous du minimum`
        ]
      }
    });
  });

  return recommendations;
}

/**
 * Générer les points forts
 */
function generatePointsForts(profil, filiere) {
  const pointsForts = [];
  
  if (profil.moyenne_generale >= 15) {
    pointsForts.push('Excellente moyenne académique');
  }
  
  if (filiere.domaine && profil.centres_interet.some(c => filiere.domaine.toLowerCase().includes(c))) {
    pointsForts.push('Domaine en accord avec vos intérêts');
  }
  
  if (profil.budget_max_mensuel && profil.budget_max_mensuel > 100000) {
    pointsForts.push('Budget suffisant');
  }

  return pointsForts.length > 0 ? pointsForts : ['Bonne correspondance générale'];
}

/**
 * Générer les points d'attention
 */
function generatePointsAttention(profil, filiere) {
  const pointsAttention = [];
  
  const moyenneMin = filiere.moyenne_min_requise || 10;
  if (profil.moyenne_generale < moyenneMin + 2) {
    pointsAttention.push('Prévoir un renforcement académique');
  }
  
  if (profil.duree_max_etudes && filiere.duree_annees > profil.duree_max_etudes) {
    pointsAttention.push('Durée d\'études plus longue que prévue');
  }

  return pointsAttention;
}

// Récupérer le nombre d'utilisateurs depuis les arguments
const numberOfUsers = parseInt(process.argv[2]) || 100;

// Lancer la génération
generateTrainingData(numberOfUsers);
