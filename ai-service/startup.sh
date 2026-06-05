#!/bin/bash

# Script de démarrage du service IA

echo "=========================================="
echo "Service IA - Startup"
echo "=========================================="

# Vérifier si l'environnement virtuel existe
if [ ! -d "venv" ]; then
    echo "Création de l'environnement virtuel..."
    python3 -m venv venv
fi

# Activer l'environnement virtuel
echo "Activation de l'environnement virtuel..."
source venv/bin/activate

# Vérifier si .env existe
if [ ! -f ".env" ]; then
    echo "Création du fichier .env..."
    cp .env.example .env
    echo "⚠️  Veuillez configurer le fichier .env"
fi

# Installer les dépendances
echo "Installation des dépendances..."
pip install -q -r requirements.txt

# Tester la connexion à la base de données
echo ""
echo "Test de connexion à la base de données..."
python test_db_connection.py

if [ $? -ne 0 ]; then
    echo "❌ Erreur: Connexion à la base de données impossible"
    exit 1
fi

# Démarrer le service
echo ""
echo "Démarrage du service IA..."
echo "Le service sera disponible sur http://localhost:5000"
echo ""

python app.py
