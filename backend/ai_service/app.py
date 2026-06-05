"""
SERVICE IA POUR RECOMMANDATIONS UNIVERSITAIRES
===============================================
Service Python utilisant scikit-learn pour générer des recommandations
intelligentes basées sur le profil académique et les résultats du test d'orientation.

Algorithmes:
- KNN (K-Nearest Neighbors) : similarité entre profils
- Scoring pondéré : combinaison multi-critères
- Random Forest : prédiction de succès académique
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import logging
import sys
from datetime import datetime

# Import des services
from services.recommendation_engine import RecommendationEngine
from services.ml_models import MLModels

# Configuration Flask
app = Flask(__name__)
CORS(app)

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler('logs/ai_service.log')
    ]
)
logger = logging.getLogger(__name__)

# Initialisation des services
recommendation_engine = RecommendationEngine()
ml_models = MLModels()


# ─── HEALTH CHECK ───────────────────────────────────────────────────────

@app.route('/health', methods=['GET'])
def health_check():
    """Vérifier que le service IA est disponible"""
    return jsonify({
        'status': 'ok',
        'service': 'AI Recommendation Engine',
        'timestamp': datetime.now().isoformat(),
        'models_loaded': ml_models.is_ready()
    }), 200


# ─── ENDPOINT PRINCIPAL : GÉNÉRER DES RECOMMANDATIONS ──────────────────

@app.route('/api/recommendations/generate', methods=['POST'])
def generate_recommendations():
    """
    Générer des recommandations pour un utilisateur
    
    Payload:
    {
        "profil": { ... données académiques ... },
        "filieres": [ ... liste des filières disponibles ... ],
        "scores_test": { ... résultats du test d'orientation ... }
    }
    
    Retour:
    {
        "success": true,
        "recommendations": [
            {
                "filiere_id": 1,
                "score": 85.5,
                "explanation": { ... },
                "factors": { ... }
            }
        ]
    }
    """
    try:
        data = request.get_json()
        
        if not data:
            return jsonify({
                'success': False,
                'error': 'Payload vide'
            }), 400
        
        profil = data.get('profil')
        filieres = data.get('filieres')
        scores_test = data.get('scores_test', {})
        
        if not profil or not filieres:
            return jsonify({
                'success': False,
                'error': 'Profil ou filières manquants'
            }), 400
        
        logger.info(f"Génération de recommandations pour profil avec {len(filieres)} filières")
        
        # Générer les recommandations
        recommendations = recommendation_engine.generate(
            profil=profil,
            filieres=filieres,
            scores_test=scores_test
        )
        
        logger.info(f"✓ {len(recommendations)} recommandations générées")
        
        return jsonify({
            'success': True,
            'count': len(recommendations),
            'recommendations': recommendations
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur lors de la génération: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500


# ─── KNN : RECOMMANDATIONS PAR SIMILARITÉ ──────────────────────────────

@app.route('/api/recommendations/knn', methods=['POST'])
def knn_recommendations():
    """
    KNN : Trouver les K profils les plus similaires et leurs filières préférées
    
    Payload:
    {
        "profil": { ... profil cible ... },
        "all_profils": [ ... tous les profils ... ],
        "filieres": [ ... filières ... ],
        "k": 5
    }
    """
    try:
        data = request.get_json()
        profil = data.get('profil')
        all_profils = data.get('all_profils', [])
        filieres = data.get('filieres', [])
        k = data.get('k', 5)
        
        logger.info(f"KNN: K={k}, profils dans BD={len(all_profils)}")
        
        recommendations = recommendation_engine.knn_recommend(
            profil=profil,
            all_profils=all_profils,
            filieres=filieres,
            k=k
        )
        
        return jsonify({
            'success': True,
            'count': len(recommendations),
            'recommendations': recommendations
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur KNN: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500


# ─── RANDOM FOREST ──────────────────────────────────────────────────────

@app.route('/api/recommendations/random-forest', methods=['POST'])
def random_forest_recommendations():
    """
    Utiliser Random Forest pour prédire le succès académique
    """
    try:
        data = request.get_json()
        profil = data.get('profil')
        filieres = data.get('filieres', [])
        
        logger.info(f"Random Forest: {len(filieres)} filières")
        
        recommendations = recommendation_engine.random_forest_recommend(
            profil=profil,
            filieres=filieres
        )
        
        return jsonify({
            'success': True,
            'recommendations': recommendations
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur Random Forest: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500


# ─── ENTRAÎNEMENT DES MODÈLES ──────────────────────────────────────────

@app.route('/api/model/train', methods=['POST'])
def train_models():
    """
    Entraîner/réentraîner les modèles ML avec les données historiques
    À appeler régulièrement (nightly ou hebdomadaire)
    """
    try:
        data = request.get_json()
        training_data = data.get('training_data', [])
        
        logger.info(f"Entraînement avec {len(training_data)} exemples")
        
        metrics = ml_models.train(training_data)
        
        return jsonify({
            'success': True,
            'metrics': metrics,
            'message': 'Modèles entraînés avec succès'
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur entraînement: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500


# ─── ÉVALUATION DES MODÈLES ────────────────────────────────────────────

@app.route('/api/model/evaluate', methods=['POST'])
def evaluate_models():
    """
    Évaluer les performances des modèles ML
    """
    try:
        data = request.get_json()
        test_data = data.get('test_data', [])
        
        logger.info(f"Évaluation avec {len(test_data)} exemples")
        
        metrics = ml_models.evaluate(test_data)
        
        return jsonify({
            'success': True,
            'metrics': metrics
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur évaluation: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500


# ─── EXPLICATION D'UNE RECOMMANDATION ──────────────────────────────────

@app.route('/api/explain-recommendation', methods=['POST'])
def explain_recommendation():
    """
    Expliquer en détail pourquoi une filière est recommandée
    """
    try:
        data = request.get_json()
        profil = data.get('profil')
        filiere = data.get('filiere')
        
        if not profil or not filiere:
            return jsonify({
                'success': False,
                'error': 'Profil ou filière manquant'
            }), 400
        
        explanation = recommendation_engine.explain(profil, filiere)
        
        return jsonify({
            'success': True,
            'explanation': explanation
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur explication: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500


# ─── IMPORTANCE DES FEATURES ────────────────────────────────────────────

@app.route('/api/feature-importance', methods=['GET'])
def feature_importance():
    """
    Retourner l'importance des features dans les modèles ML
    """
    try:
        importance = ml_models.get_feature_importance()
        
        return jsonify({
            'success': True,
            'feature_importance': importance
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur feature importance: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500


# ─── ERROR HANDLERS ────────────────────────────────────────────────────

@app.errorhandler(404)
def not_found(e):
    return jsonify({
        'success': False,
        'error': 'Endpoint non trouvé'
    }), 404


@app.errorhandler(500)
def server_error(e):
    logger.error(f"Erreur serveur: {str(e)}")
    return jsonify({
        'success': False,
        'error': 'Erreur serveur interne'
    }), 500


if __name__ == '__main__':
    logger.info("═" * 50)
    logger.info("🚀 Démarrage du service IA")
    logger.info("═" * 50)
    app.run(host='0.0.0.0', port=5000, debug=False)
