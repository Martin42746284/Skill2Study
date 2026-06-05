#!/bin/bash

# Script pour résoudre les erreurs 404 de Vite
# Nettoie et réinstalle complètement

echo "🔧 Correction des erreurs Vite..."
echo ""

# 1. Vérifier que nous sommes dans le bon répertoire
if [ ! -f "vite.config.ts" ]; then
    echo "❌ Erreur: vite.config.ts non trouvé"
    echo "Exécutez ce script depuis la racine du projet"
    exit 1
fi

# 2. Arrêter le serveur Vite s'il est en cours d'exécution
echo "⏹️  Arrêt du serveur Vite..."
pkill -f "vite" || true
sleep 2

# 3. Supprimer les caches
echo "🗑️  Suppression des caches..."
rm -rf node_modules/.vite 2>/dev/null || true
rm -rf node_modules/.vite-ssr 2>/dev/null || true
rm -rf dist 2>/dev/null || true
rm -rf .vite 2>/dev/null || true
rm -rf .cache 2>/dev/null || true

# 4. Nettoyer npm
echo "🧹 Nettoyage npm..."
npm cache clean --force 2>/dev/null || true

# 5. Réinstaller les dépendances
echo "📦 Réinstallation des dépendances..."
rm -rf node_modules
npm install

if [ $? -ne 0 ]; then
    echo "❌ Erreur lors de l'installation des dépendances"
    exit 1
fi

# 6. Pré-build les dépendances Vite
echo "🏗️  Pré-build des dépendances..."
npx vite build --mode development 2>/dev/null || true

# 7. Redémarrer le serveur Vite
echo ""
echo "✅ Correction terminée!"
echo ""
echo "🚀 Démarrage du serveur Vite..."
npm run dev
