#!/usr/bin/env node

/**
 * Script de migration pour mettre à jour les séries bac acceptées
 * pour toutes les filières en fonction de leur domaine
 * 
 * Usage: node scripts/update-filieres-series-bac.js
 */

const API_BASE_URL = process.env.VITE_API_URL || "http://localhost:5000/api";
const ADMIN_TOKEN = process.env.ADMIN_TOKEN;

// Mapping domaine -> séries bac recommandées
const SERIES_BAC_PAR_DOMAINE = {
  "Sciences et Technologies": ["C", "D", "S", "Technique"],
  "Sciences de Gestion": ["A2", "C", "D"],
  "Droit et Sciences Politiques": ["A1", "A2", "C", "D"],
  "Arts, Lettres et Communication": ["A1", "A2"],
  "Santé et Paramédical": ["C", "D", "S"],
  "Agriculture et Environnement": ["D", "S", "Technique"],
  "Sciences Humaines et Sociales": ["A1", "A2", "C", "D"],
  "Défense et Sécurité": ["C", "D", "S", "A2"],
  // Domaines alternatifs/secondaires
  "Sciences de la Société": ["A1", "A2", "C", "D"],
  "Informatique, Numérique et Technologies": ["C", "D", "S", "Technique"],
  "Sciences de l'Ingénieur et Géosciences": ["C", "D", "S", "Technique"],
  "Informatique de Gestion": ["C", "D", "Technique"],
  "Mathématiques et Informatique Théorique": ["C", "D", "S"],
  "Génie Agricole": ["D", "S", "Technique"],
  "Agriculture et Génie Rural": ["D", "S", "Technique"],
  "Santé maternelle": ["C", "D", "S"],
  "Sciences Sociales, Environnement et Gouvernance": ["A1", "A2", "C", "D"],
  "Sciences Marines, Halieutiques et Environnementales": ["C", "D", "S", "Technique"],
  "Sciences Agronomiques et Agroalimentaires": ["D", "S", "Technique"],
  "Ingénierie biomédicale": ["C", "D", "S", "Technique"],
  "Biomédical": ["C", "D", "S", "Technique"],
  "Logistique et Commerce International": ["A2", "C", "D"],
  "Théologie, Philosophie et Sciences Religieuses": ["A1", "A2"],
  "Santé": ["C", "D", "S"],
  "Gestion de la Santé": ["A2", "C", "D"],
  "Santé publique": ["C", "D", "S"],
  "Santé Maternelle et Infantile": ["C", "D", "S"],
  "Sciences Humaines, Sociales, Juridiques et Politiques": ["A1", "A2", "C", "D"],
  "Physique et Sciences de l'Ingénieur": ["C", "D", "S", "Technique"],
  "Sciences Humaines, Sociales et Interdisciplinaires": ["A1", "A2", "C", "D"],
  // 10 domaines supplémentaires (1 filière chacun)
  "Industrie Alimentaire": ["D", "S", "Technique"],
  "Sciences de la Vie et de l'Environnement": ["C", "D", "S"],
  "Développement des affaires": ["A2", "C", "D"],
  "Comptabilité et Finance": ["A2", "C", "D"],
  "Géographie, Aménagement et Environnement": ["D", "C"],
  "Formation militaire spécialisée": ["C", "D", "S", "A2"],
  "Génie Civil": ["C", "D", "S", "Technique"],
  "Chimie, Géosciences et Sciences Pharmaceutiques": ["C", "D", "S"],
  "Environnement, Développement Durable et Ressources Naturelles": ["D", "S"],
  "Informatique, Télécommunications et Technologies Numériques": ["C", "D", "S", "Technique"],
};

function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function apiCall(endpoint, options = {}) {
  const { requireAuth = true, ...fetchOptions } = options;

  const headers = new Headers(fetchOptions.headers || {});
  headers.set("Content-Type", "application/json");

  if (requireAuth && ADMIN_TOKEN) {
    headers.set("Authorization", `Bearer ${ADMIN_TOKEN}`);
  }

  const response = await fetch(`${API_BASE_URL}${endpoint}`, {
    ...fetchOptions,
    headers,
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: "Erreur inconnue" }));
    const errorMessage = error.message || error.error || JSON.stringify(error);
    throw new Error(`[${response.status}] ${errorMessage}`);
  }

  return response.json();
}

async function updateFilieres() {
  console.log("🚀 Démarrage de la migration des séries bac...\n");

  if (!ADMIN_TOKEN) {
    console.warn(
      "⚠️  ATTENTION: ADMIN_TOKEN non défini. Définissez la variable d'environnement ADMIN_TOKEN."
    );
    console.warn("   Exemple: export ADMIN_TOKEN=votre_token_admin\n");
    process.exit(1);
  }

  try {
    // Récupérer toutes les filières
    console.log("📚 Récupération des filières...");
    const response = await apiCall("/filieres?limit=10000", {
      method: "GET",
      requireAuth: false,
    });

    let filieres = [];
    if (Array.isArray(response)) {
      filieres = response;
    } else if (response.filieres && Array.isArray(response.filieres)) {
      filieres = response.filieres;
    } else if (response.data && Array.isArray(response.data)) {
      filieres = response.data;
    }

    console.log(`✅ ${filieres.length} filière(s) trouvée(s)\n`);

    let updated = 0;
    let skipped = 0;
    let errors = 0;

    // Mettre à jour chaque filière
    for (const filiere of filieres) {
      // Skip si séries bac déjà configurées
      if (filiere.series_bac_acceptees && filiere.series_bac_acceptees.length > 0) {
        console.log(
          `⏭️  SKIPPED: "${filiere.nom}" (séries bac déjà configurées)`
        );
        skipped++;
        continue;
      }

      const domaine = filiere.domaine || "";
      const seriesBac = SERIES_BAC_PAR_DOMAINE[domaine];

      if (!seriesBac) {
        console.log(
          `⏭️  SKIPPED: "${filiere.nom}" (domaine inconnu: "${domaine}")`
        );
        skipped++;
        continue;
      }

      let retries = 0;
      const maxRetries = 3;
      let success = false;

      while (retries < maxRetries && !success) {
        try {
          if (retries === 0) {
            console.log(
              `🔄 Mise à jour: "${filiere.nom}" (${domaine})`
            );
            console.log(`   Séries: ${seriesBac.join(", ")}`);
          } else {
            console.log(`   Tentative ${retries + 1}/${maxRetries}...`);
          }

          await apiCall(`/filieres/${filiere.id}`, {
            method: "PUT",
            body: JSON.stringify({
              series_bac_acceptees: seriesBac,
            }),
            requireAuth: true,
          });

          console.log(`✅ Succès\n`);
          updated++;
          success = true;

          // Délai de 2 secondes entre chaque requête réussie
          await delay(2000);
        } catch (error) {
          retries++;

          if (retries >= maxRetries) {
            console.error(
              `❌ ERREUR après ${maxRetries} tentatives: ${error instanceof Error ? error.message : "Erreur inconnue"}\n`
            );
            errors++;
            // Attendre long avant la prochaine filière
            await delay(10000);
          } else if (error instanceof Error && error.message.includes("429")) {
            console.log(`⏸️  Rate limited - attente de 10 secondes avant retry...\n`);
            await delay(10000);
          } else {
            console.log(`⏸️  Erreur - attente de 5 secondes avant retry...\n`);
            await delay(5000);
          }
        }
      }
    }

    // Résumé
    console.log("\n" + "=".repeat(60));
    console.log("📊 RÉSUMÉ DE LA MIGRATION");
    console.log("=".repeat(60));
    console.log(`✅ Mises à jour réussies: ${updated}`);
    console.log(`⏭️  Filières ignorées: ${skipped}`);
    console.log(`❌ Erreurs: ${errors}`);
    console.log(`📈 Total traité: ${updated + skipped + errors} / ${filieres.length}`);
    console.log("=".repeat(60) + "\n");

    if (errors === 0) {
      console.log("🎉 Migration terminée avec succès!");
      process.exit(0);
    } else {
      console.log(
        `⚠️  Migration terminée avec ${errors} erreur(s). Veuillez vérifier les logs ci-dessus.`
      );
      process.exit(1);
    }
  } catch (error) {
    console.error(
      "❌ Erreur fatale:",
      error instanceof Error ? error.message : error
    );
    process.exit(1);
  }
}

updateFilieres();
