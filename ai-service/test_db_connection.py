#!/usr/bin/env python
"""
Script pour tester la connexion à PostgreSQL
Utilisation: python test_db_connection.py
"""

import os
import logging
from dotenv import load_dotenv

from config.database import db_config
from services.database_service import DatabaseService

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Charger les variables d'environnement
load_dotenv()


def main():
    """Tester la connexion"""
    logger.info("="*60)
    logger.info("Test de connexion à PostgreSQL")
    logger.info("="*60)
    
    # Afficher la connexion (sans le mot de passe)
    db_url = os.getenv('DATABASE_URL', '')
    # Masquer le mot de passe
    if '@' in db_url:
        db_url_masked = db_url.split('@')[0].split('://')[0] + '://***@' + db_url.split('@')[1]
    else:
        db_url_masked = db_url
    
    logger.info(f"DATABASE_URL: {db_url_masked}")
    
    # Tester la connexion
    logger.info("\nTest de connexion...")
    try:
        if db_config.test_connection():
            logger.info("✓ Connexion OK")
        else:
            logger.error("✗ Connexion échouée")
            return False
    except Exception as e:
        logger.error(f"✗ Erreur: {str(e)}")
        return False
    
    # Récupérer les statistiques
    logger.info("\nRécupération des statistiques...")
    try:
        db_session = db_config.get_session()
        db_service = DatabaseService(db_session)
        stats = db_service.get_statistics()
        db_session.close()
        
        logger.info("\nStatistiques de la base:")
        logger.info(f"  - Utilisateurs: {stats.get('total_users', 0)}")
        logger.info(f"  - Profils académiques: {stats.get('complete_profiles', 0)}")
        logger.info(f"  - Recommandations: {stats.get('total_recommendations', 0)}")
        logger.info(f"  - Filières: {stats.get('total_filieres', 0)}")
        logger.info(f"  - Score moyen: {stats.get('avg_recommendation_score', 0):.2f}")
        logger.info(f"  - Taux de sauvegarde: {stats.get('save_rate', 0):.1f}%")
        
    except Exception as e:
        logger.error(f"✗ Erreur lors de la récupération des stats: {str(e)}")
        return False
    
    # Tester la récupération des données
    logger.info("\nRécupération des données d'entraînement...")
    try:
        db_session = db_config.get_session()
        db_service = DatabaseService(db_session)
        training_data = db_service.get_training_data(limit=10)
        db_session.close()
        
        logger.info(f"✓ {len(training_data)} exemples récupérés")
        
        if training_data:
            logger.info("\nPremier exemple:")
            example = training_data[0]
            logger.info(f"  Filière: {example['filiere']['nom']}")
            logger.info(f"  Série BAC: {example['profil_features']['serie_bac']}")
            logger.info(f"  Moyenne: {example['profil_features']['moyenne_score']:.1f}")
            logger.info(f"  Accepté: {example['accepted']}")
            logger.info(f"  Succès: {example['success']}")
            logger.info(f"  Engagement: {example['engagement']:.2f}")
        
    except Exception as e:
        logger.error(f"✗ Erreur lors de la récupération des données: {str(e)}")
        import traceback
        logger.error(traceback.format_exc())
        return False
    
    logger.info("\n" + "="*60)
    logger.info("✓ Tous les tests sont passés!")
    logger.info("="*60)
    
    return True


if __name__ == '__main__':
    success = main()
    exit(0 if success else 1)
