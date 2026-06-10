// ============================================================================
// 👤 USER TYPES
// ============================================================================

export interface User {
  id: number;
  nom: string;
  prenom: string;
  email: string;
  role: 'bachelier' | 'admin';
  serie_bac?: string;
  ville?: string;
  budget_mensuel?: number;
  actif: boolean;
  photo?: string;
  avatar_url?: string;
  createdAt?: string;
  updatedAt?: string;
}

export interface UserProfile extends User {
  annee_bac?: number;
  mention?: 'Passable' | 'Assez bien' | 'Bien' | 'Très bien';
  moyenne_generale?: number;
  notes_matieres?: Record<string, number>;
  competences?: Record<string, number>;
  centres_interet?: string[];
  objectifs_professionnels?: string;
  secteur_vise?: string;
  budget_max_mensuel?: number;
  distance_max_km?: number;
  duree_max_etudes?: number;
  preference_type_univ?: 'publique' | 'privee' | 'indifferent';
  ville_preference?: string;
}

// ============================================================================
// 🏫 UNIVERSITY TYPES
// ============================================================================

export interface University {
  id: number;
  nom?: string;
  name?: string;
  type: 'publique' | 'privee';
  ville?: string;
  city?: string;
  wilaya?: string;
  adresse?: string;
  location?: string;
  site_web?: string;
  website?: string;
  email_contact?: string;
  email?: string;
  telephone?: string;
  phone?: string;
  description?: string;
  logo_url?: string;
  photo?: string;
  date_fondation?: number;
  cout_estimatif?: string;
  costEstimate?: string;
  duree_etudes?: string;
  duration?: string;
  actif?: boolean;
  createdAt?: string;
  updatedAt?: string;
  filieres?: Filiere[];
}

// ============================================================================
// 📚 FILIERE (FIELD OF STUDY) TYPES
// ============================================================================

export interface Filiere {
  id: number;
  universite_id: number;
  nom?: string;
  code?: string;
  domaine?: string;
  domain?: string;
  description?: string;
  specialite?: string;
  niveaux?: string[];
  niveau?: string;
  duree_annees?: string;
  duree?: string;
  cout_annuel?: number;
  cost?: number;
  cout_description?: string;
  langue?: string;
  series_bac_acceptees?: string[];
  moyenne_min_requise?: number;
  competences_requises?: string[];
  centres_interet?: string[];
  difficulte?: 'facile' | 'moyen' | 'difficile' | 'tres_difficile';
  taux_emploi?: number;
  salaire_moyen_debutant?: number;
  debouches?: string[];
  actif?: boolean;
  createdAt?: string;
  updatedAt?: string;
  universite?: University;
  universite_nom?: string;
  parcours?: Parcours[];
}

// ============================================================================
// PARCOURS (STUDY PATH) TYPES
// ============================================================================

export interface Parcours {
  id: number;
  filiere_id: number;
  nom: string;
  code?: string;
  description?: string;
  duree_mois?: number;
  specialisation?: string;
  competences_acquises?: string[];
  debouches_professionnels?: string[];
  actif: boolean;
  createdAt?: string;
  updatedAt?: string;
}

// ============================================================================
// 📋 TEST & ORIENTATION TYPES
// ============================================================================

export interface TestQuestion {
  id: number;
  texte: string;
  categorie?: string;
  series_bac_cibles?: string[];
  ordre?: number;
  actif: boolean;
  options: TestOption[];
  createdAt?: string;
  updatedAt?: string;
}

export interface TestOption {
  id?: number;
  texte: string;
  poids?: Record<string, number>;
}

export interface TestSession {
  id: number;
  user_id: number;
  complete: boolean;
  reponses?: TestAnswer[];
  createdAt?: string;
  updatedAt?: string;
}

export interface TestAnswer {
  id?: number;
  session_id?: number;
  question_id: number;
  option_id: number;
  createdAt?: string;
}

// ============================================================================
// RECOMMENDATION TYPES
// ============================================================================

export interface Recommendation {
  id: number;
  user_id: number;
  filiere_id: number;
  score: number;
  raison?: string;
  sauvegarde: boolean;
  createdAt?: string;
  updatedAt?: string;
  filiere?: Filiere;
}

export interface RecommendationRule {
  id: number;
  nom?: string;
  description?: string;
  poids_serie?: number;
  poids_moyenne?: number;
  poids_interet?: number;
  poids_competences?: number;
  poids_budget?: number;
  poids_duree?: number;
  poids_test?: number;
  moyenne_min_acceptable?: number;
  filtre_eliminer_hors_serie?: boolean;
  filtre_eliminer_hors_budget?: boolean;
  top_n_recommendations?: number;
  methode_scoring?: 'pondere' | 'knn' | 'decision_tree' | 'hybrid';
  notes_modifications?: string;
  actif: boolean;
  createdAt?: string;
  updatedAt?: string;
}

// ============================================================================
// TESTIMONIAL TYPES
// ============================================================================

export interface Testimonial {
  id: number;
  student_name: string;
  student_serie?: string;
  student_photo?: string;
  university_name: string;
  course_name: string;
  text: string;
  rating: number;
  status: 'Approuvé' | 'En attente' | 'Rejeté';
  createdAt?: string;
  updatedAt?: string;
}

// ============================================================================
// ❤️ FAVORITE TYPES
// ============================================================================

export interface Favorite {
  id: number;
  user_id: number;
  filiere_id: number;
  createdAt?: string;
  updatedAt?: string;
  filiere?: Filiere;
}

// ============================================================================
// STATISTICS TYPES
// ============================================================================

export interface DashboardStats {
  totalUniversities: number;
  totalFilieres: number;
  totalUsers: number;
  totalRecommendations: number;
  topFilieres: Array<{
    id: number;
    nom: string;
    taux_recommandation: number;
  }>;
  repartitionSeries: Array<{
    serie: string;
    count: number;
  }>;
  repartitionDomaines: Array<{
    domaine: string;
    count: number;
  }>;
}

// ============================================================================
// 🔄 API RESPONSE TYPES
// ============================================================================

export interface PaginatedResponse<T> {
  success: boolean;
  data?: T[];
  total?: number;
  page?: number;
  pages?: number;
  filieres?: T[];
  universites?: T[];
  [key: string]: any; // Allow flexible response structure
}

export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  message?: string;
  error?: string;
  filiere?: T;
  universite?: T;
  [key: string]: any;
}

// ============================================================================
// 📤 EXPORT TYPES
// ============================================================================

export interface ExportColumn {
  key: string;
  label: string;
}

export interface CSVExportOptions {
  headers?: string[];
  filename?: string;
}

// ============================================================================
// 🗺️ MAP TYPES
// ============================================================================

export interface MapUniversity {
  id: number;
  nom: string;
  ville: string;
  type: 'publique' | 'privee';
  filieres?: Filiere[];
}

export interface CityMarker {
  city: string;
  province?: string;
  lat: number;
  lng: number;
  universities: MapUniversity[];
}

// ============================================================================
// 🔍 SEARCH TYPES
// ============================================================================

export interface SearchUniversity {
  id: number;
  nom: string;
  ville: string;
  type: 'Public' | 'Privé';
  specialties: string[];
  filieresCount: number;
}
