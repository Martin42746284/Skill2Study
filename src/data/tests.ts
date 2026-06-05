export interface TestQuestion {
  id: number;
  text: string;
  category: string;
  options?: string[];
  multi?: boolean;
}

export interface OrientationTest {
  id: number;
  name: string;
  description: string;
  questions: TestQuestion[];
  completions: number;
  avgScore: number;
  status: "Publié" | "Brouillon";
  lastUpdated: string;
  duration: string;
  icon: string;
}

export const categories = ["Intérêts", "Aptitudes", "Personnalité", "Valeurs"];

export const initialTests: OrientationTest[] = [
  {
    id: 1,
    name: "Test d'orientation général",
    description: "Un test complet pour découvrir vos intérêts, compétences et préférences d'études à Madagascar.",
    completions: 1240,
    avgScore: 72,
    status: "Publié",
    lastUpdated: "15/02/2026",
    duration: "15 min",
    icon: "🎯",
    questions: [
      { id: 1, text: "Quels domaines vous passionnent le plus ?", category: "Intérêts", options: ["Sciences et technologies", "Médecine et santé", "Lettres et sciences humaines", "Économie et gestion", "Arts et design", "Droit et sciences politiques"], multi: true },
      { id: 2, text: "Dans quelles matières obtenez-vous les meilleurs résultats ?", category: "Aptitudes", options: ["Mathématiques", "Physique-Chimie", "Sciences naturelles", "Langues étrangères", "Littérature", "Informatique"], multi: true },
      { id: 3, text: "Préférez-vous travailler en équipe ou seul ?", category: "Personnalité", options: ["Toujours en équipe", "Plutôt en équipe", "Plutôt seul", "Toujours seul"], multi: false },
      { id: 4, text: "Quel type d'environnement d'études préférez-vous ?", category: "Intérêts", options: ["Université publique", "Grande école", "Institut spécialisé", "Formation en alternance"], multi: false },
      { id: 5, text: "Quelle durée d'études envisagez-vous ?", category: "Valeurs", options: ["Licence (3 ans)", "Master (5 ans)", "Doctorat (8+ ans)", "Formation courte (2 ans)"], multi: false },
      { id: 6, text: "Avez-vous une préférence géographique ?", category: "Intérêts", options: ["Antananarivo", "Fianarantsoa", "Toamasina", "Mahajanga", "Antsiranana", "Toliara", "Pas de préférence"], multi: false },
    ],
  },
  {
    id: 2,
    name: "Test aptitudes scientifiques",
    description: "Évaluez vos aptitudes dans les domaines scientifiques et techniques pour trouver la filière idéale.",
    completions: 580,
    avgScore: 68,
    status: "Publié",
    lastUpdated: "10/02/2026",
    duration: "10 min",
    icon: "🔬",
    questions: [
      { id: 1, text: "La physique vous passionne-t-elle ?", category: "Intérêts", options: ["Oui, beaucoup", "Un peu", "Pas vraiment", "Pas du tout"], multi: false },
      { id: 2, text: "Aimez-vous les expériences en laboratoire ?", category: "Aptitudes", options: ["J'adore", "Ça me plaît", "C'est correct", "Je n'aime pas"], multi: false },
      { id: 3, text: "Êtes-vous à l'aise avec les mathématiques avancées ?", category: "Aptitudes", options: ["Très à l'aise", "Assez à l'aise", "Quelques difficultés", "Pas à l'aise"], multi: false },
      { id: 4, text: "Quels domaines scientifiques vous attirent ?", category: "Intérêts", options: ["Génie informatique", "Génie civil", "Biologie", "Chimie", "Électronique", "Mathématiques appliquées"], multi: true },
    ],
  },
  {
    id: 3,
    name: "Test compétences littéraires",
    description: "Découvrez si les filières littéraires, linguistiques ou en sciences humaines sont faites pour vous.",
    completions: 320,
    avgScore: 75,
    status: "Publié",
    lastUpdated: "08/02/2026",
    duration: "10 min",
    icon: "📚",
    questions: [
      { id: 1, text: "La lecture est-elle une de vos passions ?", category: "Intérêts", options: ["Oui, je lis beaucoup", "J'aime lire de temps en temps", "Rarement", "Non"], multi: false },
      { id: 2, text: "Aimez-vous rédiger des textes ?", category: "Aptitudes", options: ["J'adore écrire", "Ça me plaît", "Seulement quand il faut", "Non"], multi: false },
      { id: 3, text: "Quelles langues maîtrisez-vous ?", category: "Aptitudes", options: ["Malagasy", "Français", "Anglais", "Autre langue étrangère"], multi: true },
      { id: 4, text: "Quel métier vous attire le plus ?", category: "Valeurs", options: ["Enseignant", "Journaliste", "Traducteur", "Écrivain", "Diplomate", "Avocat"], multi: false },
    ],
  },
  {
    id: 4,
    name: "Test profil entrepreneurial",
    description: "Mesurez votre potentiel entrepreneurial et découvrez les formations en gestion et commerce.",
    completions: 190,
    avgScore: 64,
    status: "Brouillon",
    lastUpdated: "01/02/2026",
    duration: "12 min",
    icon: "💼",
    questions: [
      { id: 1, text: "Avez-vous déjà lancé un projet personnel ?", category: "Personnalité", options: ["Oui, plusieurs", "Oui, un", "Non, mais j'aimerais", "Non, ça ne m'intéresse pas"], multi: false },
    ],
  },
  {
    id: 5,
    name: "Test intérêts professionnels",
    description: "Identifiez vos centres d'intérêt professionnels pour une orientation plus précise.",
    completions: 0,
    avgScore: 0,
    status: "Brouillon",
    lastUpdated: "26/02/2026",
    duration: "8 min",
    icon: "🧭",
    questions: [],
  },
];
