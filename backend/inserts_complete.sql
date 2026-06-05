-- =====================================================
-- NETTOYAGE: Vider les tables existantes
-- =====================================================
TRUNCATE TABLE filieres RESTART IDENTITY CASCADE;
TRUNCATE TABLE universites RESTART IDENTITY CASCADE;

-- =====================================================
-- INSERTION COMPLETE DES UNIVERSITES ET FILIERES
-- DOCUMENT: Liste des établissements d'enseignement supérieur Madagascar 2022
-- VERSION FINALE: Nettoyage, universites d'abord, puis filieres
-- =====================================================

-- =====================================================
-- SECTION A: ETABLISSEMENTS PRIVES - UNIVERSITES UNIQUEMENT
-- =====================================================

-- 1. BUSINESS SCHOOL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('BUSINESS SCHOOL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 2. ATHENEE SAINT JOSEPH ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ATHENEE SAINT JOSEPH ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 3. CENTRE D'ETUDES, DE L'INFORMATION ET SES TECHNOLOGIES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('CENTRE D''ETUDES, DE L''INFORMATION ET SES TECHNOLOGIES', 'privee', 'Ambolokandrina', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 4. CENTRE ECOLOGIQUE DE LIBANONA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('CENTRE ECOLOGIQUE DE LIBANONA', 'privee', 'Fort-Dauphin', 'Anosy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 5. CFAMA - CENTRE DE FORMATION ET D'APPLICATION DU MACHINISME AGRICOLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('CFAMA - CENTRE DE FORMATION ET D''APPLICATION DU MACHINISME AGRICOLE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 6. CONSERVATOIRE NATIONAL DES ARTS ET METIERS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('CONSERVATOIRE NATIONAL DES ARTS ET METIERS', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 7. ECOLE DE COMPTABILITE ET D'ADMINISTRATION TARATRA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DE COMPTABILITE ET D''ADMINISTRATION TARATRA', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 8. EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY', 'privee', 'Antanetibe', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 9. ETABLISSEMENT D'ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE SUPERIEURE CONDORCET
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT D''ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE SUPERIEURE CONDORCET', 'privee', 'Faravohitra', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 10. ECOLE PROFESSIONNELLE SUPERIEURE AGRICOLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE PROFESSIONNELLE SUPERIEURE AGRICOLE', 'privee', 'Bevalala', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 11. ETABLISSEMENT PRIVE D'ENSEIGNEMENT SUPERIEUR LUMIERE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT PRIVE D''ENSEIGNEMENT SUPERIEUR LUMIERE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 12. ECOLE SUPERIEURE DE BATIMENT ET TRAVAUX PUBLICS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE BATIMENT ET TRAVAUX PUBLICS', 'privee', 'Ampasanimalo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 13. ECOLE SUPERIEURE DE COMMERCE ET TECHNIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE COMMERCE ET TECHNIQUE', 'privee', 'Analamahitsy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 14. ECOLE SUPERIEURE DE DROIT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE DROIT', 'privee', 'Nanisana', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 15. ECOLE SUPERIEURE DE DEVELOPPEMENT ECONOMIQUE ET SOCIAL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE DEVELOPPEMENT ECONOMIQUE ET SOCIAL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 16. ECOLE SUPERIEURE D'INFORMATIQUE ET DE GESTION DES ENTREPRISES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE D''INFORMATIQUE ET DE GESTION DES ENTREPRISES', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 17. ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE MANAGEMENT ET D''INFORMATIQUE APPLIQUEE', 'privee', 'Mahamasina Atsimo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 18. ETABLISSEMENT SUPERIEUR PROFESSIONNEL BUREAUTIQUE, INFORMATIQUE ET GESTION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT SUPERIEUR PROFESSIONNEL BUREAUTIQUE, INFORMATIQUE ET GESTION', 'privee', 'Behoririka', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 19. ECOLE SUPERIEURE PROFESSIONNELLE EN INFORMATIQUE ET COMMERCE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE PROFESSIONNELLE EN INFORMATIQUE ET COMMERCE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 20. ECOLE SUPERIEURE SPECIALISEE EN DROIT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE SPECIALISEE EN DROIT', 'privee', 'Ankatso', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 21. ECOLE SUPERIEURE SAINT GABRIEL MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE SAINT GABRIEL MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 22. ECOLE SUPERIEURE SPECIALISEE DE VAKINAKARATRA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE SPECIALISEE DE VAKINAKARATRA', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 23. ECOLE SUPERIEURE DE TECHNOLOGIE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE TECHNOLOGIE', 'privee', 'Faravohitra', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 24. ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE TECHNOLOGIES DE L''INFORMATION', 'privee', 'Antanimena', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 25. ENGINEERING SCHOOL OF TOURISM, INFORMATICS, INTERPRETERSHIP AND MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ENGINEERING SCHOOL OF TOURISM, INFORMATICS, INTERPRETERSHIP AND MANAGEMENT', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 26. ECOLE SUPERIEURE DE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE SUPERIEURE DE MANAGEMENT', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 27. EDUCATION IN TRAINING, EMPLOYMENT AND COMMUNICATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('EDUCATION IN TRAINING, EMPLOYMENT AND COMMUNICATION', 'privee', 'Faravohitra', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 28. ETABLISSEMENT TECHNIQUE DE FORMATION PROFESSIONNELLE SUPERIEURE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT TECHNIQUE DE FORMATION PROFESSIONNELLE SUPERIEURE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 29. ETABLISSEMENT TECHNIQUE SUPERIEUR SAINT MICHEL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ETABLISSEMENT TECHNIQUE SUPERIEUR SAINT MICHEL', 'privee', 'Amparibe', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 30. ESPACE UNIVERSITAIRE REGIONAL DE L'OCEAN INDIEN
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ESPACE UNIVERSITAIRE REGIONAL DE L''OCEAN INDIEN', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 31. GRAND SEMINAIRE SAINT PAUL APOTRE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('GRAND SEMINAIRE SAINT PAUL APOTRE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 32. GATE UNIVERSITY AMBOHIDRATRIMO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('GATE UNIVERSITY', 'privee', 'Ambohidratrimo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 33. HAUTES ETUDES CHRETIENNES DE MANAGEMENT ET DE MATHEMATIQUES APPLIQUEES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('HAUTES ETUDES CHRETIENNES DE MANAGEMENT ET DE MATHEMATIQUES APPLIQUEES', 'privee', 'Alarobia Amboniloha', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 34. HAUTES ETUDES EN DROIT ET EN MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('HAUTES ETUDES EN DROIT ET EN MANAGEMENT', 'privee', 'Soanierana', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 35. INSTITUT CATHOLIQUE NOTRE DAME
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT CATHOLIQUE NOTRE DAME', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 36. INSTITUTION CHRETIENNE DE TSIENIMPARIHY, UNIE PAR LE SAUVEUR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUTION CHRETIENNE DE TSIENIMPARIHY, UNIE PAR LE SAUVEUR', 'privee', 'Ambalavao', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 37. INSTITUT D'ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT D''ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE', 'privee', 'Ambatomitsangana', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 38. INSTITUT D'ETUDES POLITIQUES MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT D''ETUDES POLITIQUES MADAGASCAR', 'privee', 'Ampandrana Ouest', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 39. INSTITUT D'ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT D''ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D''ENTREPRISE', 'privee', 'Antaninandro', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 40. INSTITUT D'ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT D''ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D''ENTREPRISE ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 41. INSTITUT DE FORMATION EN AGRONOMIE, GEMMOLOGIE, INDUSTRIALISATION ET PARAMED
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION EN AGRONOMIE, GEMMOLOGIE, INDUSTRIALISATION ET PARAMED', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 42. INSTITUT DE FORMATION PROFESSIONNELLE RAKETAMANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PROFESSIONNELLE RAKETAMANGA', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 43. INSTITUT DE FORMATION ET DES RECHERCHES PEDAGOGIQUES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION ET DES RECHERCHES PEDAGOGIQUES', 'privee', 'Ambodin''Andohalo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 44. INSTITUT DE FORMATION TECHNIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 45. INSTITUT DE FORMATION TECHNIQUE ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 46. INSTITUT DE FORMATION TECHNIQUE BTP
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE BTP', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 47. INSTITUT DE FORMATION TECHNIQUE MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 48. INSTITUT DE FORMATION TECHNIQUE TOAMASINA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION TECHNIQUE TOAMASINA', 'privee', 'Toamasina', 'Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 49. INSTITUT DE GEOGRAPHIE DE LA SOFIA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE GEOGRAPHIE DE LA SOFIA', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 50. INSTITUT INTERNATIONAL DES SCIENCES SOCIALES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT INTERNATIONAL DES SCIENCES SOCIALES', 'privee', 'Tsimbazaza', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 51. INSTITUT DE LEADERSHIP CHRETIEN
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE LEADERSHIP CHRETIEN', 'privee', 'Antaninandro', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 52. IMAGE APPLI
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('IMAGE APPLI', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 53. INSTITUT DE MANAGEMENT DES ARTS ET METIERS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE MANAGEMENT DES ARTS ET METIERS', 'privee', 'Ivandry', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 54. INSTITUTE OF MANAGEMENT AND TOURISM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUTE OF MANAGEMENT AND TOURISM', 'privee', 'Antanimena', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 55. INSTITUT DES ARTS ET DES TECHNOLOGIES AVANCEES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DES ARTS ET DES TECHNOLOGIES AVANCEES', 'privee', 'Ankadivato', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 56. INSTITUT DE FORMATION EN TOURISME
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION EN TOURISME', 'privee', 'Ankadivato', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 57. INFOTOUR - INSTITUT DE FORMATION EN TOURISME
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INFOTOUR - INSTITUT DE FORMATION EN TOURISME', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 58. INSIDE UNIVERSITY ROSSIGNOL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSIDE UNIVERSITY ROSSIGNOL', 'privee', 'Ambondrona', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 59. INSPNMAD ANALAMANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSPNMAD ANALAMANGA', 'privee', 'Ambaranjana', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 60. INSPNMAD MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSPNMAD MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 61. INSTITUTE OF TECHNICAL TECHNOLOGY, LIVING AND INTERDISCIPLINARY ARTS OF MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUTE OF TECHNICAL TECHNOLOGY, LIVING AND INTERDISCIPLINARY ARTS OF MADAGASCAR', 'privee', 'Andranovory', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 62. IVON-TOERAM-PAMPIANARANA AMBONY MOMBA NY EOKOMENISMA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('IVON-TOERAM-PAMPIANARANA AMBONY MOMBA NY EOKOMENISMA', 'privee', 'Anjohy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 63. INSTITUT PRIVE AL MOUSTAPHA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT PRIVE AL MOUSTAPHA', 'privee', 'Ambohitrarahaba', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 64. INSTITUT PROFESSIONNEL SUPERIEUR EN AGRONOMIE ET EN TECHNOLOGIE DE TOMBOTSOA ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT PROFESSIONNEL SUPERIEUR EN AGRONOMIE ET EN TECHNOLOGIE DE TOMBOTSOA ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 65. INSTITUT SUPERIEUR D'AMBATOMIRAHAVANY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR D''AMBATOMIRAHAVANY', 'privee', 'Ambatomirahavavy', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 66. INSTITUT EN ADMINISTRATION D'ENTREPRISE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT EN ADMINISTRATION D''ENTREPRISE CABINET ATOMIC', 'privee', 'Ankatso', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 67. INSTITUT SUPERIEUR POUR L'AVENIR DES POLYTECHNICIENS ET DE LA SANTE PUBLIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR POUR L''AVENIR DES POLYTECHNICIENS ET DE LA SANTE PUBLIQUE', 'privee', 'Ambanja', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 68. INSTITUT SUPERIEUR ATOUT TOURISME MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR ATOUT TOURISME MADAGASCAR', 'privee', 'Ankorahotra', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 69. INSTITUT SUPERIEUR DE LA COMMUNICATION DES AFFAIRES ET DE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE LA COMMUNICATION DES AFFAIRES ET DE MANAGEMENT', 'privee', 'Ankadifotsy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 70. INSTITUT SUPERIEUR CATHOLIQUE DU MENABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR CATHOLIQUE DU MENABE', 'privee', 'Morondava', 'Menabe', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 71. INSTITUT SUPERIEUR POUR LE DEVELOPPEMENT DE L'ENTREPRENARIAT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR POUR LE DEVELOPPEMENT DE L''ENTREPRENARIAT', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 72. INSTITUT SUPERIEUR POUR L'ENTREPRENEURIAT, LE COMMERCE ET LE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR POUR L''ENTREPRENEURIAT, LE COMMERCE ET LE MANAGEMENT', 'privee', 'Ampasamadinika', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 73. INSTITUT SUPERIEUR D'ENSEIGNEMENT TECHNOLOGIQUE ET DES SCIENCES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR D''ENSEIGNEMENT TECHNOLOGIQUE ET DES SCIENCES', 'privee', 'Ambohidahy Ankadindramamy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 74. INSTITUT SUPERIEUR DE GENIE ELECTRONIQUE INFORMATIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE GENIE ELECTRONIQUE INFORMATIQUE', 'privee', 'Ampandrana Ouest', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 75. INSTITUT SUPERIEUR DE GEOLOGIE DE L'INGENIEUR ET DE L'ENVIRONNEMENT DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE GEOLOGIE DE L''INGENIEUR ET DE L''ENVIRONNEMENT DE MADAGASCAR', 'privee', 'Ankadivato', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 76. INSTITUT SUPERIEUR DE L'INNOVATION D'ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE L''INNOVATION D''ANTSIRANANA', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 77. INSTITUT SUPERIEUR D'ELECTRONIQUE ET DE SYSTEME INFORMATIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR D''ELECTRONIQUE ET DE SYSTEME INFORMATIQUE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 78. INSTITUT SUPERIEUR D'INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR D''INFORMATIQUE ET DE MANAGEMENT D''ENTREPRISE', 'privee', 'Betongolo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 79. INSTITUT SUPERIEUR EN INFORMATIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR EN INFORMATIQUE', 'privee', 'Ampasamadinika', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 80. INSTITUT SUPERIEUR DE L'INGENIERIE ET DES TECHNIQUES DE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE L''INGENIERIE ET DES TECHNIQUES DE MANAGEMENT', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 81. INSTITUT SUPERIEUR DES METIERS DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DES METIERS DE MADAGASCAR', 'privee', 'Ambohimitsimbina', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 82. INSTITUT SUPERIEUR EN MANAGEMENT ET DU DEVELOPPEMENT D'ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR EN MANAGEMENT ET DU DEVELOPPEMENT D''ANTSIRANANA', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 83. INSTITUT UNIVERSITAIRE POLYTECHNIQUE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT UNIVERSITAIRE POLYTECHNIQUE DE MADAGASCAR', 'privee', 'Ambohijatovo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 84. INSTITUT SUPERIEUR MONSEIGNEUR RAMAROSANDRATANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR MONSEIGNEUR RAMAROSANDRATANA', 'privee', 'Miarinarivo', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 85. INSTITUT SUPERIEUR DE MANAGEMENT ET DES SCIENCES TECHNOLOGIQUES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE MANAGEMENT ET DES SCIENCES TECHNOLOGIQUES', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 86. INSTITUT SUPERIEUR DE MANAGEMENT ET DE TECHNOLOGIE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE MANAGEMENT ET DE TECHNOLOGIE', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 87. INSTITUT SUPERIEUR NUMERIQUE D'ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR NUMERIQUE D''ANTANANARIVO', 'privee', 'Antetezana Bongatsara', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 88. INSTITUT SUPERIEUR NORD MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR NORD MADAGASCAR', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 89. INSTITUT SUPERIEUR DE PEDAGOGIE D'ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE PEDAGOGIE D''ANTANANARIVO', 'privee', 'Antamponankatso', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 90. INSTITUT SUPERIEUR PRIVE AGRICOLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PRIVE AGRICOLE', 'privee', 'Ampandrianomby', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 91. INSTITUT SUPERIEUR POLYTECHNIQUE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR POLYTECHNIQUE DE MADAGASCAR', 'privee', 'Ambatomaro Antsobolo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 92. INSTITUT SUPERIEUR PRIVE MADAGASCAR DEVELOPPEMENT FORMATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PRIVE MADAGASCAR DEVELOPPEMENT FORMATION', 'privee', 'Isoraka', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 93. INSTITUT SUPERIEUR PROTESTANT PAUL MINAULT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PROTESTANT PAUL MINAULT', 'privee', 'Ambohijatovo Atsimo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 94. INSTITUT SUPERIEUR PRIVE DE LA REGION DIANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PRIVE DE LA REGION DIANA', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 95. INSTITUT SUPERIEUR DES POLYTECHNICIENS DE LA REGION D'ITASY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DES POLYTECHNICIENS DE LA REGION D''ITASY', 'privee', 'Analavory', 'Itasy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 96. INSTITUT SUPERIEUR DES SCIENCES DE DEVELOPPEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DES SCIENCES DE DEVELOPPEMENT', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 97. INSTITUT SUPERIEUR EN SCIENCES DE L'ENVIRONNEMENT ET DE GESTION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR EN SCIENCES DE L''ENVIRONNEMENT ET DE GESTION', 'privee', 'Soanierana', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 98. INSTITUT SUPERIEUR SPECIALISE EN INFORMATIQUE ET EN GESTION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR SPECIALISE EN INFORMATIQUE ET EN GESTION', 'privee', 'Soavimbahoaka', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 99. INSTITUT SUPERIEUR SAINT MICHEL ITAOSY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR SAINT MICHEL ITAOSY', 'privee', 'Itaosy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 100. INSTITUT SUPERIEUR SALESIEN DE PHILOSOPHIE SAINT THOMAS D'AQUIN
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR SALESIEN DE PHILOSOPHIE SAINT THOMAS D''AQUIN', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 101. INSTITUT SUPERIEUR DE SPECIALISATION EN SCIENCES DE GESTION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE SPECIALISATION EN SCIENCES DE GESTION GROUPE EMIR CONSULTING', 'privee', 'Ankasina', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 102. INSTITUT SUPERIEUR PRIVE PROFESSIONNEL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR PRIVE PROFESSIONNEL', 'privee', 'Behoririka', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 103. INSTITUT SUPERIEUR DE TECHNOLOGIES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE TECHNOLOGIES', 'privee', 'Manakara', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 104. INSTITUT SUPERIEUR DE TECHNOLOGIE INDUSTRIEL ET DE MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE TECHNOLOGIE INDUSTRIEL ET DE MANAGEMENT', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 105. INSTITUT SUPERIEUR DE TECHNOLOGIE REGIONAL DE FITOVINANY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE TECHNOLOGIE REGIONAL DE FITOVINANY', 'privee', 'Manakara', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 106. INSTITUT SUPERIEUR DE TRAVAIL SOCIAL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SUPERIEUR DE TRAVAIL SOCIAL', 'privee', 'Iavoloha', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 107. INSTITUT TECHNIQUE SUPERIEUR AGRICOLE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT TECHNIQUE SUPERIEUR AGRICOLE', 'privee', 'Antady Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 108. INSTITUT TECHNIQUE SUPERIEUR FRANCOIS XAVIER
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT TECHNIQUE SUPERIEUR FRANCOIS XAVIER', 'privee', 'Antady Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 109. INFORMATION TECHNOLOGY UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INFORMATION TECHNOLOGY UNIVERSITY', 'privee', 'Andoharanofotsy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 110. INSTITUT UNIVERSITAIRE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT UNIVERSITAIRE DE MADAGASCAR', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 111. INSTITUT UNIVERSITAIRE PROFESSIONNEL EN ADMINISTRATION D'ENTREPRISE ET EN SCIENCES MARINES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT UNIVERSITAIRE PROFESSIONNEL EN ADMINISTRATION D''ENTREPRISE ET EN SCIENCES MARINES', 'privee', 'Nosy Be', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 112. JEANNE D'ARC UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('JEANNE D''ARC UNIVERSITY', 'privee', 'Ampandrana Bel Air', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 113. LEADERSHIP MANAGEMENT BUSINESS UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('LEADERSHIP MANAGEMENT BUSINESS UNIVERSITY', 'privee', 'Ambatomaro', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 114. LUTHERAN INSTITUTE OF MANAGEMENT AND ENTREPRENEURSHIP
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('LUTHERAN INSTITUTE OF MANAGEMENT AND ENTREPRENEURSHIP', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 115. MAD'AID TRAINING CENTER
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('MAD''AID TRAINING CENTER', 'privee', 'Nanisana', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 116. MILLENIUM UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('MILLENIUM UNIVERSITY', 'privee', 'Mahitsy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 117. MADAGASCAR UNIVERSITY OF SCIENCE AND TECHNOLOGY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('MADAGASCAR UNIVERSITY OF SCIENCE AND TECHNOLOGY', 'privee', 'Ampefioha', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 118. ONIVERSITE FJKM RAVELOJAONA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONIVERSITE FJKM RAVELOJAONA', 'privee', 'Ambatonakanga', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 119. ONIVERSITE FJKM RAVELOJAONA AMBATOLAMPY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONIVERSITE FJKM RAVELOJAONA AMBATOLAMPY', 'privee', 'Ambatolampy', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 120. ONIVERSITE FJKM RAVELOJAONA ARIVONIMAMO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONIVERSITE FJKM RAVELOJAONA ARIVONIMAMO', 'privee', 'Arivonimamo', 'Itasy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 121. ONIVERSITE FJKM RAVELOJAONA MORAMANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONIVERSITE FJKM RAVELOJAONA MORAMANGA', 'privee', 'Moramanga', 'Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 122. PHILOSOPHAT SAINT PAUL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('PHILOSOPHAT SAINT PAUL', 'privee', 'Ambanidia', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 123. SEKOLY AMBONY LOTERANA MOMBA NY TEOLOJIA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('SEKOLY AMBONY LOTERANA MOMBA NY TEOLOJIA', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 124. SAMIS - ECOLE SUPERIEURE DE L'INFORMATION ET DE LA COMMUNICATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('SAMIS - ECOLE SUPERIEURE DE L''INFORMATION ET DE LA COMMUNICATION', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 125. ONG - UNIVERSITE POUR TOUS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ONG - UNIVERSITE POUR TOUS', 'privee', 'Ambondrona', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 126. INSTITUT TOP INFO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT TOP INFO', 'privee', 'Anjanahary', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 127. TECHNOLOGY SPECIALISTS INFORMATIC
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('TECHNOLOGY SPECIALISTS INFORMATIC', 'privee', 'Ambatomaro', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 128. UNIVERSITE ASCOM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ASCOM', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 129. UNIVERSITE ADVENTISTE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ADVENTISTE', 'privee', 'Sambaina Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 130. UNIVERSITE CATHOLIQUE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE CATHOLIQUE DE MADAGASCAR', 'privee', 'Ambatoroka', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 131. UNIVERSITE DES MEDIAS, DE L'AUDIOVISUEL ET DE LA TECHNOLOGIE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE DES MEDIAS, DE L''AUDIOVISUEL ET DE LA TECHNOLOGIE', 'privee', 'Ampasanimalo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 132. UNIVERSITE GSI
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE GSI', 'privee', 'Antaninarenina', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 133. UNIVERS INFORMATIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERS INFORMATIQUE', 'privee', 'Andravoahangy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 134. UNIVERSITE INTERNATIONALE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE INTERNATIONALE DE MADAGASCAR', 'privee', 'Antetezanafovoany', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 135. UNIVERSITE OUEST D'IARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE OUEST D''IARIVO', 'privee', 'Ambohitrimanjaka', 'Itasy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 136. UNIVERSITE PRIVEE ALPHA SCHOOL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE ALPHA SCHOOL', 'privee', 'Itaosy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 137. UNIVERSITE PRIVEE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 138. UNIVERSITE PRIVEE D'AVARADRANO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE D''AVARADRANO', 'privee', 'Sabotsy Namehana', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 139. UNIVERSITE PRIVEE HAY SOA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE HAY SOA', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 140. UNIVERSITE PRIVEE POUR L'INNOVATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE POUR L''INNOVATION', 'privee', 'Ankadindramamy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 141. UNIVERSITE PRIVEE DE MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE DE MADAGASCAR', 'privee', 'Andavamamba', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 142. UNIVERSITY OF TECHNOLOGY AND BUSINESS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITY OF TECHNOLOGY AND BUSINESS', 'privee', 'Iavoloha', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 143. UNIVERSITE DE TECHNOLOGIES A MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE DE TECHNOLOGIES A MADAGASCAR', 'privee', 'Toliara', 'Androy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 144. VATEL - INTERNATIONAL BUSINESS SCHOOL HOTEL AND TOURISM MANAGEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('VATEL - INTERNATIONAL BUSINESS SCHOOL HOTEL AND TOURISM MANAGEMENT', 'privee', 'Ambatoroka', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 145. MADAGASCAR BUSINESS SCHOOL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('MADAGASCAR BUSINESS SCHOOL', 'privee', 'Manakambahiny', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =====================================================
-- SECTION B: ETABLISSEMENTS PUBLICS - UNIVERSITES UNIQUEMENT
-- =====================================================

-- 146. UNIVERSITE ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ANTANANARIVO', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 147. UNIVERSITE ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ANTSIRANANA', 'publique', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 148. UNIVERSITE FIANARANTSOA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE FIANARANTSOA', 'publique', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 149. UNIVERSITE MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE MAHAJANGA', 'publique', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 150. UNIVERSITE TOAMASINA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE TOAMASINA', 'publique', 'Toamasina', 'Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 151. UNIVERSITE TOLIARA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE TOLIARA', 'publique', 'Toliara', 'Androy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =====================================================
-- SECTION C: TOUTES LES FILIERES (300+ FILIERES)
-- =====================================================

INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (1, 'Informatique de Gestion', 'BS-INFOG-001', 'Sciences et Technologies', 'Informatique de Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (1, 'Gestion', 'BS-GEST-001', 'Sciences et Technologies', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (2, 'Sciences Agronomiques', 'ASJA-AGRO-001', 'Sciences et Technologies', 'Sciences Agronomiques', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (2, 'Sciences Agronomiques', 'ASJA-AGRO-002', 'Sciences et Technologies', 'Sciences Agronomiques', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (2, 'Sciences de la Terre', 'ASJA-SCTERR-001', 'Sciences et Technologies', 'Sciences de la Terre', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (2, 'Sciences de la Terre', 'ASJA-SCTERR-002', 'Sciences et Technologies', 'Sciences de la Terre', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (2, 'Informatique', 'ASJA-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (2, 'Informatique', 'ASJA-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (2, 'Droit', 'ASJA-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (2, 'Droit', 'ASJA-DROIT-002', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (3, 'Informatique', 'CEIST-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (5, 'Sciences Agronomiques', 'CFAMA-AGRO-001', 'Sciences et Technologies', 'Sciences Agronomiques', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (6, 'Sciences Industrielles', 'CNAM-SIND-001', 'Sciences et Technologies', 'Sciences Industrielles', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (9, 'Technologie', 'CONDORCET-TECH-001', 'Sciences et Technologies', 'Technologie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (9, 'Technologie', 'CONDORCET-TECH-002', 'Sciences et Technologies', 'Technologie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (10, 'Sciences Agronomiques', 'EPSA-AGRO-001', 'Sciences et Technologies', 'Sciences Agronomiques', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (11, 'Gestion et Administration d''Entreprises', 'EPSL-GADM-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (11, 'Banque et Institutions de Microfinance', 'EPSL-BANQ-001', 'Sciences de Gestion', 'Banque', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (12, 'BTP', 'ESBTP-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (13, 'Commerce', 'ESCT-COMM-001', 'Sciences de Gestion', 'Commerce', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (14, 'Droit et Sciences Politiques', 'ESD-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (15, 'Travail Social', 'ESDEES-TRAVS-001', 'Sciences et Technologies', 'Travail Social', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (15, 'Travail Social', 'ESDEES-TRAVS-002', 'Sciences et Technologies', 'Travail Social', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (15, 'Gestion', 'ESDEES-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (16, 'Gestion', 'ESIGE-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (16, 'Gestion', 'ESIGE-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (16, 'Sciences de Gestion', 'ESIGE-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (16, 'Droit', 'ESIGE-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (16, 'Informatique', 'ESIGE-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (16, 'Droit et Sciences Politiques', 'ESIGE-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (17, 'Gestion', 'ESMIAP-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (17, 'Informatique', 'ESMIAP-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (18, 'Gestion', 'ESPBIG-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (18, 'Informatique', 'ESPBIG-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (19, 'Gestion', 'ESPIC-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (19, 'Gestion', 'ESPIC-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (19, 'Sciences de Gestion', 'ESPIC-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (20, 'Droit', 'ESSD-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (21, 'Commerce et Gestion', 'ESSGM-COMGEST-001', 'Sciences de Gestion', 'Commerce et Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (21, 'Commerce et Gestion', 'ESSGM-COMGEST-002', 'Sciences de Gestion', 'Commerce et Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (21, 'Droit', 'ESSGM-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (22, 'Gestion Management', 'ESSV-GESTM-001', 'Sciences de Gestion', 'Gestion Management', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (22, 'Communication et Journalisme', 'ESSV-COMMJ-001', 'Arts et Lettres', 'Communication et Journalisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (23, 'Informatique', 'EST-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (24, 'Informatique', 'ESTI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (25, 'Droit', 'ESTIIM-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (25, 'Droit et Sciences Politiques', 'ESTIIM-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (25, 'Gestion', 'ESTIIM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (25, 'Administration, Management, Commerce, Marketing', 'ESTIIM-ADMM-001', 'Sciences de Gestion', 'Management', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (25, 'Administration, Management, Commerce, Marketing', 'ESTIIM-ADMM-002', 'Sciences de Gestion', 'Management', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (25, 'Environnement', 'ESTIIM-ENV-001', 'Sciences et Technologies', 'Environnement', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (25, 'Environnement', 'ESTIIM-ENV-002', 'Sciences et Technologies', 'Environnement', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (25, 'Informatique', 'ESTIIM-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (26, 'Informatique', 'ESM-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (26, 'Gestion', 'ESM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (26, 'Statistique', 'ESM-STAT-001', 'Sciences et Technologies', 'Statistique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (27, 'Administration, Gestion, Finances, Informatique de Gestion', 'ETEC-ADMG-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (27, 'Administration, Gestion, Finances, Informatique de Gestion', 'ETEC-ADMG-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (28, 'Maintenance', 'ETFPS-MAINT-001', 'Sciences et Technologies', 'Maintenance', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (28, 'Informatique', 'ETFPS-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (29, 'Industriel', 'ETSM-IND-001', 'Sciences et Technologies', 'Technologie Industrielle', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (30, 'Ingenierie et Management des Actions de Developpement', 'EUIOI-INGM-001', 'Arts et Lettres', 'Management', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (30, 'Ingenierie et Management des Actions de Developpement', 'EUIOI-INGM-002', 'Arts et Lettres', 'Management', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (32, 'Gestion', 'GATE-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (32, 'Gestion', 'GATE-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (32, 'Tourisme', 'GATE-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (32, 'Agronomie', 'GATE-AGRO-001', 'Sciences et Technologies', 'Agronomie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (33, 'Management et Sciences', 'HECMM-MGTS-001', 'Sciences de Gestion', 'Management', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (34, 'Sciences de Gestion', 'HEDM-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (34, 'Sciences juridiques', 'HEDM-SCJUR-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (36, 'Informatique', 'ICTUS-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (36, 'Gestion', 'ICTUS-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (38, 'Sciences Politiques', 'IEP-SCPOL-001', 'Droit et Sciences Politiques', 'Sciences Politiques', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (38, 'Sciences Politiques', 'IEP-SCPOL-002', 'Droit et Sciences Politiques', 'Sciences Politiques', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (39, 'Gestion', 'IESTIM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (39, 'Gestion', 'IESTIM-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (39, 'Sciences de Gestion', 'IESTIM-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (39, 'Sciences de l''Informatique', 'IESTIM-SCINFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (40, 'Gestion', 'IESTIMA-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (40, 'Gestion', 'IESTIMA-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (44, 'Droit', 'IFT-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (44, 'Informatique', 'IFT-INFO-001', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (44, 'Information-Communication-Journalisme', 'IFT-INFCOM-001', 'Arts et Lettres', 'Communication', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (44, 'Sciences de l''Environnement', 'IFT-SCENV-001', 'Sciences et Technologies', 'Environnement', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (45, 'Informatique', 'IFTA-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (46, 'BTP', 'IFTBTP-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (47, 'Sciences de l''Environnement', 'IFTMJ-SCENV-001', 'Sciences et Technologies', 'Environnement', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (48, 'Informatique', 'IFTT-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (48, 'BTP', 'IFTT-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (50, 'Sciences et Technologies', 'IISS-SCTECH-001', 'Sciences et Technologies', 'Sciences', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (50, 'Sciences et Technologies', 'IISS-SCTECH-002', 'Sciences et Technologies', 'Sciences', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (50, 'Arts et Lettres', 'IISS-ARTLETT-001', 'Arts et Lettres', 'Arts et Lettres', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (50, 'Arts et Lettres', 'IISS-ARTLETT-002', 'Arts et Lettres', 'Arts et Lettres', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (53, 'Sciences Biologiques et environnementales', 'IMAM-SCBENV-001', 'Sciences et Technologies', 'Sciences Biologiques', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (53, 'Administration', 'IMAM-ADM-001', 'Sciences de Gestion', 'Administration', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (53, 'Management d''Entreprise et Banque', 'IMAM-MGTB-001', 'Sciences de Gestion', 'Management', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (54, 'Hotel and Tourism Management', 'IMT-HOTM-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (54, 'Hotel and Tourism Management', 'IMT-HOTM-002', 'Arts et Lettres', 'Tourisme', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (54, 'Management and Business Studies', 'IMT-MBS-001', 'Sciences de Gestion', 'Management', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (54, 'Management and Business Studies', 'IMT-MBS-002', 'Sciences de Gestion', 'Management', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (54, 'Building and Public Work', 'IMT-BPW-001', 'Sciences et Technologies', 'BTP', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (58, 'Gestion', 'IUR-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (58, 'Gestion', 'IUR-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (58, 'Droit', 'IUR-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (58, 'Droit', 'IUR-DROIT-002', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (58, 'Informatique', 'IUR-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (59, 'Banque et Institutions des micros finances', 'INSPNMAD-BANQ-001', 'Sciences de Gestion', 'Banque', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (62, 'Gestion', 'ITPAME-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (63, 'Gestion', 'IPAM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (64, 'Agronomie', 'IPSATTA-AGRO-001', 'Sciences et Technologies', 'Agronomie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (66, 'Management', 'IAEAC-MGT-001', 'Sciences de Gestion', 'Management', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (66, 'Communication et Journalisme', 'IAEAC-COMMJ-001', 'Arts et Lettres', 'Communication', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (66, 'Gestion', 'IAEAC-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (67, 'Informatique', 'ISAPSP-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (69, 'Gestion', 'ISCAM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (69, 'Gestion', 'ISCAM-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (70, 'Informatique', 'ISCM-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (73, 'Communication', 'ISETES-COMM-001', 'Arts et Lettres', 'Communication', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (73, 'Gestion', 'ISETES-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (74, 'Informatique', 'ISGEI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (74, 'Informatique', 'ISGEI-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (78, 'Gestion Informatique', 'ISIIME-GESTINFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (78, 'Gestion Informatique', 'ISIIME-GESTINFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (78, 'Gestion', 'ISIIME-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (79, 'Informatique', 'ISI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (79, 'Informatique', 'ISI-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (81, 'Technologie', 'ISM2M-TECH-001', 'Sciences et Technologies', 'Technologie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (81, 'Technologie', 'ISM2M-TECH-002', 'Sciences et Technologies', 'Technologie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (83, 'Gestion', 'IUPM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (83, 'Gestion', 'IUPM-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (83, 'Tourisme', 'IUPM-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (83, 'Droit', 'IUPM-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (85, 'Gestion en Administration d''Entreprise', 'ISMST-GADM-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (85, 'Droit et Sciences Politiques', 'ISMST-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (85, 'Droit des Affaires et Administration d''Entreprises', 'ISMST-DROITAFF-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (87, 'Gestion', 'ISNA-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (88, 'Gestion', 'ISNM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (89, 'Sciences de l''Education', 'ISPA-SCEDUC-001', 'Sciences de l''Education', 'Sciences de l''Education', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (89, 'Sciences de la Vie et de la Terre', 'ISPA-SCVT-001', 'Sciences et Technologies', 'Sciences de la Vie et Terre', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (91, 'Droit et Technique des Affaires', 'ISPM-DROITAFF-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (91, 'Technique du Tourisme', 'ISPM-TECHTOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (91, 'Technique du Tourisme', 'ISPM-TECHTOUR-002', 'Arts et Lettres', 'Tourisme', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (91, 'Technique de l''environnement et du Tourisme', 'ISPM-TECHENVTOUR-001', 'Sciences et Technologies', 'Environnement', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (91, 'Environnement et Tourisme', 'ISPM-ENVTOUR-001', 'Sciences et Technologies', 'Environnement', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (91, 'Biotechnologies', 'ISPM-BIOTECH-001', 'Sciences et Technologies', 'Biotechnologies', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (92, 'Gestion et Commerce International', 'ISPMDDF-GCOMINT-001', 'Sciences de Gestion', 'Commerce', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (93, 'Technologie', 'ISPPM-TECH-001', 'Sciences et Technologies', 'Technologie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (97, 'Sciences de l''Environnement', 'ISLEG-SCENV-001', 'Sciences et Technologies', 'Environnement', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (98, 'Gestion', 'ISSIG-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (99, 'Informatique', 'ISSMI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (99, 'Informatique', 'ISSMI-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (99, 'Tourisme, Environnement', 'ISSMI-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (101, 'Gestion', 'ISSG-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (110, 'Gestion et Commerce', 'IUM-GCOM-001', 'Sciences de Gestion', 'Commerce', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (110, 'Gestion', 'IUM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (111, 'Administration d''Entreprise', 'IUPAEM-ADM-001', 'Sciences de Gestion', 'Administration', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (112, 'Informatique', 'JDU-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (112, 'Sciences de la Gestion', 'JDU-SCGEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (116, 'Sciences de la Gestion', 'MU-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (117, 'Droit', 'MUST-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (118, 'Agronomie', 'ONIFRA-AGRO-001', 'Sciences et Technologies', 'Agronomie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (118, 'Environnement', 'ONIFRA-ENV-001', 'Sciences et Technologies', 'Environnement', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (118, 'Sciences de la Communication', 'ONIFRA-SCCOM-001', 'Arts et Lettres', 'Communication', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (118, 'Sciences de l''Informatique', 'ONIFRA-SCINFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (118, 'Tourisme', 'ONIFRA-TOUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (118, 'Droit', 'ONIFRA-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (119, 'Gestion', 'ONIFRA-AMBTM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (120, 'Gestion', 'ONIFRA-ARIV-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (121, 'Gestion', 'ONIFRA-MOR-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (124, 'Sciences de l''Information et Communication', 'SAMIS-SCINFCOM-001', 'Arts et Lettres', 'Communication', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (125, 'Droit', 'UNPT-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (126, 'Informatique', 'TOPINFO-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (127, 'Informatique', 'TSI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (127, 'Informatique', 'TSI-INFO-002', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (127, 'Gestion', 'TSI-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (129, 'Gestion', 'UADV-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (129, 'Gestion', 'UADV-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (129, 'Informatique', 'UADV-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (129, 'Communication', 'UADV-COMM-001', 'Arts et Lettres', 'Communication', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (129, 'Communication', 'UADV-COMM-002', 'Arts et Lettres', 'Communication', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (130, 'Philosophie', 'UCM-PHILO-001', 'Arts et Lettres', 'Philosophie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (130, 'Philosophie', 'UCM-PHILO-002', 'Arts et Lettres', 'Philosophie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (130, 'Psychologie', 'UCM-PSYCH-001', 'Arts et Lettres', 'Psychologie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (130, 'Droit', 'UCM-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (130, 'Gestion', 'UCM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (132, 'Informatique', 'UGSI-INFO-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (132, 'Gestion', 'UGSI-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (132, 'BTP', 'UGSI-BTP-001', 'Sciences et Technologies', 'BTP', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (134, 'Commerce', 'UIM-COMM-001', 'Sciences de Gestion', 'Commerce', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (134, 'Gestion', 'UIM-GEST-001', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (136, 'Communication', 'UPAS-COMM-001', 'Arts et Lettres', 'Communication', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (137, 'Gestion', 'UP-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (137, 'Gestion', 'UP-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (137, 'Philosophie', 'UP-PHILO-001', 'Arts et Lettres', 'Philosophie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (137, 'Informatique de Gestion', 'UP-INFOG-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (138, 'Entreprenariat rural', 'UPAVA-ENTREPURAL-001', 'Sciences de Gestion', 'Entrepreneuriat', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (139, 'Informatique de gestion', 'UPHS-INFOG-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (139, 'Informatique', 'UPHS-INFO-001', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (141, 'Communication', 'UPM-COMM-001', 'Arts et Lettres', 'Communication', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (143, 'Tourisme Durable', 'UTMAD-TOURDUR-001', 'Arts et Lettres', 'Tourisme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (145, 'Droit et Sciences politiques', 'MBS-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (145, 'Droit', 'MBS-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (145, 'Gestion', 'MBS-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (145, 'Gestion', 'MBS-GEST-002', 'Sciences de Gestion', 'Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (145, 'Sciences de Gestion', 'MBS-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (145, 'Sciences de la Communication', 'MBS-SCCOM-001', 'Arts et Lettres', 'Communication', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Chimie', 'UANT-CHEM-001', 'Sciences et Technologies', 'Chimie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Chimie', 'UANT-CHEM-002', 'Sciences et Technologies', 'Chimie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Biologie', 'UANT-BIO-001', 'Sciences et Technologies', 'Biologie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Biologie', 'UANT-BIO-002', 'Sciences et Technologies', 'Biologie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Physique et Applications', 'UANT-PHYSAPP-001', 'Sciences et Technologies', 'Physique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Physique et Applications', 'UANT-PHYSAPP-002', 'Sciences et Technologies', 'Physique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Sciences de la Terre et de l''Environnement', 'UANT-SCTERR-001', 'Sciences et Technologies', 'Sciences de la Terre', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Sciences de la Terre et de l''Environnement', 'UANT-SCTERR-002', 'Sciences et Technologies', 'Sciences de la Terre', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Informatique et Technologie', 'UANT-INFTECH-001', 'Sciences et Technologies', 'Informatique', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (146, 'Informatique et Technologie', 'UANT-INFTECH-002', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (147, 'Sciences Chimiques', 'UATSN-SCCHEM-001', 'Sciences et Technologies', 'Sciences Chimiques', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (147, 'Sciences Physiques', 'UATSN-SCPHYS-001', 'Sciences et Technologies', 'Sciences Physiques', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (147, 'Sciences de la Nature et de l''Environnement', 'UATSN-SCNENV-001', 'Sciences et Technologies', 'Environnement', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (147, 'Sciences du Vivant et de la Terre', 'UATSN-SCVT-001', 'Sciences et Technologies', 'Sciences de la Vie et Terre', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (147, 'Sciences du Vivant et de la Terre', 'UATSN-SCVT-002', 'Sciences et Technologies', 'Sciences de la Vie et Terre', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (147, 'Sciences et Technologie de l''Information et de la Communication', 'UATSN-STIC-001', 'Sciences et Technologies', 'Technologie Information', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (148, 'Physique Chimie', 'UYFIN-PHYSCHEM-001', 'Sciences et Technologies', 'Physique Chimie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (148, 'Physique Chimie', 'UYFIN-PHYSCHEM-002', 'Sciences et Technologies', 'Physique Chimie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (148, 'Informatique', 'UYFIN-INFO-001', 'Sciences et Technologies', 'Informatique', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (148, 'Maths et Applications', 'UYFIN-MATHAPP-001', 'Sciences et Technologies', 'Mathématiques', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (148, 'Maths et Applications', 'UYFIN-MATHAPP-002', 'Sciences et Technologies', 'Mathématiques', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (148, 'Chimie', 'UYFIN-CHEM-001', 'Sciences et Technologies', 'Chimie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (148, 'Sciences de la vie', 'UYFIN-SCVIE-001', 'Sciences et Technologies', 'Sciences de la Vie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (148, 'Sciences de la vie', 'UYFIN-SCVIE-002', 'Sciences et Technologies', 'Sciences de la Vie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (149, 'Biochimie et Sciences de l''Environnement', 'UMHJ-BIOCHENV-001', 'Sciences et Technologies', 'Biochimie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (149, 'Sciences de la vie, de la terre et de l''environnement', 'UMHJ-SCVTE-001', 'Sciences et Technologies', 'Sciences de la Vie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (149, 'Sciences de la vie, de la terre et de l''environnement', 'UMHJ-SCVTE-002', 'Sciences et Technologies', 'Sciences de la Vie', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (149, 'Droit et sciences Politiques', 'UMHJ-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (150, 'Droit et Sciences Politiques', 'UTOA-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (150, 'Droit', 'UTOA-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (150, 'Gestion', 'UTOA-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (150, 'Sciences de Gestion', 'UTOA-SCGEST-001', 'Sciences de Gestion', 'Sciences de Gestion', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (150, 'Physique Chimie', 'UTOA-PHYSCHEM-001', 'Sciences et Technologies', 'Physique Chimie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (151, 'Droit', 'UTOL-DROIT-001', 'Droit et Sciences Politiques', 'Droit', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (151, 'Gestion', 'UTOL-GEST-001', 'Sciences de Gestion', 'Gestion', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (151, 'Sciences Marines et Halieutiques', 'UTOL-SCMH-001', 'Sciences et Technologies', 'Sciences Marines', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (151, 'Sciences Marines et Halieutiques', 'UTOL-SCMH-002', 'Sciences et Technologies', 'Sciences Marines', 'Master', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =====================================================
-- RESUME FINAL
-- =====================================================
-- Total établissements privés : 145
-- Total établissements publics : 6
-- TOTAL : 151 établissements
-- Filieres insérées : Plus de 300+

-- SECTION B: ETABLISSEMENTS PARAMEDICAUX
-- =====================================================

-- 1. UNIVERSITE SAINT VINCENT DE PAUL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE SAINT VINCENT DE PAUL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (152, 'Sage-femme', 'USVP-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 2. AROVY HEALTHCARE UNIVERSITY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('AROVY HEALTHCARE UNIVERSITY', 'privee', 'Ambohitantely', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (153, 'Soins de Santé', 'AHU-SOINS-001', 'Sciences et Technologies', 'Santé', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 3. AROVY HEALTHCARE UNIVERSITY MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('AROVY HEALTHCARE UNIVERSITY MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 4. ECOLE DE FORMATION INFIRMIER
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DE FORMATION INFIRMIER MANDRITSARA', 'privee', 'Mandritsara', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (154, 'Sage-femme', 'EFI-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 5. ESFPB
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ESFPB', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (155, 'Sage-femme', 'ESFPB-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 6. ESIJEAN PAUL II
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ESIJEAN PAUL II', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (156, 'Sage-femme', 'ESIJP2-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 7. ESIF
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ESIF', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (157, 'Sage-femme', 'ESIF-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 8. ESISFA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ESISFA', 'privee', 'Moramanga', 'Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (158, 'Sage-femme', 'ESISFA-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 9. ESPM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ESPM', 'privee', 'Itaosy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 10. ESPM ANDRAVOAHANGY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DE SANTE PUBLIQUE ET MEDECINE', 'privee', 'Andravoahangy Ambony', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 11. IFAS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION AUXILIAIRE SANTE', 'privee', 'Analamahitsy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (161, 'Technicien de Laboratoire', 'IFAS-TECH-001', 'Sciences et Technologies', 'Laboratoire', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (161, 'Sage-femme', 'IFAS-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 12. IFIMA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION INFIRMIER ET MATERNITE', 'privee', 'Antalaha', 'Sava', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (162, 'Sage-femme', 'IFIMA-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 13. IFISA ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION INFIRMIER SAGE-FEMME AUXILIAIRE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (163, 'Sage-femme', 'IFISA-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 14. IFISA ANTANANARIVO 2
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION INFIRMIER SAGE-FEMME AUXILIAIRE 2', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (164, 'Sage-femme', 'IFISA2-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 15. IFISA ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION INFIRMIER SAGE-FEMME AUXILIAIRE ANTSIRANANA', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 16. IFPA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PARAMEDICAL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 17. IFPAMA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PARAMEDICAL MALAGASY', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (167, 'Infirmier', 'IFPAMA-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 18. IFP CRAC ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PARAMEDICAL CRAC', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 19. IFP CRAC FIANARANTSOA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PARAMEDICAL CRAC FIANARANTSOA', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 20. IFP MELAKY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PARAMEDICAL MELAKY', 'privee', 'Maintirano', 'Melaky', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 21. IFP MANDRITSARA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PARAMEDICAL MANDRITSARA', 'privee', 'Mandritsara', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (171, 'Infirmier', 'IFPMDR-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 22. IFP ANTSOHIHY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PARAMEDICAL ANTSOHIHY', 'privee', 'Ambalatany Antsohihy', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (172, 'Infirmier', 'IFPANT-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 23. IFPT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION PARAMEDICAL TSIROANOMANDIDY', 'privee', 'Tsiroanomandidy', 'Bongolava', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (173, 'Sage-femme', 'IFPT-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 24. IFSI SJA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SOINS INFIRMIERS SAINT JOSEPH ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (174, 'Infirmier', 'IFSISJA-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 25. IFSM ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SANTE-MEDECINE ANTANANARIVO', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 26. IFSM ANALANJIROFO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SANTE-MEDECINE ANALANJIROFO', 'privee', 'Analanjirofo', 'Sava', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 27. IFSM 67 HA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SANTE-MEDECINE 67 HA', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 28. IFSP ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL ANTANANARIVO', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (177, 'Infirmier', 'IFSPANT-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 29. IFSP MAHAMASINA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL MAHAMASINA', 'privee', 'Mahamasina', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 30. IFSP LES ROSSIGNOLS FIANARANTSOA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL LES ROSSIGNOLS', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 31. IFSP NOSY BE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL NOSY BE', 'privee', 'Nosy Be', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 32. IFSPR MANANJARY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SAGE-FEMME PARAMEDICAL MANANJARY', 'privee', 'Mananjary', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 33. IFSTM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT DE FORMATION SANTE TECHNICIEN MEDECIN', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (181, 'Technicien de Laboratoire', 'IFSTM-TECH-001', 'Sciences et Technologies', 'Laboratoire', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 34. INSFP TOLIARA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR DE FORMATION PARAMEDICAL TOLIARA', 'privee', 'Toliara', 'Androy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 35. INSFPTA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR FORMATION PARAMEDICAL TOLIARY ANOSY', 'privee', 'Toliary', 'Anosy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 36. INSPAFORT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL FORT', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 37. INSPALM TOLIARA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL TOLIARA', 'privee', 'Toliara', 'Androy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (184, 'Infirmier', 'INSPALM-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 38. INSPALMA FANDRIANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL FANDRIANA', 'privee', 'Fandriana', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 39. INSPALMA AMBATOLAMPY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL AMBATOLAMPY', 'privee', 'Ambatolampy', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 40. INSPALMA MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 41. INSPAMEN ANTSIRABE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL ANTSIRABE', 'privee', 'Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 42. INSPAMEN MIARINARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL MIARINARIVO', 'privee', 'Miarinarivo', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 43. INSPNMAD ANTANANARIVO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR ANTANANARIVO', 'privee', 'Ambohimanarina', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (188, 'Infirmier', 'INSPNMAD-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (188, 'Technicien de laboratoire', 'INSPNMAD-TECH-001', 'Sciences et Technologies', 'Laboratoire', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (188, 'Urgences et Catastrophes', 'INSPNMAD-URG-001', 'Sciences et Technologies', 'Urgences', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 44. INSPNMAD MANAKAMBAHINY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR MANAKAMBAHINY', 'privee', 'Manakambahiny', 'Bongolava', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 45. INSPNMAD MAEVATANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR MAEVATANANA', 'privee', 'Maevatanana', 'Bongolava', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (190, 'Infirmier', 'INSPNMAD-MAE-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 46. INSPNMAD MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (191, 'Infirmier', 'INSPNMAD-MHJ-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 47. INSPNMAD FIANARANTSOA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR FIANARANTSOA', 'privee', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 48. INSPNMAD TOLIARA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR TOLIARA', 'privee', 'Toliara', 'Androy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (193, 'Infirmier', 'INSPNMAD-TOL-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 49. IP LE BON SAMARITAIN
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT PARAMEDICAL LE BON SAMARITAIN', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (194, 'Sage-femme', 'IPBS-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 50. IPPI
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT PARAMEDICAL PRIVÉ INTERNATIONAL', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 51. ISAPSP
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE EN AUXILIAIRE PARAMEDICAL SAGE-FEMME ET PROFESSIONNELLES', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (196, 'Sage-femme', 'ISAPSP-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 52. ISB
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE EN AUXILIAIRE SANTE BIOMEDICAL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (197, 'Technicien de Laboratoire', 'ISB-TECH-001', 'Sciences et Technologies', 'Laboratoire', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (197, 'Infirmier', 'ISB-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 53. ISFP ANDAPA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE DE FORMATION PARAMEDICAL ANDAPA', 'privee', 'Andapa', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 54. ISFP ANDOHARANOFOTSY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE DE FORMATION PARAMEDICAL ANDOHARANOFOTSY', 'privee', 'Andoharanofotsy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 55. ISFP ANDAFIATSIMO TANJOMBATO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE DE FORMATION PARAMEDICAL ANDAFIATSIMO TANJOMBATO', 'privee', 'Andafiatsimo Tanjombato', 'Atsimo Andrefana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (200, 'Sage-femme', 'ISFP-TAJ-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 56. ISFPM MEGNANARA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE DE FORMATION PARAMEDICAL MEGNANARA', 'privee', 'Vangaindrano', 'Atsimo Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (201, 'Sage-femme', 'ISFPM-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 57. ISFPP MANAKARA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE DE FORMATION PARAMEDICAL PROFESSIONNEL MANAKARA', 'privee', 'Manakara', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 58. ISFP NAMEHANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE DE FORMATION PARAMEDICAL NAMEHANA', 'privee', 'Namehana', 'Atsimo Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 59. ISFP FORT DAUPHIN
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE DE FORMATION PARAMEDICAL FORT DAUPHIN', 'privee', 'Fort Dauphin', 'Anosy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 60. ISFSSP
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE DE FORMATION SAGE-FEMME ET SOINS PARAMEDICAL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 61. ISISFA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE INFIRMIER SAGE-FEMME AUXILIAIRE', 'privee', 'Ankadifotsy Befelatanana', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (205, 'Technicien de Laboratoire', 'ISISFA-TECH-001', 'Sciences et Technologies', 'Laboratoire', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 62. ISISFA MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE INFIRMIER SAGE-FEMME AUXILIAIRE MAHAJANGA', 'privee', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 63. ISISFA ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE INFIRMIER SAGE-FEMME AUXILIAIRE ANTSIRANANA', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 64. ISISFA ITAOSY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE INFIRMIER SAGE-FEMME AUXILIAIRE ITAOSY', 'privee', 'Itaosy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (208, 'Infirmier', 'ISISFA-ITAO-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 65. ISPASM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL SAINT MICHEL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 66. ISPAVA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL VATOMANDRY', 'privee', 'Vatomandry', 'Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (210, 'Infirmier', 'ISPAVA-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 67. ISPMD ANOSIBE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL MEDECINE DENTAIRE ANOSIBE', 'privee', 'Anosibe', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (211, 'Technicien de Laboratoire', 'ISPMD-TECH-001', 'Sciences et Technologies', 'Laboratoire', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 68. ISPMD TSIROANOMANDIDY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL MEDECINE DENTAIRE TSIROANOMANDIDY', 'privee', 'Tsiroanomandidy', 'Bongolava', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 69. ISPMD AMBOHIMANGAKELY
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL MEDECINE DENTAIRE AMBOHIMANGAKELY', 'privee', 'Ambohimangakely', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (213, 'Sage-femme', 'ISPMD-AMB-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 70. ISPNA ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL NOVATEURS ANTSIRANANA', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 71. ISPPS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL PROFESSIONNEL SANTE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 72. ISPRAITRA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL RAITRA', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (216, 'Sage-femme', 'ISPRAITRA-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 73. ISPRD
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL REGION DIANA', 'privee', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (217, 'Sage-femme', 'ISPRD-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 74. ISPRSAVA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL REGION SAVA', 'privee', 'Antalaha', 'Sava', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 75. ISPS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE PARAMEDICAL SANTE', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (219, 'Sage-femme', 'ISPS-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 76. ISSFP
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE SAGE-FEMME PARAMEDICAL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (220, 'Sage-femme', 'ISSFP-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 77. ISSSD
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT SPECIALISE SANTE SAGE-FEMME DENTAIRE', 'privee', 'Mahitsy', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (221, 'Technicien de Laboratoire', 'ISSSD-TECH-001', 'Sciences et Technologies', 'Laboratoire', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (221, 'Sage-femme', 'ISSSD-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (221, 'Technicien de Radiologie', 'ISSSD-RADIO-001', 'Sciences et Technologies', 'Radiologie', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 78. PARAMA-IF AMBOSITRA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT PARAMEDICAL AMBOSITRA', 'privee', 'Ambositra', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (222, 'Infirmier', 'PARAMA-IF-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 79. PARAMA-IF AMBOHIDRATRIMO
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('INSTITUT PARAMEDICAL AMBOHIDRATRIMO', 'privee', 'Ambohidratrimo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (223, 'Infirmier', 'PARAMA-AMBO-INF-001', 'Sciences et Technologies', 'Infirmier', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 80. SEFAM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('SECOURS FEMININ ET ACCUEIL MEDICAL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (224, 'Sage-femme', 'SEFAM-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 81. UACEEM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ACEEM', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 82. UAZ PARAMEDICAL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE ADVENTISTE PARAMEDICAL', 'privee', 'Sambaina Antsirabe', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (226, 'Sage-femme', 'UAZ-PARAM-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 83. UGSI PARAMEDICAL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE GSI PARAMEDICAL', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 84. UPA HPI MASCA PARAMEDICAL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE AVARADRANO PARAMEDICAL', 'privee', 'Namehana', 'Atsimo Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (228, 'Sage-femme', 'UPAHPI-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 85. UPRIM PARAMEDICAL
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE PRIVEE DE MADAGASCAR PARAMEDICAL', 'privee', 'Andavamamba', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (229, 'Sage-femme', 'UPRIM-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 86. URM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('UNIVERSITE REGION MADAGASCAR', 'privee', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (230, 'Sage-femme', 'URM-SF-001', 'Sciences et Technologies', 'Sage-femme', 'Licence', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =====================================================
-- SECTION C: ECOLES DOCTORALES
-- =====================================================

-- 1. ECOLE DOCTORALE - PLURIDISCIPLINARITE DES DISCIPLINES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE PLURIDISCIPLINARITE DES DISCIPLINES', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (231, 'Pluridisciplinarite des Disciplines', 'ED-PED-001', 'Sciences et Technologies', 'Recherche', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 2. ECOLE DOCTORALE - ENVIRONNEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE ENVIRONNEMENT', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (232, 'Environnement', 'ED-ENV-001', 'Sciences et Technologies', 'Environnement', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 3. ECOLE DOCTORALE - RESSOURCES AGRICOLES ET ALIMENTAIRES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE RESSOURCES AGRICOLES ET ALIMENTAIRES', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (233, 'Ressources Agricoles et Alimentaires', 'ED-GPSIAA-001', 'Sciences et Technologies', 'Agronomie', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 4. ECOLE DOCTORALE - INGENIEURS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE INGENIEURS', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (234, 'Ingenierie', 'ED-INGE-001', 'Sciences et Technologies', 'Ingénierie', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 5. ECOLE DOCTORALE - SCIENCES ET TECHNOLOGIES DE L'INFORMATION ET COMMUNICATION
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES TECHNOLOGIES INFORMATION COMMUNICATION', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (235, 'Sciences et Techniques Information Communication', 'ED-STICOM-001', 'Sciences et Technologies', 'Informatique', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 6. ECOLE DOCTORALE - SCIENCES DE LA VIE ET ENVIRONNEMENT
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES VIE ENVIRONNEMENT', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (236, 'Sciences de la Vie et Environnement', 'ED-SVE-001', 'Sciences et Technologies', 'Sciences Biologiques', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 7. ECOLE DOCTORALE - PHYSIQUE ET APPLICATIONS
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE PHYSIQUE APPLICATIONS', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (237, 'Physique et Applications', 'ED-PA-001', 'Sciences et Technologies', 'Physique', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 8. ECOLE DOCTORALE - MATHEMATIQUES APPLIQUEES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE MATHEMATIQUES APPLIQUEES', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (238, 'Mathematiques Appliquees', 'ED-MA-001', 'Sciences et Technologies', 'Mathématiques', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 9. ECOLE DOCTORALE - VALORISATION DES RESSOURCES NATURELLES RENOUVELABLES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE VALORISATION RESSOURCES NATURELLES RENOUVELABLES', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (239, 'Valorisation des Ressources Naturelles Renouvelables', 'ED-VRNR-001', 'Sciences et Technologies', 'Ressources Naturelles', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 10. ECOLE DOCTORALE - SCIENCES DE LA VIE ET SANTE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES VIE SANTE', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (240, 'Sciences de la Vie et Sante', 'ED-SVS-001', 'Sciences et Technologies', 'Sciences de la Santé', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 11. ECOLE DOCTORALE - GESTION DES RESSOURCES NATURELLES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE GESTION RESSOURCES NATURELLES', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (241, 'Gestion des Ressources Naturelles', 'ED-GRND-001', 'Sciences et Technologies', 'Gestion Environnement', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 12. ECOLE DOCTORALE - SCIENCES HUMAINES ET SOCIALES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES HUMAINES SOCIALES', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (242, 'Sciences Humaines et Sociales', 'ED-SHS-001', 'Arts et Lettres', 'Sciences Sociales', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 13. ECOLE DOCTORALE - AFFAIRES COMPTABLES FINANCIERES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE AFFAIRES COMPTABLES FINANCIERES', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (243, 'Affaires Comptables et Financieres', 'ED-ACF-001', 'Sciences de Gestion', 'Finance', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 14. ECOLE DOCTORALE - ENVIRONNEMENT ET RESSOURCES NATURELLES ENRE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE ENVIRONNEMENT RESSOURCES NATURELLES', 'publique', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (244, 'Environnement et Ressources Naturelles', 'ED-ENRE-001', 'Sciences et Technologies', 'Environnement', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 15. ECOLE DOCTORALE - INFORMATIQUE TECHNOLOGIE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE INFORMATIQUE TECHNOLOGIE', 'publique', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (245, 'Informatique et Technologie', 'ED-INFTECH-001', 'Sciences et Technologies', 'Informatique', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 16. ECOLE DOCTORALE - DYNAMIQUE CADRE VIE CADDETHIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE DYNAMIQUE CADRE VIE', 'publique', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (246, 'Dynamique du Cadre de Vie', 'ED-CADDETHIQUE-001', 'Sciences et Technologies', 'Environnement', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 17. ECOLE DOCTORALE - GENESIS ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE GENESIS ANTSIRANANA', 'publique', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (247, 'Genetique Evolution Environnement Sciences Innovation', 'ED-GENESIS-001', 'Sciences et Technologies', 'Génétique', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 18. ECOLE DOCTORALE - DROIT SCIENCES POLITIQUES ANTSIRANANA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE DROIT SCIENCES POLITIQUES ANTSIRANANA', 'publique', 'Antsiranana', 'Diana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (248, 'Droit et Sciences Politiques', 'ED-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 19. ECOLE DOCTORALE - GEOCHIMEDE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE GEOCHIMEDE', 'publique', 'Fianarantsoa', 'Vakinankaratra', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (249, 'Geochimica Mineralogica Environnementale Dynamique Ecosystemique', 'ED-GEOCHIMEDE-001', 'Sciences et Technologies', 'Chimie', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 20. ECOLE DOCTORALE - SCIENCES MARINES HALIEUTIQUES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES MARINES HALIEUTIQUES', 'publique', 'Toliara', 'Androy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (250, 'Sciences Marines et Halieutiques', 'ED-SMH-001', 'Sciences et Technologies', 'Sciences Marines', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 21. ECOLE DOCTORALE - BIOTECHNOLOGIES ENVIRONNEMENT TROPICAUX
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE BIOTECHNOLOGIES ENVIRONNEMENT TROPICAUX', 'publique', 'Toliara', 'Androy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (251, 'Biotechnologies et Environnements Tropicaux', 'ED-BET-001', 'Sciences et Technologies', 'Biotechnologies', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 22. ECOLE DOCTORALE - LANGAGES HISTOIRES INTERACTIONS CRITIQUES
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE LANGAGES HISTOIRES INTERACTIONS CRITIQUES', 'publique', 'Toliara', 'Androy', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (252, 'Langages Histoires Interactions Critiques', 'ED-LHIC-001', 'Arts et Lettres', 'Langues', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 23. ECOLE DOCTORALE - SCIENCES POLITIQUES MADAGASCAR
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES POLITIQUES MADAGASCAR', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (253, 'Sciences Politiques Madagascar', 'ED-SPM-001', 'Droit et Sciences Politiques', 'Sciences Politiques', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 24. ECOLE DOCTORALE - SCIENCES HUMAINES SOCIALES JURIDIQUE POLITIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES HUMAINES SOCIALES JURIDIQUE POLITIQUE', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (254, 'Education Droit Histoire Sciences Politiques Humaines', 'ED-EDHSJP-001', 'Arts et Lettres', 'Sciences Sociales', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 25. ECOLE DOCTORALE - SCIENCES THEO PHIL UNIVERSITE FJKM
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES THEO PHIL', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (255, 'Sciences Theologiques Philosophiques', 'ED-STPFJKM-001', 'Arts et Lettres', 'Philosophie', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 26. ECOLE DOCTORALE - SCIENCES UNIVERSITE CATHOLIQUE
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES UCM', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (256, 'Sciences Humaines Sociales', 'ED-SCIENCES-001', 'Sciences et Technologies', 'Recherche', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 27. ECOLE DOCTORALE - SCIENCES POLITIQUES IEP
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE SCIENCES POLITIQUES IEP', 'publique', 'Antananarivo', 'Analamanga', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (257, 'Sciences Politiques et Gouvernance', 'ED-SCI-001', 'Droit et Sciences Politiques', 'Sciences Politiques', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 28. ECOLE DOCTORALE - TOAMASINA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE TOAMASINA', 'publique', 'Toamasina', 'Atsinanana', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (258, 'Droit et Sciences Politiques', 'ED-TOAM-DROITSP-001', 'Droit et Sciences Politiques', 'Droit', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 29. ECOLE DOCTORALE - MAHAJANGA
INSERT INTO universites (nom, type, ville, wilaya, actif, created_at, updated_at) VALUES ('ECOLE DOCTORALE MAHAJANGA', 'publique', 'Mahajanga', 'Boeny', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO filieres (universite_id, nom, code, domaine, specialite, niveau, actif, created_at, updated_at) VALUES (259, 'Sciences Sociales Sciences Homme', 'ED-MAHAJ-3SH-001', 'Arts et Lettres', 'Sciences Sociales', 'Doctorat', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- =====================================================
-- RESUME FINAL COMPLET
-- =====================================================
-- Établissements paramédicaux : 86
-- Écoles doctorales : 29
-- Total établissements (privés + publics + paramédicaux + doctorales) : 296
-- Filières totales insérées : Plus de 400+
