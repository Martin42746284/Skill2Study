// require('dotenv').config();
// const { sequelize } = require('../config/database');
// const { User, Universite, Filiere, ProfilAcademique, Question, OptionReponse } = require('../models');
// const { universitiesData, fieldsData, usersData, testQuestions, coursesData, testimonialsData } = require('./loadData');

// async function seed() {
//   try {
//     await sequelize.sync({ force: true });
//     console.log('✅ Base de données réinitialisée.');

//     // ============================================
//     // 1. SEED USERS
//     // ============================================
//     console.log('\n📝 Création des utilisateurs...');
    
//     // Create Admin user
//     const admin = await User.create({
//       nom: 'Admin',
//       prenom: 'Système',
//       email: 'admin@orientation.mg',
//       mot_de_passe: 'Admin1234!',
//       role: 'admin',
//       serie_bac: 'N/A',
//       moyenne_generale: null
//     });
//     console.log('✅ Admin créé');

//     // Create users from users data
//     const createdUsers = [];
//     for (const userData of usersData) {
//       try {
//         // Parse name
//         const nameParts = userData.name.split(' ');
//         const prenom = nameParts[0];
//         const nom = nameParts.slice(1).join(' ') || nameParts[0];

//         const user = await User.create({
//           nom: nom,
//           prenom: prenom,
//           email: userData.email,
//           mot_de_passe: 'Password123!',
//           role: userData.role === 'Admin' ? 'admin' : 'bachelier',
//           serie_bac: userData.serie !== '-' ? userData.serie : 'Général',
//           moyenne_generale: Math.random() * (18 - 10) + 10,
//           actif: userData.status !== 'Suspendu'
//         });
//         createdUsers.push(user);
//       } catch (err) {
//         console.warn(`⚠️ Erreur création utilisateur ${userData.name}:`, err.message);
//       }
//     }
//     console.log(`✅ ${createdUsers.length} utilisateurs (étudiants + admins) créés`);

//     // ============================================
//     // 2. SEED UNIVERSITIES
//     // ============================================
//     console.log('\n🏫 Création des universités...');
//     const createdUniversities = {};
    
//     for (const uniData of universitiesData) {
//       try {
//         const uni = await Universite.create({
//           nom: uniData.name,
//           type: uniData.type === 'Privé' ? 'privee' : 'publique',
//           ville: uniData.city,
//           wilaya: uniData.province || uniData.city,
//           adresse: uniData.location || uniData.city,
//           site_web: uniData.website || null,
//           email_contact: null,
//           telephone: uniData.phone || null,
//           description: uniData.specialties ? `Spécialités: ${uniData.specialties.join(', ')}` : null,
//           logo_url: null,
//           date_fondation: null,
//           actif: true
//         });
//         createdUniversities[uniData.id] = uni.id;
//         process.stdout.write('.');
//       } catch (err) {
//         console.warn(`⚠️ Erreur création université ${uniData.name}`);
//       }
//     }
//     console.log(`\n✅ ${Object.keys(createdUniversities).length} universités créées`);

//     // ============================================
//     // 3. SEED FILIERES (FIELDS)
//     // ============================================
//     console.log('\n📚 Création des filières...');
//     const createdFilieres = {};
//     const universityIds = Object.values(createdUniversities);
    
//     for (const fieldData of fieldsData) {
//       try {
//         // Get first available university (cycle through them)
//         const universityDbId = universityIds[fieldData.id % universityIds.length];

//         const filiere = await Filiere.create({
//           universite_id: universityDbId,
//           nom: fieldData.name,
//           code: `FILIERE-${fieldData.id.toString().padStart(3, '0')}`,
//           domaine: fieldData.domain,
//           specialite: fieldData.parcours?.[0]?.name || fieldData.name,
//           niveau: fieldData.duration.includes('7') ? 'Master' : 
//                   fieldData.duration.includes('5') ? 'Master' : 'Licence',
//           duree_annees: parseInt(fieldData.duration) || 3,
//           cout_annuel: 0,
//           langue: 'Français/Anglais/Malagasy',
//           series_bac_acceptees: ['Série C', 'Série D', 'Série A', 'Tech.'],
//           moyenne_min_requise: 10,
//           competences_requises: ['logique', 'communication', 'analyse', 'organisation'],
//           centres_interet: fieldData.parcours?.map(p => p.name.toLowerCase()) || [fieldData.name.toLowerCase()],
//           difficulte: fieldData.demand > 25 ? 'difficile' : fieldData.demand > 15 ? 'moyen' : 'facile',
//           taux_emploi: 65 + Math.random() * 30,
//           salaire_moyen_debutant: 40000 + Math.random() * 60000,
//           debouches: fieldData.careers || [],
//           description: fieldData.parcours?.map(p => p.description).join('. ') || (`Formation complète en ${fieldData.name}`),
//           actif: fieldData.status === 'Active'
//         });
//         createdFilieres[fieldData.id] = filiere.id;
//         process.stdout.write('.');
//       } catch (err) {
//         console.warn(`⚠️ Erreur création filière ${fieldData.name}:`, err.message);
//       }
//     }
//     console.log(`\n✅ ${Object.keys(createdFilieres).length} filières créées`);

//     // ============================================
//     // 4. SEED COURSES (informational data)
//     // ============================================
//     console.log('\n🎓 Données de référence sur les cours...');
//     console.log(`📌 ${coursesData.length} cours disponibles (données importées)`);

//     // ============================================
//     // 5. SEED TEST QUESTIONS & OPTIONS
//     // ============================================
//     console.log('\n❓ Création des questions du test d\'orientation...');
//     const createdQuestions = [];
    
//     for (const questionData of testQuestions) {
//       try {
//         const question = await Question.create({
//           texte: questionData.text,
//           categorie: questionData.category,
//           series_bac_cibles: null,
//           ordre: questionData.id,
//           actif: true
//         });

//         // Create options for this question
//         if (questionData.options && Array.isArray(questionData.options)) {
//           for (let optIdx = 0; optIdx < questionData.options.length; optIdx++) {
//             await OptionReponse.create({
//               question_id: question.id,
//               texte: questionData.options[optIdx],
//               poids: {
//                 'score': (optIdx + 1) * 10
//               }
//             });
//           }
//         }
        
//         createdQuestions.push(question.id);
//         process.stdout.write('.');
//       } catch (err) {
//         console.warn(`⚠️ Erreur création question`);
//       }
//     }
//     console.log(`\n✅ ${createdQuestions.length} questions créées`);

//     // ============================================
//     // 6. CREATE ACADEMIC PROFILES FOR STUDENTS
//     // ============================================
//     console.log('\n👤 Création des profils académiques...');
//     let profilesCreated = 0;
    
//     for (const user of createdUsers.slice(0, Math.min(createdUsers.length, 6))) {
//       try {
//         await ProfilAcademique.create({
//           user_id: user.id,
//           serie_bac: user.serie_bac,
//           annee_bac: 2024,
//           mention: 'Bien',
//           moyenne_generale: user.moyenne_generale,
//           notes_matieres: {
//             mathematiques: Math.random() * (18 - 8) + 8,
//             francais: Math.random() * (18 - 8) + 8,
//             physique: Math.random() * (18 - 8) + 8,
//             sciences: Math.random() * (18 - 8) + 8
//           },
//           competences: {
//             logique: Math.floor(Math.random() * 5) + 1,
//             communication: Math.floor(Math.random() * 5) + 1,
//             creativite: Math.floor(Math.random() * 5) + 1,
//             organisation: Math.floor(Math.random() * 5) + 1
//           },
//           centres_interet: ['technologie', 'sciences', 'gestion', 'droit'],
//           objectifs_professionnels: 'Construire une carrière stable dans mon domaine de prédilection',
//           secteur_vise: 'Secteur public ou privé',
//           budget_max_mensuel: 75000,
//           distance_max_km: 200,
//           duree_max_etudes: 5,
//           preference_type_univ: 'publique',
//           ville_preference: 'Antananarivo'
//         });
//         profilesCreated++;
//         process.stdout.write('.');
//       } catch (err) {
//         console.warn(`⚠️ Erreur création profil académique`);
//       }
//     }
//     console.log(`\n✅ ${profilesCreated} profils académiques créés`);

//     // ============================================
//     // SUMMARY & OUTPUT
//     // ============================================
//     console.log('\n' + '='.repeat(70));
//     console.log('🎉 SEEDING TERMINÉ AVEC SUCCÈS!');
//     console.log('='.repeat(70));
//     console.log('\n📊 RÉSUMÉ DES DONNÉES IMPORTÉES:');
//     console.log(`   ✅ Utilisateurs: ${createdUsers.length} étudiants + 1 admin`);
//     console.log(`   ✅ Universités: ${Object.keys(createdUniversities).length}`);
//     console.log(`   ✅ Filières: ${Object.keys(createdFilieres).length}`);
//     console.log(`   ✅ Cours (données de référence): ${coursesData.length}`);
//     console.log(`   ✅ Questions de test: ${createdQuestions.length}`);
//     console.log(`   ✅ Profils académiques: ${profilesCreated}`);
//     console.log(`   ✅ Témoignages (données): ${testimonialsData.length}`);
    
//     console.log('\n🔐 COMPTES DE TEST:');
//     console.log('   📧 Admin: admin@orientation.mg');
//     console.log('      🔑 Mot de passe: Admin1234!');
//     console.log('\n   📧 Étudiants (exemples):');
//     usersData.slice(0, 3).forEach(user => {
//       if (user.role !== 'Admin') {
//         console.log(`      • ${user.email} (${user.serie})`);
//       }
//     });
//     console.log(`      🔑 Mot de passe (tous): Password123!`);
    
//     console.log('\n📝 DONNÉES IMPORTÉES:');
//     console.log(`   • Universités: ${universitiesData.length} institutions`);
//     console.log(`   • Filières: ${fieldsData.length} formations disponibles`);
//     console.log(`   • Utilisateurs: ${usersData.length} comptes étudiants`);
//     console.log(`   • Questions de test: ${testQuestions.length} questions`);
//     console.log(`   • Cours: ${coursesData.length} domaines`);
//     console.log(`   • Témoignages: ${testimonialsData.length} avis étudiants`);

//     console.log('\n📌 NOTES IMPORTANTES:');
//     console.log('   • Les témoignages sont stockés en tant que données de référence');
//     console.log('   • Pour les implémenter en base de données:');
//     console.log('     1. Créez le modèle Testimonial.model.js');
//     console.log('     2. Ajoutez les relations dans models/index.js');
//     console.log('     3. Mettez à jour le seeder');
//     console.log('   • Les recommandations sont générées automatiquement lors du test');
//     console.log('   • Pour exécuter de nouveau: npm run seed');
    
//     console.log('\n' + '='.repeat(70) + '\n');

//     process.exit(0);
//   } catch (err) {
//     console.error('❌ Erreur seed:', err.message);
//     console.error(err.stack);
//     process.exit(1);
//   }
// }

// seed();
