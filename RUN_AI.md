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

# restart et recréer l'image

docker-compose down ai-service
docker-compose build --no-cache ai-service
docker-compose up -d ai-service
sleep 15

# Connaitre la performance de model IA
# Métriques de performance basées sur les recommandations existantes
curl http://localhost:3000/api/metrics/model/performance

# Importance des features
curl http://localhost:3000/api/metrics/model/feature-importance

# Qualité des recommandations (nécessite auth)
curl -H "Authorization: Bearer YOUR_TOKEN" \
  http://localhost:3000/api/metrics/recommendations/quality


# Insertion des données d'entrainement
# Générer 100 utilisateurs (rapide pour tester)
node scripts/generate-training-data.js 100

# Ou générer 500 utilisateurs pour une bonne base d'entraînement
node scripts/generate-training-data.js 500

# Ou 1000+ pour une excellente base
node scripts/generate-training-data.js 1000


# Entrer dans la base de données
# Lister les containers
docker-compose ps

# Accéder au container PostgreSQL
docker-compose exec skill2study-postgres psql -U postgres -d orientation_db



# Voir combien de données ont été générées
cd backend
node -e "
require('dotenv').config();
const { User, ProfilAcademique, Recommendation, SessionTest } = require('./models');
Promise.all([
  User.count(),
  ProfilAcademique.count(),
  SessionTest.count(),
  Recommendation.count()
]).then(([users, profils, sessions, recs]) => {
  console.log('📊 Données générées:');
  console.log('  ✓ Users:', users);
  console.log('  ✓ Profils:', profils);
  console.log('  ✓ Sessions test:', sessions);
  console.log('  ✓ Recommandations:', recs);
  process.exit(0);
}).catch(e => console.error('Erreur:', e.message));
"

# reentrainement 
node scripts/train-ai-model.js

# evaluation
node scripts/test-model-metrics.js

# 1. Vérifier la génération
node -e "require('dotenv').config(); const {User,ProfilAcademique,Recommendation,SessionTest}=require('./models'); Promise.all([User.count(),ProfilAcademique.count(),SessionTest.count(),Recommendation.count()]).then(([u,p,s,r])=>{console.log('Users:',u,'Profils:',p,'Sessions:',s,'Recs:',r); process.exit(0);})"

# 2. Réentraîner le modèle
node scripts/train-ai-model.js

# 3. Évaluer les performances
node scripts/test-model-metrics.js

# 4. (Optionnel) Redémarrer le backend pour utiliser le nouveau modèle
npm start

# SANS risque pour les données
docker-compose down

# Supprimer SEULEMENT l'image du service IA
docker rmi skill2study-ai-service

# Afficher les images de Docker
docker images | grep -i ai

# Vérifier les models enregistrés dans le conteneur
docker exec skill2study-ai-service ls -la /app/models/