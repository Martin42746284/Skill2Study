#!/bin/bash

set -e

echo "🚀 Démarrage de la plateforme d'orientation universitaire..."
echo "=================================================="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}⚠️  Docker n'est pas installé. En utilisant PostgreSQL local.${NC}"
else
    echo -e "${BLUE}📦 Vérification de PostgreSQL...${NC}"
    if ! docker ps | grep -q postgres; then
        echo -e "${BLUE}🐘 Démarrage de PostgreSQL via Docker...${NC}"
        docker-compose up -d
        echo -e "${BLUE}⏳ Attente du démarrage de PostgreSQL...${NC}"
        sleep 5
    else
        echo -e "${GREEN}✅ PostgreSQL est déjà en cours d'exécution${NC}"
    fi
fi

# Backend
echo ""
echo -e "${BLUE}🔧 Installation/Mise à jour du backend...${NC}"
cd backend
if [ ! -d "node_modules" ]; then
    npm install
fi

# Check if .env exists
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}⚠️  .env n'existe pas. Création à partir du modèle...${NC}"
    cp .env.example .env
fi

echo -e "${BLUE}🌱 Initialisation de la base de données...${NC}"
npm run seed > /dev/null 2>&1 || true

echo -e "${GREEN}✅ Backend prêt!${NC}"
echo -e "${BLUE}🚀 Démarrage du serveur backend...${NC}"
npm run dev &
BACKEND_PID=$!

cd ..

# Frontend
echo ""
echo -e "${BLUE}🎨 Installation/Mise à jour du frontend...${NC}"
if [ ! -d "node_modules" ]; then
    npm install
fi

echo -e "${GREEN}✅ Frontend prêt!${NC}"
echo -e "${BLUE}🚀 Démarrage du serveur frontend...${NC}"
npm run dev &
FRONTEND_PID=$!

echo ""
echo -e "${GREEN}=================================================="
echo -e "🎉 Plateforme démarrée avec succès!${NC}"
echo ""
echo -e "${BLUE}📱 Frontend  : http://localhost:5173${NC}"
echo -e "${BLUE}⚙️  Backend   : http://localhost:5000${NC}"
echo -e "${BLUE}📚 API Docs  : http://localhost:5000/api/docs${NC}"
echo ""
echo -e "${YELLOW}Comptes de test :${NC}"
echo "  👤 Admin      : admin@orientation.dz / Admin1234!"
echo "  👤 Bachelier1 : marie.dupont@example.com / Password123!"
echo "  👤 Bachelier2 : karim.ahmed@example.com / Password123!"
echo ""
echo -e "${YELLOW}Appuyez sur Ctrl+C pour arrêter la plateforme${NC}"
echo -e "${GREEN}=================================================="
echo ""

# Wait for both processes
wait $BACKEND_PID $FRONTEND_PID

echo -e "${YELLOW}Arrêt de la plateforme...${NC}"

# Cleanup
if command -v docker &> /dev/null; then
    docker-compose down 2>/dev/null || true
fi

echo -e "${GREEN}✅ Arrêt réussi${NC}"
