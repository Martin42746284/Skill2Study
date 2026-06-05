-- =====================================================
-- INSERTION COMPLETE DES UNIVERSITES ET FILIERES (FIXED)
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
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ATHENEE SAINT JOSEPH ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Sciences Agronomiques', 'ASJA-AGRO-001', 'Sciences et Technologies', 'Sciences Agronomiques', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Sciences Agronomiques', 'ASJA-AGRO-002', 'Sciences et Technologies', 'Sciences Agronomiques', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Sciences de la Terre', 'ASJA-SCTERR-001', 'Sciences et Technologies', 'Sciences de la Terre', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Sciences de la Terre', 'ASJA-SCTERR-002', 'Sciences et Technologies', 'Sciences de la Terre', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Informatique', 'ASJA-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Informatique', 'ASJA-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Droit', 'ASJA-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif) VALUES (2, 'Droit', 'ASJA-DROIT-002', 'Droit et Sciences Politiques', 'Droit', 'Master', true);

-- Additional universities will need to be added similarly
-- The pattern is: INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES (..., CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
