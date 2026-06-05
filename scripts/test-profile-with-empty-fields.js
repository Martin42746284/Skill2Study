#!/usr/bin/env node
/**
 * Test Profile with Empty Fields
 * Simulates frontend behavior when optional fields are left empty
 */

const API_URL = 'http://localhost:5000/api';

const TEST_USER = {
  email: 'hery@email.mg',
  password: 'Password123!',
};

let authToken = '';

async function apiCall(method, endpoint, body = null) {
  const options = {
    method,
    headers: {
      'Content-Type': 'application/json',
    },
  };

  if (authToken) {
    options.headers['Authorization'] = `Bearer ${authToken}`;
  }

  if (body) {
    options.body = JSON.stringify(body);
  }

  const response = await fetch(`${API_URL}${endpoint}`, options);
  const data = await response.json();

  if (!response.ok) {
    throw new Error(`${response.status}: ${JSON.stringify(data)}`);
  }

  return data;
}

async function runTests() {
  try {
    console.log('🧪 Testing Profile with Empty/Null Fields\n');

    // 1. Login
    console.log('1️⃣  Logging in...');
    const loginResponse = await apiCall('POST', '/auth/login', {
      email: TEST_USER.email,
      mot_de_passe: TEST_USER.password,
    });
    authToken = loginResponse.token;
    console.log(`✅ Logged in as ${loginResponse.user.nom} ${loginResponse.user.prenom}\n`);

    // 2. Update with some empty fields (like frontend does)
    console.log('2️⃣  Updating profile with partial data (some fields empty)...');
    const updateResponse = await apiCall('PUT', '/users/profil/academique', {
      serie_bac: 'D',
      annee_bac: 2025,
      mention: 'Assez bien',
      moyenne_generale: undefined,  // Frontend sends undefined for empty fields
      notes_matieres: null,
      competences: null,
      centres_interet: null,
      objectifs_professionnels: 'Devenir docteur',
      secteur_vise: 'Santé',
      budget_max_mensuel: null,    // Frontend sends null for empty numeric fields
      distance_max_km: undefined,
      duree_max_etudes: undefined,
      preference_type_univ: 'indifferent',
      ville_preference: '',         // Frontend sends empty string
    });
    console.log('✅ Profile updated with empty fields handled correctly');
    console.log('  - Updated fields:');
    console.log('    - Serie Bac:', updateResponse.profil_academique.serie_bac);
    console.log('    - Année Bac:', updateResponse.profil_academique.annee_bac);
    console.log('    - Mention:', updateResponse.profil_academique.mention);
    console.log('    - Professional Goals:', updateResponse.profil_academique.objectifs_professionnels);
    console.log();

    // 3. Verify the data was saved correctly
    console.log('3️⃣  Verifying saved data...');
    const verifyResponse = await apiCall('GET', '/users/profil');
    console.log('✅ Data verified:');
    console.log('  - Serie Bac:', verifyResponse.profil_academique.serie_bac);
    console.log('  - Année Bac:', verifyResponse.profil_academique.annee_bac);
    console.log('  - Mention:', verifyResponse.profil_academique.mention);
    console.log();

    console.log('🎉 Empty fields test passed!\n');
  } catch (error) {
    console.error('❌ Test failed:', error.message);
    process.exit(1);
  }
}

runTests();
