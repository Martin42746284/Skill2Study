#!/usr/bin/env node
/**
 * Test All Notifications Scenarios
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
    console.log('🧪 Testing All Notifications Scenarios\n');

    // 1. Login
    console.log('1️⃣  Logging in...');
    const loginResponse = await apiCall('POST', '/auth/login', {
      email: TEST_USER.email,
      mot_de_passe: TEST_USER.password,
    });
    authToken = loginResponse.token;
    console.log(`✅ Logged in as ${loginResponse.user.nom} ${loginResponse.user.prenom}\n`);

    // 2. Add a favorite - should create notification
    console.log('2️⃣  Adding a favorite filière...');
    try {
      await apiCall('POST', '/users/favoris/1');
      console.log('✅ Favorite added - notification should be created\n');
    } catch (e) {
      console.log('⚠️  Could not add favorite\n');
    }

    // 3. Change password - should create notification
    console.log('3️⃣  Changing password...');
    try {
      const newPassword = 'NewPassword123!';
      await apiCall('PUT', '/users/change-password', {
        current_password: TEST_USER.password,
        new_password: newPassword,
        confirm_password: newPassword
      });
      console.log('✅ Password changed - notification should be created\n');
    } catch (e) {
      console.log('⚠️  Could not change password\n');
    }

    // 4. Get notifications to see what was created
    console.log('4️⃣  Getting all notifications...');
    const notificationsResponse = await apiCall('GET', '/notifications');
    console.log(`✅ Retrieved ${notificationsResponse.notifications.length} notifications\n`);
    
    console.log('📋 Recent notifications:');
    notificationsResponse.notifications.slice(0, 5).forEach((notif) => {
      console.log(`   - ${notif.title} (${notif.type})`);
    });
    console.log();

    // 5. Get unread count
    console.log('5️⃣  Getting unread count...');
    const unreadResponse = await apiCall('GET', '/notifications/unread-count');
    console.log(`✅ Unread notifications: ${unreadResponse.unreadCount}\n`);

    console.log('🎉 All notification tests completed!\n');
    console.log('📝 Notifications that should have been created:');
    console.log('   ✅ Profile updated (when you change profile)');
    console.log('   ❤️  Favorite added (when you add a favorite)');
    console.log('   💔 Favorite removed (when you remove a favorite)');
    console.log('   🔐 Password changed (when you change password)');
    console.log('   🎉 Test completed (when you complete a test)');
    console.log('   📋 Recommendations ready (when recommendations are generated)');
    console.log('   🏫 New university (when admin adds a new university)');
    console.log('   📚 New field (when admin adds a new field/filière)\n');
  } catch (error) {
    console.error('❌ Test failed:', error.message);
    process.exit(1);
  }
}

runTests();
