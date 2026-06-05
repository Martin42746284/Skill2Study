export interface Parcours {
  id: number;
  name: string;
  description: string;
}

export interface Field {
  id: number;
  name: string;
  domain: string;
  duration: string;
  demand: number;
  universityIds: number[];
  parcours: Parcours[];
  careers: string[];
  status: "Active" | "Inactive";
}

export const fields: Field[] = [
  {
    id: 1,
    name: "Informatique",
    domain: "Sciences & Technologies",
    duration: "5 ans (Licence + Master)",
    demand: 34,
    universityIds: [1, 3, 6],
    parcours: [
      { id: 1, name: "Génie Logiciel", description: "Conception et développement de logiciels" },
      { id: 2, name: "Intelligence Artificielle", description: "Machine Learning, Deep Learning, NLP" },
      { id: 3, name: "Systèmes d'Information", description: "Bases de données, ERP, BI" },
      { id: 4, name: "Réseaux & Sécurité", description: "Administration réseau, cybersécurité" },
    ],
    careers: ["Développeur", "Data Scientist", "DevOps"],
    status: "Active",
  },
  {
    id: 2,
    name: "Médecine",
    domain: "Sciences Médicales",
    duration: "7 ans",
    demand: 22,
    universityIds: [1, 4, 5],
    parcours: [
      { id: 1, name: "Médecine Générale", description: "Formation généraliste" },
      { id: 2, name: "Chirurgie", description: "Spécialisation chirurgicale" },
      { id: 3, name: "Pédiatrie", description: "Médecine de l'enfant" },
    ],
    careers: ["Médecin", "Chirurgien", "Chercheur"],
    status: "Active",
  },
  {
    id: 3,
    name: "Génie Civil",
    domain: "Sciences & Technologies",
    duration: "5 ans",
    demand: 15,
    universityIds: [1, 2, 3, 4],
    parcours: [
      { id: 1, name: "Structures", description: "Calcul et conception des structures" },
      { id: 2, name: "Routes et Ponts", description: "Infrastructure de transport" },
      { id: 3, name: "Géotechnique", description: "Fondations et stabilité des sols" },
    ],
    careers: ["Ingénieur civil", "Conducteur de travaux", "Chef de projet BTP"],
    status: "Active",
  },
  {
    id: 4,
    name: "Droit",
    domain: "Sciences Juridiques",
    duration: "3-5 ans",
    demand: 18,
    universityIds: [1, 4, 5, 8],
    parcours: [
      { id: 1, name: "Droit Privé", description: "Droit civil, commercial et des entreprises" },
      { id: 2, name: "Droit Public", description: "Droit administratif et constitutionnel" },
      { id: 3, name: "Droit International", description: "Relations et droit international" },
    ],
    careers: ["Avocat", "Juge", "Notaire", "Consultant juridique"],
    status: "Active",
  },
  {
    id: 5,
    name: "Gestion & Management",
    domain: "Économie et Gestion",
    duration: "3-5 ans",
    demand: 28,
    universityIds: [1, 3, 5, 6],
    parcours: [
      { id: 1, name: "Management Stratégique", description: "Direction et stratégie d'entreprise" },
      { id: 2, name: "Entrepreneuriat", description: "Création et développement d'entreprise" },
      { id: 3, name: "Gestion Financière", description: "Finance d'entreprise et investissement" },
    ],
    careers: ["Manager", "Directeur", "Consultant", "Chef d'entreprise"],
    status: "Active",
  },
  {
    id: 6,
    name: "Comptabilité & Audit",
    domain: "Économie et Gestion",
    duration: "3-5 ans",
    demand: 20,
    universityIds: [1, 6],
    parcours: [
      { id: 1, name: "Comptabilité Générale", description: "Tenue de la comptabilité" },
      { id: 2, name: "Audit et Contrôle", description: "Audit interne et externe" },
      { id: 3, name: "Fiscalité", description: "Optimisation et droit fiscal" },
    ],
    careers: ["Expert-comptable", "Auditeur", "Contrôleur de gestion"],
    status: "Active",
  },
  {
    id: 7,
    name: "Littérature & Langues",
    domain: "Lettres & Sciences Humaines",
    duration: "3 ans",
    demand: 12,
    universityIds: [1, 5, 8],
    parcours: [
      { id: 1, name: "Littérature Française", description: "Littérature et critique littéraire" },
      { id: 2, name: "Langues Étrangères", description: "Apprentissage et traduction" },
      { id: 3, name: "Linguistique", description: "Science du langage" },
    ],
    careers: ["Enseignant", "Traducteur", "Journaliste", "Écrivain"],
    status: "Active",
  },
  {
    id: 8,
    name: "Agronomie",
    domain: "Agriculture & Environnement",
    duration: "3-5 ans",
    demand: 16,
    universityIds: [1, 2, 5],
    parcours: [
      { id: 1, name: "Culture Générale", description: "Production agricole générale" },
      { id: 2, name: "Élevage", description: "Production animale" },
      { id: 3, name: "Horticulture", description: "Production maraîchère" },
    ],
    careers: ["Agronome", "Éleveur consultant", "Responsable production"],
    status: "Active",
  },
  {
    id: 9,
    name: "Communication & Médias",
    domain: "Communication",
    duration: "3 ans",
    demand: 21,
    universityIds: [1, 3, 6],
    parcours: [
      { id: 1, name: "Communication Digitale", description: "Marketing digital et réseaux sociaux" },
      { id: 2, name: "Journalisme", description: "Reportage et investigation" },
      { id: 3, name: "Relations Publiques", description: "Management de réputation" },
    ],
    careers: ["Community Manager", "Responsable communication", "Journaliste"],
    status: "Active",
  },
  {
    id: 10,
    name: "Pharmacie",
    domain: "Sciences Médicales",
    duration: "6 ans",
    demand: 10,
    universityIds: [1, 5],
    parcours: [
      { id: 1, name: "Pharmacie Officinale", description: "Pharmacien en officine" },
      { id: 2, name: "Pharmacie Hospitalière", description: "Pharmacie à l'hôpital" },
      { id: 3, name: "Pharmacologie Clinique", description: "Recherche en médicaments" },
    ],
    careers: ["Pharmacien", "Chercheur pharma", "Responsable QA"],
    status: "Active",
  },
];

export const getFieldById = (id: number) => {
  return fields.find((f) => f.id === id);
};

export const getFieldsByDomain = (domain: string) => {
  return fields.filter((f) => f.domain === domain);
};

export const getFieldsByStatus = (status: "Active" | "Inactive") => {
  return fields.filter((f) => f.status === status);
};

export const getDomains = () => {
  return Array.from(new Set(fields.map((f) => f.domain)));
};

export const searchFields = (query: string) => {
  const q = query.toLowerCase();
  return fields.filter(
    (f) =>
      f.name.toLowerCase().includes(q) ||
      f.domain.toLowerCase().includes(q) ||
      f.parcours.some((p) => p.name.toLowerCase().includes(q))
  );
};

export const getFieldsByDemand = (minDemand: number) => {
  return fields.filter((f) => f.demand >= minDemand).sort((a, b) => b.demand - a.demand);
};

export const getPopularFields = (limit: number = 5) => {
  return [...fields].sort((a, b) => b.demand - a.demand).slice(0, limit);
};
