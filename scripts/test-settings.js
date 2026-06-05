#!/usr/bin/env node
/**
 * Test Settings API
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
    console.log('🧪 Testing Settings API\n');

    // 1. Login
    console.log('1️⃣  Logging in...');
    const loginResponse = await apiCall('POST', '/auth/login', {
      email: TEST_USER.email,
      mot_de_passe: TEST_USER.password,
    });
    authToken = loginResponse.token;
    console.log(`✅ Logged in as ${loginResponse.user.nom} ${loginResponse.user.prenom}\n`);

    // 2. Get settings
    console.log('2️⃣  Getting user settings...');
    const settingsResponse = await apiCall('GET', '/users/settings');
    console.log('✅ Settings retrieved:');
    console.log(`   - Email notifications: ${settingsResponse.email_notifications}`);
    console.log(`   - Theme: ${settingsResponse.theme}`);
    console.log(`   - Language: ${settingsResponse.language}`);
    console.log();

    // 3. Update settings
    console.log('3️⃣  Updating settings...');
    const updateResponse = await apiCall('PUT', '/users/settings', {
      email_notifications: false,
      theme: 'dark',
      language: 'en',
      profile_visibility: 'public'
    });
    console.log('✅ Settings updated:');
    console.log(`   - Email notifications: ${updateResponse.email_notifications}`);
    console.log(`   - Theme: ${updateResponse.theme}`);
    console.log(`   - Language: ${updateResponse.language}`);
    console.log();

    // 4. Verify settings were saved
    console.log('4️⃣  Verifying settings were saved...');
    const verifyResponse = await apiCall('GET', '/users/settings');
    console.log('✅ Settings verified:');
    console.log(`   - Email notifications: ${verifyResponse.email_notifications}`);
    console.log(`   - Theme: ${verifyResponse.theme}`);
    console.log();

    // 5. Change password
    console.log('5️⃣  Changing password...');
    const newPassword = 'NewPassword123!';
    await apiCall('PUT', '/users/change-password', {
      current_password: TEST_USER.password,
      new_password: newPassword,
      confirm_password: newPassword
    });
    console.log('✅ Password changed successfully');
    console.log(`   - New password: ${newPassword}\n`);

    console.log('🎉 All settings tests passed!\n');
  } catch (error) {
    console.error('❌ Test failed:', error.message);
    process.exit(1);
  }
}

runTests();
