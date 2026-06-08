#!/usr/bin/env node

/**
 * Script pour analyser les filières ignorées et identifier les domaines manquants
 * Génère un rapport des domaines qui n'ont pas de mapping
 */

const API_BASE_URL = process.env.VITE_API_URL || "http://localhost:5000/api";

async function apiCall(endpoint, options = {}) {
  const { requireAuth = true, ...fetchOptions } = options;

  const headers = new Headers(fetchOptions.headers || {});
  headers.set("Content-Type", "application/json");

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

async function analyzeFilieres() {
  console.log("🔍 Analyse des domaines manquants...\n");

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

    // Domaines existants dans notre mapping
    const mappedDomains = [
      "Sciences et Technologies",
      "Sciences de Gestion",
      "Droit et Sciences Politiques",
      "Arts, Lettres et Communication",
      "Santé et Paramédical",
      "Agriculture et Environnement",
      "Sciences Humaines et Sociales",
      "Défense et Sécurité",
      "Sciences de la Société",
      "Informatique, Numérique et Technologies",
      "Sciences de l'Ingénieur et Géosciences",
      "Informatique de Gestion",
      "Mathématiques et Informatique Théorique",
      "Génie Agricole",
      "Agriculture et Génie Rural",
      "Santé maternelle",
      "Sciences Sociales, Environnement et Gouvernance",
      "Sciences Marines, Halieutiques et Environnementales",
      "Sciences Agronomiques et Agroalimentaires",
      "Ingénierie biomédicale",
      "Biomédical",
      "Logistique et Commerce International",
      "Théologie, Philosophie et Sciences Religieuses",
      "Santé",
      "Gestion de la Santé",
      "Santé publique",
      "Santé Maternelle et Infantile",
      "Sciences Humaines, Sociales, Juridiques et Politiques",
      "Physique et Sciences de l'Ingénieur",
      "Sciences Humaines, Sociales et Interdisciplinaires",
    ];

    // Analyser les filières sans séries bac
    const filieresSansSeries = filieres.filter(f => !f.series_bac_acceptees || f.series_bac_acceptees.length === 0);
    
    console.log(`📊 Filières sans séries bac: ${filieresSansSeries.length}\n`);

    // Regrouper par domaine
    const domaineCounts = {};
    const domaineFilieres = {};

    for (const filiere of filieresSansSeries) {
      const domaine = filiere.domaine || "DOMAINE VIDE";
      
      if (!domaineCounts[domaine]) {
        domaineCounts[domaine] = 0;
        domaineFilieres[domaine] = [];
      }
      
      domaineCounts[domaine]++;
      domaineFilieres[domaine].push(filiere.nom);
    }

    // Identifier les domaines manquants (non mappés)
    const missingDomains = Object.keys(domaineCounts)
      .filter(d => !mappedDomains.includes(d))
      .sort((a, b) => domaineCounts[b] - domaineCounts[a]);

    console.log("=" .repeat(70));
    console.log("🔴 DOMAINES MANQUANTS (à ajouter au mapping)");
    console.log("=" .repeat(70));
    
    if (missingDomains.length === 0) {
      console.log("✅ Aucun domaine manquant!\n");
    } else {
      missingDomains.forEach((domaine) => {
        const count = domaineCounts[domaine];
        console.log(`\n📌 "${domaine}" (${count} filière(s))`);
        console.log(`   Exemples: ${domaineFilieres[domaine].slice(0, 3).join(", ")}`);
      });
      console.log("\n");
    }

    // Domaines mappés utilisés
    const mappedUsed = Object.keys(domaineCounts)
      .filter(d => mappedDomains.includes(d))
      .sort((a, b) => domaineCounts[b] - domaineCounts[a]);

    console.log("=" .repeat(70));
    console.log("✅ DOMAINES MAPPÉS (déjà couvertes)");
    console.log("=" .repeat(70));
    
    mappedUsed.forEach((domaine) => {
      const count = domaineCounts[domaine];
      console.log(`  "${domaine}": ${count} filière(s)`);
    });
    console.log();

    // Résumé
    console.log("=" .repeat(70));
    console.log("📊 RÉSUMÉ");
    console.log("=" .repeat(70));
    console.log(`Total filières: ${filieres.length}`);
    console.log(`Filières sans séries bac: ${filieresSansSeries.length}`);
    console.log(`Domaines uniques manquants: ${missingDomains.length}`);
    console.log(`Domaines mappés utilisés: ${mappedUsed.length}`);
    console.log("=" .repeat(70) + "\n");

    // Export JSON pour faciliter l'ajout
    if (missingDomains.length > 0) {
      console.log("💾 Suggestion de mapping à ajouter:\n");
      console.log("const SERIES_BAC_PAR_DOMAINE = {");
      missingDomains.forEach((domaine) => {
        console.log(`  "${domaine}": [/* À DÉFINIR */],`);
      });
      console.log("};\n");
    }

  } catch (error) {
    console.error(
      "❌ Erreur:",
      error instanceof Error ? error.message : error
    );
    process.exit(1);
  }
}

analyzeFilieres();
