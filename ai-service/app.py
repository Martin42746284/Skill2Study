"""
Service de recommandation intelligente avec scikit-learn
Utilise KNN, Random Forest et Scoring pondéré
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import os
from dotenv import load_dotenv
import logging

# Import des services ML
from services.recommendation_ml import RecommendationMLService
from services.data_processor import DataProcessor
from services.model_trainer import ModelTrainer
from services.database_service import DatabaseService

try:
    from config.database import db_config
    print("✓ db_config imported successfully")
except Exception as e:
    print(f"✗ Failed to import db_config: {e}")
    raise

# Configuration
load_dotenv()
app = Flask(__name__)
CORS(app)

# Configuration du logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

logger.info("Starting AI Recommendation Service...")
logger.info(f"DATABASE_URL env var: {os.getenv('DATABASE_URL', 'NOT SET')}")

# Instance du service de recommandation
ml_service = RecommendationMLService()
data_processor = DataProcessor()
model_trainer = ModelTrainer()

logger.info("AI Service initialized successfully")


# ────────────────────────────────────────────────────────────────────────────
# ROUTES PRINCIPALES
# ────────────────────────────────────────────────────────────────────────────

@app.route('/health', methods=['GET'])
def health_check():
    """Vérifier que le service est en ligne"""
    try:
        db_session = db_config.get_session()
        db_service = DatabaseService(db_session)
        db_status = db_service.test_connection()
        db_session.close()
    except Exception as e:
        logger.error(f"Health check - Database error: {str(e)}")
        db_status = False

    return jsonify({
        'status': 'ok',
        'service': 'AI Recommendation Engine',
        'version': '1.0.0',
        'database': 'connected' if db_status else 'disconnected'
    }), 200


@app.route('/api/stats/database', methods=['GET'])
def database_stats():
    """Récupérer les statistiques de la base de données"""
    try:
        db_session = db_config.get_session()
        db_service = DatabaseService(db_session)
        stats = db_service.get_statistics()
        db_session.close()

        return jsonify({
            'success': True,
            'statistics': stats
        }), 200

    except Exception as e:
        logger.error(f"Erreur lors de la récupération des stats: {str(e)}")
        return jsonify({
            'success': False,
            'message': str(e)
        }), 500


@app.route('/api/recommendations/generate', methods=['POST'])
def generate_recommendations():
    """
    Générer des recommandations basées sur le profil académique
    
    Body:
    {
        "profil": {
            "serie_bac": "S",
            "moyenne_generale": 15.5,
            "centres_interet": ["informatique", "science"],
            "competences": {"logique": 4, "communication": 3},
            "budget_max_mensuel": 500,
            "duree_max_etudes": 4
        },
        "filieres": [
            {"id": 1, "nom": "Informatique", "moyenne_min": 12, ...},
            ...
        ],
        "scores_test": {"informatique": 85, "science": 80}
    }
    
    Returns:
    {
        "success": true,
        "recommendations": [
            {
                "filiere_id": 1,
                "nom": "Informatique",
                "score": 92.5,
                "methode": "ml_ensemble",
                "justification": {...}
            }
        ]
    }
    """
    try:
        data = request.get_json()
        
        if not data or 'profil' not in data or 'filieres' not in data:
            return jsonify({
                'success': False,
                'message': 'Données manquantes: profil et filieres requis'
            }), 400
        
        profil = data.get('profil')
        filieres = data.get('filieres')
        scores_test = data.get('scores_test')
        
        # Préparer les données
        features_profil = data_processor.prepare_profil_features(profil)
        
        # Générer les recommandations avec ensemble ML
        recommendations = ml_service.recommend_filieres(
            features_profil,
            filieres,
            scores_test
        )
        
        return jsonify({
            'success': True,
            'count': len(recommendations),
            'recommendations': recommendations
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur lors de la génération des recommandations: {str(e)}")
        return jsonify({
            'success': False,
            'message': str(e)
        }), 500


@app.route('/api/recommendations/knn', methods=['POST'])
def knn_recommendations():
    """
    Recommandations basées sur K-Nearest Neighbors
    Trouve les profils similaires et recommande les filières qu'ils ont choisies
    """
    try:
        data = request.get_json()
        profil = data.get('profil', {})
        filieres = data.get('filieres', [])

        # Enrichir le profil avec des valeurs par défaut
        if not profil:
            profil = {}

        profil.setdefault('serie_bac', 'S')
        profil.setdefault('moyenne_generale', 14.0)
        profil.setdefault('centres_interet', [])
        profil.setdefault('competences', {})
        profil.setdefault('budget_max_mensuel', 500)
        profil.setdefault('duree_max_etudes', 4)

        # Enrichir les filières avec des valeurs par défaut
        for filiere in filieres:
            filiere.setdefault('id', 0)
            filiere.setdefault('nom', 'Unknown')
            filiere.setdefault('series_bac_acceptees', ['S', 'L'])
            filiere.setdefault('centres_interet', [])
            filiere.setdefault('competences_requises', {})
            filiere.setdefault('duree_annees', 3)
            filiere.setdefault('cout_annuel', 0)
            filiere.setdefault('debouches', [])

        features_profil = data_processor.prepare_profil_features(profil)

        # Utiliser l'ensemble ML au lieu de KNN pur
        recommendations = ml_service.recommend_filieres(
            features_profil,
            filieres
        )

        return jsonify({
            'success': True,
            'method': 'knn_ensemble',
            'count': len(recommendations),
            'recommendations': recommendations
        }), 200

    except Exception as e:
        logger.error(f"Erreur KNN: {str(e)}")
        return jsonify({'success': False, 'error': str(e)}), 500


@app.route('/api/recommendations/random-forest', methods=['POST'])
def random_forest_recommendations():
    """
    Recommandations basées sur Random Forest
    Utilise un modèle entraîné pour prédire la compatibilité filière
    """
    try:
        data = request.get_json()
        profil = data.get('profil', {})
        filieres = data.get('filieres', [])

        # Enrichir le profil avec des valeurs par défaut
        if not profil:
            profil = {}

        profil.setdefault('serie_bac', 'S')
        profil.setdefault('moyenne_generale', 14.0)
        profil.setdefault('centres_interet', [])
        profil.setdefault('competences', {})
        profil.setdefault('budget_max_mensuel', 500)
        profil.setdefault('duree_max_etudes', 4)

        # Enrichir les filières avec des valeurs par défaut
        for filiere in filieres:
            filiere.setdefault('id', 0)
            filiere.setdefault('nom', 'Unknown')
            filiere.setdefault('series_bac_acceptees', ['S', 'L'])
            filiere.setdefault('centres_interet', [])
            filiere.setdefault('competences_requises', {})
            filiere.setdefault('duree_annees', 3)
            filiere.setdefault('cout_annuel', 0)
            filiere.setdefault('debouches', [])

        features_profil = data_processor.prepare_profil_features(profil)

        # Utiliser l'ensemble ML
        recommendations = ml_service.recommend_filieres(
            features_profil,
            filieres
        )

        return jsonify({
            'success': True,
            'method': 'ensemble',
            'count': len(recommendations),
            'recommendations': recommendations
        }), 200

    except Exception as e:
        logger.error(f"Erreur Random Forest: {str(e)}")
        return jsonify({'success': False, 'error': str(e)}), 500


@app.route('/api/model/train', methods=['POST'])
def train_model():
    """
    Entraîner/réentraîner les modèles ML avec les données historiques
    Doit être appelé périodiquement pour améliorer les recommandations

    Body (optionnel):
    {
        "training_data": [
            {"profil_features": [...], "filiere_id": 1, "accepted": true, "success": true},
            ...
        ],
        "from_database": false  # Si true, récupère les données depuis PostgreSQL
    }
    """
    try:
        data = request.get_json() or {}
        training_data = data.get('training_data', [])
        from_database = data.get('from_database', True)  # Par défaut, utiliser la BD

        # Récupérer les données depuis la base de données si demandé
        if from_database:
            logger.info("Récupération des données d'entraînement depuis PostgreSQL...")
            db_session = db_config.get_session()
            db_service = DatabaseService(db_session)
            training_data = db_service.get_training_data(limit=1000)
            db_session.close()

            if not training_data:
                return jsonify({
                    'success': False,
                    'message': 'Pas de données dans la base de données'
                }), 400

        if not training_data:
            return jsonify({
                'success': False,
                'message': 'Données d\'entraînement requises'
            }), 400

        logger.info(f"Entraînement des modèles avec {len(training_data)} exemples...")

        # Entraîner les modèles
        metrics = model_trainer.train_models(training_data)

        return jsonify({
            'success': True,
            'message': 'Modèles entraînés avec succès',
            'samples_used': len(training_data),
            'metrics': metrics
        }), 200

    except Exception as e:
        logger.error(f"Erreur lors de l'entraînement: {str(e)}")
        return jsonify({
            'success': False,
            'message': str(e)
        }), 500


@app.route('/api/model/train-from-db', methods=['POST'])
def train_from_db():
    """
    Entraîner les modèles avec les données récentes de PostgreSQL
    Endpoint dédié pour l'entraînement automatique
    """
    try:
        data = request.get_json() or {}
        days = data.get('days', 30)
        limit = data.get('limit', 500)

        logger.info(f"Récupération des données des {days} derniers jours...")

        db_session = db_config.get_session()
        db_service = DatabaseService(db_session)
        training_data = db_service.get_recent_training_data(days=days, limit=limit)
        db_session.close()

        if not training_data:
            return jsonify({
                'success': False,
                'message': f'Pas de données des {days} derniers jours'
            }), 400

        logger.info(f"Entraînement avec {len(training_data)} exemples récents...")

        metrics = model_trainer.train_models(training_data)

        return jsonify({
            'success': True,
            'message': f'Modèles entraînés avec {len(training_data)} exemples',
            'samples_used': len(training_data),
            'metrics': metrics
        }), 200

    except Exception as e:
        logger.error(f"Erreur: {str(e)}")
        return jsonify({
            'success': False,
            'message': str(e)
        }), 500


@app.route('/api/model/evaluate', methods=['POST'])
def evaluate_model():
    """
    Évaluer les performances du modèle
    """
    try:
        data = request.get_json()
        test_data = data.get('test_data', [])
        
        if not test_data:
            return jsonify({
                'success': False,
                'message': 'Données de test requises'
            }), 400
        
        metrics = model_trainer.evaluate_models(test_data)
        
        return jsonify({
            'success': True,
            'metrics': metrics
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur lors de l'évaluation: {str(e)}")
        return jsonify({
            'success': False,
            'message': str(e)
        }), 500


@app.route('/api/explain-recommendation', methods=['POST'])
def explain_recommendation():
    """
    Expliquer une recommandation en détail
    Montre les facteurs qui ont influencé le score
    """
    try:
        data = request.get_json()
        profil = data.get('profil', {})
        filiere = data.get('filiere', {})

        # Enrichir le profil avec des valeurs par défaut
        if not profil:
            profil = {}

        profil.setdefault('serie_bac', 'S')
        profil.setdefault('moyenne_generale', 14.0)
        profil.setdefault('centres_interet', [])
        profil.setdefault('competences', {})
        profil.setdefault('budget_max_mensuel', 500)
        profil.setdefault('duree_max_etudes', 4)

        # Enrichir la filière
        if not filiere:
            return jsonify({
                'success': False,
                'error': 'Filière requise'
            }), 400

        filiere.setdefault('id', 0)
        filiere.setdefault('nom', 'Unknown')
        filiere.setdefault('series_bac_acceptees', ['S', 'L'])
        filiere.setdefault('centres_interet', [])
        filiere.setdefault('competences_requises', {})
        filiere.setdefault('duree_annees', 3)
        filiere.setdefault('cout_annuel', 0)
        filiere.setdefault('debouches', [])

        features_profil = data_processor.prepare_profil_features(profil)

        # Générer une explication basique
        explanation = {
            'filiere': filiere.get('nom'),
            'profil_summary': {
                'serie_bac': profil.get('serie_bac'),
                'moyenne': profil.get('moyenne_generale'),
                'centres_interet': profil.get('centres_interet', [])
            },
            'factors': {
                'moyenne_score': features_profil.get('moyenne_score', 50),
                'centres_interet_match': features_profil.get('centres_interet_match', 0.5),
                'competences_score': features_profil.get('competences_score', 50),
                'budget_compatibility': 'Acceptable',
                'duration_compatibility': 'Compatible'
            },
            'recommendation_reason': f"Cette filière est recommandée basée sur votre profil académique."
        }

        return jsonify({
            'success': True,
            'explanation': explanation
        }), 200

    except Exception as e:
        logger.error(f"Erreur lors de l'explication: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500


@app.route('/api/feature-importance', methods=['GET'])
def feature_importance():
    """
    Récupérer l'importance des features selon les modèles
    Utile pour comprendre quels critères sont les plus importants
    """
    try:
        importance = ml_service.get_feature_importance()
        
        return jsonify({
            'success': True,
            'feature_importance': importance
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur: {str(e)}")
        return jsonify({
            'success': False,
            'message': str(e)
        }), 500


# ────────────────────────────────────────────────────────────────────────────
# GESTION DES ERREURS
# ────────────────────────────────────────────────────────────────────────────

@app.errorhandler(404)
def not_found(e):
    return jsonify({'success': False, 'message': 'Endpoint non trouvé'}), 404


@app.errorhandler(500)
def internal_error(e):
    logger.error(f"Erreur serveur: {str(e)}")
    return jsonify({'success': False, 'message': 'Erreur serveur interne'}), 500


if __name__ == '__main__':
    port = int(os.getenv('AI_SERVICE_PORT', 5000))
    debug = os.getenv('AI_SERVICE_DEBUG', 'False').lower() == 'true'
    app.run(host='0.0.0.0', port=port, debug=debug)
