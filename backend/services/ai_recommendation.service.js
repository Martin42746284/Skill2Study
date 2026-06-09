/**
 * SERVICE D'INTÉGRATION AVEC LE MOTEUR IA SCIKIT-LEARN
 * 
 * Ce service fait l'interface entre le backend Node.js et le service Python
 * pour obtenir des recommandations ML avancées
 */

const axios = require('axios');
const logger = require('../utils/logger');

const AI_SERVICE_URL = process.env.AI_SERVICE_URL || 'http://ai-service:5000';

// Configuration axios avec retry
const axiosInstance = axios.create({
  timeout: 10000,
  retryAttempts: 3,
  retryDelay: 1000
});

class AIRecommendationService {
  
  /**
   * Vérifier que le service IA est disponible
   */
  static async healthCheck() {
    try {
      const response = await axiosInstance.get(`${AI_SERVICE_URL}/health`);
      logger.info(`✓ Service IA disponible: ${response.data.service}`);
      return { status: 'ok', service: response.data.service };
    } catch (err) {
      logger.error(`[TODO] Erreur health check IA: ${err.message}`);
      return { status: 'unavailable', error: err.message };
    }
  }

  /**
   * Point d'entrée principal pour générer des recommandations
   * Appelle le service Python IA pour obtenir des recommandations intelligentes
   *
   * @param {ProfilAcademique} profil
   * @param {Filiere[]} filieres
   * @param {Object} scoresTest
   * @returns {Array} Recommandations avec scores ML
   */
  static async generateRecommendations(profil, filieres, scoresTest = null) {
    return this.generateRecommendationsML(profil, filieres, scoresTest);
  }

  /**
   * Générer des recommandations avec le moteur ML ensemble
   * Appelle le service Python IA pour obtenir des recommandations intelligentes
   *
   * @param {ProfilAcademique} profil
   * @param {Filiere[]} filieres
   * @param {Object} scoresTest
   * @returns {Array} Recommandations avec scores ML
   */
  static async generateRecommendationsML(profil, filieres, scoresTest = null) {
    try {
      const payload = {
        profil: this._prepareProfilPayload(profil),
        filieres: filieres.map(f => this._prepareFilierePayload(f)),
        scores_test: scoresTest || {}
      };

      logger.info(`📤 Appel IA service: ${filieres.length} filières à scorer`);
      logger.debug(`   Profil: ${JSON.stringify(payload.profil).substring(0, 100)}...`);
      logger.debug(`   Première filière: ${JSON.stringify(payload.filieres[0]).substring(0, 150)}...`);

      const response = await axiosInstance.post(
        `${AI_SERVICE_URL}/api/recommendations/generate`,
        payload
      );

      if (!response.data.success) {
        logger.warn('⚠️ Service IA a retourné une erreur:', response.data.message);
        logger.warn('   Response:', JSON.stringify(response.data).substring(0, 200));
        return null;
      }

      logger.info(`✓ ${response.data.count} recommandations reçues du service IA`);
      return response.data.recommendations;

    } catch (err) {
      logger.error(`[TODO] Erreur appel service IA: ${err.message}`);
      logger.error(`   URL: ${AI_SERVICE_URL}/api/recommendations/generate`);
      return null;
    }
  }

  /**
   * Recommandations basées sur KNN
   * Basé sur les profils similaires
   */
  static async knnRecommendations(profil, allProfils, filieres, k = 5) {
    try {
      const payload = {
        profil: this._prepareProfilPayload(profil),
        all_profils: allProfils.map(p => this._prepareProfilPayload(p)),
        filieres: filieres.map(f => this._prepareFilierePayload(f)),
        k: k
      };

      const response = await axios.post(
        `${AI_SERVICE_URL}/api/recommendations/knn`,
        payload,
        { timeout: 5000 }
      );

      return response.data.success ? response.data.recommendations : null;
      
    } catch (err) {
      logger.error(`Erreur KNN: ${err.message}`);
      return null;
    }
  }

  /**
   * Recommandations basées sur Random Forest
   */
  static async randomForestRecommendations(profil, filieres) {
    try {
      const payload = {
        profil: this._prepareProfilPayload(profil),
        filieres: filieres.map(f => this._prepareFilierePayload(f))
      };

      const response = await axios.post(
        `${AI_SERVICE_URL}/api/recommendations/random-forest`,
        payload,
        { timeout: 5000 }
      );

      return response.data.success ? response.data.recommendations : null;
      
    } catch (err) {
      logger.error(`Erreur Random Forest: ${err.message}`);
      return null;
    }
  }

  /**
   * Entraîner les modèles ML avec les données historiques
   * À appeler régulièrement (ex: nightly)
   */
  static async trainModels(trainingData) {
    try {
      const payload = {
        training_data: trainingData
      };

      const response = await axios.post(
        `${AI_SERVICE_URL}/api/model/train`,
        payload,
        { timeout: 30000 }  // Timeout plus long pour l'entraînement
      );

      if (response.data.success) {
        logger.info(`Modèles entraînés: ${response.data.metrics}`);
      }

      return response.data;
      
    } catch (err) {
      logger.error(`Erreur lors de l'entraînement: ${err.message}`);
      return { success: false, error: err.message };
    }
  }

  /**
   * Évaluer les performances des modèles
   */
  static async evaluateModels(testData) {
    try {
      const payload = {
        test_data: testData
      };

      const response = await axios.post(
        `${AI_SERVICE_URL}/api/model/evaluate`,
        payload,
        { timeout: 15000 }
      );

      return response.data;
      
    } catch (err) {
      logger.error(`Erreur lors de l'évaluation: ${err.message}`);
      return { success: false, error: err.message };
    }
  }

  /**
   * Expliquer une recommandation en détail
   */
  static async explainRecommendation(profil, filiere) {
    try {
      const payload = {
        profil: this._prepareProfilPayload(profil),
        filiere: this._prepareFilierePayload(filiere)
      };

      const response = await axios.post(
        `${AI_SERVICE_URL}/api/explain-recommendation`,
        payload,
        { timeout: 5000 }
      );

      return response.data.success ? response.data.explanation : null;
      
    } catch (err) {
      logger.error(`Erreur lors de l'explication: ${err.message}`);
      return null;
    }
  }

  /**
   * Récupérer l'importance des features
   */
  static async getFeatureImportance() {
    try {
      const response = await axios.get(
        `${AI_SERVICE_URL}/api/feature-importance`,
        { timeout: 5000 }
      );

      return response.data.success ? response.data.feature_importance : null;
      
    } catch (err) {
      logger.error(`Erreur lors de la récupération de l'importance: ${err.message}`);
      return null;
    }
  }

  // ────────────────────────────────────────────────────────────────────────
  // UTILITAIRES DE PRÉPARATION DES DONNÉES
  // ────────────────────────────────────────────────────────────────────────

  /**
   * Préparer les données du profil pour l'envoi au service IA
   */
  static _prepareProfilPayload(profil) {
    return {
      serie_bac: profil.serie_bac || '',
      moyenne_generale: profil.moyenne_generale || 10,
      centres_interet: profil.centres_interet || [],
      competences: profil.competences || {},
      budget_max_mensuel: profil.budget_max_mensuel || 0,
      duree_max_etudes: profil.duree_max_etudes || 3,
      distance_max_km: profil.distance_max_km || 0,
      preference_type_univ: profil.preference_type_univ || 'indifferent',
      ville_preference: profil.ville_preference || '',
      objectifs_professionnels: profil.objectifs_professionnels || '',
      secteur_vise: profil.secteur_vise || '',
      chosen_filieres: profil.chosen_filieres || []
    };
  }

  /**
   * Préparer les données de la filière pour l'envoi au service IA
   */
  static _prepareFilierePayload(filiere) {
    return {
      id: filiere.id,
      nom: filiere.nom,
      series_bac_acceptees: filiere.series_bac_acceptees || [],
      moyenne_min_requise: filiere.moyenne_min_requise || 10,
      centres_interet: filiere.centres_interet || [],
      competences_requises: filiere.competences_requises || [],
      cout_annuel: filiere.cout_annuel || 0,
      duree_annees: filiere.duree_annees || 3,
      taux_emploi: filiere.taux_emploi || 0,
      debouches: filiere.debouches || [],
      parcours: (filiere.parcours || []).map(p => ({
        id: p.id,
        nom: p.nom,
        specialisation: p.specialisation || '',
        duree_mois: p.duree_mois || 36,
        debouches_professionnels: p.debouches_professionnels || [],
        competences_acquises: p.competences_acquises || []
      })),
      universite: {
        id: filiere.universite?.id,
        nom: filiere.universite?.nom,
        type: filiere.universite?.type,
        ville: filiere.universite?.ville
      }
    };
  }

  /**
   * Formater les données d'entraînement
   */
  static formatTrainingExample(profil, filiere, accepted, success, engagement = 0.5) {
    return {
      profil_features: this._prepareProfilPayload(profil),
      filiere_id: filiere.id,
      accepted: accepted,
      success: success,
      engagement: engagement  // 0-1 : niveau d'engagement/satisfaction
    };
  }
}

module.exports = AIRecommendationService;
