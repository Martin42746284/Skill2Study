# Guide de Déploiement du Service ML de Recommandation

## Vue d'ensemble

Le système de recommandation intelligente utilise un service Python basé sur scikit-learn qui s'exécute séparément du backend Node.js.

### Architecture

```
Frontend (React)
    ↓
Backend Node.js (Port 3000)
    ↓
Service Python Flask (Port 5000)
    ├─ Recommendation ML Service (KNN, Random Forest, Weighted Scoring)
    ├─ Data Processor (Feature Engineering)
    └─ Model Trainer (Training & Evaluation)
```

## Installation

### Prérequis

- Python 3.8+
- Node.js 14+ (déjà installé)
- PostgreSQL (déjà configuré)

### Step 1: Setup du service IA

```bash
# Entrer le répertoire
cd ai-service

# Créer un environnement virtuel
python -m venv venv

# Activer l'environnement
source venv/bin/activate  # Linux/Mac
# ou
venv\Scripts\activate  # Windows

# Installer les dépendances
pip install -r requirements.txt

# Créer le fichier de configuration
cp .env.example .env

# Éditer .env avec les bonnes valeurs
nano .env  # ou votre éditeur
```

### Step 2: Configuration

Éditer `ai-service/.env` :

```env
# Port du service IA
AI_SERVICE_PORT=5000

# Mode debug
AI_SERVICE_DEBUG=False

# Configuration de la base de données
DB_HOST=localhost
DB_PORT=5432
DB_NAME=orientation_universitaire
DB_USER=postgres
DB_PASSWORD=your_password

# URL du backend Node.js
BACKEND_API_URL=http://localhost:3000/api

# Logging
LOG_LEVEL=INFO
```

### Step 3: Configuration du backend Node.js

Éditer `backend/.env` pour ajouter :

```env
# Service IA
AI_SERVICE_URL=http://localhost:5000
AI_SERVICE_ENABLED=true
```

## Lancement

### Mode développement (2 terminaux)

**Terminal 1 - Service IA:**
```bash
cd ai-service
source venv/bin/activate
python app.py
```

**Terminal 2 - Backend Node.js:**
```bash
cd backend
npm run dev
```

**Terminal 3 - Frontend (optionnel):**
```bash
npm run dev
```

### Mode production

#### Avec Gunicorn (Python)

```bash
cd ai-service

# Installer Gunicorn
pip install gunicorn

# Lancer avec 4 workers
gunicorn -w 4 -b 0.0.0.0:5000 app:app

# Ou avec Systemd (voir section systemd)
```

#### Avec PM2 (Node.js)

```bash
cd backend

# Installer PM2 globalement
npm install -g pm2

# Lancer les deux services
pm2 start server.js --name "api-backend"
pm2 start "python ../ai-service/app.py" --name "ai-service" --interpreter python

# Sauvegarder la configuration
pm2 save

# Relancer au démarrage
pm2 startup
```

## Configuration Systemd (Linux)

### Service Python

Créer `/etc/systemd/system/ai-service.service` :

```ini
[Unit]
Description=AI Recommendation Service
After=network.target

[Service]
Type=notify
User=www-data
WorkingDirectory=/path/to/project/ai-service
Environment="PATH=/path/to/project/ai-service/venv/bin"
ExecStart=/path/to/project/ai-service/venv/bin/gunicorn -w 4 -b 127.0.0.1:5000 app:app
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Activer le service :

```bash
sudo systemctl daemon-reload
sudo systemctl enable ai-service
sudo systemctl start ai-service
sudo systemctl status ai-service
```

### Service Node.js

Créer `/etc/systemd/system/api-backend.service` :

```ini
[Unit]
Description=API Backend
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/path/to/project/backend
ExecStart=/usr/bin/node server.js
Restart=on-failure
RestartSec=10
Environment="NODE_ENV=production"

[Install]
WantedBy=multi-user.target
```

## Configuration Nginx (Reverse Proxy)

```nginx
# Configuration pour l'API Backend
upstream backend {
    server 127.0.0.1:3000;
}

# Configuration pour le service IA
upstream ai_service {
    server 127.0.0.1:5000;
}

server {
    listen 80;
    server_name api.example.com;

    # Backend API
    location /api {
        proxy_pass http://backend;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # Service IA (interne seulement via Backend)
    # Ne pas exposer directement au public
}
```

## Entraînement des modèles

### Entraînement initial

```bash
# Via API depuis Node.js
curl -X POST http://localhost:3000/api/recommendations/ml/entrainer-modeles \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

### Entraînement automatique (cron job)

Créer un script `scripts/train_ml_models.js` :

```javascript
const axios = require('axios');

async function trainModels() {
  try {
    const response = await axios.post(
      'http://localhost:3000/api/recommendations/ml/entrainer-modeles',
      {},
      {
        headers: {
          'Authorization': `Bearer ${process.env.ADMIN_TOKEN}`
        }
      }
    );
    
    console.log('Modeles entraines:', response.data);
  } catch (err) {
    console.error('Erreur entraînement:', err.message);
  }
}

trainModels();
```

Ajouter au crontab :

```bash
# Entraîner les modèles chaque jour à 2h du matin
0 2 * * * cd /path/to/project && node scripts/train_ml_models.js
```

## Monitoring

### Vérifier l'état du service

```bash
# Health check
curl http://localhost:5000/health

# Logs
tail -f /var/log/ai-service.log
tail -f /var/log/api-backend.log
```

### Metriques Prometheus (optionnel)

Ajouter à `ai-service/app.py` :

```python
from prometheus_client import Counter, Histogram, start_http_server

# Metrics
recommendations_counter = Counter(
    'recommendations_total',
    'Total recommendations generated',
    ['method']
)

request_duration = Histogram(
    'request_duration_seconds',
    'Request duration in seconds',
    ['endpoint']
)

# Démarrer le serveur Prometheus sur le port 8000
start_http_server(8000)
```

## Dépannage

### Le service IA n'est pas accessible

```bash
# Vérifier que le service écoute
netstat -tuln | grep 5000

# Vérifier les logs
tail -50 ai-service.log

# Redémarrer le service
systemctl restart ai-service
```

### Les modèles ne s'entraînent pas

```bash
# Vérifier qu'il y a assez de données
curl http://localhost:3000/api/admin/stats

# Entraîner manuellement
python ai-service/train_offline.py
```

### Performance lente

1. Vérifier la CPU/RAM
2. Réduire le nombre de features
3. Augmenter les workers Gunicorn
4. Utiliser le caching Redis

## Optimisations pour la production

### 1. Caching Redis

```python
# Ajouter à requirements.txt
redis==4.5.0

# Utiliser dans le service
from redis import Redis

cache = Redis(host='localhost', port=6379)

# Cacher les recommandations pendant 1 heure
cache.setex(f'recs_{user_id}', 3600, json.dumps(recommendations))
```

### 2. Load Balancing

```nginx
upstream ai_service {
    server 127.0.0.1:5000 weight=1;
    server 127.0.0.1:5001 weight=1;
    server 127.0.0.1:5002 weight=1;
}
```

### 3. Async Processing

Pour les entraînements longs, utiliser Celery :

```bash
pip install celery
```

### 4. Database Optimization

```sql
-- Créer des index sur les colonnes utilisées
CREATE INDEX idx_profil_user ON profils_academiques(user_id);
CREATE INDEX idx_rec_user ON recommendations(user_id);
CREATE INDEX idx_filiere_id ON filieres(id);
```

## Backup & Recovery

### Backup des modèles

```bash
# Sauvegarder les modèles entraînés
tar -czf models_backup_$(date +%Y%m%d).tar.gz ai-service/models/

# Restaurer les modèles
tar -xzf models_backup_20231215.tar.gz -C ai-service/
```

### Versioning des modèles

```bash
# Avec Git LFS pour les fichiers volumineux
git lfs install
git lfs track "ai-service/models/*.pkl"
git add .gitattributes
git commit -m "Track models with LFS"
```

## Support et Documentation

- Service IA: `ai-service/README.md`
- Backend: `backend/README.md`
- Documentation API: `http://localhost:3000/api-docs`

## Checklist de déploiement

- [ ] Vérifier les variables d'environnement
- [ ] Tester la connexion à la base de données
- [ ] Entraîner les modèles initiaux
- [ ] Vérifier le health check
- [ ] Tester un appel API complet
- [ ] Configurer le monitoring
- [ ] Configurer les logs
- [ ] Mettre en place le backup
- [ ] Documenter les secrets
- [ ] Tester la récupération d'erreurs
