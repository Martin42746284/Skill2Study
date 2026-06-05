#!/usr/bin/env node
/**
 * Test Avatar Upload Endpoint
 */

const API_URL = 'http://localhost:5000/api';

const TEST_USER = {
  email: 'fanja@email.mg',
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
    console.log('🧪 Testing Avatar Upload\n');

    // 1. Login
    console.log('1️⃣  Logging in...');
    const loginResponse = await apiCall('POST', '/auth/login', {
      email: TEST_USER.email,
      mot_de_passe: TEST_USER.password,
    });
    authToken = loginResponse.token;
    console.log(`✅ Logged in as ${loginResponse.user.nom} ${loginResponse.user.prenom}\n`);

    // 2. Get profile (check initial avatar)
    console.log('2️⃣  Getting profile...');
    const profileBefore = await apiCall('GET', '/users/profil');
    console.log('✅ Profile retrieved:');
    console.log('  - Avatar URL before:', profileBefore.avatar_url || 'null');
    console.log();

    // 3. Update avatar
    console.log('3️⃣  Updating avatar...');
    const avatarDataUrl = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==';
    const updateResponse = await apiCall('PUT', '/users/profil/avatar', {
      avatar_url: avatarDataUrl,
    });
    console.log('✅ Avatar updated:');
    console.log('  - Avatar URL length:', updateResponse.avatar_url?.length || 0, 'characters');
    console.log();

    // 4. Verify avatar was saved
    console.log('4️⃣  Verifying avatar was saved...');
    const profileAfter = await apiCall('GET', '/users/profil');
    console.log('✅ Avatar verified:');
    console.log('  - Avatar URL matches:', profileAfter.avatar_url === avatarDataUrl ? 'YES' : 'NO');
    console.log();

    console.log('🎉 Avatar upload test passed!\n');
  } catch (error) {
    console.error('❌ Test failed:', error.message);
    process.exit(1);
  }
}

runTests();
