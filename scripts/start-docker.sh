#!/bin/bash

# Script de démarrage des services avec Docker Compose
# Usage: ./scripts/start-docker.sh [up|down|restart|logs|build]

set -e

PROJECT_NAME="skill2study"
COMMAND="${1:-up}"

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║     SKILL2STUDY - Service IA Intelligent                 ║"
echo "║     Docker Compose Manager                               ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

case "$COMMAND" in
  up)
    echo "🚀 Démarrage des services..."
    docker-compose up -d
    echo ""
    echo "✓ Services démarrés!"
    echo ""
    echo "Services disponibles:"
    echo "  - Backend Node.js    : http://localhost:3000"
    echo "  - Service IA Python  : http://localhost:5000"
    echo "  - Base de données    : localhost:5432"
    echo ""
    echo "Utilisez 'docker-compose logs -f [service]' pour voir les logs"
    ;;
    
  down)
    echo "🛑 Arrêt des services..."
    docker-compose down
    echo "✓ Services arrêtés"
    ;;
    
  restart)
    echo "🔄 Redémarrage des services..."
    docker-compose restart
    echo "✓ Services redémarrés"
    ;;
    
  logs)
    SERVICE="${2:-}"
    if [ -z "$SERVICE" ]; then
      docker-compose logs -f
    else
      docker-compose logs -f "$SERVICE"
    fi
    ;;
    
  build)
    echo "🔨 Construction des images..."
    docker-compose build
    echo "✓ Images construites"
    ;;
    
  status)
    echo "📊 État des services:"
    docker-compose ps
    ;;
    
  health)
    echo "🏥 Vérification de la santé des services..."
    echo ""
    
    # Check Backend
    if curl -s http://localhost:3000/health > /dev/null 2>&1; then
      echo "✓ Backend: OK"
    else
      echo "✗ Backend: ERREUR"
    fi
    
    # Check AI Service
    if curl -s http://localhost:5000/health > /dev/null 2>&1; then
      echo "✓ Service IA: OK"
    else
      echo "✗ Service IA: ERREUR"
    fi
    
    # Check Database
    if docker exec skill2study_postgres pg_isready -U postgres > /dev/null 2>&1; then
      echo "✓ Base de données: OK"
    else
      echo "✗ Base de données: ERREUR"
    fi
    ;;
    
  *)
    echo "Usage: $0 [up|down|restart|logs|build|status|health]"
    echo ""
    echo "Commands:"
    echo "  up       - Démarrer tous les services"
    echo "  down     - Arrêter tous les services"
    echo "  restart  - Redémarrer tous les services"
    echo "  logs     - Afficher les logs (optionnel: [service])"
    echo "  build    - Construire les images Docker"
    echo "  status   - Afficher l'état des services"
    echo "  health   - Vérifier la santé des services"
    exit 1
    ;;
esac
