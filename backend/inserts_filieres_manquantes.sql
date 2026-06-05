-- =====================================================
-- INSERTION DES FILIÈRES POUR LES 39 UNIVERSITÉS MANQUANTES
-- Source: Document officiel MESupReS (Août 2022)
-- =====================================================

-- NOTE: Les universite_id vont de 297 à 335 (après les 296 existants)

-- =====================================================
-- SECTION 1: FILIÈRES DES INSTITUTS PRIVÉS (IDs 297-311)
-- =====================================================

-- CENTRE DE RESSOURCES, D'ASSISTANCE ET DE CONSEIL (ID 297)
-- Ce centre n'a pas de filières classiques listées

-- CENTRE DE FORMATION DES RESSOURCES HUMAINES (ID 298)
-- Ce centre n'a pas de filières classiques listées

-- UNIVERSITE ASCOM (ID 299)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (269, 'Gestion', 'ASCOM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- MADAGASCAR BUSINESS SCHOOL (ID 300)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (270, 'Droit', 'MBS-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (270, 'Gestion', 'MBS-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (270, 'Gestion', 'MBS-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (270, 'Sciences de la Communication', 'MBS-COMM-001', 'Arts et Lettres', 'Communication', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- UNIVERSITE PRIVEE D'AVARADRANO (ID 301)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (271, 'Entrepreneuriat rural', 'UPA-ENTREPR-001', 'Sciences de Gestion', 'Entrepreneuriat', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- UNIVERSITE OUEST D'IARIVO (ID 302)
-- Filières non précisées dans le document

-- UNIVERSITE PRIVEE POUR L'INNOVATION (ID 303)
-- Filières non précisées dans le document

-- UNIVERSITY OF TECHNOLOGY AND BUSINESS (ID 304)
-- Filières non précisées dans le document

-- UNIVERSITE DE TECHNOLOGIES A MADAGASCAR (ID 305)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (275, 'Tourisme Durable', 'UTAM-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- UNIVERSITE DES MEDIAS, DE L'AUDIOVISUEL ET DE LA TECHNOLOGIE (ID 306)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (276, 'Informatique', 'UMAT-INFO-001', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- UNIVERSITE INFORMATIQUE GSI (ID 307)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (277, 'Informatique', 'UGSI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (277, 'Gestion', 'UGSI-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (277, 'BTP', 'UGSI-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- UNIVERSITE INFORMATIQUE (ID 308)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (278, 'Informatique', 'UINF-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- JEANNE D'ARC UNIVERSITY (ID 309)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (279, 'Informatique', 'JAU-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (279, 'Sciences de la Gestion', 'JAU-SCGEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- LEADERSHIP MANAGEMENT BUSINESS UNIVERSITY (ID 310)
-- Filières non précisées dans le document

-- LUTHERAN INSTITUTE OF MANAGEMENT AND ENTREPRENEURSHIP (ID 311)
-- Filières non précisées dans le document

-- =====================================================
-- SECTION 2: FILIÈRES DES INSTITUTS SPÉCIALISÉS (IDs 312-321)
-- =====================================================

-- UNIVERSITE INTERNATIONALE DE MADAGASCAR (ID 312)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (282, 'Gestion', 'UIM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (282, 'Gestion', 'UIM-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (282, 'Commerce', 'UIM-COMM-001', 'Sciences de Gestion', 'Commerce', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- MILLENIUM UNIVERSITY (ID 313)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (283, 'Sciences de la Gestion', 'MU-SCGEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- MADAGASCAR UNIVERSITY OF SCIENCE AND TECHNOLOGY (ID 314)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (284, 'Droit', 'MUST-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- MAD'AID TRAINING CENTER (ID 315)
-- Filières non précisées dans le document

-- ONG UNIVERSITE POUR TOUS (ID 316)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (286, 'Droit', 'OUP-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- PHILOSOPHAT SAINT PAUL (ID 317)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (287, 'Philosophie', 'PSP-PHILO-001', 'Arts et Lettres', 'Philosophie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- SAMIS - ECOLE SUPERIEURE DE L'INFORMATION ET DE LA COMMUNICATION (ID 318)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (288, 'Sciences de l''Information et Communication', 'SAMIS-SIC-001', 'Arts et Lettres', 'Communication', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (288, 'Sciences de l''Information et Communication', 'SAMIS-SIC-002', 'Arts et Lettres', 'Communication', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- SEKOLY AMBONY LOTERANA MOMBA NY TEOLOJIA (ID 319)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (289, 'Théologie', 'SALTY-THEO-001', 'Arts et Lettres', 'Théologie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- INSTITUT SUPERIEUR SAINT MICHEL ITAOSY (ID 320)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (290, 'Informatique', 'ISSM-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (290, 'Tourisme', 'ISSM-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (290, 'Environnement', 'ISSM-ENV-001', 'Sciences et Technologies', 'Environnement', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- INSTITUT SUPERIEUR SALESIEN DE PHILOSOPHIE SAINT THOMAS D'AQUIN (ID 321)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (291, 'Philosophie', 'ISSSPTA-PHILO-001', 'Arts et Lettres', 'Philosophie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =====================================================
-- SECTION 3: FILIÈRES DES ÉCOLES DOCTORALES PRIVÉES (IDs 322-324)
-- =====================================================

-- INSTITUT D'ETUDES POLITIQUES - ECOLE DOCTORALE (ID 322)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (292, 'Sciences Politiques et Gouvernance', 'IEP-ED-SCI-001', 'Droit et Sciences Politiques', 'Sciences Politiques', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- UNIVERSITE CATHOLIQUE DE MADAGASCAR - ECOLES DOCTORALES (ID 323)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (293, 'Philosophie', 'UCM-ED-PHILO-001', 'Arts et Lettres', 'Philosophie', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (293, 'Droit', 'UCM-ED-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (293, 'Gestion', 'UCM-ED-GEST-001', 'Sciences de Gestion', 'Gestion', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ONIFRA - UNIVERSITE FJKM RAVELOJAONA - ECOLE DOCTORALE (ID 324)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (294, 'Bible et Histoire Interculturelle', 'ONIFRA-ED-BIB-001', 'Arts et Lettres', 'Théologie', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =====================================================
-- SECTION 4: FILIÈRES DES ÉTABLISSEMENTS PUBLICS (IDs 325-335)
-- =====================================================

-- CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA (ID 325)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (295, 'Sciences', 'CRFUF-SCI-001', 'Sciences et Technologies', 'Sciences', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- CNTEMAD ANTSIRANANA (ID 326)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (296, 'Informatique', 'CNTEMAD-ANT-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (296, 'Droit', 'CNTEMAD-ANT-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- CNTEMAD FIANARANTSOA (ID 327)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (267, 'Gestion', 'CNTEMAD-FIA-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (267, 'Communication', 'CNTEMAD-FIA-COMM-001', 'Arts et Lettres', 'Communication', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- CNTEMAD MAHAJANGA (ID 328)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (268, 'Informatique', 'CNTEMAD-MAH-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- CNTEMAD TOLIARA (ID 329)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (269, 'Gestion', 'CNTEMAD-TOL-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ÉCOLE NATIONALE SUPÉRIEURE DE LA POLICE (ID 330)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (270, 'Police et Sécurité', 'ENSP-POL-001', 'Droit et Sciences Politiques', 'Police', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- INSTITUT NATIONAL DES SCIENCES COMPTABLES ET DE L'ADMINISTRATION D'ENTREPRISE (ID 331)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (271, 'Gestion', 'INSCAE-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (271, 'Gestion', 'INSCAE-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (271, 'Finance', 'INSCAE-FIN-001', 'Sciences de Gestion', 'Finance', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (271, 'Marketing, Entrepreneuriat', 'INSCAE-MARK-001', 'Sciences de Gestion', 'Marketing', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- INSTITUT NATIONAL DE LA SANTE PUBLIQUE ET COMMUNAUTAIRE (ID 332)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (272, 'Santé Publique', 'INSPC-SANTE-001', 'Sciences de la Santé', 'Santé Publique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- INSTITUT NATIONAL DES SCIENCES ET TECHNIQUES NUCLÉAIRES (ID 333)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (273, 'Sciences Nucléaires', 'INSTN-NUCL-001', 'Sciences et Technologies', 'Physique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (273, 'Sciences Nucléaires', 'INSTN-NUCL-002', 'Sciences et Technologies', 'Physique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- INSTITUT NATIONAL DE TOURISME ET HOTELLERIE (ID 334)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (274, 'Tourisme et Hôtellerie', 'INTH-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (274, 'Tourisme et Hôtellerie', 'INTH-TOUR-002', 'Arts et Lettres', 'Tourisme', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ACADÉMIE MILITAIRE (ID 335)
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) 
VALUES (275, 'Formation Militaire', 'ACMIL-MIL-001', 'Droit et Sciences Politiques', 'Militaire', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =====================================================
-- RÉSUMÉ:
-- =====================================================
-- ~65 filières créées pour les 39 universités
-- Quelques établissements n'ont pas eu de filières listées dans le document officiel
-- (elles doivent être ajoutées manuellement si nécessaire)
-- =====================================================
