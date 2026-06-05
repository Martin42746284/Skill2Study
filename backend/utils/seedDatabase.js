// const bcrypt = require('bcryptjs');
// const { User, Universite, Filiere, Parcours, ProfilAcademique, Settings, Testimonial, Question, OptionReponse, RecommendationRules } = require('../models');
// const { sequelize } = require('../config/database');

// const seedDatabase = async () => {
//   try {
//     console.log('🌱 Démarrage du seeding de la base de données...');

//     // Sync all models
//     await sequelize.sync({ alter: false });
//     console.log('✅ Tables synchronisées');

//     // 1. Créer un utilisateur admin
//     console.log('👤 Création de l\'utilisateur admin...');
//     const adminExists = await User.findOne({ where: { email: 'admin@orientai.mg' } });
//     if (!adminExists) {
//       await User.create({
//         nom: 'Admin',
//         prenom: 'Skill2Study',
//         email: 'admin@orientai.mg',
//         mot_de_passe: bcrypt.hashSync('admin123456', 10),
//         role: 'admin',
//         actif: true
//       });
//       console.log('✅ Admin créé : admin@orientai.mg / admin123456');
//     }

//     // 2. Créer des utilisateurs bachelier de test
//     console.log('👨‍🎓 Création des utilisateurs bacheliiers...');
//     const bacheliersData = [
//       { nom: 'Martin', prenom: 'Rakoto', email: 'martin.rakoto@email.mg', serie_bac: 'Sciences', ville: 'Antananarivo', budget_mensuel: 500000 },
//       { nom: 'Sophie', prenom: 'Andriamampoinimerina', email: 'sophie.andria@email.mg', serie_bac: 'Littérature', ville: 'Antsirabe', budget_mensuel: 300000 },
//       { nom: 'Jean', prenom: 'Rasolomampionona', email: 'jean.rasolo@email.mg', serie_bac: 'Mathématiques', ville: 'Fianarantsoa', budget_mensuel: 700000 },
//       { nom: 'Claire', prenom: 'Razafindratsimihovahobe', email: 'claire.raza@email.mg', serie_bac: 'Sciences Economiques', ville: 'Toliara', budget_mensuel: 400000 },
//     ];

//     for (const data of bacheliersData) {
//       const exists = await User.findOne({ where: { email: data.email } });
//       if (!exists) {
//         await User.create({
//           ...data,
//           mot_de_passe: bcrypt.hashSync('password123', 10),
//           role: 'bachelier',
//           actif: true
//         });
//       }
//     }
//     console.log(`✅ ${bacheliersData.length} utilisateurs bacheliiers créés`);

//     // 3. Créer des universités
//     console.log('🏫 Création des universités...');
//     const universitesData = [
//       {
//         nom: 'Université d\'Antananarivo',
//         type: 'publique',
//         ville: 'Antananarivo',
//         wilaya: 'Antananarivo',
//         adresse: 'Boulevard de l\'Indépendance, Antananarivo',
//         site_web: 'https://www.univ-antananarivo.mg',
//         email_contact: 'contact@univ-antananarivo.mg',
//         telephone: '+261 20 22 261 35',
//         description: 'Principale université publique de Madagascar',
//         date_fondation: 1961,
//         actif: true
//       },
//       {
//         nom: 'Université de Fianarantsoa',
//         type: 'publique',
//         ville: 'Fianarantsoa',
//         wilaya: 'Fianarantsoa',
//         adresse: 'Rue de Madagascar, Fianarantsoa',
//         site_web: 'https://www.univ-fianarantsoa.mg',
//         email_contact: 'contact@univ-fianarantsoa.mg',
//         telephone: '+261 75 39 413 58',
//         description: 'Université publique du Fianarantsoa',
//         date_fondation: 1981,
//         actif: true
//       },
//       {
//         nom: 'Université d\'Antsirabe',
//         type: 'publique',
//         ville: 'Antsirabe',
//         wilaya: 'Vakinankaratra',
//         adresse: 'Antsirabe',
//         site_web: 'https://www.univ-antsirabe.mg',
//         email_contact: 'contact@univ-antsirabe.mg',
//         telephone: '+261 20 44 413 58',
//         description: 'Université publique d\'Antsirabe',
//         date_fondation: 1978,
//         actif: true
//       },
//       {
//         nom: 'École Supérieure Polytechnique d\'Antananarivo',
//         type: 'publique',
//         ville: 'Antananarivo',
//         wilaya: 'Antananarivo',
//         adresse: 'Antananarivo',
//         site_web: 'https://www.espa.mg',
//         email_contact: 'contact@espa.mg',
//         telephone: '+261 20 22 261 35',
//         description: 'École d\'ingénieurs spécialisée',
//         date_fondation: 1970,
//         actif: true
//       },
//       {
//         nom: 'Université Catholique de Madagascar',
//         type: 'privee',
//         ville: 'Antananarivo',
//         wilaya: 'Antananarivo',
//         adresse: 'Antananarivo',
//         site_web: 'https://www.ucm.mg',
//         email_contact: 'contact@ucm.mg',
//         telephone: '+261 20 22 261 35',
//         description: 'Université privée catholique',
//         date_fondation: 1993,
//         actif: true
//       }
//     ];

//     const universites = {};
//     for (const data of universitesData) {
//       const existing = await Universite.findOne({ where: { nom: data.nom } });
//       if (!existing) {
//         const univ = await Universite.create(data);
//         universites[data.nom] = univ.id;
//       } else {
//         universites[data.nom] = existing.id;
//       }
//     }
//     console.log(`✅ ${Object.keys(universites).length} universités créées`);

//     // 4. Créer des filières
//     console.log('📚 Création des filières...');
//     const filieresData = [
//       {
//         universite_id: universites['Université d\'Antananarivo'],
//         nom: 'Informatique',
//         code: 'INFO-L',
//         domaine: 'Sciences & Technologies',
//         specialite: 'Développement Logiciel',
//         niveau: 'Licence',
//         duree_annees: 3,
//         cout_annuel: 1200000,
//         langue: 'Français',
//         series_bac_acceptees: ['Sciences', 'Mathématiques'],
//         moyenne_min_requise: 12,
//         competences_requises: ['Mathématiques', 'Logique', 'Programmation'],
//         centres_interet: ['Technologie', 'Innovation', 'Résolution de problèmes'],
//         difficulte: 'difficile',
//         taux_emploi: 92,
//         salaire_moyen_debutant: 2500000,
//         debouches: ['Développeur', 'Architecte Logiciel', 'Chef de Projet IT'],
//         description: 'Licence en Informatique axée sur le développement logiciel',
//         actif: true
//       },
//       {
//         universite_id: universites['Université d\'Antananarivo'],
//         nom: 'Droit',
//         code: 'DROIT-L',
//         domaine: 'Sciences Sociales',
//         specialite: 'Droit Général',
//         niveau: 'Licence',
//         duree_annees: 3,
//         cout_annuel: 800000,
//         langue: 'Français',
//         series_bac_acceptees: ['Littérature', 'Sciences Economiques'],
//         moyenne_min_requise: 11,
//         competences_requises: ['Français', 'Raisonnement', 'Analyse'],
//         centres_interet: ['Justice', 'Politique', 'Entreprise'],
//         difficulte: 'moyen',
//         taux_emploi: 75,
//         salaire_moyen_debutant: 1800000,
//         debouches: ['Avocat', 'Juge', 'Notaire', 'Juriste'],
//         description: 'Licence en Droit pour une carrière légale',
//         actif: true
//       },
//       {
//         universite_id: universites['Université d\'Antananarivo'],
//         nom: 'Médecine',
//         code: 'MED-L',
//         domaine: 'Sciences de la Santé',
//         specialite: 'Médecine Générale',
//         niveau: 'Doctorat',
//         duree_annees: 6,
//         cout_annuel: 3000000,
//         langue: 'Français/Anglais',
//         series_bac_acceptees: ['Sciences'],
//         moyenne_min_requise: 14,
//         competences_requises: ['Biologie', 'Chimie', 'Physique', 'Empathie'],
//         centres_interet: ['Santé', 'Biologie', 'Aider les gens'],
//         difficulte: 'tres_difficile',
//         taux_emploi: 99,
//         salaire_moyen_debutant: 4000000,
//         debouches: ['Médecin', 'Chirurgien', 'Médecin Généraliste'],
//         description: 'Doctorat en Médecine - Formation médicale complète',
//         actif: true
//       },
//       {
//         universite_id: universites['Université d\'Fianarantsoa'],
//         nom: 'Gestion d\'Entreprise',
//         code: 'GESTION-L',
//         domaine: 'Gestion & Commerce',
//         specialite: 'Management Général',
//         niveau: 'Licence',
//         duree_annees: 3,
//         cout_annuel: 1000000,
//         langue: 'Français',
//         series_bac_acceptees: ['Sciences Economiques', 'Littérature'],
//         moyenne_min_requise: 10,
//         competences_requises: ['Mathématiques', 'Leadership', 'Communication'],
//         centres_interet: ['Entreprise', 'Leadership', 'Innovation'],
//         difficulte: 'moyen',
//         taux_emploi: 88,
//         salaire_moyen_debutant: 2000000,
//         debouches: ['Gestionnaire', 'Manager', 'Entrepreneur'],
//         description: 'Licence en Gestion d\'Entreprise',
//         actif: true
//       },
//       {
//         universite_id: universites['École Supérieure Polytechnique d\'Antananarivo'],
//         nom: 'Génie Civil',
//         code: 'GENIE-CIVIL',
//         domaine: 'Ingénierie',
//         specialite: 'Construction',
//         niveau: 'Ingénieur',
//         duree_annees: 5,
//         cout_annuel: 2500000,
//         langue: 'Français',
//         series_bac_acceptees: ['Mathématiques', 'Sciences'],
//         moyenne_min_requise: 13,
//         competences_requises: ['Mathématiques', 'Physique', 'Dessin'],
//         centres_interet: ['Construction', 'Infrastructure', 'Innovation'],
//         difficulte: 'difficile',
//         taux_emploi: 95,
//         salaire_moyen_debutant: 3500000,
//         debouches: ['Ingénieur Civil', 'Chef de Chantier', 'Architecte'],
//         description: 'Diplôme d\'Ingénieur en Génie Civil',
//         actif: true
//       },
//       {
//         universite_id: universites['Université Catholique de Madagascar'],
//         nom: 'Théologie',
//         code: 'THEO-L',
//         domaine: 'Sciences Religieuses',
//         specialite: 'Théologie Catholique',
//         niveau: 'Master',
//         duree_annees: 2,
//         cout_annuel: 1500000,
//         langue: 'Français',
//         series_bac_acceptees: ['Littérature', 'Sciences Economiques'],
//         moyenne_min_requise: 11,
//         competences_requises: ['Français', 'Philosophie', 'Réflexion'],
//         centres_interet: ['Spiritualité', 'Enseignement', 'Pastorale'],
//         difficulte: 'moyen',
//         taux_emploi: 70,
//         salaire_moyen_debutant: 1500000,
//         debouches: ['Prêtre', 'Enseignant', 'Théologien'],
//         description: 'Master en Théologie pour formation religieuse',
//         actif: true
//       }
//     ];

//     const filieres = {};
//     for (const data of filieresData) {
//       const existing = await Filiere.findOne({ where: { nom: data.nom, universite_id: data.universite_id } });
//       if (!existing) {
//         const fil = await Filiere.create(data);
//         filieres[data.nom] = fil.id;
//       } else {
//         filieres[data.nom] = existing.id;
//       }
//     }
//     console.log(`✅ ${Object.keys(filieres).length} filières créées`);

//     // 5. Créer des parcours
//     console.log('🛤️ Création des parcours...');
//     const parcoursData = [
//       {
//         filiere_id: filieres['Informatique'],
//         nom: 'Développement Web',
//         code: 'DEV-WEB',
//         description: 'Spécialisation en développement web et applications mobiles',
//         duree_mois: 36,
//         specialisation: 'Web/Mobile',
//         competences_acquises: ['HTML/CSS', 'JavaScript', 'React', 'Node.js', 'Bases de données'],
//         debouches_professionnels: ['Développeur Web', 'Développeur Mobile', 'Full Stack Developer']
//       },
//       {
//         filiere_id: filieres['Informatique'],
//         nom: 'Cybersécurité',
//         code: 'CYBER-SEC',
//         description: 'Spécialisation en sécurité informatique',
//         duree_mois: 36,
//         specialisation: 'Cybersécurité',
//         competences_acquises: ['Sécurité Réseau', 'Cryptographie', 'Audit de Sécurité', 'Pentesting'],
//         debouches_professionnels: ['Analyste Sécurité', 'Consultant Sécurité', 'Pentest Engineer']
//       },
//       {
//         filiere_id: filieres['Droit'],
//         nom: 'Droit des Affaires',
//         code: 'DROIT-AFF',
//         description: 'Spécialisation en droit commercial et des affaires',
//         duree_mois: 36,
//         specialisation: 'Droit Affaires',
//         competences_acquises: ['Droit Commercial', 'Contrats', 'Droit des Sociétés'],
//         debouches_professionnels: ['Avocat d\'Affaires', 'Juriste Entreprise']
//       },
//       {
//         filiere_id: filieres['Médecine'],
//         nom: 'Médecine Générale',
//         code: 'MED-GEN',
//         description: 'Formation en médecine générale',
//         duree_mois: 72,
//         specialisation: 'Médecine Générale',
//         competences_acquises: ['Diagnostic', 'Traitement', 'Chirurgie', 'Pédiatrie'],
//         debouches_professionnels: ['Médecin Généraliste', 'Médecin en Cabinet']
//       }
//     ];

//     for (const data of parcoursData) {
//       const existing = await Parcours.findOne({ where: { filiere_id: data.filiere_id, nom: data.nom } });
//       if (!existing) {
//         await Parcours.create(data);
//       }
//     }
//     console.log(`✅ ${parcoursData.length} parcours créés`);

//     // 6. Créer les paramètres de plateforme
//     console.log('⚙️ Création des paramètres...');
//     const settingsExists = await Settings.findOne();
//     if (!settingsExists) {
//       await Settings.create({
//         platform_name: 'Skill2Study',
//         platform_description: 'Plateforme d\'aide à l\'orientation universitaire intelligente',
//         contact_email: 'contact@orientai.mg',
//         email_notifications: true,
//         moderation_alerts: true,
//         weekly_reports: false,
//         two_factor_auth: false,
//         open_registration: true,
//         email_verification: false,
//         maintenance_mode: false
//       });
//       console.log('✅ Paramètres créés');
//     }

//     // 7. Créer les règles de recommandation
//     console.log('🎯 Création des règles de recommandation...');
//     const rulesExists = await RecommendationRules.findOne({ where: { est_default: true } });
//     if (!rulesExists) {
//       await RecommendationRules.create({
//         nom: 'Règles par défaut',
//         description: 'Configuration standard du système de recommandation',
//         poids_serie: 25,
//         poids_moyenne: 20,
//         poids_interet: 20,
//         poids_competences: 15,
//         poids_budget: 10,
//         poids_duree: 5,
//         poids_test: 5,
//         moyenne_min_acceptable: 10,
//         filtre_eliminer_hors_serie: true,
//         filtre_eliminer_hors_budget: false,
//         top_n_recommendations: 10,
//         methode_scoring: 'pondere',
//         actif: true,
//         est_default: true,
//         version: '1.0'
//       });
//       console.log('✅ Règles de recommandation créées');
//     }

//     // 8. Créer des témoignages
//     console.log('💬 Création des témoignages...');
//     const testimonialsData = [
//       {
//         student_name: 'Rakoto Jean',
//         student_serie: 'Sciences',
//         university_name: 'Université d\'Antananarivo',
//         course_name: 'Informatique',
//         text: 'Skill2Study m\'a vraiment aidé à trouver la filière qui me convient. Les recommandations étaient très pertinentes!',
//         rating: 5,
//         status: 'Approuvé'
//       },
//       {
//         student_name: 'Andriamampoinimerina Sophie',
//         student_serie: 'Littérature',
//         university_name: 'Université de Fianarantsoa',
//         course_name: 'Gestion d\'Entreprise',
//         text: 'La plateforme est très intuitive et m\'a permis de comparer différentes filières facilement.',
//         rating: 4,
//         status: 'Approuvé'
//       },
//       {
//         student_name: 'Rasolomampionona Jean',
//         student_serie: 'Mathématiques',
//         university_name: 'École Supérieure Polytechnique d\'Antananarivo',
//         course_name: 'Génie Civil',
//         text: 'Les tests d\'orientation sont très utiles et les résultats correspondaient à mes attentes.',
//         rating: 5,
//         status: 'En attente'
//       }
//     ];

//     for (const data of testimonialsData) {
//       const existing = await Testimonial.findOne({ where: { student_name: data.student_name } });
//       if (!existing) {
//         await Testimonial.create(data);
//       }
//     }
//     console.log(`✅ ${testimonialsData.length} témoignages créés`);

//     // 9. Créer des questions de test
//     console.log('📋 Création des questions de test...');
//     const questionsData = [
//       {
//         texte: 'Quel type de travail vous intéresse le plus ?',
//         categorie: 'interet',
//         series_bac_cibles: null,
//         ordre: 1,
//         actif: true
//       },
//       {
//         texte: 'Vous êtes plutôt attiré par les technologies et l\'innovation ?',
//         categorie: 'interet',
//         series_bac_cibles: ['Sciences', 'Mathématiques'],
//         ordre: 2,
//         actif: true
//       },
//       {
//         texte: 'Quel est votre niveau en mathématiques ?',
//         categorie: 'competence',
//         series_bac_cibles: null,
//         ordre: 3,
//         actif: true
//       },
//       {
//         texte: 'Vous préférez une carrière en entreprise ou en libéral ?',
//         categorie: 'personnalite',
//         series_bac_cibles: null,
//         ordre: 4,
//         actif: true
//       }
//     ];

//     const questions = {};
//     for (const data of questionsData) {
//       const existing = await Question.findOne({ where: { texte: data.texte } });
//       if (!existing) {
//         const q = await Question.create(data);
//         questions[data.texte] = q.id;
//       } else {
//         questions[data.texte] = existing.id;
//       }
//     }
//     console.log(`✅ ${Object.keys(questions).length} questions créées`);

//     // 10. Créer des options de réponse
//     console.log('📝 Création des options de réponse...');
//     const optionsData = [
//       {
//         question_id: questions['Quel type de travail vous intéresse le plus ?'],
//         texte: 'Travail avec les nouvelles technologies',
//         poids: { technologie: 5, innovation: 4, programmation: 5 }
//       },
//       {
//         question_id: questions['Quel type de travail vous intéresse le plus ?'],
//         texte: 'Travail en contact avec les gens',
//         poids: { communication: 5, gestion: 3, empathie: 5 }
//       },
//       {
//         question_id: questions['Quel type de travail vous intéresse le plus ?'],
//         texte: 'Travail créatif et artistique',
//         poids: { creativite: 5, art: 5, design: 4 }
//       },
//       {
//         question_id: questions['Vous êtes plutôt attiré par les technologies et l\'innovation ?'],
//         texte: 'Oui, beaucoup',
//         poids: { technologie: 5, innovation: 5 }
//       },
//       {
//         question_id: questions['Vous êtes plutôt attiré par les technologies et l\'innovation ?'],
//         texte: 'Un peu',
//         poids: { technologie: 3, innovation: 2 }
//       },
//       {
//         question_id: questions['Vous êtes plutôt attiré par les technologies et l\'innovation ?'],
//         texte: 'Non pas vraiment',
//         poids: { technologie: 1, innovation: 0 }
//       },
//       {
//         question_id: questions['Quel est votre niveau en mathématiques ?'],
//         texte: 'Excellent',
//         poids: { mathematiques: 5 }
//       },
//       {
//         question_id: questions['Quel est votre niveau en mathématiques ?'],
//         texte: 'Bon',
//         poids: { mathematiques: 3 }
//       },
//       {
//         question_id: questions['Quel est votre niveau en mathématiques ?'],
//         texte: 'Moyen',
//         poids: { mathematiques: 1 }
//       },
//       {
//         question_id: questions['Vous préférez une carrière en entreprise ou en libéral ?'],
//         texte: 'En entreprise',
//         poids: { entreprise: 5, securite: 3 }
//       },
//       {
//         question_id: questions['Vous préférez une carrière en entreprise ou en libéral ?'],
//         texte: 'En libéral',
//         poids: { liberte: 5, entrepreneurship: 5 }
//       }
//     ];

//     for (const data of optionsData) {
//       const existing = await OptionReponse.findOne({
//         where: { question_id: data.question_id, texte: data.texte }
//       });
//       if (!existing) {
//         await OptionReponse.create(data);
//       }
//     }
//     console.log(`✅ ${optionsData.length} options de réponse créées`);

//     console.log('\n✅ ✅ ✅ Seeding terminé avec succès ! ✅ ✅ ✅\n');
//     console.log('📊 Données de test créées:');
//     console.log('  - 1 admin + 4 bacheliiers');
//     console.log('  - 5 universités');
//     console.log('  - 6 filières');
//     console.log('  - 4 parcours');
//     console.log('  - 3 témoignages');
//     console.log('  - 4 questions avec options\n');
//     console.log('🔐 Identifiants de connexion:');
//     console.log('  Admin: admin@orientai.mg / admin123456');
//     console.log('  Bachelier: martin.rakoto@email.mg / password123\n');
//   } catch (error) {
//     console.error('❌ Erreur lors du seeding:', error);
//     process.exit(1);
//   }
// };

// module.exports = seedDatabase;
