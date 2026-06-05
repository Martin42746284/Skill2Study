export interface Testimonial {
  id: number;
  student_name: string;
  student_serie: string;
  student_photo: string;
  university_name: string;
  course_name: string;
  rating: number; // 1-5
  text: string;
  date: string;
  status: "Approuvé" | "En attente" | "Rejeté";
}

export const testimonials: Testimonial[] = [
  {
    id: 1,
    student_name: "Mialy Rakoto",
    student_serie: "Série C",
    student_photo: "M",
    university_name: "Université d'Antananarivo",
    course_name: "Informatique",
    rating: 5,
    text: "Excellent programme ! Les enseignants sont très compétents et l'infrastructure est moderne. J'ai pu développer mes compétences en programmation et en gestion de projets. L'université offre aussi des stages en entreprise qui sont vraiment bénéfiques.",
    date: "26/02/2026",
    status: "Approuvé",
  },
  {
    id: 2,
    student_name: "Hery Razafy",
    student_serie: "Série D",
    student_photo: "H",
    university_name: "IST Antananarivo",
    course_name: "Génie Industriel",
    rating: 4,
    text: "Très satisfait de mes études. Les cours sont bien structurés et les professeurs sont disponibles pour aider. Le seul point faible est les locaux qui sont parfois bondés, mais globalement c'est une très bonne expérience.",
    date: "25/02/2026",
    status: "Approuvé",
  },
  {
    id: 3,
    student_name: "Fanja Andria",
    student_serie: "Série A",
    student_photo: "F",
    university_name: "Université Catholique de Madagascar",
    course_name: "Droit",
    rating: 5,
    text: "Je recommande vivement cette université ! Les professeurs sont des experts dans leur domaine et les cours sont très intéressants. La bibliothèque est excellente et les ressources pédagogiques sont riches. J'ai vraiment progressé.",
    date: "24/02/2026",
    status: "Approuvé",
  },
  {
    id: 4,
    student_name: "Tiana Rabe",
    student_serie: "Tech.",
    student_photo: "T",
    university_name: "CFAMA Antsirabe",
    course_name: "Machinisme Agricole",
    rating: 4,
    text: "Formation technique très pratique. On apprend en faisant, ce qui est vraiment efficace. Les équipements sont bons et les instructeurs connaissent très bien le métier. Un bon choix pour une formation courte.",
    date: "23/02/2026",
    status: "Approuvé",
  },
  {
    id: 5,
    student_name: "Noro Randria",
    student_serie: "Série C",
    student_photo: "N",
    university_name: "Université de Fianarantsoa",
    course_name: "Informatique",
    rating: 4,
    text: "Très bonne expérience à Fianarantsoa. Les cours en informatique sont modernes et incluent les dernières technologies. Les laboratoires informatiques sont bien équipés. Seul bémol : la petite taille de la ville peut sembler monotone.",
    date: "22/02/2026",
    status: "Approuvé",
  },
  {
    id: 6,
    student_name: "Voahirana Rina",
    student_serie: "Série C",
    student_photo: "V",
    university_name: "INSCAE",
    course_name: "Comptabilité",
    rating: 5,
    text: "Excellente école de commerce ! Les professeurs sont tous des praticiens du domaine. On apprend les meilleures pratiques comptables et les normes internationales. Les débouchés professionnels sont très bons.",
    date: "20/02/2026",
    status: "Approuvé",
  },
  {
    id: 7,
    student_name: "Andry Rasolofo",
    student_serie: "Série D",
    student_photo: "A",
    university_name: "École Nationale d'Informatique (ENI)",
    course_name: "Développement logiciel",
    rating: 5,
    text: "L'une des meilleures écoles informatiques de Madagascar ! Les cours sont intensifs mais très enrichissants. Les projets réels avec des entreprises donnent une vraie expérience professionnelle. Hautement recommandé pour ceux qui aiment la tech.",
    date: "19/02/2026",
    status: "Approuvé",
  },
  {
    id: 8,
    student_name: "Rina Ratsimalala",
    student_serie: "Série A",
    student_photo: "R",
    university_name: "ENS Fianarantsoa",
    course_name: "Formation pédagogique",
    rating: 3,
    text: "Bonne formation pédagogique mais les ressources manquent parfois. Les professeurs sont compétents et passionnés par l'enseignement. Cependant, l'infrastructure pourrait être améliorée.",
    date: "18/02/2026",
    status: "Approuvé",
  },
  {
    id: 9,
    student_name: "Soa Ramananarivo",
    student_serie: "Série C",
    student_photo: "S",
    university_name: "ACEEM Business School",
    course_name: "Gestion",
    rating: 4,
    text: "Très professionnel comme école. Les cours sont pratiques et tournés vers le monde des affaires. Les partenariats avec les entreprises offrent de bonnes opportunités de stage et d'emploi après.",
    date: "17/02/2026",
    status: "Approuvé",
  },
  {
    id: 10,
    student_name: "Marc Rakoto",
    student_serie: "Série D",
    student_photo: "M",
    university_name: "Université de Toamasina",
    course_name: "Génie maritime",
    rating: 4,
    text: "Formation intéressante avec accès à la mer pour les pratiques. Les enseignants ont une bonne expérience maritime. Le climat tropical est agréable mais l'infrastructure pourrait être modernisée.",
    date: "16/02/2026",
    status: "Approuvé",
  },
  {
    id: 11,
    student_name: "Claudine Andrianampoinimerina",
    student_serie: "Série C",
    student_photo: "C",
    university_name: "ISCAM Business School",
    course_name: "Management",
    rating: 5,
    text: "Super école pour apprendre le management ! Curriculum très complet et professeurs expérimentés. Beaucoup de networking opportunities avec d'autres étudiants et des professionnels. À recommander sans hésitation.",
    date: "15/02/2026",
    status: "Approuvé",
  },
  {
    id: 12,
    student_name: "Jérôme Razafindrakoto",
    student_serie: "Tech.",
    student_photo: "J",
    university_name: "LTP Fianarantsoa",
    course_name: "Génie civil",
    rating: 3,
    text: "Formation technique convenable. Les travaux pratiques sont bien organisés. Cependant, j'aurais souhaité plus de modules sur les technologies modernes en construction. Globalement satisfait.",
    date: "14/02/2026",
    status: "Approuvé",
  },
];

export const getTestimonialById = (id: number) => {
  return testimonials.find((t) => t.id === id);
};

export const getTestimonialsByUniversity = (universityName: string) => {
  return testimonials.filter((t) => t.university_name === universityName);
};

export const getTestimonialsByStatus = (status: "Approuvé" | "En attente" | "Rejeté") => {
  return testimonials.filter((t) => t.status === status);
};

export const getApprovedTestimonials = () => {
  return testimonials.filter((t) => t.status === "Approuvé");
};

export const getPendingTestimonials = () => {
  return testimonials.filter((t) => t.status === "En attente");
};

export const getTestimonialsByRating = (minRating: number) => {
  return testimonials.filter((t) => t.rating >= minRating);
};

export const searchTestimonials = (query: string) => {
  const q = query.toLowerCase();
  return testimonials.filter(
    (t) =>
      t.student_name.toLowerCase().includes(q) ||
      t.university_name.toLowerCase().includes(q) ||
      t.course_name.toLowerCase().includes(q) ||
      t.text.toLowerCase().includes(q)
  );
};

export const getAverageRatingByUniversity = (universityName: string) => {
  const univTestimonials = getTestimonialsByUniversity(universityName);
  if (univTestimonials.length === 0) return 0;
  const sum = univTestimonials.reduce((acc, t) => acc + t.rating, 0);
  return (sum / univTestimonials.length).toFixed(1);
};
