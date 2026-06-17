-- Insert approved testimonials into the database
INSERT INTO testimonials (id, student_name, student_serie, university_name, course_name, rating, text, status, created_at, updated_at) 
VALUES 
  (3, 'Fanja Andria', 'Série A', 'Université Catholique de Madagascar', 'Droit', 5, 'Je recommande vivement cette université ! Les professeurs sont des experts dans leur domaine et les cours sont très intéressants. La bibliothèque est excellente et les ressources pédagogiques sont riches. J''ai vraiment progressé.', 'Approuvé', NOW(), NOW()),
  (4, 'Tiana Rabe', 'Tech.', 'CFAMA Antsirabe', 'Machinisme Agricole', 4, 'Formation technique très pratique. On apprend en faisant, ce qui est vraiment efficace. Les équipements sont bons et les instructeurs connaissent très bien le métier. Un bon choix pour une formation courte.', 'Approuvé', NOW(), NOW()),
  (5, 'Noro Randria', 'Série C', 'Université de Fianarantsoa', 'Informatique', 4, 'Très bonne expérience à Fianarantsoa. Les cours en informatique sont modernes et incluent les dernières technologies. Les laboratoires informatiques sont bien équipés. Seul bémol : la petite taille de la ville peut sembler monotone.', 'Approuvé', NOW(), NOW()),
  (6, 'Voahirana Rina', 'Série C', 'INSCAE', 'Comptabilité', 5, 'Excellente école de commerce ! Les professeurs sont tous des praticiens du domaine. On apprend les meilleures pratiques comptables et les normes internationales. Les débouchés professionnels sont très bons.', 'Approuvé', NOW(), NOW()),
  (7, 'Andry Rasolofo', 'Série D', 'École Nationale d''Informatique (ENI)', 'Développement logiciel', 5, 'L''une des meilleures écoles informatiques de Madagascar ! Les cours sont intensifs mais très enrichissants. Les projets réels avec des entreprises donnent une vraie expérience professionnelle. Hautement recommandé pour ceux qui aiment la tech.', 'Approuvé', NOW(), NOW()),
  (8, 'Rina Ratsimalala', 'Série A', 'ENS Fianarantsoa', 'Formation pédagogique', 3, 'Bonne formation pédagogique mais les ressources manquent parfois. Les professeurs sont compétents et passionnés par l''enseignement. Cependant, l''infrastructure pourrait être améliorée.', 'Approuvé', NOW(), NOW()),
  (9, 'Soa Ramananarivo', 'Série C', 'ACEEM Business School', 'Gestion', 4, 'Très professionnel comme école. Les cours sont pratiques et tournés vers le monde des affaires. Les partenariats avec les entreprises offrent de bonnes opportunités de stage et d''emploi après.', 'Approuvé', NOW(), NOW()),
  (10, 'Marc Rakoto', 'Série D', 'Université de Toamasina', 'Génie maritime', 4, 'Formation intéressante avec accès à la mer pour les pratiques. Les enseignants ont une bonne expérience maritime. Le climat tropical est agréable mais l''infrastructure pourrait être modernisée.', 'Approuvé', NOW(), NOW()),
  (11, 'Claudine Andrianampoinimerina', 'Série C', 'ISCAM Business School', 'Management', 5, 'Super école pour apprendre le management ! Curriculum très complet et professeurs expérimentés. Beaucoup de networking opportunities avec d''autres étudiants et des professionnels. À recommander sans hésitation.', 'Approuvé', NOW(), NOW()),
  (12, 'Jérôme Razafindrakoto', 'Tech.', 'LTP Fianarantsoa', 'Génie civil', 3, 'Formation technique convenable. Les travaux pratiques sont bien organisés. Cependant, j''aurais souhaité plus de modules sur les technologies modernes en construction. Globalement satisfait.', 'Approuvé', NOW(), NOW())
ON CONFLICT (id) DO UPDATE 
SET 
  student_name = EXCLUDED.student_name,
  student_serie = EXCLUDED.student_serie,
  university_name = EXCLUDED.university_name,
  course_name = EXCLUDED.course_name,
  rating = EXCLUDED.rating,
  text = EXCLUDED.text,
  status = EXCLUDED.status,
  updated_at = NOW();
