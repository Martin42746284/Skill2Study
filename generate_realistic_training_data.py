#!/usr/bin/env python3
"""
Générer des données d'entraînement réalistes dans PostgreSQL
basées sur les tables existantes
"""

import psycopg2
import json
import random
from datetime import datetime, timedelta

# Configuration PostgreSQL
DB_CONFIG = {
    'host': 'localhost',
    'port': 5432,
    'database': 'orientation_db',
    'user': 'postgres',
    'password': 'martin4274'
}

def connect_db():
    """Connecter à PostgreSQL"""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        return conn
    except Exception as e:
        print(f"❌ Erreur de connexion: {e}")
        return None

def create_sample_data(conn):
    """Créer des données d'entraînement réalistes"""
    try:
        cursor = conn.cursor()
        
        print("📊 Création des données d'entraînement réalistes...")
        
        # 1. Créer des utilisateurs/étudiants
        print("\n👥 Création de 50 utilisateurs...")
        try:
            for i in range(1, 51):
                cursor.execute("""
                    INSERT INTO users (nom, prenom, email, mot_de_passe, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, NOW(), NOW())
                    ON CONFLICT (email) DO NOTHING
                """, (f'Student{i}', f'Name{i}', f'student{i}@test.com', 'hashed_password'))
            conn.commit()
            print("  ✓ Utilisateurs créés")
        except Exception as e:
            print(f"  ⚠️  Utilisateurs: {e}")
            conn.rollback()
        
        # 2. Mettre à jour les utilisateurs avec données académiques
        print("📚 Ajout de données académiques aux utilisateurs...")
        series = ['S', 'L', 'ES', 'D', 'C']

        try:
            for i in range(1, 51):
                serie = random.choice(series)
                moyenne = round(random.uniform(8, 20), 2)
                ville = random.choice(['Antananarivo', 'Fianarantsoa', 'Toliara', 'Mahajanga', 'Antalaha'])
                budget = random.choice([300, 500, 800, 1000, 1500])

                cursor.execute("""
                    UPDATE users
                    SET serie_bac = %s, moyenne_generale = %s, ville = %s, budget_mensuel = %s, updated_at = NOW()
                    WHERE id = %s
                """, (serie, moyenne, ville, budget, i))

            conn.commit()
            print("  ✓ Données académiques ajoutées")
        except Exception as e:
            print(f"  ⚠️  Données académiques: {e}")
            conn.rollback()
        
        # 3. Récupérer les filières
        print("🎓 Récupération des filières...")
        cursor.execute("SELECT id, nom FROM filieres LIMIT 100")
        filieres = cursor.fetchall()

        if not filieres:
            print("⚠️  Pas de filières trouvées!")
            return False

        print(f"✅ {len(filieres)} filières trouvées")

        # 4. Créer des recommandations
        print("💾 Création de 200 recommandations...")
        try:
            for idx, user_id in enumerate(range(1, 51)):
                # Chaque utilisateur a 4-5 recommandations
                num_recs = random.randint(3, 5)
                filiere_sample = random.sample(filieres, min(num_recs, len(filieres)))

                for filiere_id, filiere_nom in filiere_sample:
                    score = round(random.uniform(50, 95), 1)
                    sauvegardee = random.choice([True, False])

                    # Date aléatoire dans les 6 derniers mois
                    days_ago = random.randint(1, 180)
                    created_at = datetime.now() - timedelta(days=days_ago)

                    cursor.execute("""
                        INSERT INTO recommendations
                        (user_id, filiere_id, score_compatibilite, sauvegardee, created_at, updated_at)
                        VALUES (%s, %s, %s, %s, %s, NOW())
                        ON CONFLICT DO NOTHING
                    """, (user_id, filiere_id, score, sauvegardee, created_at))

                if (idx + 1) % 10 == 0:
                    print(f"  ✓ {idx + 1}/50 utilisateurs traités")

            conn.commit()
            print("  ✓ Recommandations créées")
        except Exception as e:
            print(f"  ⚠️  Recommandations: {e}")
            conn.rollback()
        
        # 5. Vérifier les données créées
        cursor.execute("SELECT COUNT(*) FROM users")
        users_count = cursor.fetchone()[0]
        
        cursor.execute("SELECT COUNT(*) FROM profils_academiques")
        profils_count = cursor.fetchone()[0]
        
        cursor.execute("SELECT COUNT(*) FROM recommendations")
        recs_count = cursor.fetchone()[0]
        
        print(f"\n✅ DONNÉES CRÉÉES:")
        print(f"   - {users_count} utilisateurs")
        print(f"   - {profils_count} profils académiques")
        print(f"   - {recs_count} recommandations")
        
        cursor.close()
        return True
        
    except Exception as e:
        print(f"❌ Erreur lors de la création des données: {e}")
        return False

def main():
    print("╔═══════════════════════════════════════════════════════╗")
    print("║  GÉNÉRATION DE DONNÉES D'ENTRAÎNEMENT IA             ║")
    print("╚═══════════════════════════════════════════════════════╝")
    
    conn = connect_db()
    if not conn:
        return False
    
    try:
        success = create_sample_data(conn)
        
        if success:
            print("\n✅ DONNÉES D'ENTRAÎNEMENT GÉNÉRÉES AVEC SUCCÈS!")
            print("\n📝 Prochaine étape:")
            print("   1. Relancer le service IA: docker-compose restart ai-service")
            print("   2. Entraîner les modèles: curl -X POST http://localhost:5000/api/model/train -H 'Content-Type: application/json' -d '{\"from_database\": true}'")
            print("   3. Tester les endpoints")
        
        return success
        
    finally:
        conn.close()

if __name__ == '__main__':
    success = main()
    exit(0 if success else 1)
