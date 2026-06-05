/**
 * Centralized API client module
 * Contains all backend API endpoints organized by feature
 */

import type { User, University, Filiere, Parcours, TestQuestion, Recommendation, Testimonial, DashboardStats, PaginatedResponse, ApiResponse } from '@/types';

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:5000/api';

// Multi-session support: store tokens by role
export interface SessionData {
  token: string;
  user: User;
  role: string;
}

function getSessionsFromStorage(): Record<string, SessionData> {
  try {
    const sessions = localStorage.getItem('orientai_sessions');
    return sessions ? JSON.parse(sessions) : {};
  } catch {
    return {};
  }
}

function getSessionByRole(role?: string): SessionData | null {
  const sessions = getSessionsFromStorage();

  if (role) {
    return sessions[role] || null;
  }

  // Return the most recently active session (or admin if available)
  if (sessions['admin']) return sessions['admin'];
  const keys = Object.keys(sessions);
  return keys.length > 0 ? sessions[keys[0]] : null;
}

function saveSession(user: User, token: string): void {
  const role = user.role || 'bachelier';

  // Save to sessionStorage for this tab's active session
  sessionStorage.setItem('orientai_token', token);
  sessionStorage.setItem('orientai_user', JSON.stringify(user));
  sessionStorage.setItem('orientai_current_role', role);

  // Also save to localStorage for persistence across tab switches
  const sessions = getSessionsFromStorage();
  sessions[role] = { token, user, role };
  localStorage.setItem('orientai_sessions', JSON.stringify(sessions));
}

function switchSession(role: string): boolean {
  const session = getSessionByRole(role);
  if (!session) return false;

  // Update sessionStorage for this tab
  sessionStorage.setItem('orientai_token', session.token);
  sessionStorage.setItem('orientai_user', JSON.stringify(session.user));
  sessionStorage.setItem('orientai_current_role', role);

  // Also update localStorage for consistency
  localStorage.setItem('orientai_token', session.token);
  localStorage.setItem('orientai_user', JSON.stringify(session.user));

  return true;
}

function removeSession(role: string): void {
  const sessions = getSessionsFromStorage();
  delete sessions[role];
  localStorage.setItem('orientai_sessions', JSON.stringify(sessions));

  const currentRole = sessionStorage.getItem('orientai_current_role');

  // If removing current tab's session, switch to another or clear
  if (currentRole === role) {
    if (Object.keys(sessions).length > 0) {
      const nextRole = Object.keys(sessions)[0];
      switchSession(nextRole);
    } else {
      // No more sessions, clear everything
      sessionStorage.removeItem('orientai_token');
      sessionStorage.removeItem('orientai_user');
      sessionStorage.removeItem('orientai_current_role');
      localStorage.removeItem('orientai_token');
      localStorage.removeItem('orientai_user');
    }
  }
}

// Helper function to get auth token from sessionStorage (per-tab) or localStorage (fallback)
function getAuthToken(): string | null {
  // Check sessionStorage first (per-tab session)
  const sessionToken = sessionStorage.getItem('orientai_token');
  if (sessionToken) return sessionToken;

  // Fallback to localStorage
  return localStorage.getItem('orientai_token');
}

// Helper function to make authenticated requests
async function apiCall<T>(
  endpoint: string,
  options: RequestInit & { requireAuth?: boolean } = {}
): Promise<T> {
  const { requireAuth = true, ...fetchOptions } = options;

  const headers = new Headers(fetchOptions.headers || {});
  headers.set('Content-Type', 'application/json');

  if (requireAuth) {
    const token = getAuthToken();
    if (token) {
      headers.set('Authorization', `Bearer ${token}`);
    }
  }

  const response = await fetch(`${API_BASE_URL}${endpoint}`, {
    ...fetchOptions,
    headers,
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: 'Une erreur est survenue' }));
    const errorMessage = error.message || error.error || JSON.stringify(error) || `Erreur ${response.status}`;
    throw new Error(errorMessage);
  }

  return response.json();
}

// ============================================================================
// 🔐 AUTHENTIFICATION (Auth)
// ============================================================================

export const auth = {
  /**
   * Register a new student
   */
  register: async (data: {
    nom: string;
    prenom: string;
    email: string;
    mot_de_passe: string;
  }) => {
    return apiCall('/auth/register', {
      method: 'POST',
      body: JSON.stringify(data),
      requireAuth: false,
    });
  },

  /**
   * Login user
   */
  login: async (email: string, mot_de_passe: string) => {
    return apiCall('/auth/login', {
      method: 'POST',
      body: JSON.stringify({ email, mot_de_passe }),
      requireAuth: false,
    });
  },

  /**
   * Get current user info
   */
  me: async () => {
    return apiCall('/auth/me', { method: 'GET' });
  },

  /**
   * Verify email with token
   */
  verifyEmail: async (token: string) => {
    return apiCall('/auth/verify-email', {
      method: 'POST',
      body: JSON.stringify({ token }),
      requireAuth: false,
    });
  },

  /**
   * Request password reset (sends email with reset link)
   */
  forgotPassword: async (email: string) => {
    return apiCall('/auth/forgot-password', {
      method: 'POST',
      body: JSON.stringify({ email }),
      requireAuth: false,
    });
  },

  /**
   * Reset password with token from email link
   */
  resetPassword: async (token: string, nouveau_mot_de_passe: string) => {
    return apiCall('/auth/reset-password', {
      method: 'POST',
      body: JSON.stringify({ token, nouveau_mot_de_passe }),
      requireAuth: false,
    });
  },

  /**
   * Logout user (client-side)
   */
  logout: () => {
    // Clear sessionStorage (per-tab session)
    sessionStorage.removeItem('orientai_token');
    sessionStorage.removeItem('orientai_user');
    sessionStorage.removeItem('orientai_current_role');

    // Clear localStorage (persistent session)
    localStorage.removeItem('orientai_token');
    localStorage.removeItem('orientai_user');
    localStorage.removeItem('orientai_sessions');
  },
};

// ============================================================================
// 👤 UTILISATEURS (Users)
// ============================================================================

export const users = {
  /**
   * Get authenticated user's profile
   * Backend MUST:
   * - Return only the authenticated user's profile
   * - Filter by user_id from token
   */
  getProfil: async () => {
    return apiCall('/users/profil', { method: 'GET' });
  },

  /**
   * Update authenticated user's avatar/profile photo
   * Backend MUST:
   * - Verify that only the authenticated user can update their own avatar
   * - Use user_id from token
   */
  updateAvatar: async (avatar_url: string) => {
    return apiCall('/users/profil/avatar', {
      method: 'PUT',
      body: JSON.stringify({ avatar_url }),
    });
  },

  /**
   * Update authenticated user's basic profile
   * Backend MUST:
   * - Verify that only the authenticated user can update their own profile
   * - Use user_id from token to identify which user is being updated
   * - Reject if trying to update another user's profile
   */
  updateProfil: async (data: {
    nom?: string;
    prenom?: string;
    ville?: string;
    budget_mensuel?: number;
  }) => {
    return apiCall('/users/profil', {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Update authenticated user's academic profile
   * Backend MUST:
   * - Verify that only the authenticated user can update their own profile
   * - Use user_id from token
   * - Reject if trying to update another user's academic profile
   */
  updateProfilAcademique: async (data: {
    serie_bac?: string;
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
  }) => {
    return apiCall('/users/profil/academique', {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Get authenticated user's favorites only
   * Backend MUST:
   * - Filter by authenticated user_id from token
   * - Never return another user's favorites
   */
  getFavoris: async () => {
    return apiCall('/users/favoris', { method: 'GET' });
  },

  /**
   * Add a field to authenticated user's favorites
   * Backend MUST:
   * - Save favorite linked to authenticated user_id
   * - Prevent duplicate favorites for same user and field
   */
  addFavori: async (filiereId: number) => {
    return apiCall(`/users/favoris/${filiereId}`, { method: 'POST' });
  },

  /**
   * Remove a field from authenticated user's favorites
   * Backend MUST:
   * - Verify the favorite belongs to authenticated user
   * - Reject if trying to remove another user's favorite
   */
  removeFavori: async (filiereId: number) => {
    return apiCall(`/users/favoris/${filiereId}`, { method: 'DELETE' });
  },

  /**
   * Get authenticated user's settings
   */
  getSettings: async () => {
    return apiCall('/users/settings', { method: 'GET' });
  },

  /**
   * Update authenticated user's settings
   */
  updateSettings: async (data: {
    email_notifications?: boolean;
    new_university_notifications?: boolean;
    test_updates_notifications?: boolean;
    recommendations_notifications?: boolean;
    theme?: 'light' | 'dark' | 'system';
    language?: string;
    profile_visibility?: 'public' | 'private';
  }) => {
    return apiCall('/users/settings', {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Change password for authenticated user
   */
  changePassword: async (data: {
    current_password: string;
    new_password: string;
    confirm_password: string;
  }) => {
    return apiCall('/users/change-password', {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Delete authenticated user's account
   */
  deleteAccount: async (password: string) => {
    return apiCall('/users/account', {
      method: 'DELETE',
      body: JSON.stringify({ password }),
    });
  },
};

// ============================================================================
// 🏫 UNIVERSITÉS (Universities)
// ============================================================================

export const universities = {
  /**
   * Get all universities with pagination
   */
  getAll: async (page: number = 1, limit: number = 10000) => {
    return apiCall(`/universites?page=${page}&limit=${limit}`, {
      method: 'GET',
      requireAuth: false,
    });
  },

  /**
   * Get university by ID
   */
  getById: async (id: number) => {
    return apiCall(`/universites/${id}`, {
      method: 'GET',
      requireAuth: false,
    });
  },

  /**
   * Create new university (Admin only)
   */
  create: async (data: {
    nom: string;
    type: 'publique' | 'privee';
    ville: string;
    wilaya?: string;
    adresse?: string;
    site_web?: string;
    email_contact?: string;
    telephone?: string;
    description?: string;
    logo_url?: string;
    date_fondation?: number;
  }) => {
    return apiCall('/universites', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  },

  /**
   * Update university (Admin only)
   */
  update: async (
    id: number,
    data: {
      nom?: string;
      type?: 'publique' | 'privee';
      ville?: string;
      wilaya?: string;
      adresse?: string;
      site_web?: string;
      email_contact?: string;
      telephone?: string;
      description?: string;
      logo_url?: string;
      date_fondation?: number;
    }
  ) => {
    return apiCall(`/universites/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Delete university (Admin only)
   */
  delete: async (id: number) => {
    return apiCall(`/universites/${id}`, { method: 'DELETE' });
  },
};

// ============================================================================
// 📚 FILIÈRES (Fields of Study)
// ============================================================================

export const filieres = {
  /**
   * Get all fields with filters
   */
  getAll: async (
    page: number = 1,
    limit: number = 10000,
    filters?: {
      niveau?: 'Licence' | 'Master' | 'Doctorat' | 'DTS' | 'DUT' | 'Ingénieur';
      difficulte?: 'facile' | 'moyen' | 'difficile' | 'tres_difficile';
    }
  ) => {
    const params = new URLSearchParams({ page: String(page), limit: String(limit) });
    if (filters?.niveau) params.append('niveau', filters.niveau);
    if (filters?.difficulte) params.append('difficulte', filters.difficulte);
    return apiCall(`/filieres?${params}`, {
      method: 'GET',
      requireAuth: false,
    });
  },

  /**
   * Get field by ID
   */
  getById: async (id: number) => {
    return apiCall(`/filieres/${id}`, {
      method: 'GET',
      requireAuth: false,
    });
  },

  /**
   * Create new field (Admin only)
   */
  create: async (data: {
    universite_id: number;
    nom: string;
    code?: string;
    domaine?: string;
    specialite?: string;
    niveau: 'Licence' | 'Master' | 'Doctorat' | 'DTS' | 'DUT' | 'Ingénieur';
    duree_annees?: number;
    cout_annuel?: number;
    langue?: string;
    series_bac_acceptees?: string[];
    moyenne_min_requise?: number;
    competences_requises?: string[];
    centres_interet?: string[];
    difficulte?: 'facile' | 'moyen' | 'difficile' | 'tres_difficile';
    taux_emploi?: number;
    salaire_moyen_debutant?: number;
    debouches?: string[];
  }) => {
    return apiCall('/filieres', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  },

  /**
   * Update field (Admin only)
   */
  update: async (
    id: number,
    data: {
      nom?: string;
      code?: string;
      domaine?: string;
      specialite?: string;
      niveau?: 'Licence' | 'Master' | 'Doctorat' | 'DTS' | 'DUT' | 'Ingénieur';
      duree_annees?: number;
      cout_annuel?: number;
      langue?: string;
      series_bac_acceptees?: string[];
      moyenne_min_requise?: number;
      competences_requises?: string[];
      centres_interet?: string[];
      difficulte?: 'facile' | 'moyen' | 'difficile' | 'tres_difficile';
      taux_emploi?: number;
      salaire_moyen_debutant?: number;
      debouches?: string[];
    }
  ) => {
    return apiCall(`/filieres/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Delete field (Admin only)
   */
  delete: async (id: number) => {
    return apiCall(`/filieres/${id}`, { method: 'DELETE' });
  },
};

// ============================================================================
// 🎓 PARCOURS (Study Paths)
// ============================================================================

export const parcours = {
  /**
   * Get all parcours with filters
   */
  getAll: async (
    page: number = 1,
    limit: number = 10000,
    filters?: {
      filiere_id?: number;
      search?: string;
    }
  ) => {
    const params = new URLSearchParams({ page: String(page), limit: String(limit) });
    if (filters?.filiere_id) params.append('filiere_id', String(filters.filiere_id));
    if (filters?.search) params.append('search', filters.search);
    return apiCall(`/parcours?${params}`, {
      method: 'GET',
      requireAuth: false,
    });
  },

  /**
   * Get parcours by ID
   */
  getById: async (id: number) => {
    return apiCall(`/parcours/${id}`, {
      method: 'GET',
      requireAuth: false,
    });
  },

  /**
   * Get all parcours for a specific filiere
   */
  getByFiliere: async (filiere_id: number) => {
    return apiCall(`/parcours/filiere/${filiere_id}`, {
      method: 'GET',
      requireAuth: false,
    });
  },

  /**
   * Create new parcours (Admin only)
   */
  create: async (data: {
    filiere_id: number;
    nom: string;
    code?: string;
    description?: string;
    duree_mois?: number;
    specialisation?: string;
    competences_acquises?: string[];
    debouches_professionnels?: string[];
  }) => {
    return apiCall('/parcours', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  },

  /**
   * Update parcours (Admin only)
   */
  update: async (
    id: number,
    data: {
      filiere_id?: number;
      nom?: string;
      code?: string;
      description?: string;
      duree_mois?: number;
      specialisation?: string;
      competences_acquises?: string[];
      debouches_professionnels?: string[];
    }
  ) => {
    return apiCall(`/parcours/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Delete parcours (Admin only)
   */
  delete: async (id: number) => {
    return apiCall(`/parcours/${id}`, { method: 'DELETE' });
  },
};

// ============================================================================
// 📋 TESTS D'ORIENTATION (Orientation Tests)
// ============================================================================

export const tests = {
  /**
   * Get test questions with optional filtering by bac series
   * Backend MUST verify that the authenticated user can access these questions
   */
  getQuestions: async (serie_bac?: string) => {
    const params = serie_bac ? `?serie_bac=${serie_bac}` : '';
    return apiCall(`/test/questions${params}`, { method: 'GET' });
  },

  /**
   * Start a new test session for the authenticated user
   * Backend MUST:
   * - Create session linked to the authenticated user_id from token
   * - Return session_id unique to this user
   */
  startSession: async () => {
    return apiCall('/test/demarrer', { method: 'POST' });
  },

  /**
   * Submit an answer to a question in the current test session
   * Backend MUST:
   * - Verify that sessionId belongs to the authenticated user
   * - Reject if user tries to submit to another user's session
   * - Link answer to the user and session
   */
  submitAnswer: async (sessionId: number, question_id: number, option_id: number) => {
    return apiCall(`/test/${sessionId}/repondre`, {
      method: 'POST',
      body: JSON.stringify({ question_id, option_id }),
    });
  },

  /**
   * End test session and get results
   * Backend MUST:
   * - Verify that sessionId belongs to the authenticated user
   * - Only mark test as complete for this specific user
   * - Calculate results for this user's answers only
   */
  endSession: async (sessionId: number) => {
    return apiCall(`/test/${sessionId}/terminer`, { method: 'POST' });
  },

  /**
   * Get test history for the authenticated user only
   * Backend MUST:
   * - Filter results by authenticated user's ID
   * - Never return other users' test sessions
   */
  getHistory: async () => {
    return apiCall('/test/historique', { method: 'GET' });
  },
};

// ============================================================================
// 🎯 RECOMMANDATIONS (Recommendations)
// ============================================================================

export const recommendations = {
  /**
   * Generate recommendations based on test session for the authenticated user
   * Backend MUST:
   * - Verify that session_test_id belongs to the authenticated user
   * - Generate recommendations based only on this user's test answers
   * - Store recommendations linked to user_id from token
   */
  generate: async (session_test_id: number) => {
    return apiCall('/recommendations/generer', {
      method: 'POST',
      body: JSON.stringify({ session_test_id }),
    });
  },

  /**
   * Get authenticated user's recommendations only
   * Backend MUST:
   * - Filter by authenticated user_id from token
   * - Never return another user's recommendations
   */
  getMine: async () => {
    return apiCall('/recommendations/mes-recommendations', { method: 'GET' });
  },

  /**
   * Get recommendation by ID with explanation
   */
  getById: async (id: number) => {
    return apiCall(`/recommendations/${id}/explication`, { method: 'GET' });
  },

  /**
   * Save a recommendation as favorite for authenticated user
   * Backend MUST:
   * - Link favorite to authenticated user_id
   * - Prevent duplicates
   */
  saveFavorite: async (recommendation_id: number) => {
    return apiCall(`/recommendations/${recommendation_id}/sauvegarder`, {
      method: 'PATCH',
    });
  },

  /**
   * Delete a recommendation
   */
  deleteRecommendation: async (recommendation_id: number) => {
    return apiCall(`/recommendations/${recommendation_id}`, {
      method: 'DELETE',
    });
  },
};

// ============================================================================
// ⚖️ COMPARATEUR (Comparison Tool)
// ============================================================================

export const comparator = {
  /**
   * Compare multiple fields/universities
   */
  compare: async (filiere_ids: number[]) => {
    if (filiere_ids.length < 2 || filiere_ids.length > 50) {
      throw new Error('Veuillez sélectionner entre 2 et 50 filières à comparer');
    }
    return apiCall('/comparateur', {
      method: 'POST',
      body: JSON.stringify({ filiere_ids }),
    });
  },
};

// ============================================================================
// 📊 STATISTIQUES (Statistics)
// ============================================================================

export const stats = {
  /**
   * Get admin dashboard statistics
   */
  getDashboard: async () => {
    return apiCall('/stats/dashboard', { method: 'GET' });
  },

  /**
   * Get statistics for a field
   */
  getFieldStats: async (id: number) => {
    return apiCall(`/stats/filieres/${id}`, { method: 'GET' });
  },

  /**
   * Get user's personal statistics
   */
  getMine: async () => {
    return apiCall('/stats/moi', { method: 'GET' });
  },
};

// ============================================================================
// 👨‍💼 ADMINISTRATION (Admin)
// ============================================================================

export const admin = {
  /**
   * Get all users with pagination (Admin only)
   */
  getUsers: async (page: number = 1, limit: number = 10, role?: 'bachelier' | 'admin') => {
    const params = new URLSearchParams({ page: String(page), limit: String(limit) });
    if (role) params.append('role', role);
    return apiCall(`/admin/users?${params}`, { method: 'GET' });
  },

  /**
   * Create new user (Admin only)
   */
  createUser: async (data: {
    nom: string;
    prenom: string;
    email: string;
    mot_de_passe: string;
    role?: 'bachelier' | 'admin';
    serie_bac?: string;
    ville?: string;
    budget_mensuel?: number;
    actif?: boolean;
  }) => {
    return apiCall('/admin/users', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  },

  /**
   * Update user (Admin only)
   */
  updateUser: async (
    id: number,
    data: {
      nom?: string;
      prenom?: string;
      email?: string;
      mot_de_passe?: string;
      role?: 'bachelier' | 'admin';
      serie_bac?: string;
      ville?: string;
      budget_mensuel?: number;
      actif?: boolean;
    }
  ) => {
    return apiCall(`/admin/users/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Delete user (Admin only)
   */
  deleteUser: async (id: number) => {
    return apiCall(`/admin/users/${id}`, { method: 'DELETE' });
  },

  /**
   * Toggle user status (Admin only)
   */
  toggleUserStatus: async (id: number) => {
    return apiCall(`/admin/users/${id}/toggle`, { method: 'PATCH' });
  },

  /**
   * Create test question (Admin only)
   */
  createQuestion: async (data: {
    texte: string;
    categorie?: string;
    series_bac_cibles?: string[];
    ordre?: number;
    options: Array<{
      texte: string;
      poids?: Record<string, number>;
    }>;
  }) => {
    return apiCall('/admin/questions', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  },

  /**
   * Update test question (Admin only)
   */
  updateQuestion: async (
    id: number,
    data: {
      texte?: string;
      categorie?: string;
      actif?: boolean;
    }
  ) => {
    return apiCall(`/admin/questions/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Delete test question (Admin only)
   */
  deleteQuestion: async (id: number) => {
    return apiCall(`/admin/questions/${id}`, { method: 'DELETE' });
  },

  /**
   * Get all recommendation rules (Admin only)
   */
  getRules: async () => {
    return apiCall('/admin/recommendation-rules', { method: 'GET' });
  },

  /**
   * Get specific recommendation rule (Admin only)
   */
  getRule: async (id: number) => {
    return apiCall(`/admin/recommendation-rules/${id}`, { method: 'GET' });
  },

  /**
   * Get active recommendation rule (Admin only)
   */
  getActiveRule: async () => {
    return apiCall('/admin/recommendation-rules/active', { method: 'GET' });
  },

  /**
   * Create new recommendation rule (Admin only)
   */
  createRule: async (data: {
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
  }) => {
    return apiCall('/admin/recommendation-rules', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  },

  /**
   * Update recommendation rule (Admin only)
   */
  updateRule: async (
    id: number,
    data: {
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
    }
  ) => {
    return apiCall(`/admin/recommendation-rules/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Activate recommendation rule as default (Admin only)
   */
  activateRule: async (id: number) => {
    return apiCall(`/admin/recommendation-rules/${id}/activate`, { method: 'PATCH' });
  },

  /**
   * Delete recommendation rule (Admin only)
   */
  deleteRule: async (id: number) => {
    return apiCall(`/admin/recommendation-rules/${id}`, { method: 'DELETE' });
  },

  /**
   * Get all testimonials with optional filtering (Admin only)
   */
  getTestimonials: async (page: number = 1, limit: number = 20, status?: string) => {
    const params = new URLSearchParams({ page: String(page), limit: String(limit) });
    if (status) params.append('status', status);
    return apiCall(`/admin/testimonials?${params}`, { method: 'GET' });
  },

  /**
   * Create new testimonial (Admin only)
   */
  createTestimonial: async (data: {
    student_name: string;
    student_serie: string;
    university_name: string;
    course_name: string;
    text: string;
    rating: number;
    status?: 'Approuvé' | 'En attente' | 'Rejeté';
  }) => {
    return apiCall('/admin/testimonials', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  },

  /**
   * Update testimonial (Admin only)
   */
  updateTestimonial: async (
    id: number,
    data: {
      student_name?: string;
      university_name?: string;
      course_name?: string;
      text?: string;
      rating?: number;
      status?: 'Approuvé' | 'En attente' | 'Rejeté';
    }
  ) => {
    return apiCall(`/admin/testimonials/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },

  /**
   * Delete testimonial (Admin only)
   */
  deleteTestimonial: async (id: number) => {
    return apiCall(`/admin/testimonials/${id}`, { method: 'DELETE' });
  },

  /**
   * Approve testimonial (Admin only)
   */
  approveTestimonial: async (id: number) => {
    return apiCall(`/admin/testimonials/${id}/approve`, { method: 'PATCH' });
  },

  /**
   * Reject testimonial (Admin only)
   */
  rejectTestimonial: async (id: number) => {
    return apiCall(`/admin/testimonials/${id}/reject`, { method: 'PATCH' });
  },

  /**
   * Get platform settings (Admin only)
   */
  getSettings: async () => {
    return apiCall('/admin/settings', { method: 'GET' });
  },

  /**
   * Update platform settings (Admin only)
   */
  updateSettings: async (data: {
    platform_name?: string;
    platform_description?: string;
    contact_email?: string;
    email_notifications?: boolean;
    moderation_alerts?: boolean;
    weekly_reports?: boolean;
    two_factor_auth?: boolean;
    open_registration?: boolean;
    email_verification?: boolean;
    maintenance_mode?: boolean;
  }) => {
    return apiCall('/admin/settings', {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },
};

// ============================================================================
// 🔔 NOTIFICATIONS
// ============================================================================

export const notifications = {
  /**
   * Get all notifications for authenticated user
   */
  getNotifications: async (limit: number = 50, offset: number = 0) => {
    return apiCall(`/notifications?limit=${limit}&offset=${offset}`, { method: 'GET' });
  },

  /**
   * Get count of unread notifications
   */
  getUnreadCount: async () => {
    return apiCall('/notifications/unread-count', { method: 'GET' });
  },

  /**
   * Mark specific notification as read
   */
  markAsRead: async (id: number) => {
    return apiCall(`/notifications/${id}/read`, { method: 'PUT' });
  },

  /**
   * Mark all notifications as read
   */
  markAllRead: async () => {
    return apiCall('/notifications/mark-all-read', { method: 'PUT' });
  },

  /**
   * Delete specific notification
   */
  deleteNotification: async (id: number) => {
    return apiCall(`/notifications/${id}`, { method: 'DELETE' });
  },

  /**
   * Delete all read notifications
   */
  deleteAllRead: async () => {
    return apiCall('/notifications', { method: 'DELETE' });
  },
};

// ============================================================================
// 🏥 HEALTH CHECK
// ============================================================================

export const health = {
  /**
   * Check if backend is online
   */
  check: async () => {
    return apiCall('/health', { method: 'GET', requireAuth: false });
  },
};

// ============================================================================
// Utility functions
// ============================================================================

/**
 * Normalize API response to ensure consistent data structure
 */
export function normalizeResponse<T>(response: unknown, dataKeys: string[] = ['data', 'items', 'rows']): T[] {
  if (Array.isArray(response)) {
    return response;
  }

  if (typeof response !== 'object' || response === null) {
    return [];
  }

  for (const key of dataKeys) {
    const value = (response as Record<string, unknown>)[key];
    if (Array.isArray(value)) {
      return value;
    }
  }

  return [];
}

export function setAuthToken(token: string, user?: User): void {
  localStorage.setItem('orientai_token', token);
  if (user) {
    saveSession(user, token);
  }
}

export function clearAuthToken(): void {
  localStorage.removeItem('orientai_token');
}

export function isAuthenticated(): boolean {
  return getAuthToken() !== null;
}

// Multi-session management
export function getSessions(): SessionData[] {
  const sessions = getSessionsFromStorage();
  return Object.values(sessions);
}

export function getCurrentSession(): SessionData | null {
  return getSessionByRole();
}

export function switchToSession(role: string): boolean {
  return switchSession(role);
}

export function logoutSession(role: string): void {
  removeSession(role);
}

/**
 * Get the redirect path based on user role
 * @param role - User role ('admin' or 'bachelier')
 * @returns Redirect path
 */
export function getRedirectPathByRole(role?: string): string {
  return role === "admin" ? "/admin" : "/dashboard";
}

/**
 * Get current user from localStorage
 */
export function getCurrentUser(): User | null {
  const user = localStorage.getItem("orientai_user");
  return user ? JSON.parse(user) : null;
}

/**
 * Get current user role
 */
export function getUserRole(): string | null {
  const user = getCurrentUser();
  return user?.role || null;
}
