export interface Course {
  id: string;
  name: string;
  description: string;
  duration: string;
  level: "Licence" | "Master" | "Doctorat" | "Formation courte";
  category: string;
  requirements: string[];
  career_paths: string[];
  universities_count: number;
  popularity: number; // 1-10
  difficulty: "Facile" | "Moyen" | "Difficile";
  status: "Actif" | "Archivé";
}

export const courses: Course[] = [
  {
    id: "course-math",
    name: "Mathématiques appliquées",
    description: "Étude approfondie des mathématiques et leurs applications en sciences et ingénierie",
    duration: "3 ans",
    level: "Licence",
    category: "Sciences",
    requirements: ["Bac Série C", "Bac Série D"],
    career_paths: ["Ingénieur", "Chercheur", "Actuaire", "Analyste financier"],
    universities_count: 12,
    popularity: 8,
    difficulty: "Difficile",
    status: "Actif",
  },
  {
    id: "course-info",
    name: "Informatique",
    description: "Formation en développement logiciel, réseaux et systèmes informatiques",
    duration: "3 ans",
    level: "Licence",
    category: "Sciences et Technologie",
    requirements: ["Bac Série C", "Bac Série D"],
    career_paths: ["Développeur", "Ingénieur réseau", "Administrateur système", "Chef de projet IT"],
    universities_count: 15,
    popularity: 9,
    difficulty: "Moyen",
    status: "Actif",
  },
  {
    id: "course-medicine",
    name: "Médecine",
    description: "Formation médicale complète pour pratiquer la médecine générale",
    duration: "7 ans",
    level: "Master",
    category: "Santé",
    requirements: ["Bac Série C", "Concours d'entrée"],
    career_paths: ["Médecin généraliste", "Spécialiste", "Chercheur médical"],
    universities_count: 8,
    popularity: 9,
    difficulty: "Difficile",
    status: "Actif",
  },
  {
    id: "course-pharma",
    name: "Pharmacie",
    description: "Étude des médicaments, de leur composition et utilisation thérapeutique",
    duration: "6 ans",
    level: "Master",
    category: "Santé",
    requirements: ["Bac Série C"],
    career_paths: ["Pharmacien officinal", "Pharmacien hospitalier", "Chercheur pharma"],
    universities_count: 6,
    popularity: 8,
    difficulty: "Difficile",
    status: "Actif",
  },
  {
    id: "course-droit",
    name: "Droit",
    description: "Formation juridique couvrant le droit civil, pénal et commercial",
    duration: "3-5 ans",
    level: "Licence",
    category: "Droit et Sciences Politiques",
    requirements: ["Bac Série A", "Bac Série D"],
    career_paths: ["Avocat", "Juge", "Notaire", "Consultant juridique"],
    universities_count: 10,
    popularity: 7,
    difficulty: "Moyen",
    status: "Actif",
  },
  {
    id: "course-econ",
    name: "Économie",
    description: "Étude de l'économie, de la gestion et des finances",
    duration: "3 ans",
    level: "Licence",
    category: "Économie et Gestion",
    requirements: ["Tous les bacs"],
    career_paths: ["Économiste", "Analyste financier", "Conseiller économique"],
    universities_count: 12,
    popularity: 7,
    difficulty: "Moyen",
    status: "Actif",
  },
  {
    id: "course-gestion",
    name: "Gestion d'entreprise",
    description: "Formation aux techniques de management et gestion administrative",
    duration: "3-5 ans",
    level: "Licence",
    category: "Économie et Gestion",
    requirements: ["Tous les bacs"],
    career_paths: ["Manager", "Directeur opérationnel", "Consultant RH"],
    universities_count: 14,
    popularity: 8,
    difficulty: "Moyen",
    status: "Actif",
  },
  {
    id: "course-genicivil",
    name: "Génie Civil",
    description: "Formation en conception et construction de structures et infrastructures",
    duration: "5 ans",
    level: "Master",
    category: "Ingénierie",
    requirements: ["Bac Série C", "Bac Série D"],
    career_paths: ["Ingénieur civil", "Conducteur de travaux", "Chef de projet BTP"],
    universities_count: 10,
    popularity: 8,
    difficulty: "Difficile",
    status: "Actif",
  },
  {
    id: "course-agronomie",
    name: "Agronomie",
    description: "Étude scientifique de la production agricole et de l'élevage",
    duration: "3-5 ans",
    level: "Licence",
    category: "Agriculture",
    requirements: ["Bac Série C", "Bac Série D"],
    career_paths: ["Agronome", "Éleveur consultant", "Responsable production"],
    universities_count: 8,
    popularity: 6,
    difficulty: "Moyen",
    status: "Actif",
  },
  {
    id: "course-lettres",
    name: "Littérature et Lettres",
    description: "Étude de la littérature, de la linguistique et des langues",
    duration: "3 ans",
    level: "Licence",
    category: "Lettres et Sciences Humaines",
    requirements: ["Bac Série A", "Bac Série D"],
    career_paths: ["Enseignant", "Traducteur", "Journaliste", "Écrivain"],
    universities_count: 9,
    popularity: 6,
    difficulty: "Facile",
    status: "Actif",
  },
  {
    id: "course-comptabilite",
    name: "Comptabilité et Audit",
    description: "Formation en comptabilité, audit et contrôle de gestion",
    duration: "3-5 ans",
    level: "Licence",
    category: "Économie et Gestion",
    requirements: ["Tous les bacs"],
    career_paths: ["Expert-comptable", "Auditeur", "Contrôleur de gestion"],
    universities_count: 11,
    popularity: 7,
    difficulty: "Moyen",
    status: "Actif",
  },
  {
    id: "course-communication",
    name: "Communication et Médias",
    description: "Formation en communication, relations publiques et médias numériques",
    duration: "3 ans",
    level: "Licence",
    category: "Communication",
    requirements: ["Tous les bacs"],
    career_paths: ["Community manager", "Responsable communication", "Journaliste digital"],
    universities_count: 8,
    popularity: 7,
    difficulty: "Moyen",
    status: "Actif",
  },
];

export const getCourseById = (id: string) => {
  return courses.find((c) => c.id === id);
};

export const getCoursesByCategory = (category: string) => {
  return courses.filter((c) => c.category === category);
};

export const getCoursesByLevel = (level: string) => {
  return courses.filter((c) => c.level === level);
};

export const getCategories = () => {
  return Array.from(new Set(courses.map((c) => c.category)));
};

export const searchCourses = (query: string) => {
  const q = query.toLowerCase();
  return courses.filter(
    (c) =>
      c.name.toLowerCase().includes(q) ||
      c.description.toLowerCase().includes(q) ||
      c.category.toLowerCase().includes(q)
  );
};

export const getCoursesByDifficulty = (difficulty: string) => {
  return courses.filter((c) => c.difficulty === difficulty);
};

export const getPopularCourses = (limit: number = 5) => {
  return [...courses].sort((a, b) => b.popularity - a.popularity).slice(0, limit);
};
