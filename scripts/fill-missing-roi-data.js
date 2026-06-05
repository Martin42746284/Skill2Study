#!/usr/bin/env node

/**
 * Script pour remplir automatiquement les données manquantes de ROI
 * Remplit les champs de salaire, coût, et durée pour les filières qui en manquent
 * 
 * Usage: npm run fill-roi
 */

require('dotenv').config();
const { Filiere, Universite } = require('../backend/models');
const { sequelize } = require('../backend/config/database');

// Default values based on field type/domain
const defaultValuesByDomain = {
  'Sciences & Technologies': {
    salaire: 2500000,
    cout: 1200000,
    duree: 3
  },
  'Sciences': {
    salaire: 2200000,
    cout: 1000000,
    duree: 3
  },
  'Sciences Sociales': {
    salaire: 1800000,
    cout: 800000,
    duree: 3
  },
  'Droit et Sciences Politiques': {
    salaire: 2000000,
    cout: 900000,
    duree: 3
  },
  'Sciences de la Santé': {
    salaire: 3500000,
    cout: 2500000,
    duree: 6
  },
  'Ingénierie': {
    salaire: 3000000,
    cout: 1500000,
    duree: 4
  },
  'Gestion et Économie': {
    salaire: 2200000,
    cout: 1100000,
    duree: 3
  },
  'Lettres et Humanités': {
    salaire: 1600000,
    cout: 700000,
    duree: 3
  }
};

const fillMissingROIData = async () => {
  try {
    console.log('🔧 Remplissage des données ROI manquantes...\n');
    
    await sequelize.authenticate();
    console.log('✅ Connexion à la base de données établie\n');

    const filieres = await Filiere.findAll({
      include: [{ model: Universite, as: 'universite' }]
    });

    if (filieres.length === 0) {
      console.log('⚠️ Aucune filière trouvée');
      process.exit(0);
    }

    let updated = 0;
    const updates = [];

    for (const filiere of filieres) {
      const needsUpdate = !filiere.salaire_moyen_debutant || 
                         !filiere.cout_annuel || 
                         !filiere.duree_annees;

      if (needsUpdate) {
        const domain = filiere.domaine || 'Sciences';
        const defaults = defaultValuesByDomain[domain] || defaultValuesByDomain['Sciences'];
        
        const updateData = {
          salaire_moyen_debutant: filiere.salaire_moyen_debutant || defaults.salaire,
          cout_annuel: filiere.cout_annuel || defaults.cout,
          duree_annees: filiere.duree_annees || defaults.duree
        };

        await filiere.update(updateData);
        updated++;

        updates.push({
          id: filiere.id,
          nom: filiere.nom,
          domaine: filiere.domaine,
          updates: updateData
        });

        console.log(`✅ Mise à jour: ID ${filiere.id} - ${filiere.nom}`);
        console.log(`   → Salaire: ${updateData.salaire_moyen_debutant} | Coût: ${updateData.cout_annuel} | Durée: ${updateData.duree_annees} ans\n`);
      }
    }

    console.log('─'.repeat(80));
    console.log(`\n📊 Résumé:`);
    console.log(`  ✅ ${updated} filière(s) mise(s) à jour`);
    console.log(`  ℹ️ ${filieres.length - updated} filière(s) déjà complète(s)`);

    if (updated > 0) {
      console.log(`\n💡 Les scores ROI devraient maintenant s'afficher correctement!`);
    } else {
      console.log(`\n✨ Toutes les filières ont déjà les données ROI complètes!`);
    }

    await sequelize.close();
    process.exit(0);
  } catch (error) {
    console.error('❌ Erreur:', error.message);
    process.exit(1);
  }
};

fillMissingROIData();
