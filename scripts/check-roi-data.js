#!/usr/bin/env node

/**
 * Script pour vérifier et signaler les données manquantes pour le calcul du ROI
 * Identifies which fields are missing salary, cost, or duration data
 * 
 * Usage: npm run check-roi-data
 */

require('dotenv').config();
const { Filiere, Universite } = require('../backend/models');
const { sequelize } = require('../backend/config/database');

const checkROIData = async () => {
  try {
    console.log('🔍 Vérification des données ROI pour toutes les filières...\n');
    
    await sequelize.authenticate();
    console.log('✅ Connexion à la base de données établie\n');

    const filieres = await Filiere.findAll({
      include: [{ model: Universite, as: 'universite' }],
      attributes: ['id', 'nom', 'salaire_moyen_debutant', 'cout_annuel', 'duree_annees']
    });

    if (filieres.length === 0) {
      console.log('⚠️ Aucune filière trouvée dans la base de données');
      process.exit(0);
    }

    console.log(`📊 Total: ${filieres.length} filière(s) trouvées\n`);
    console.log('─'.repeat(80));

    const incomplete = [];
    const complete = [];

    filieres.forEach(f => {
      const hasAll = f.salaire_moyen_debutant && f.cout_annuel && f.duree_annees;
      
      if (hasAll) {
        complete.push(f);
        console.log(`✅ ID ${f.id}: ${f.nom}`);
        console.log(`   → Salaire: ${f.salaire_moyen_debutant} | Coût: ${f.cout_annuel} | Durée: ${f.duree_annees} ans\n`);
      } else {
        incomplete.push(f);
        const missing = [];
        if (!f.salaire_moyen_debutant) missing.push('Salaire');
        if (!f.cout_annuel) missing.push('Coût annuel');
        if (!f.duree_annees) missing.push('Durée');
        
        console.log(`❌ ID ${f.id}: ${f.nom}`);
        console.log(`   → Manquant: ${missing.join(', ')}`);
        console.log(`   → Salaire: ${f.salaire_moyen_debutant || '❌'} | Coût: ${f.cout_annuel || '❌'} | Durée: ${f.duree_annees || '❌'}\n`);
      }
    });

    console.log('─'.repeat(80));
    console.log(`\n📈 Résumé:`);
    console.log(`  ✅ Complètes: ${complete.length}/${filieres.length}`);
    console.log(`  ❌ Incomplètes: ${incomplete.length}/${filieres.length}`);

    if (incomplete.length > 0) {
      console.log(`\n⚠️ Les filières suivantes n'afficheront pas de score ROI:`);
      incomplete.forEach(f => {
        console.log(`   - ID ${f.id}: ${f.nom}`);
      });
      console.log(`\n💡 Solution: Mettez à jour les données manquantes via l'interface admin`);
      console.log(`   ou exécutez: npm run seed:fresh`);
    }

    await sequelize.close();
    process.exit(0);
  } catch (error) {
    console.error('❌ Erreur:', error.message);
    process.exit(1);
  }
};

checkROIData();
