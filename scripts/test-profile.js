#!/usr/bin/env node
/**
 * Test Profile Endpoints
 * Tests the Profile page functionality by calling backend APIs
 */

const API_URL = 'http://localhost:5000/api';

// Test user credentials from seeded data
const TEST_USER = {
  email: 'mialy@email.mg',
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
    console.log('🧪 Testing Profile Endpoints\n');

    // 1. Login
    console.log('1️⃣  Logging in...');
    const loginResponse = await apiCall('POST', '/auth/login', {
      email: TEST_USER.email,
      mot_de_passe: TEST_USER.password,
    });
    authToken = loginResponse.token;
    console.log(`✅ Logged in as ${loginResponse.user.nom} ${loginResponse.user.prenom}\n`);

    // 2. Get Profile
    console.log('2️⃣  Getting profile...');
    const profileResponse = await apiCall('GET', '/users/profil');
    console.log('✅ Profile retrieved:');
    console.log('  - Name:', profileResponse.prenom, profileResponse.nom);
    console.log('  - Email:', profileResponse.email);
    console.log('  - Academic Profile:', profileResponse.profil_academique ? 'Present' : 'Missing');
    if (profileResponse.profil_academique) {
      console.log('    - Serie Bac:', profileResponse.profil_academique.serie_bac);
      console.log('    - Année Bac:', profileResponse.profil_academique.annee_bac);
    }
    console.log();

    // 3. Update Profile
    console.log('3️⃣  Updating profile...');
    const updateResponse = await apiCall('PUT', '/users/profil', {
      nom: 'Test Updated',
      prenom: 'User',
      ville: 'Antananarivo',
      budget_mensuel: 50000,
    });
    console.log('✅ Profile updated:');
    console.log('  - New Name:', updateResponse.prenom, updateResponse.nom);
    console.log('  - City:', updateResponse.ville);
    console.log('  - Budget:', updateResponse.budget_mensuel);
    console.log();

    // 4. Update Academic Profile
    console.log('4️⃣  Updating academic profile...');
    const academicResponse = await apiCall('PUT', '/users/profil/academique', {
      serie_bac: 'C',
      annee_bac: 2024,
      mention: 'Bien',
      moyenne_generale: 16.5,
      objectifs_professionnels: 'Devenir ingénieur informatique',
      secteur_vise: 'Informatique',
      budget_max_mensuel: 75000,
      distance_max_km: 100,
      duree_max_etudes: 3,
      preference_type_univ: 'publique',
      ville_preference: 'Antananarivo',
    });
    console.log('✅ Academic profile updated:');
    console.log('  - Serie Bac:', academicResponse.profil_academique.serie_bac);
    console.log('  - Mention:', academicResponse.profil_academique.mention);
    console.log('  - Moyenne Générale:', academicResponse.profil_academique.moyenne_generale);
    console.log('  - Professional Goals:', academicResponse.profil_academique.objectifs_professionnels);
    console.log();

    // 5. Verify Updated Profile
    console.log('5️⃣  Verifying updated profile...');
    const verifyResponse = await apiCall('GET', '/users/profil');
    console.log('✅ Profile verified:');
    console.log('  - Name:', verifyResponse.prenom, verifyResponse.nom);
    console.log('  - Academic Serie:', verifyResponse.profil_academique.serie_bac);
    console.log('  - Academic Mention:', verifyResponse.profil_academique.mention);
    console.log();

    console.log('🎉 All tests passed!\n');
  } catch (error) {
    console.error('❌ Test failed:', error.message);
    process.exit(1);
  }
}

runTests();
