#!/usr/bin/env node

/**
 * Script de test des endpoints API
 * Vérifie que tous les endpoints critiques fonctionnent correctement
 * 
 * Usage: node scripts/test-endpoints.js
 */

const API_URL = process.env.API_URL || 'http://localhost:3000/api';
let authToken = null;
let testUserId = null;

const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m',
};

function log(message, color = 'reset') {
  console.log(`${colors[color]}${message}${colors.reset}`);
}

async function apiCall(endpoint, options = {}) {
  const { method = 'GET', body = null, requireAuth = true } = options;

  const headers = {
    'Content-Type': 'application/json',
    ...options.headers,
  };

  if (requireAuth && authToken) {
    headers['Authorization'] = `Bearer ${authToken}`;
  }

  const fetchOptions = {
    method,
    headers,
  };

  if (body) {
    fetchOptions.body = JSON.stringify(body);
  }

  try {
    const response = await fetch(`${API_URL}${endpoint}`, fetchOptions);

    if (!response.ok) {
      const error = await response.json().catch(() => ({ message: `HTTP ${response.status}` }));
      throw new Error(error.message || error.error || `HTTP ${response.status}`);
    }

    return {
      status: response.status,
      data: await response.json(),
    };
  } catch (err) {
    throw err;
  }
}

// ============================================================================
// TEST SUITES
// ============================================================================

const tests = {
  authentication: [
    {
      name: 'POST /auth/register',
      test: async () => {
        const email = `test_${Date.now()}@example.com`;
        const response = await apiCall('/auth/register', {
          method: 'POST',
          body: {
            nom: 'Test',
            prenom: 'User',
            email,
            mot_de_passe: 'Test@12345',
          },
          requireAuth: false,
        });
        return response;
      },
    },
    {
      name: 'POST /auth/login',
      test: async () => {
        // Register first
        const email = `test_${Date.now()}@example.com`;
        await apiCall('/auth/register', {
          method: 'POST',
          body: {
            nom: 'Test',
            prenom: 'User',
            email,
            mot_de_passe: 'Test@12345',
          },
          requireAuth: false,
        });

        // Then login
        const response = await apiCall('/auth/login', {
          method: 'POST',
          body: {
            email,
            mot_de_passe: 'Test@12345',
          },
          requireAuth: false,
        });

        // Save token for other tests
        if (response.data.token) {
          authToken = response.data.token;
        }

        return response;
      },
    },
    {
      name: 'GET /auth/me',
      test: async () => {
        return apiCall('/auth/me', { method: 'GET' });
      },
    },
  ],

  users: [
    {
      name: 'GET /users/profil',
      test: async () => {
        return apiCall('/users/profil', { method: 'GET' });
      },
    },
    {
      name: 'PUT /users/profil/academique',
      test: async () => {
        return apiCall('/users/profil/academique', {
          method: 'PUT',
          body: {
            serie_bac: 'S',
            moyenne_generale: 15.5,
            centres_interet: ['informatique', 'science'],
            competences: {
              logique: 4,
              communication: 3,
              creativite: 5,
            },
            budget_max_mensuel: 500,
            duree_max_etudes: 3,
          },
        });
      },
    },
    {
      name: 'GET /users/favoris',
      test: async () => {
        return apiCall('/users/favoris', { method: 'GET' });
      },
    },
  ],

  universities: [
    {
      name: 'GET /universites (page 1)',
      test: async () => {
        return apiCall('/universites?page=1&limit=5', { 
          method: 'GET',
          requireAuth: false,
        });
      },
    },
  ],

  filieres: [
    {
      name: 'GET /filieres (page 1)',
      test: async () => {
        return apiCall('/filieres?page=1&limit=5', { 
          method: 'GET',
          requireAuth: false,
        });
      },
    },
  ],

  tests: [
    {
      name: 'GET /test/questions',
      test: async () => {
        return apiCall('/test/questions', { 
          method: 'GET',
          requireAuth: false,
        });
      },
    },
    {
      name: 'POST /test/demarrer',
      test: async () => {
        const response = await apiCall('/test/demarrer', {
          method: 'POST',
          body: {},
        });
        return response;
      },
    },
    {
      name: 'GET /test/historique',
      test: async () => {
        return apiCall('/test/historique', { method: 'GET' });
      },
    },
  ],

  recommendations: [
    {
      name: 'POST /recommendations/generer',
      test: async () => {
        return apiCall('/recommendations/generer', {
          method: 'POST',
          body: { session_test_id: null },
        });
      },
    },
    {
      name: 'GET /recommendations/mes-recommendations',
      test: async () => {
        return apiCall('/recommendations/mes-recommendations', { 
          method: 'GET',
        });
      },
    },
  ],

  comparator: [
    {
      name: 'POST /comparateur',
      test: async () => {
        // First get some filieres
        const filieresResponse = await apiCall('/filieres?page=1&limit=3', { 
          method: 'GET',
          requireAuth: false,
        });

        const filiereIds = filieresResponse.data.filieres?.slice(0, 2).map(f => f.id) || [];

        if (filiereIds.length < 2) {
          throw new Error('Pas assez de filières pour la comparaison');
        }

        return apiCall('/comparateur', {
          method: 'POST',
          body: { filiere_ids: filiereIds },
        });
      },
    },
  ],

  statistics: [
    {
      name: 'GET /stats/moi',
      test: async () => {
        return apiCall('/stats/moi', { method: 'GET' });
      },
    },
  ],
};

// ============================================================================
// TEST RUNNER
// ============================================================================

async function runTests() {
  log('\n' + '='.repeat(60), 'cyan');
  log('TEST DES ENDPOINTS API', 'cyan');
  log('='.repeat(60), 'cyan');
  log(`\nAPI URL: ${API_URL}\n`);

  let passed = 0;
  let failed = 0;
  const results = [];

  for (const [category, categoryTests] of Object.entries(tests)) {
    log(`\n${category.toUpperCase()}`, 'blue');
    log('-'.repeat(40), 'blue');

    for (const test of categoryTests) {
      try {
        const result = await test.test();
        log(`✓ ${test.name}`, 'green');
        results.push({ category, name: test.name, status: 'PASS' });
        passed++;
      } catch (err) {
        log(`✗ ${test.name}`, 'red');
        log(`  Erreur: ${err.message}`, 'red');
        results.push({ category, name: test.name, status: 'FAIL', error: err.message });
        failed++;
      }
    }
  }

  // Summary
  log('\n' + '='.repeat(60), 'cyan');
  log('RÉSUMÉ', 'cyan');
  log('='.repeat(60), 'cyan');
  log(`Total: ${passed + failed} tests`);
  log(`✓ Réussis: ${passed}`, 'green');
  log(`✗ Échoués: ${failed}`, failed === 0 ? 'green' : 'red');

  // Details
  if (failed > 0) {
    log('\nEndpoints qui ont échoué:', 'yellow');
    results
      .filter(r => r.status === 'FAIL')
      .forEach(r => {
        log(`  - ${r.name}: ${r.error}`, 'yellow');
      });
  }

  log('\n');
  return failed === 0;
}

// ============================================================================
// MAIN
// ============================================================================

runTests()
  .then(success => {
    process.exit(success ? 0 : 1);
  })
  .catch(err => {
    log(`Erreur fatale: ${err.message}`, 'red');
    process.exit(1);
  });
