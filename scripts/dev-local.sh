#!/bin/bash

# Script de développement local (sans Docker)
# Utilise le service IA Python en développement et Node.js directement

set -e

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║     SKILL2STUDY - Mode Développement Local               ║"
echo "║  (Exécute Node.js et Python sans Docker)                 ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

COMMAND="${1:-start}"

case "$COMMAND" in
  start)
    echo "🚀 Démarrage en mode développement..."
    echo ""
    
    # Vérifier les prérequis
    if ! command -v python3 &> /dev/null; then
      echo "❌ Python3 non trouvé. Installez Python 3.11+."
      exit 1
    fi
    
    if ! command -v node &> /dev/null; then
      echo "❌ Node.js non trouvé. Installez Node.js 20+."
      exit 1
    fi
    
    # Créer les dossiers nécessaires
    mkdir -p backend/logs backend/ai_service/logs backend/ai_service/models
    
    # Démarrer le service IA dans le background
    echo "📡 Démarrage du service IA Python..."
    cd backend/ai_service
    
    if [ ! -d "venv" ]; then
      echo "   Création de l'environnement virtuel..."
      python3 -m venv venv
    fi
    
    source venv/bin/activate
    pip install -q -r requirements.txt
    
    # Lancer le service IA avec Flask development server
    FLASK_APP=app.py FLASK_ENV=development python app.py > logs/ai_service.log 2>&1 &
    AI_PID=$!
    
    cd ../..
    
    # Attendre que le service IA soit prêt
    echo "   Attente du démarrage du service IA..."
    sleep 3
    
    if ! curl -s http://localhost:5000/health > /dev/null 2>&1; then
      echo "❌ Service IA n'a pas démarré. Vérifiez les logs:"
      tail backend/ai_service/logs/ai_service.log
      kill $AI_PID 2>/dev/null || true
      exit 1
    fi
    
    echo "✓ Service IA démarré (PID: $AI_PID)"
    echo ""
    
    # Démarrer le backend Node.js
    echo "🔧 Démarrage du backend Node.js..."
    cd backend
    npm install -q 2>/dev/null || npm ci -q
    
    # Vérifier/Attendre PostgreSQL
    echo "   Vérification de la base de données..."
    for i in {1..30}; do
      if pg_isready -h localhost -U postgres > /dev/null 2>&1; then
        echo "✓ PostgreSQL est accessible"
        break
      fi
      if [ $i -eq 30 ]; then
        echo "❌ PostgreSQL n'est pas accessible. Assurez-vous qu'il est démarré."
        kill $AI_PID 2>/dev/null || true
        exit 1
      fi
      echo "   Attente... ($i/30)"
      sleep 1
    done
    
    # Lancer le backend avec nodemon (hot reload)
    npm run dev &
    NODE_PID=$!
    cd ..
    
    echo "✓ Backend Node.js démarré (PID: $NODE_PID)"
    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                  Services Disponibles                     ║"
    echo "╠═══════════════════════════════════════════════════════════╣"
    echo "║  Backend     : http://localhost:3000                      ║"
    echo "║  Service IA  : http://localhost:5000                      ║"
    echo "║  Database    : localhost:5432                             ║"
    echo "║                                                           ║"
    echo "║  Service IA (PID: $AI_PID)                        ║"
    echo "║  Backend (PID: $NODE_PID)                         ║"
    echo "║                                                           ║"
    echo "║  Logs:                                                    ║"
    echo "║    - IA: tail -f backend/ai_service/logs/ai_service.log  ║"
    echo "║    - Backend: tail -f backend/logs/app.log               ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""
    
    # Attendre l'interruption
    trap "kill $AI_PID $NODE_PID 2>/dev/null || true; echo ''; echo '🛑 Services arrêtés'; exit 0" INT TERM
    wait
    ;;
    
  test)
    echo "🧪 Test de l'API du service IA..."
    cd backend/ai_service
    
    if [ ! -d "venv" ]; then
      python3 -m venv venv
    fi
    
    source venv/bin/activate
    pip install -q requests
    
    python test_api.py
    ;;
    
  logs-ai)
    echo "📜 Logs du service IA (dernières 50 lignes):"
    tail -50 backend/ai_service/logs/ai_service.log
    ;;
    
  logs-backend)
    echo "📜 Logs du backend (dernières 50 lignes):"
    tail -50 backend/logs/app.log
    ;;
    
  *)
    echo "Usage: $0 [start|test|logs-ai|logs-backend]"
    echo ""
    echo "Commands:"
    echo "  start       - Démarrer le développement local"
    echo "  test        - Tester l'API du service IA"
    echo "  logs-ai     - Voir les logs du service IA"
    echo "  logs-backend - Voir les logs du backend"
    exit 1
    ;;
esac
