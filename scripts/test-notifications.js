#!/usr/bin/env node
/**
 * Test Notifications API
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
    console.log('🧪 Testing Notifications API\n');

    // 1. Login
    console.log('1️⃣  Logging in...');
    const loginResponse = await apiCall('POST', '/auth/login', {
      email: TEST_USER.email,
      mot_de_passe: TEST_USER.password,
    });
    authToken = loginResponse.token;
    console.log(`✅ Logged in as ${loginResponse.user.nom} ${loginResponse.user.prenom}\n`);

    // 2. Get notifications
    console.log('2️⃣  Getting notifications...');
    const notificationsResponse = await apiCall('GET', '/notifications');
    console.log(`✅ Retrieved ${notificationsResponse.notifications.length} notifications`);
    console.log('   Sample notifications:');
    notificationsResponse.notifications.slice(0, 3).forEach((notif, idx) => {
      console.log(`   ${idx + 1}. ${notif.title} (${notif.type}) - ${notif.read ? 'read' : 'unread'}`);
    });
    console.log();

    // 3. Get unread count
    console.log('3️⃣  Getting unread count...');
    const unreadResponse = await apiCall('GET', '/notifications/unread-count');
    console.log(`✅ Unread count: ${unreadResponse.unreadCount}\n`);

    // 4. Mark first unread notification as read
    if (notificationsResponse.notifications.length > 0) {
      const unreadNotif = notificationsResponse.notifications.find(n => !n.read);
      if (unreadNotif) {
        console.log('4️⃣  Marking notification as read...');
        const markReadResponse = await apiCall('PUT', `/notifications/${unreadNotif.id}/read`);
        console.log(`✅ Marked as read: "${markReadResponse.title}"\n`);

        // 5. Get updated unread count
        console.log('5️⃣  Getting updated unread count...');
        const updatedUnreadResponse = await apiCall('GET', '/notifications/unread-count');
        console.log(`✅ Updated unread count: ${updatedUnreadResponse.unreadCount}\n`);
      }
    }

    // 6. Mark all as read
    console.log('6️⃣  Marking all notifications as read...');
    await apiCall('PUT', '/notifications/mark-all-read');
    const finalUnreadResponse = await apiCall('GET', '/notifications/unread-count');
    console.log(`✅ All marked as read. Unread count: ${finalUnreadResponse.unreadCount}\n`);

    console.log('🎉 All notification tests passed!\n');
  } catch (error) {
    console.error('❌ Test failed:', error.message);
    process.exit(1);
  }
}

runTests();
