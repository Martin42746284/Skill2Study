#!/usr/bin/env python
"""
Script pour entraîner les modèles hors ligne avec les données de PostgreSQL
Utilisation: python train_offline.py [--days DAYS] [--limit LIMIT]
"""

import os
import argparse
import logging
from dotenv import load_dotenv

from config.database import db_config
from services.database_service import DatabaseService
from services.model_trainer import ModelTrainer

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Charger les variables d'environnement
load_dotenv()


def main():
    """Fonction principale"""
    parser = argparse.ArgumentParser(
        description='Entraîner les modèles ML avec les données de PostgreSQL'
    )
    parser.add_argument(
        '--days',
        type=int,
        default=30,
        help='Nombre de jours à remonter (défaut: 30)'
    )
    parser.add_argument(
        '--limit',
        type=int,
        default=1000,
        help='Limite du nombre d\'exemples (défaut: 1000)'
    )
    parser.add_argument(
        '--all',
        action='store_true',
        help='Utiliser toutes les données disponibles'
    )
    
    args = parser.parse_args()
    
    logger.info("="*60)
    logger.info("Entraînement des modèles ML")
    logger.info("="*60)
    
    # Tester la connexion à la base de données
    logger.info("Vérification de la connexion à PostgreSQL...")
    try:
        if not db_config.test_connection():
            logger.error("Impossible de se connecter à la base de données")
            return False
        logger.info("✓ Connexion à PostgreSQL OK")
    except Exception as e:
        logger.error(f"Erreur de connexion: {str(e)}")
        return False
    
    # Récupérer les données
    logger.info("Récupération des données d'entraînement...")
    try:
        db_session = db_config.get_session()
        db_service = DatabaseService(db_session)
        
        # Afficher les statistiques
        stats = db_service.get_statistics()
        logger.info(f"Statistiques de la base:")
        logger.info(f"  - Utilisateurs: {stats.get('total_users', 0)}")
        logger.info(f"  - Profils: {stats.get('complete_profiles', 0)}")
        logger.info(f"  - Recommandations: {stats.get('total_recommendations', 0)}")
        logger.info(f"  - Filières: {stats.get('total_filieres', 0)}")
        logger.info(f"  - Score moyen: {stats.get('avg_recommendation_score', 0):.2f}")
        logger.info(f"  - Taux de sauvegarde: {stats.get('save_rate', 0):.1f}%")
        
        # Récupérer les données
        if args.all:
            logger.info(f"Récupération de tous les données disponibles...")
            training_data = db_service.get_training_data(limit=10000)
        else:
            logger.info(f"Récupération des {args.days} derniers jours (max {args.limit} exemples)...")
            training_data = db_service.get_recent_training_data(
                days=args.days,
                limit=args.limit
            )
        
        db_session.close()
        
        if not training_data:
            logger.error("Pas de données disponibles pour l'entraînement")
            return False
        
        logger.info(f"✓ {len(training_data)} exemples récupérés")
        
    except Exception as e:
        logger.error(f"Erreur lors de la récupération des données: {str(e)}")
        return False
    
    # Entraîner les modèles
    logger.info("Entraînement des modèles...")
    try:
        trainer = ModelTrainer()
        metrics = trainer.train_models(training_data)
        
        if metrics.get('error'):
            logger.error(f"Erreur lors de l'entraînement: {metrics.get('error')}")
            return False
        
        logger.info("✓ Modèles entraînés avec succès")
        logger.info("")
        logger.info("Métriques du classificateur:")
        clf_metrics = metrics.get('classifier_metrics', {})
        logger.info(f"  - Accuracy: {clf_metrics.get('accuracy', 0):.3f}")
        logger.info(f"  - Precision: {clf_metrics.get('precision', 0):.3f}")
        logger.info(f"  - Recall: {clf_metrics.get('recall', 0):.3f}")
        logger.info(f"  - F1: {clf_metrics.get('f1', 0):.3f}")
        
        logger.info("")
        logger.info("Métriques du régresseur:")
        reg_metrics = metrics.get('regressor_metrics', {})
        logger.info(f"  - RMSE: {reg_metrics.get('rmse', 0):.2f}")
        logger.info(f"  - MAE: {reg_metrics.get('mae', 0):.2f}")
        logger.info(f"  - R²: {reg_metrics.get('r2', 0):.3f}")
        
        logger.info("")
        logger.info("Cross-Validation Scores:")
        cv_scores = metrics.get('cross_val_scores', {})
        logger.info(f"  - Classifier: {cv_scores.get('classifier_cv_score', 0):.3f}")
        logger.info(f"  - Regressor: {cv_scores.get('regressor_cv_score', 0):.3f}")
        
        logger.info("")
        logger.info("Feature Importance:")
        importance = metrics.get('feature_importance', {})
        for feature, value in importance.items():
            logger.info(f"  - {feature}: {value:.4f}")
        
        logger.info("")
        logger.info("="*60)
        logger.info("✓ Entraînement terminé avec succès!")
        logger.info("="*60)
        
        return True
        
    except Exception as e:
        logger.error(f"Erreur lors de l'entraînement: {str(e)}")
        import traceback
        logger.error(traceback.format_exc())
        return False


if __name__ == '__main__':
    success = main()
    exit(0 if success else 1)
