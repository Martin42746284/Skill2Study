-- =====================================================
-- INSERTION COMPLETE DES UNIVERSITES ET FILIERES
-- DOCUMENT: Liste des établissements d'enseignement supérieur Madagascar 2022
-- =====================================================

-- =====================================================
-- SECTION A: ETABLISSEMENTS PRIVES
-- =====================================================

-- 1. BUSINESS SCHOOL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('BUSINESS SCHOOL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (1, 'Informatique de Gestion', 'BS-INFOG-001', 'Sciences et Technologies', 'Informatique de Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (1, 'Gestion', 'BS-GEST-001', 'Sciences et Technologies', 'Gestion', 'Licence', true);

-- 2. ATHENEE SAINT JOSEPH ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ATHENEE SAINT JOSEPH ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Sciences Agronomiques', 'ASJA-AGRO-001', 'Sciences et Technologies', 'Sciences Agronomiques', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Sciences Agronomiques', 'ASJA-AGRO-002', 'Sciences et Technologies', 'Sciences Agronomiques', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Sciences de la Terre', 'ASJA-SCTERR-001', 'Sciences et Technologies', 'Sciences de la Terre', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Sciences de la Terre', 'ASJA-SCTERR-002', 'Sciences et Technologies', 'Sciences de la Terre', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Informatique', 'ASJA-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Informatique', 'ASJA-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Droit', 'ASJA-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Droit', 'ASJA-DROIT-002', 'Droit et Sciences Politiques', 'Droit', 'Master', true);

-- 3. CENTRE D'ETUDES, DE L'INFORMATION ET SES TECHNOLOGIES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('CENTRE D''ETUDES, DE L''INFORMATION ET SES TECHNOLOGIES', 'privee', 'Ambolokandrina', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (3, 'Informatique', 'CEIST-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 4. CENTRE ECOLOGIQUE DE LIBANONA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('CENTRE ECOLOGIQUE DE LIBANONA', 'privee', 'Fort-Dauphin', 'Anosy', true);

-- 5. CFAMA - CENTRE DE FORMATION ET D'APPLICATION DU MACHINISME AGRICOLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('CFAMA - CENTRE DE FORMATION ET D''APPLICATION DU MACHINISME AGRICOLE', 'privee', 'Antsirabe', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (5, 'Sciences Agronomiques', 'CFAMA-AGRO-001', 'Sciences et Technologies', 'Sciences Agronomiques', 'Licence', true);

-- 6. CONSERVATOIRE NATIONAL DES ARTS ET METIERS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('CONSERVATOIRE NATIONAL DES ARTS ET METIERS', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (6, 'Sciences Industrielles', 'CNAM-SIND-001', 'Sciences et Technologies', 'Sciences Industrielles', 'Master', true);

-- 7. ECOLE DE COMPTABILITE ET D'ADMINISTRATION TARATRA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DE COMPTABILITE ET D''ADMINISTRATION TARATRA', 'privee', 'Fianarantsoa', 'Vakinankaratra', true);

-- 8. EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY', 'privee', 'Antanetibe', 'Analamanga', true);

-- 9. ETABLISSEMENT D'ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE SUPERIEURE CONDORCET
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT D''ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE SUPERIEURE CONDORCET', 'privee', 'Faravohitra', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (9, 'Technologie', 'CONDORCET-TECH-001', 'Sciences et Technologies', 'Technologie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (9, 'Technologie', 'CONDORCET-TECH-002', 'Sciences et Technologies', 'Technologie', 'Master', true);

-- 10. ECOLE PROFESSIONNELLE SUPERIEURE AGRICOLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE PROFESSIONNELLE SUPERIEURE AGRICOLE', 'privee', 'Bevalala', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (10, 'Sciences Agronomiques', 'EPSA-AGRO-001', 'Sciences et Technologies', 'Sciences Agronomiques', 'Licence', true);

-- 11. ETABLISSEMENT PRIVE D'ENSEIGNEMENT SUPERIEUR LUMIERE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT PRIVE D''ENSEIGNEMENT SUPERIEUR LUMIERE', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (11, 'Gestion et Administration d''Entreprises', 'EPSL-GADM-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (11, 'Banque et Institutions de Microfinance', 'EPSL-BANQ-001', 'Sciences de Gestion', 'Banque', 'Licence', true);

-- 12. ECOLE SUPERIEURE DE BATIMENT ET TRAVAUX PUBLICS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE BATIMENT ET TRAVAUX PUBLICS', 'privee', 'Ampasanimalo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (12, 'BTP', 'ESBTP-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true);

-- 13. ECOLE SUPERIEURE DE COMMERCE ET TECHNIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE COMMERCE ET TECHNIQUE', 'privee', 'Analamahitsy', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (13, 'Commerce', 'ESCT-COMM-001', 'Sciences de Gestion', 'Commerce', 'Licence', true);

-- 14. ECOLE SUPERIEURE DE DROIT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE DROIT', 'privee', 'Nanisana', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (14, 'Droit et Sciences Politiques', 'ESD-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);

-- 15. ECOLE SUPERIEURE DE DEVELOPPEMENT ECONOMIQUE ET SOCIAL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE DEVELOPPEMENT ECONOMIQUE ET SOCIAL', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (15, 'Travail Social', 'ESDEES-TRAVS-001', 'Sciences et Technologies', 'Travail Social', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (15, 'Travail Social', 'ESDEES-TRAVS-002', 'Sciences et Technologies', 'Travail Social', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (15, 'Gestion', 'ESDEES-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 16. ECOLE SUPERIEURE D'INFORMATIQUE ET DE GESTION DES ENTREPRISES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE D''INFORMATIQUE ET DE GESTION DES ENTREPRISES', 'privee', 'Mahajanga', 'Boeny', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (16, 'Gestion', 'ESIGE-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (16, 'Gestion', 'ESIGE-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (16, 'Sciences de Gestion', 'ESIGE-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (16, 'Droit', 'ESIGE-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (16, 'Informatique', 'ESIGE-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (16, 'Droit et Sciences Politiques', 'ESIGE-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true);

-- 17. ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE MANAGEMENT ET D''INFORMATIQUE APPLIQUEE', 'privee', 'Mahamasina Atsimo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (17, 'Gestion', 'ESMIAP-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (17, 'Informatique', 'ESMIAP-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 18. ETABLISSEMENT SUPERIEUR PROFESSIONNEL BUREAUTIQUE, INFORMATIQUE ET GESTION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT SUPERIEUR PROFESSIONNEL BUREAUTIQUE, INFORMATIQUE ET GESTION', 'privee', 'Behoririka', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (18, 'Gestion', 'ESPBIG-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (18, 'Informatique', 'ESPBIG-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 19. ECOLE SUPERIEURE PROFESSIONNELLE EN INFORMATIQUE ET COMMERCE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE PROFESSIONNELLE EN INFORMATIQUE ET COMMERCE', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (19, 'Gestion', 'ESPIC-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (19, 'Gestion', 'ESPIC-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (19, 'Sciences de Gestion', 'ESPIC-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Master', true);

-- 20. ECOLE SUPERIEURE SPECIALISEE EN DROIT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE SPECIALISEE EN DROIT', 'privee', 'Ankatso', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (20, 'Droit', 'ESSD-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);

-- 21. ECOLE SUPERIEURE SAINT GABRIEL MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE SAINT GABRIEL MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (21, 'Commerce et Gestion', 'ESSGM-COMGEST-001', 'Sciences de Gestion', 'Commerce et Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (21, 'Commerce et Gestion', 'ESSGM-COMGEST-002', 'Sciences de Gestion', 'Commerce et Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (21, 'Droit', 'ESSGM-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);

-- 22. ECOLE SUPERIEURE SPECIALISEE DE VAKINAKARATRA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE SPECIALISEE DE VAKINAKARATRA', 'privee', 'Antsirabe', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (22, 'Gestion Management', 'ESSV-GESTM-001', 'Sciences de Gestion', 'Gestion Management', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (22, 'Communication et Journalisme', 'ESSV-COMMJ-001', 'Arts et Lettres', 'Communication et Journalisme', 'Licence', true);

-- 23. ECOLE SUPERIEURE DE TECHNOLOGIE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE TECHNOLOGIE', 'privee', 'Faravohitra', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (23, 'Informatique', 'EST-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 24. ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE TECHNOLOGIES DE L''INFORMATION', 'privee', 'Antanimena', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (24, 'Informatique', 'ESTI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 25. ENGINEERING SCHOOL OF TOURISM, INFORMATICS, INTERPRETERSHIP AND MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ENGINEERING SCHOOL OF TOURISM, INFORMATICS, INTERPRETERSHIP AND MANAGEMENT', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (25, 'Droit', 'ESTIIM-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (25, 'Droit et Sciences Politiques', 'ESTIIM-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (25, 'Gestion', 'ESTIIM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (25, 'Administration, Management, Commerce, Marketing', 'ESTIIM-ADMM-001', 'Sciences de Gestion', 'Management', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (25, 'Administration, Management, Commerce, Marketing', 'ESTIIM-ADMM-002', 'Sciences de Gestion', 'Management', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (25, 'Environnement', 'ESTIIM-ENV-001', 'Sciences et Technologies', 'Environnement', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (25, 'Environnement', 'ESTIIM-ENV-002', 'Sciences et Technologies', 'Environnement', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (25, 'Informatique', 'ESTIIM-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 26. ECOLE SUPERIEURE DE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE MANAGEMENT', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (26, 'Informatique', 'ESM-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (26, 'Gestion', 'ESM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (26, 'Statistique', 'ESM-STAT-001', 'Sciences et Technologies', 'Statistique', 'Licence', true);

-- 27. EDUCATION IN TRAINING, EMPLOYMENT AND COMMUNICATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('EDUCATION IN TRAINING, EMPLOYMENT AND COMMUNICATION', 'privee', 'Faravohitra', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (27, 'Administration, Gestion, Finances, Informatique de Gestion', 'ETEC-ADMG-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (27, 'Administration, Gestion, Finances, Informatique de Gestion', 'ETEC-ADMG-002', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 28. ETABLISSEMENT TECHNIQUE DE FORMATION PROFESSIONNELLE SUPERIEURE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT TECHNIQUE DE FORMATION PROFESSIONNELLE SUPERIEURE', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (28, 'Maintenance', 'ETFPS-MAINT-001', 'Sciences et Technologies', 'Maintenance', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (28, 'Informatique', 'ETFPS-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 29. ETABLISSEMENT TECHNIQUE SUPERIEUR SAINT MICHEL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT TECHNIQUE SUPERIEUR SAINT MICHEL', 'privee', 'Amparibe', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (29, 'Industriel', 'ETSM-IND-001', 'Sciences et Technologies', 'Technologie Industrielle', 'Licence', true);

-- 30. ESPACE UNIVERSITAIRE REGIONAL DE L'OCEAN INDIEN
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ESPACE UNIVERSITAIRE REGIONAL DE L''OCEAN INDIEN', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (30, 'Ingenierie et Management des Actions de Developpement', 'EUIOI-INGM-001', 'Arts et Lettres', 'Management', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (30, 'Ingenierie et Management des Actions de Developpement', 'EUIOI-INGM-002', 'Arts et Lettres', 'Management', 'Master', true);

-- 31. GRAND SEMINAIRE SAINT PAUL APOTRE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('GRAND SEMINAIRE SAINT PAUL APOTRE', 'privee', 'Antsirabe', 'Vakinankaratra', true);

-- 32. GATE UNIVERSITY AMBOHIDRATRIMO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('GATE UNIVERSITY', 'privee', 'Ambohidratrimo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (32, 'Gestion', 'GATE-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (32, 'Gestion', 'GATE-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (32, 'Tourisme', 'GATE-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (32, 'Agronomie', 'GATE-AGRO-001', 'Sciences et Technologies', 'Agronomie', 'Licence', true);

-- 33. HAUTES ETUDES CHRETIENNES DE MANAGEMENT ET DE MATHEMATIQUES APPLIQUEES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('HAUTES ETUDES CHRETIENNES DE MANAGEMENT ET DE MATHEMATIQUES APPLIQUEES', 'privee', 'Alarobia Amboniloha', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (33, 'Management et Sciences', 'HECMM-MGTS-001', 'Sciences de Gestion', 'Management', 'Master', true);

-- 34. HAUTES ETUDES EN DROIT ET EN MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('HAUTES ETUDES EN DROIT ET EN MANAGEMENT', 'privee', 'Soanierana', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (34, 'Sciences de Gestion', 'HEDM-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (34, 'Sciences juridiques', 'HEDM-SCJUR-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);

-- 35. INSTITUT CATHOLIQUE NOTRE DAME
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT CATHOLIQUE NOTRE DAME', 'privee', 'Mahajanga', 'Boeny', true);

-- 36. INSTITUTION CHRETIENNE DE TSIENIMPARIHY, UNIE PAR LE SAUVEUR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUTION CHRETIENNE DE TSIENIMPARIHY, UNIE PAR LE SAUVEUR', 'privee', 'Ambalavao', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (36, 'Informatique', 'ICTUS-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (36, 'Gestion', 'ICTUS-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 37. INSTITUT D'ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT D''ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE', 'privee', 'Ambatomitsangana', 'Analamanga', true);

-- 38. INSTITUT D'ETUDES POLITIQUES MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT D''ETUDES POLITIQUES MADAGASCAR', 'privee', 'Ampandrana Ouest', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (38, 'Sciences Politiques', 'IEP-SCPOL-001', 'Droit et Sciences Politiques', 'Sciences Politiques', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (38, 'Sciences Politiques', 'IEP-SCPOL-002', 'Droit et Sciences Politiques', 'Sciences Politiques', 'Master', true);

-- 39. INSTITUT D'ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT D''ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D''ENTREPRISE', 'privee', 'Antaninandro', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (39, 'Gestion', 'IESTIM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (39, 'Gestion', 'IESTIM-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (39, 'Sciences de Gestion', 'IESTIM-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (39, 'Sciences de l''Informatique', 'IESTIM-SCINFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 40. INSTITUT D'ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT D''ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D''ENTREPRISE ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (40, 'Gestion', 'IESTIMA-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (40, 'Gestion', 'IESTIMA-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 41. INSTITUT DE FORMATION EN AGRONOMIE, GEMMOLOGIE, INDUSTRIALISATION ET PARAMED
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION EN AGRONOMIE, GEMMOLOGIE, INDUSTRIALISATION ET PARAMED', 'privee', 'Antananarivo', 'Analamanga', true);

-- 42. INSTITUT DE FORMATION PROFESSIONNELLE RAKETAMANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PROFESSIONNELLE RAKETAMANGA', 'privee', 'Antananarivo', 'Analamanga', true);

-- 43. INSTITUT DE FORMATION ET DES RECHERCHES PEDAGOGIQUES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION ET DES RECHERCHES PEDAGOGIQUES', 'privee', 'Ambodin''Andohalo', 'Analamanga', true);

-- 44. INSTITUT DE FORMATION TECHNIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (44, 'Droit', 'IFT-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (44, 'Informatique', 'IFT-INFO-001', 'Sciences et Technologies', 'Informatique', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (44, 'Information-Communication-Journalisme', 'IFT-INFCOM-001', 'Arts et Lettres', 'Communication', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (44, 'Sciences de l''Environnement', 'IFT-SCENV-001', 'Sciences et Technologies', 'Environnement', 'Master', true);

-- 45. INSTITUT DE FORMATION TECHNIQUE ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (45, 'Informatique', 'IFTA-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 46. INSTITUT DE FORMATION TECHNIQUE BTP
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE BTP', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (46, 'BTP', 'IFTBTP-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true);

-- 47. INSTITUT DE FORMATION TECHNIQUE MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (47, 'Sciences de l''Environnement', 'IFTMJ-SCENV-001', 'Sciences et Technologies', 'Environnement', 'Licence', true);

-- 48. INSTITUT DE FORMATION TECHNIQUE TOAMASINA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE TOAMASINA', 'privee', 'Toamasina', 'Atsinanana', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (48, 'Informatique', 'IFTT-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (48, 'BTP', 'IFTT-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true);

-- 49. INSTITUT DE GEOGRAPHIE DE LA SOFIA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE GEOGRAPHIE DE LA SOFIA', 'privee', 'Antananarivo', 'Analamanga', true);

-- 50. INSTITUT INTERNATIONAL DES SCIENCES SOCIALES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT INTERNATIONAL DES SCIENCES SOCIALES', 'privee', 'Tsimbazaza', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (50, 'Sciences et Technologies', 'IISS-SCTECH-001', 'Sciences et Technologies', 'Sciences', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (50, 'Sciences et Technologies', 'IISS-SCTECH-002', 'Sciences et Technologies', 'Sciences', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (50, 'Arts et Lettres', 'IISS-ARTLETT-001', 'Arts et Lettres', 'Arts et Lettres', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (50, 'Arts et Lettres', 'IISS-ARTLETT-002', 'Arts et Lettres', 'Arts et Lettres', 'Master', true);

-- 51. INSTITUT DE LEADERSHIP CHRETIEN
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE LEADERSHIP CHRETIEN', 'privee', 'Antaninandro', 'Analamanga', true);

-- 52. IMAGE APPLI
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('IMAGE APPLI', 'privee', 'Antananarivo', 'Analamanga', true);

-- 53. INSTITUT DE MANAGEMENT DES ARTS ET METIERS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE MANAGEMENT DES ARTS ET METIERS', 'privee', 'Ivandry', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (53, 'Sciences Biologiques et environnementales', 'IMAM-SCBENV-001', 'Sciences et Technologies', 'Sciences Biologiques', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (53, 'Administration', 'IMAM-ADM-001', 'Sciences de Gestion', 'Administration', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (53, 'Management d''Entreprise et Banque', 'IMAM-MGTB-001', 'Sciences de Gestion', 'Management', 'Master', true);

-- 54. INSTITUTE OF MANAGEMENT AND TOURISM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUTE OF MANAGEMENT AND TOURISM', 'privee', 'Antanimena', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (54, 'Hotel and Tourism Management', 'IMT-HOTM-001', 'Arts et Lettres', 'Tourisme', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (54, 'Hotel and Tourism Management', 'IMT-HOTM-002', 'Arts et Lettres', 'Tourisme', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (54, 'Management and Business Studies', 'IMT-MBS-001', 'Sciences de Gestion', 'Management', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (54, 'Management and Business Studies', 'IMT-MBS-002', 'Sciences de Gestion', 'Management', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (54, 'Building and Public Work', 'IMT-BPW-001', 'Sciences et Technologies', 'BTP', 'Licence', true);

-- 55. INSTITUT DES ARTS ET DES TECHNOLOGIES AVANCEES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DES ARTS ET DES TECHNOLOGIES AVANCEES', 'privee', 'Ankadivato', 'Analamanga', true);

-- 56. INSTITUT DE FORMATION EN TOURISME
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION EN TOURISME', 'privee', 'Ankadivato', 'Analamanga', true);

-- 57. INFOTOUR - INSTITUT DE FORMATION EN TOURISME
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INFOTOUR - INSTITUT DE FORMATION EN TOURISME', 'privee', 'Mahajanga', 'Boeny', true);

-- 58. INSIDE UNIVERSITY ROSSIGNOL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSIDE UNIVERSITY ROSSIGNOL', 'privee', 'Ambondrona', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (58, 'Gestion', 'IUR-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (58, 'Gestion', 'IUR-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (58, 'Droit', 'IUR-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (58, 'Droit', 'IUR-DROIT-002', 'Droit et Sciences Politiques', 'Droit', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (58, 'Informatique', 'IUR-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 59. INSPNMAD ANALAMANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSPNMAD ANALAMANGA', 'privee', 'Ambaranjana', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (59, 'Banque et Institutions des micros finances', 'INSPNMAD-BANQ-001', 'Sciences de Gestion', 'Banque', 'Master', true);

-- 60. INSPNMAD MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSPNMAD MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true);

-- 61. INSTITUTE OF TECHNICAL TECHNOLOGY, LIVING AND INTERDISCIPLINARY ARTS OF MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUTE OF TECHNICAL TECHNOLOGY, LIVING AND INTERDISCIPLINARY ARTS OF MADAGASCAR', 'privee', 'Andranovory', 'Analamanga', true);

-- 62. IVON-TOERAM-PAMPIANARANA AMBONY MOMBA NY EOKOMENISMA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('IVON-TOERAM-PAMPIANARANA AMBONY MOMBA NY EOKOMENISMA', 'privee', 'Anjohy', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (62, 'Gestion', 'ITPAME-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 63. INSTITUT PRIVE AL MOUSTAPHA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT PRIVE AL MOUSTAPHA', 'privee', 'Ambohitrarahaba', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (63, 'Gestion', 'IPAM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 64. INSTITUT PROFESSIONNEL SUPERIEUR EN AGRONOMIE ET EN TECHNOLOGIE DE TOMBOTSOA ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT PROFESSIONNEL SUPERIEUR EN AGRONOMIE ET EN TECHNOLOGIE DE TOMBOTSOA ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (64, 'Agronomie', 'IPSATTA-AGRO-001', 'Sciences et Technologies', 'Agronomie', 'Licence', true);

-- 65. INSTITUT SUPERIEUR D'AMBATOMIRAHAVANY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR D''AMBATOMIRAHAVANY', 'privee', 'Ambatomirahavavy', 'Vakinankaratra', true);

-- 66. INSTITUT EN ADMINISTRATION D'ENTREPRISE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT EN ADMINISTRATION D''ENTREPRISE CABINET ATOMIC', 'privee', 'Ankatso', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (66, 'Management', 'IAEAC-MGT-001', 'Sciences de Gestion', 'Management', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (66, 'Communication et Journalisme', 'IAEAC-COMMJ-001', 'Arts et Lettres', 'Communication', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (66, 'Gestion', 'IAEAC-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 67. INSTITUT SUPERIEUR POUR L'AVENIR DES POLYTECHNICIENS ET DE LA SANTE PUBLIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR POUR L''AVENIR DES POLYTECHNICIENS ET DE LA SANTE PUBLIQUE', 'privee', 'Ambanja', 'Diana', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (67, 'Informatique', 'ISAPSP-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 68. INSTITUT SUPERIEUR ATOUT TOURISME MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR ATOUT TOURISME MADAGASCAR', 'privee', 'Ankorahotra', 'Analamanga', true);

-- 69. INSTITUT SUPERIEUR DE LA COMMUNICATION DES AFFAIRES ET DE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE LA COMMUNICATION DES AFFAIRES ET DE MANAGEMENT', 'privee', 'Ankadifotsy', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (69, 'Gestion', 'ISCAM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (69, 'Gestion', 'ISCAM-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 70. INSTITUT SUPERIEUR CATHOLIQUE DU MENABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR CATHOLIQUE DU MENABE', 'privee', 'Morondava', 'Menabe', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (70, 'Informatique', 'ISCM-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 71. INSTITUT SUPERIEUR POUR LE DEVELOPPEMENT DE L'ENTREPRENARIAT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR POUR LE DEVELOPPEMENT DE L''ENTREPRENARIAT', 'privee', 'Antananarivo', 'Analamanga', true);

-- 72. INSTITUT SUPERIEUR POUR L'ENTREPRENEURIAT, LE COMMERCE ET LE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR POUR L''ENTREPRENEURIAT, LE COMMERCE ET LE MANAGEMENT', 'privee', 'Ampasamadinika', 'Analamanga', true);

-- 73. INSTITUT SUPERIEUR D'ENSEIGNEMENT TECHNOLOGIQUE ET DES SCIENCES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR D''ENSEIGNEMENT TECHNOLOGIQUE ET DES SCIENCES', 'privee', 'Ambohidahy Ankadindramamy', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (73, 'Communication', 'ISETES-COMM-001', 'Arts et Lettres', 'Communication', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (73, 'Gestion', 'ISETES-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 74. INSTITUT SUPERIEUR DE GENIE ELECTRONIQUE INFORMATIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE GENIE ELECTRONIQUE INFORMATIQUE', 'privee', 'Ampandrana Ouest', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (74, 'Informatique', 'ISGEI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (74, 'Informatique', 'ISGEI-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true);

-- 75. INSTITUT SUPERIEUR DE GEOLOGIE DE L'INGENIEUR ET DE L'ENVIRONNEMENT DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE GEOLOGIE DE L''INGENIEUR ET DE L''ENVIRONNEMENT DE MADAGASCAR', 'privee', 'Ankadivato', 'Analamanga', true);

-- 76. INSTITUT SUPERIEUR DE L'INNOVATION D'ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE L''INNOVATION D''ANTSIRANANA', 'privee', 'Antsiranana', 'Diana', true);

-- 77. INSTITUT SUPERIEUR D'ELECTRONIQUE ET DE SYSTEME INFORMATIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR D''ELECTRONIQUE ET DE SYSTEME INFORMATIQUE', 'privee', 'Antananarivo', 'Analamanga', true);

-- 78. INSTITUT SUPERIEUR D'INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR D''INFORMATIQUE ET DE MANAGEMENT D''ENTREPRISE', 'privee', 'Betongolo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (78, 'Gestion Informatique', 'ISIIME-GESTINFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (78, 'Gestion Informatique', 'ISIIME-GESTINFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (78, 'Gestion', 'ISIIME-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 79. INSTITUT SUPERIEUR EN INFORMATIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR EN INFORMATIQUE', 'privee', 'Ampasamadinika', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (79, 'Informatique', 'ISI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (79, 'Informatique', 'ISI-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true);

-- 80. INSTITUT SUPERIEUR DE L'INGENIERIE ET DES TECHNIQUES DE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE L''INGENIERIE ET DES TECHNIQUES DE MANAGEMENT', 'privee', 'Antananarivo', 'Analamanga', true);

-- 81. INSTITUT SUPERIEUR DES METIERS DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DES METIERS DE MADAGASCAR', 'privee', 'Ambohimitsimbina', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (81, 'Technologie', 'ISM2M-TECH-001', 'Sciences et Technologies', 'Technologie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (81, 'Technologie', 'ISM2M-TECH-002', 'Sciences et Technologies', 'Technologie', 'Master', true);

-- 82. INSTITUT SUPERIEUR EN MANAGEMENT ET DU DEVELOPPEMENT D'ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR EN MANAGEMENT ET DU DEVELOPPEMENT D''ANTSIRANANA', 'privee', 'Antsiranana', 'Diana', true);

-- 83. INSTITUT UNIVERSITAIRE POLYTECHNIQUE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT UNIVERSITAIRE POLYTECHNIQUE DE MADAGASCAR', 'privee', 'Ambohijatovo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (83, 'Gestion', 'IUPM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (83, 'Gestion', 'IUPM-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (83, 'Tourisme', 'IUPM-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (83, 'Droit', 'IUPM-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);

-- 84. INSTITUT SUPERIEUR MONSEIGNEUR RAMAROSANDRATANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR MONSEIGNEUR RAMAROSANDRATANA', 'privee', 'Miarinarivo', 'Vakinankaratra', true);

-- 85. INSTITUT SUPERIEUR DE MANAGEMENT ET DES SCIENCES TECHNOLOGIQUES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE MANAGEMENT ET DES SCIENCES TECHNOLOGIQUES', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (85, 'Gestion en Administration d''Entreprise', 'ISMST-GADM-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (85, 'Droit et Sciences Politiques', 'ISMST-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (85, 'Droit des Affaires et Administration d''Entreprises', 'ISMST-DROITAFF-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true);

-- 86. INSTITUT SUPERIEUR DE MANAGEMENT ET DE TECHNOLOGIE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE MANAGEMENT ET DE TECHNOLOGIE', 'privee', 'Fianarantsoa', 'Vakinankaratra', true);

-- 87. INSTITUT SUPERIEUR NUMERIQUE D'ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR NUMERIQUE D''ANTANANARIVO', 'privee', 'Antetezana Bongatsara', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (87, 'Gestion', 'ISNA-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 88. INSTITUT SUPERIEUR NORD MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR NORD MADAGASCAR', 'privee', 'Antsiranana', 'Diana', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (88, 'Gestion', 'ISNM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 89. INSTITUT SUPERIEUR DE PEDAGOGIE D'ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE PEDAGOGIE D''ANTANANARIVO', 'privee', 'Antamponankatso', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (89, 'Sciences de l''Education', 'ISPA-SCEDUC-001', 'Sciences de l''Education', 'Sciences de l''Education', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (89, 'Sciences de la Vie et de la Terre', 'ISPA-SCVT-001', 'Sciences et Technologies', 'Sciences de la Vie et Terre', 'Licence', true);

-- 90. INSTITUT SUPERIEUR PRIVE AGRICOLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PRIVE AGRICOLE', 'privee', 'Ampandrianomby', 'Analamanga', true);

-- 91. INSTITUT SUPERIEUR POLYTECHNIQUE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR POLYTECHNIQUE DE MADAGASCAR', 'privee', 'Ambatomaro Antsobolo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (91, 'Droit et Technique des Affaires', 'ISPM-DROITAFF-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (91, 'Technique du Tourisme', 'ISPM-TECHTOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (91, 'Technique du Tourisme', 'ISPM-TECHTOUR-002', 'Arts et Lettres', 'Tourisme', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (91, 'Technique de l''environnement et du Tourisme', 'ISPM-TECHENVTOUR-001', 'Sciences et Technologies', 'Environnement', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (91, 'Environnement et Tourisme', 'ISPM-ENVTOUR-001', 'Sciences et Technologies', 'Environnement', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (91, 'Biotechnologies', 'ISPM-BIOTECH-001', 'Sciences et Technologies', 'Biotechnologies', 'Master', true);

-- 92. INSTITUT SUPERIEUR PRIVE MADAGASCAR DEVELOPPEMENT FORMATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PRIVE MADAGASCAR DEVELOPPEMENT FORMATION', 'privee', 'Isoraka', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (92, 'Gestion et Commerce International', 'ISPMDDF-GCOMINT-001', 'Sciences de Gestion', 'Commerce', 'Licence', true);

-- 93. INSTITUT SUPERIEUR PROTESTANT PAUL MINAULT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PROTESTANT PAUL MINAULT', 'privee', 'Ambohijatovo Atsimo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (93, 'Technologie', 'ISPPM-TECH-001', 'Sciences et Technologies', 'Technologie', 'Licence', true);

-- 94. INSTITUT SUPERIEUR PRIVE DE LA REGION DIANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PRIVE DE LA REGION DIANA', 'privee', 'Antsiranana', 'Diana', true);

-- 95. INSTITUT SUPERIEUR DES POLYTECHNICIENS DE LA REGION D'ITASY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DES POLYTECHNICIENS DE LA REGION D''ITASY', 'privee', 'Analavory', 'Itasy', true);

-- 96. INSTITUT SUPERIEUR DES SCIENCES DE DEVELOPPEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DES SCIENCES DE DEVELOPPEMENT', 'privee', 'Fianarantsoa', 'Vakinankaratra', true);

-- 97. INSTITUT SUPERIEUR EN SCIENCES DE L'ENVIRONNEMENT ET DE GESTION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR EN SCIENCES DE L''ENVIRONNEMENT ET DE GESTION', 'privee', 'Soanierana', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (97, 'Sciences de l''Environnement', 'ISLEG-SCENV-001', 'Sciences et Technologies', 'Environnement', 'Licence', true);

-- 98. INSTITUT SUPERIEUR SPECIALISE EN INFORMATIQUE ET EN GESTION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR SPECIALISE EN INFORMATIQUE ET EN GESTION', 'privee', 'Soavimbahoaka', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (98, 'Gestion', 'ISSIG-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 99. INSTITUT SUPERIEUR SAINT MICHEL ITAOSY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR SAINT MICHEL ITAOSY', 'privee', 'Itaosy', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (99, 'Informatique', 'ISSMI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (99, 'Informatique', 'ISSMI-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (99, 'Tourisme, Environnement', 'ISSMI-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true);

-- 100. INSTITUT SUPERIEUR SALESIEN DE PHILOSOPHIE SAINT THOMAS D'AQUIN
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR SALESIEN DE PHILOSOPHIE SAINT THOMAS D''AQUIN', 'privee', 'Fianarantsoa', 'Vakinankaratra', true);

-- 101. INSTITUT SUPERIEUR DE SPECIALISATION EN SCIENCES DE GESTION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE SPECIALISATION EN SCIENCES DE GESTION GROUPE EMIR CONSULTING', 'privee', 'Ankasina', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (101, 'Gestion', 'ISSG-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 102. INSTITUT SUPERIEUR PRIVE PROFESSIONNEL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PRIVE PROFESSIONNEL', 'privee', 'Behoririka', 'Analamanga', true);

-- 103. INSTITUT SUPERIEUR DE TECHNOLOGIES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE TECHNOLOGIES', 'privee', 'Manakara', 'Vakinankaratra', true);

-- 104. INSTITUT SUPERIEUR DE TECHNOLOGIE INDUSTRIEL ET DE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE TECHNOLOGIE INDUSTRIEL ET DE MANAGEMENT', 'privee', 'Antsiranana', 'Diana', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (104, 'Gestion d''Entreprise et des Administrations', 'ISTIM-GADM-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (104, 'Management des Entreprises', 'ISTIM-MGT-001', 'Sciences de Gestion', 'Management', 'Licence', true);

-- 105. INSTITUT SUPERIEUR DE TECHNOLOGIE REGIONAL DE FITOVINANY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE TECHNOLOGIE REGIONAL DE FITOVINANY', 'privee', 'Manakara', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (105, 'Sciences Agronomiques et Halieutiques', 'ISTRF-SCAGH-001', 'Sciences et Technologies', 'Agronomie', 'Licence', true);

-- 106. INSTITUT SUPERIEUR DE TRAVAIL SOCIAL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE TRAVAIL SOCIAL', 'privee', 'Iavoloha', 'Analamanga', true);

-- 107. INSTITUT TECHNIQUE SUPERIEUR AGRICOLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT TECHNIQUE SUPERIEUR AGRICOLE', 'privee', 'Antady Fianarantsoa', 'Vakinankaratra', true);

-- 108. INSTITUT TECHNIQUE SUPERIEUR FRANCOIS XAVIER
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT TECHNIQUE SUPERIEUR FRANCOIS XAVIER', 'privee', 'Antady Fianarantsoa', 'Vakinankaratra', true);

-- 109. INFORMATION TECHNOLOGY UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INFORMATION TECHNOLOGY UNIVERSITY', 'privee', 'Andoharanofotsy', 'Analamanga', true);

-- 110. INSTITUT UNIVERSITAIRE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT UNIVERSITAIRE DE MADAGASCAR', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (110, 'Gestion et Commerce', 'IUM-GCOM-001', 'Sciences de Gestion', 'Commerce', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (110, 'Gestion', 'IUM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 111. INSTITUT UNIVERSITAIRE PROFESSIONNEL EN ADMINISTRATION D'ENTREPRISE ET EN SCIENCES MARINES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT UNIVERSITAIRE PROFESSIONNEL EN ADMINISTRATION D''ENTREPRISE ET EN SCIENCES MARINES', 'privee', 'Nosy Be', 'Diana', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (111, 'Administration d''Entreprise', 'IUPAEM-ADM-001', 'Sciences de Gestion', 'Administration', 'Licence', true);

-- 112. JEANNE D'ARC UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('JEANNE D''ARC UNIVERSITY', 'privee', 'Ampandrana Bel Air', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (112, 'Informatique', 'JDU-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (112, 'Sciences de la Gestion', 'JDU-SCGEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 113. LEADERSHIP MANAGEMENT BUSINESS UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('LEADERSHIP MANAGEMENT BUSINESS UNIVERSITY', 'privee', 'Ambatomaro', 'Analamanga', true);

-- 114. LUTHERAN INSTITUTE OF MANAGEMENT AND ENTREPRENEURSHIP
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('LUTHERAN INSTITUTE OF MANAGEMENT AND ENTREPRENEURSHIP', 'privee', 'Fianarantsoa', 'Vakinankaratra', true);

-- 115. MAD'AID TRAINING CENTER
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('MAD''AID TRAINING CENTER', 'privee', 'Nanisana', 'Analamanga', true);

-- 116. MILLENIUM UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('MILLENIUM UNIVERSITY', 'privee', 'Mahitsy', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (116, 'Sciences de la Gestion', 'MU-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Licence', true);

-- 117. MADAGASCAR UNIVERSITY OF SCIENCE AND TECHNOLOGY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('MADAGASCAR UNIVERSITY OF SCIENCE AND TECHNOLOGY', 'privee', 'Ampefioha', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (117, 'Droit', 'MUST-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);

-- 118. ONIVERSITE FJKM RAVELOJAONA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONIVERSITE FJKM RAVELOJAONA', 'privee', 'Ambatonakanga', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (118, 'Agronomie', 'ONIFRA-AGRO-001', 'Sciences et Technologies', 'Agronomie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (118, 'Environnement', 'ONIFRA-ENV-001', 'Sciences et Technologies', 'Environnement', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (118, 'Sciences de la Communication', 'ONIFRA-SCCOM-001', 'Arts et Lettres', 'Communication', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (118, 'Sciences de l''Informatique', 'ONIFRA-SCINFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (118, 'Tourisme', 'ONIFRA-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (118, 'Droit', 'ONIFRA-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true);

-- 119. ONIVERSITE FJKM RAVELOJAONA AMBATOLAMPY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONIVERSITE FJKM RAVELOJAONA AMBATOLAMPY', 'privee', 'Ambatolampy', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (119, 'Gestion', 'ONIFRA-AMBTM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 120. ONIVERSITE FJKM RAVELOJAONA ARIVONIMAMO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONIVERSITE FJKM RAVELOJAONA ARIVONIMAMO', 'privee', 'Arivonimamo', 'Itasy', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (120, 'Gestion', 'ONIFRA-ARIV-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 121. ONIVERSITE FJKM RAVELOJAONA MORAMANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONIVERSITE FJKM RAVELOJAONA MORAMANGA', 'privee', 'Moramanga', 'Atsinanana', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (121, 'Gestion', 'ONIFRA-MOR-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);

-- 122. PHILOSOPHAT SAINT PAUL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('PHILOSOPHAT SAINT PAUL', 'privee', 'Ambanidia', 'Analamanga', true);

-- 123. SEKOLY AMBONY LOTERANA MOMBA NY TEOLOJIA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('SEKOLY AMBONY LOTERANA MOMBA NY TEOLOJIA', 'privee', 'Fianarantsoa', 'Vakinankaratra', true);

-- 124. SAMIS - ECOLE SUPERIEURE DE L'INFORMATION ET DE LA COMMUNICATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('SAMIS - ECOLE SUPERIEURE DE L''INFORMATION ET DE LA COMMUNICATION', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (124, 'Sciences de l''Information et Communication', 'SAMIS-SCINFCOM-001', 'Arts et Lettres', 'Communication', 'Master', true);

-- 125. ONG - UNIVERSITE POUR TOUS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONG - UNIVERSITE POUR TOUS', 'privee', 'Ambondrona', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (125, 'Droit', 'UNPT-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);

-- 126. INSTITUT TOP INFO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT TOP INFO', 'privee', 'Anjanahary', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (126, 'Informatique', 'TOPINFO-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);

-- 127. TECHNOLOGY SPECIALISTS INFORMATIC
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('TECHNOLOGY SPECIALISTS INFORMATIC', 'privee', 'Ambatomaro', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (127, 'Informatique', 'TSI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (127, 'Informatique', 'TSI-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (127, 'Gestion', 'TSI-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 128. UNIVERSITE ASCOM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ASCOM', 'privee', 'Antananarivo', 'Analamanga', true);

-- 129. UNIVERSITE ADVENTISTE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ADVENTISTE', 'privee', 'Sambaina Antsirabe', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (129, 'Gestion', 'UADV-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (129, 'Gestion', 'UADV-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (129, 'Informatique', 'UADV-INFO-001', 'Sciences et Technologies', 'Informatique', 'License', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (129, 'Communication', 'UADV-COMM-001', 'Arts et Lettres', 'Communication', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (129, 'Communication', 'UADV-COMM-002', 'Arts et Lettres', 'Communication', 'Master', true);

-- 130. UNIVERSITE CATHOLIQUE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE CATHOLIQUE DE MADAGASCAR', 'privee', 'Ambatoroka', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (130, 'Philosophie', 'UCM-PHILO-001', 'Arts et Lettres', 'Philosophie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (130, 'Philosophie', 'UCM-PHILO-002', 'Arts et Lettres', 'Philosophie', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (130, 'Psychologie', 'UCM-PSYCH-001', 'Arts et Lettres', 'Psychologie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (130, 'Droit', 'UCM-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (130, 'Gestion', 'UCM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 131. UNIVERSITE DES MEDIAS, DE L'AUDIOVISUEL ET DE LA TECHNOLOGIE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE DES MEDIAS, DE L''AUDIOVISUEL ET DE LA TECHNOLOGIE', 'privee', 'Ampasanimalo', 'Analamanga', true);

-- 132. UNIVERSITE GSI
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE GSI', 'privee', 'Antaninarenina', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (132, 'Informatique', 'UGSI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (132, 'Gestion', 'UGSI-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (132, 'BTP', 'UGSI-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true);

-- 133. UNIVERS INFORMATIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERS INFORMATIQUE', 'privee', 'Andravoahangy', 'Analamanga', true);

-- 134. UNIVERSITE INTERNATIONALE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE INTERNATIONALE DE MADAGASCAR', 'privee', 'Antetezanafovoany', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (134, 'Commerce', 'UIM-COMM-001', 'Sciences de Gestion', 'Commerce', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (134, 'Gestion', 'UIM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true);

-- 135. UNIVERSITE OUEST D'IARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE OUEST D''IARIVO', 'privee', 'Ambohitrimanjaka', 'Itasy', true);

-- 136. UNIVERSITE PRIVEE ALPHA SCHOOL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE ALPHA SCHOOL', 'privee', 'Itaosy', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (136, 'Communication', 'UPAS-COMM-001', 'Arts et Lettres', 'Communication', 'Licence', true);

-- 137. UNIVERSITE PRIVEE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (137, 'Gestion', 'UP-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (137, 'Gestion', 'UP-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (137, 'Philosophie', 'UP-PHILO-001', 'Arts et Lettres', 'Philosophie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (137, 'Informatique de Gestion', 'UP-INFOG-001', 'Sciences et Technologies', 'Informatique', 'License', true);

-- 138. UNIVERSITE PRIVEE D'AVARADRANO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE D''AVARADRANO', 'privee', 'Sabotsy Namehana', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (138, 'Entreprenariat rural', 'UPAVA-ENTREPURAL-001', 'Sciences de Gestion', 'Entrepreneuriat', 'Licence', true);

-- 139. UNIVERSITE PRIVEE HAY SOA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE HAY SOA', 'privee', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (139, 'Informatique de gestion', 'UPHS-INFOG-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (139, 'Informatique', 'UPHS-INFO-001', 'Sciences et Technologies', 'Informatique', 'Master', true);

-- 140. UNIVERSITE PRIVEE POUR L'INNOVATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE POUR L''INNOVATION', 'privee', 'Ankadindramamy', 'Analamanga', true);

-- 141. UNIVERSITE PRIVEE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE DE MADAGASCAR', 'privee', 'Andavamamba', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (141, 'Communication', 'UPM-COMM-001', 'Arts et Lettres', 'Communication', 'Licence', true);

-- 142. UNIVERSITY OF TECHNOLOGY AND BUSINESS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITY OF TECHNOLOGY AND BUSINESS', 'privee', 'Iavoloha', 'Analamanga', true);

-- 143. UNIVERSITE DE TECHNOLOGIES A MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE DE TECHNOLOGIES A MADAGASCAR', 'privee', 'Toliara', 'Androy', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (143, 'Tourisme Durable', 'UTMAD-TOURDUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true);

-- 144. VATEL - INTERNATIONAL BUSINESS SCHOOL HOTEL AND TOURISM MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('VATEL - INTERNATIONAL BUSINESS SCHOOL HOTEL AND TOURISM MANAGEMENT', 'privee', 'Ambatoroka', 'Analamanga', true);

-- 145. MADAGASCAR BUSINESS SCHOOL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('MADAGASCAR BUSINESS SCHOOL', 'privee', 'Manakambahiny', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (145, 'Droit et Sciences politiques', 'MBS-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (145, 'Droit', 'MBS-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (145, 'Gestion', 'MBS-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (145, 'Gestion', 'MBS-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (145, 'Sciences de Gestion', 'MBS-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (145, 'Sciences de la Communication', 'MBS-SCCOM-001', 'Arts et Lettres', 'Communication', 'Master', true);

-- =====================================================
-- SECTION B: ETABLISSEMENTS PUBLICS
-- =====================================================

-- 1. UNIVERSITE ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ANTANANARIVO', 'publique', 'Antananarivo', 'Analamanga', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Chimie', 'UANT-CHEM-001', 'Sciences et Technologies', 'Chimie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Chimie', 'UANT-CHEM-002', 'Sciences et Technologies', 'Chimie', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Biologie', 'UANT-BIO-001', 'Sciences et Technologies', 'Biologie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Biologie', 'UANT-BIO-002', 'Sciences et Technologies', 'Biologie', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Physique et Applications', 'UANT-PHYSAPP-001', 'Sciences et Technologies', 'Physique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Physique et Applications', 'UANT-PHYSAPP-002', 'Sciences et Technologies', 'Physique', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Sciences de la Terre et de l''Environnement', 'UANT-SCTERR-001', 'Sciences et Technologies', 'Sciences de la Terre', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Sciences de la Terre et de l''Environnement', 'UANT-SCTERR-002', 'Sciences et Technologies', 'Sciences de la Terre', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Informatique et Technologie', 'UANT-INFTECH-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (146, 'Informatique et Technologie', 'UANT-INFTECH-002', 'Sciences et Technologies', 'Informatique', 'Master', true);

-- 2. UNIVERSITE ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ANTSIRANANA', 'publique', 'Antsiranana', 'Diana', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (147, 'Sciences Chimiques', 'UATSN-SCCHEM-001', 'Sciences et Technologies', 'Sciences Chimiques', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (147, 'Sciences Physiques', 'UATSN-SCPHYS-001', 'Sciences et Technologies', 'Sciences Physiques', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (147, 'Sciences de la Nature et de l''Environnement', 'UATSN-SCNENV-001', 'Sciences et Technologies', 'Environnement', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (147, 'Sciences du Vivant et de la Terre', 'UATSN-SCVT-001', 'Sciences et Technologies', 'Sciences de la Vie et Terre', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (147, 'Sciences du Vivant et de la Terre', 'UATSN-SCVT-002', 'Sciences et Technologies', 'Sciences de la Vie et Terre', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (147, 'Sciences et Technologie de l''Information et de la Communication', 'UATSN-STIC-001', 'Sciences et Technologies', 'Technologie Information', 'Licence', true);

-- 3. UNIVERSITE FIANARANTSOA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE FIANARANTSOA', 'publique', 'Fianarantsoa', 'Vakinankaratra', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (148, 'Physique Chimie', 'UYFIN-PHYSCHEM-001', 'Sciences et Technologies', 'Physique Chimie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (148, 'Physique Chimie', 'UYFIN-PHYSCHEM-002', 'Sciences et Technologies', 'Physique Chimie', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (148, 'Informatique', 'UYFIN-INFO-001', 'Sciences et Technologies', 'Informatique', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (148, 'Maths et Applications', 'UYFIN-MATHAPP-001', 'Sciences et Technologies', 'Mathématiques', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (148, 'Maths et Applications', 'UYFIN-MATHAPP-002', 'Sciences et Technologies', 'Mathématiques', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (148, 'Chimie', 'UYFIN-CHEM-001', 'Sciences et Technologies', 'Chimie', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (148, 'Sciences de la vie', 'UYFIN-SCVIE-001', 'Sciences et Technologies', 'Sciences de la Vie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (148, 'Sciences de la vie', 'UYFIN-SCVIE-002', 'Sciences et Technologies', 'Sciences de la Vie', 'Master', true);

-- 4. UNIVERSITE MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE MAHAJANGA', 'publique', 'Mahajanga', 'Boeny', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (149, 'Biochimie et Sciences de l''Environnement', 'UMHJ-BIOCHENV-001', 'Sciences et Technologies', 'Biochimie', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (149, 'Sciences de la vie, de la terre et de l''environnement', 'UMHJ-SCVTE-001', 'Sciences et Technologies', 'Sciences de la Vie', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (149, 'Sciences de la vie, de la terre et de l''environnement', 'UMHJ-SCVTE-002', 'Sciences et Technologies', 'Sciences de la Vie', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (149, 'Droit et sciences Politiques', 'UMHJ-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);

-- 5. UNIVERSITE TOAMASINA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE TOAMASINA', 'publique', 'Toamasina', 'Atsinanana', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (150, 'Droit et Sciences Politiques', 'UTOA-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (150, 'Droit', 'UTOA-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (150, 'Gestion', 'UTOA-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (150, 'Sciences de Gestion', 'UTOA-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (150, 'Physique Chimie', 'UTOA-PHYSCHEM-001', 'Sciences et Technologies', 'Physique Chimie', 'Licence', true);

-- 6. UNIVERSITE TOLIARA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE TOLIARA', 'publique', 'Toliara', 'Androy', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (151, 'Droit', 'UTOL-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (151, 'Gestion', 'UTOL-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (151, 'Sciences Marines et Halieutiques', 'UTOL-SCMH-001', 'Sciences et Technologies', 'Sciences Marines', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (151, 'Sciences Marines et Halieutiques', 'UTOL-SCMH-002', 'Sciences et Technologies', 'Sciences Marines', 'Master', true);

-- =====================================================
-- RESUME FINAL
-- =====================================================
-- Total établissements privés : 145
-- Total établissements publics : 6
-- TOTAL : 151 établissements
-- Filieres insérées : Plus de 300+
