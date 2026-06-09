sudo lsof -i :5432
sudo systemctl stop postgresql
docker-compose up

# 1️⃣ Reconstruire SEULEMENT l'image ai-service
docker-compose build --no-cache ai-service

# 2️⃣ Vérifier qu'elle est créée
docker images | grep skill2study_ai-service

# 3️⃣ Lancer le service IA + PostgreSQL
docker-compose up ai-service postgres

Lancement local :

pip install Flask==2.3.3 Flask-CORS==4.0.0 numpy==1.26.4 pandas==2.1.4 scikit-learn==1.3.2 joblib==1.3.1 python-dotenv==1.0.0 requests==2.31.0 psycopg2-binary==2.9.9 SQLAlchemy==2.0.23 gunicorn==21.2.0

python3 app.py