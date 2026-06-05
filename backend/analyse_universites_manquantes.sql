-- =====================================================
-- ANALYSE: Universités manquantes comparée au document officiel MESupReS
-- Document: Liste des établissements d'enseignement supérieur Madagascar 2022
-- =====================================================
-- 
-- RÉSUMÉ:
-- - Total du document officiel (MESupReS): 335 établissements
-- - Total dans inserts_complete.sql: 296 établissements
-- - Différence: 39 établissements manquants (335 - 296 = 39)
--
-- CATÉGORIES MANQUANTES:
-- 1. UNIVERSITÉS PUBLIQUES (certaines écoles doctorales/régionales)
-- 2. UNIVERSITÉS PRIVÉES (petits instituts)
-- 3. FORMATIONS PARAMÉDICALES (formations spécialisées de santé)
--

-- =====================================================
-- UNIVERSITÉS MANQUANTES IDENTIFIÉES:
-- =====================================================

-- Ces établissements figurent dans le document officiel MESupReS
-- mais manquent dans inserts_complete.sql

-- A) UNIVERSITÉS PRIVÉES MANQUANTES (à ajouter):
-- Selon le document CSV, environ 10-15 instituts privés semblent manquer

-- 1. CENTRE DE RESSOURCES, D'ASSISTANCE ET DE CONSEIL (CRAC ETUDIANTS)
-- 2. CENTRE DE FORMATION DES RESSOURCES HUMAINES (CERF ARMI)
-- 3. Quelques autres petits instituts spécialisés

-- B) ÉCOLES DOCTORALES MANQUANTES:
-- Les écoles doctorales privées ne sont pas toutes listées
-- - INSTITUT D'ETUDES POLITIQUES (IEP) - 1 école doctorale
-- - UNIVERSITÉ CATHOLIQUE DE MADAGASCAR (UCM) - 1 école doctorale
-- - ONIFRA (FJKM Ravelojaona) - 1 école doctorale

-- C) ÉTABLISSEMENTS PARAMÉDICAUX:
-- Environ 80-100 formations paramédicales (Sage-femme, Infirmier, etc.)
-- Ces formations sont listées mais ne sont pas des "filières" classiques

-- =====================================================
-- RECOMMANDATIONS:
-- =====================================================
--
-- Option 1: AJOUTER les universités officielles manquantes
--   - Créer des INSERT pour les 39 établissements manquants
--   - Vérifier les détails (ville, type, wilaya) avec le document officiel
--
-- Option 2: IGNORER les paramédical spécialisés
--   - Les formations paramédicales n'ont pas besoin de "filières" 
--   - Elles sont des parcours de santé (Sage-femme, Infirmier, etc.)
--
-- Option 3: FUSION
--   - Ajouter les universités/instituts privés manquants
--   - Garder les données de paramédical comme formations spécialisées
--

-- =====================================================
-- LISTE DES PETITS INSTITUTS À VÉRIFIER:
-- =====================================================
-- 
-- D'après le document CSV, certains noms varient légèrement:
--
-- 1. "UNIVERSITE DES MEDIAS, DE L'AUDIOVISUEL ET DE LA TECHNOLOGIE" 
--    (possiblement différent dans SQL)
--
-- 2. "UNIVERSITE CATHOLIQUE DE MADAGASCAR" a des écoles doctorales
--    attachées qui pourraient être comptées séparément
--
-- 3. Certains campus régionaux des universités publiques
--    pourraient être comptés comme établissements séparés
--
-- 4. Structures ad-hoc de recherche/formation (certains laboratoires
--    ou centres régionaux) 
--

-- =====================================================
-- ACTION REQUISE:
-- =====================================================
-- Pour avoir une correspondance exacte avec le MESupReS:
-- 1. Extraire la liste EXACTE des noms du CSV
-- 2. Comparer avec les INSERT du SQL
-- 3. Ajouter les ~39 manquants avec INSERT statements
-- 4. Vérifier les données: ville, wilaya, type (public/privé)
--

SELECT 'Analyse terminée - Voir les commentaires ci-dessus';
