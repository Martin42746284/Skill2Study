"""
Configuration de la base de données pour le service IA
Utilise la chaîne de connexion PostgreSQL
"""

import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import logging

logger = logging.getLogger(__name__)


class DatabaseConfig:
    """Configuration de la base de données"""
    
    def __init__(self):
        """Initialiser la configuration"""
        # Récupérer la chaîne de connexion des variables d'environnement
        self.database_url = os.getenv(
            'DATABASE_URL',
            'postgresql://postgres:postgres@localhost:5432/orientation_db'
        )

        # Vérifier que la chaîne de connexion est valide
        if not self.database_url:
            raise ValueError("DATABASE_URL non définie")

        # Log sans afficher le mot de passe
        safe_url = self.database_url.split('@')[1] if '@' in self.database_url else 'unknown'
        logger.info(f"Database URL configured (user@host): {self.database_url.split(':')[1].lstrip('//')}_@{safe_url}")

        # Options de connexion
        self.connect_args = {
            'connect_timeout': 10,
        }

        # SSL (optionnel)
        if os.getenv('DB_SSL', 'false').lower() == 'true':
            self.connect_args['sslmode'] = 'require'

        # Créer l'engine SQLAlchemy
        self.engine = self._create_engine()
        self.SessionLocal = sessionmaker(
            autocommit=False,
            autoflush=False,
            bind=self.engine
        )
    
    def _create_engine(self):
        """Créer le moteur SQLAlchemy"""
        try:
            # Modifier la chaîne de connexion pour SQLAlchemy si nécessaire
            db_url = self.database_url

            # Si c'est postgresql://, le convertir en postgresql+psycopg2://
            if db_url.startswith('postgresql://'):
                db_url = db_url.replace('postgresql://', 'postgresql+psycopg2://', 1)

            logger.info(f"Creating engine with database: {db_url.split('/')[-1]}")

            engine = create_engine(
                db_url,
                connect_args=self.connect_args,
                echo=os.getenv('SQL_ECHO', 'false').lower() == 'true',
                pool_size=10,
                max_overflow=20,
                pool_pre_ping=True  # Tester la connexion avant de l'utiliser
            )

            logger.info("Engine SQLAlchemy créé avec succès")
            return engine

        except Exception as e:
            logger.error(f"Erreur lors de la création de l'engine: {str(e)}")
            raise
    
    def get_session(self):
        """Obtenir une session de base de données"""
        return self.SessionLocal()
    
    def test_connection(self):
        """Tester la connexion à la base de données"""
        try:
            from sqlalchemy import text
            with self.engine.connect() as conn:
                result = conn.execute(text("SELECT 1"))
                logger.info("Connexion à la base de données OK")
                return True
        except Exception as e:
            logger.error(f"Erreur de connexion: {str(e)}")
            return False


# Instance globale
db_config = DatabaseConfig()


def get_db_session():
    """Dépendance FastAPI/Flask pour obtenir une session"""
    db = db_config.get_session()
    try:
        yield db
    finally:
        db.close()
