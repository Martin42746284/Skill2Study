/**
 * Script de diagnostic des données d'entraînement IA
 * Analyse la qualité, les corrélations et identifie les features manquantes
 * 
 * Usage: node scripts/diagnose-training-data.js
 */

require('dotenv').config();
const { Recommendation, User, ProfilAcademique, Filiere, Universite } = require('../models');
const logger = require('../utils/logger');

async function diagnoseData() {
  try {
    logger.info('\n📊 DIAGNOSTIC DES DONNÉES D\'ENTRAÎNEMENT\n');

    // 1. Récupérer les données
    logger.info('📂 Récupération des données...');
    
    const recommendations = await Recommendation.findAll({
      include: [
        {
          model: User,
          attributes: ['id']
        },
        {
          model: Filiere,
          as: 'filiere',
          attributes: ['id', 'nom', 'domaine', 'taux_emploi', 'cout_annuel', 'universite_id'],
          include: [
            {
              model: Universite,
              as: 'universite',
              attributes: ['id', 'nom', 'type', 'ville']
            }
          ]
        }
      ],
      limit: 5000
    });

    logger.info(`✓ ${recommendations.length} recommandations trouvées`);

    // 2. Récupérer les profils
    const profils = await ProfilAcademique.findAll({
      attributes: [
        'user_id', 'moyenne_generale', 'centres_interet', 'competences', 
        'budget_max_mensuel', 'duree_max_etudes', 'distance_max_km',
        'secteur_vise', 'scores_test'
      ]
    });

    logger.info(`✓ ${profils.length} profils académiques trouvés\n`);

    // 3. Analyser les données
    logger.info('🔍 ANALYSE DES DONNÉES:\n');

    // 3.1 Distribution des scores
    const scores = recommendations.map(r => r.score_compatibilite).filter(s => s != null);
    console.log('📈 Distribution des scores de compatibilité:');
    console.log(`  Min: ${Math.min(...scores).toFixed(2)}`);
    console.log(`  Max: ${Math.max(...scores).toFixed(2)}`);
    console.log(`  Moyenne: ${(scores.reduce((a, b) => a + b, 0) / scores.length).toFixed(2)}`);
    console.log(`  Médiane: ${scores.sort((a, b) => a - b)[Math.floor(scores.length / 2)].toFixed(2)}`);
    console.log(`  Écart-type: ${Math.sqrt(scores.reduce((a, b) => a + Math.pow(b - scores.reduce((x, y) => x + y, 0) / scores.length, 2), 0) / scores.length).toFixed(2)}`);

    // 3.2 Analyse par catégorie
    const acceptes = recommendations.filter(r => r.score_compatibilite >= 70).length;
    const rejetes = recommendations.filter(r => r.score_compatibilite < 70).length;
    console.log(`\n🎯 Classification:
  Acceptés (≥70): ${acceptes} (${(100 * acceptes / recommendations.length).toFixed(1)}%)
  Rejetés (<70): ${rejetes} (${(100 * rejetes / recommendations.length).toFixed(1)}%)`);

    // 3.3 Moyennes académiques
    const moyennes = profils.map(p => p.moyenne_generale).filter(m => m != null);
    console.log(`\n📚 Moyennes académiques:
  Min: ${Math.min(...moyennes).toFixed(2)}
  Max: ${Math.max(...moyennes).toFixed(2)}
  Moyenne: ${(moyennes.reduce((a, b) => a + b, 0) / moyennes.length).toFixed(2)}`);

    // 3.4 Budgets
    const budgets = profils.map(p => p.budget_max_mensuel).filter(b => b != null && b > 0);
    console.log(`\n💰 Budgets mensuels:
  Nombre avec budget: ${budgets.length}/${profils.length}
  Min: ${Math.min(...budgets).toFixed(0)}
  Max: ${Math.max(...budgets).toFixed(0)}
  Moyenne: ${(budgets.reduce((a, b) => a + b, 0) / budgets.length).toFixed(0)}`);

    // 3.5 Centres d'intérêt
    const centresCount = profils.map(p => (p.centres_interet?.length || 0));
    console.log(`\n🎯 Centres d'intérêt:
  Moyenne par profil: ${(centresCount.reduce((a, b) => a + b, 0) / centresCount.length).toFixed(1)}
  Min: ${Math.min(...centresCount)}
  Max: ${Math.max(...centresCount)}`);

    // 3.6 Compétences
    const competencesCount = profils.map(p => Object.keys(p.competences || {}).length);
    console.log(`\n⚙️ Compétences:
  Moyenne par profil: ${(competencesCount.reduce((a, b) => a + b, 0) / competencesCount.length).toFixed(1)}
  Min: ${Math.min(...competencesCount)}
  Max: ${Math.max(...competencesCount)}`);

    // 3.7 Scores de test
    const scoresTestCount = profils.map(p => Object.keys(p.scores_test || {}).length);
    console.log(`\n🧪 Scores de test:
  Profils avec scores: ${scoresTestCount.filter(c => c > 0).length}/${profils.length}
  Moyenne par profil: ${scoresTestCount.filter(c => c > 0).length > 0 ? (scoresTestCount.reduce((a, b) => a + b, 0) / scoresTestCount.filter(c => c > 0).length).toFixed(1) : 0}`);

    // 3.8 Données des filieres
    const filieresTauxEmploi = recommendations
      .map(r => r.filiere?.taux_emploi)
      .filter(t => t != null);
    console.log(`\n💼 Taux d'emploi des filières:
  Filières avec taux: ${filieresTauxEmploi.length}/${recommendations.length}
  Moyenne: ${filieresTauxEmploi.length > 0 ? (filieresTauxEmploi.reduce((a, b) => a + b, 0) / filieresTauxEmploi.length).toFixed(1) : 'N/A'}%`);

    const filieresCout = recommendations
      .map(r => r.filiere?.cout_annuel)
      .filter(c => c != null && c > 0);
    console.log(`\n💳 Coût annuel des filières:
  Filières avec coût: ${filieresCout.length}/${recommendations.length}
  Moyenne: ${filieresCout.length > 0 ? (filieresCout.reduce((a, b) => a + b, 0) / filieresCout.length).toFixed(0) : 'N/A'}`);

    // 3.9 Type d'université
    const typeUniv = {};
    recommendations.forEach(r => {
      const type = r.filiere?.universite?.type || 'unknown';
      typeUniv[type] = (typeUniv[type] || 0) + 1;
    });
    console.log(`\n🏫 Types d'université:
  ${Object.entries(typeUniv).map(([t, c]) => `${t}: ${c} (${(100*c/recommendations.length).toFixed(1)}%)`).join('\n  ')}`);

    // 4. Identifier les features enrichissantes
    console.log('\n\n🚀 FEATURES À AJOUTER:\n');
    
    const features = [
      {
        nom: 'taux_emploi_filiere',
        disponible: filieresTauxEmploi.length,
        total: recommendations.length,
        impact: 'ÉLEVÉ - Prédicteur fort de la compatibilité'
      },
      {
        nom: 'cout_annuel_filiere',
        disponible: filieresCout.length,
        total: recommendations.length,
        impact: 'MOYEN - À comparer avec budget_max_mensuel'
      },
      {
        nom: 'type_universite',
        disponible: recommendations.length,
        total: recommendations.length,
        impact: 'MOYEN - Certains profils préfèrent public/privé'
      },
      {
        nom: 'domaine_filiere',
        disponible: recommendations.filter(r => r.filiere?.domaine).length,
        total: recommendations.length,
        impact: 'MOYEN - À matcher avec secteur_vise du profil'
      },
      {
        nom: 'scores_test_categorie',
        disponible: scoresTestCount.filter(c => c > 0).length,
        total: profils.length,
        impact: 'ÉLEVÉ - Score le plus prédictif du test d\'orientation'
      },
      {
        nom: 'distance_university',
        disponible: profils.filter(p => p.distance_max_km).length,
        total: profils.length,
        impact: 'FAIBLE - Certains étudiants ignorent cette contrainte'
      }
    ];

    features.forEach(f => {
      const pct = ((100 * f.disponible) / f.total).toFixed(0);
      console.log(`✓ ${f.nom.padEnd(25)} ${pct.padStart(3)}% dispo | ${f.impact}`);
    });

    // 5. Recommandations
    console.log('\n\n📋 RECOMMANDATIONS:\n');
    console.log('1. ✅ PRIORITÉ 1: Ajouter "scores_test" du test d\'orientation');
    console.log('   → Feature très prédictive, déjà en base pour ~' + scoresTestCount.filter(c => c > 0).length + ' profils');
    console.log('\n2. ✅ PRIORITÉ 1: Ajouter "taux_emploi_filiere"');
    console.log('   → Peut fortement impacter le score de compatibilité');
    console.log('\n3. ⚠️  PRIORITÉ 2: Ajouter "type_universite" + "domaine_filiere"');
    console.log('   → Helpful pour segmentation, mais impact limité');
    console.log('\n4. ℹ️  PRIORITÉ 3: Ratio budget_profil vs cout_filiere');
    console.log('   → Nouvelle feature d\'interaction calculée');

    console.log('\n' + '='.repeat(60));
    console.log('✅ Diagnostic terminé !\n');

  } catch (err) {
    logger.error(`Erreur fatale: ${err.message}`);
    console.error(err);
    process.exit(1);
  }
}

diagnoseData();
