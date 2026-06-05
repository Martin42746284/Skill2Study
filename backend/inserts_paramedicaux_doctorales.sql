-- =====================================================
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
