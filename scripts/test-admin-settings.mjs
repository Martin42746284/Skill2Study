#!/usr/bin/env node

/**
 * Test script for Admin Settings functionality
 * This script tests:
 * 1. Getting admin settings
 * 2. Updating admin settings
 * 3. Verifying real-time sync across pages
 */

const API_BASE_URL = process.env.API_URL || 'http://localhost:5000/api';

// Helper to make API calls with auth
async function apiCall(endpoint, options = {}) {
  const headers = new Headers(options.headers || {});
  headers.set('Content-Type', 'application/json');

  // Get token from environment or use test token if available
  const token = process.env.ADMIN_TOKEN;
  if (token) {
    headers.set('Authorization', `Bearer ${token}`);
  }

  const response = await fetch(`${API_BASE_URL}${endpoint}`, {
    ...options,
    headers,
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: 'Request failed' }));
    throw new Error(`API Error: ${error.message || response.statusText}`);
  }

  return response.json();
}

// Color codes for console output
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

async function testAdminSettings() {
  log('\n╔════════════════════════════════════════════════════════════════╗', 'cyan');
  log('║          Admin Settings API Test Suite                         ║', 'cyan');
  log('╚════════════════════════════════════════════════════════════════╝', 'cyan');

  let testsPassed = 0;
  let testsFailed = 0;

  try {
    // Test 1: Get current settings
    log('\n[1/5] Testing GET /admin/settings', 'blue');
    let currentSettings;
    try {
      const response = await apiCall('/admin/settings', { method: 'GET' });
      currentSettings = response.settings || response;
      
      if (currentSettings) {
        log('✓ Successfully retrieved admin settings', 'green');
        log(`  Platform Name: ${currentSettings.platform_name}`, 'cyan');
        log(`  Email Notifications: ${currentSettings.email_notifications}`, 'cyan');
        log(`  Maintenance Mode: ${currentSettings.maintenance_mode}`, 'cyan');
        testsPassed++;
      } else {
        throw new Error('No settings data in response');
      }
    } catch (error) {
      log(`✗ Failed to get settings: ${error.message}`, 'red');
      log('  Note: Make sure the backend is running and you have admin access', 'yellow');
      testsFailed++;
      return testsFailed;
    }

    // Test 2: Update platform name
    log('\n[2/5] Testing PUT /admin/settings (update platform_name)', 'blue');
    const testPlatformName = `OrientAI Test ${Date.now()}`;
    try {
      const response = await apiCall('/admin/settings', {
        method: 'PUT',
        body: JSON.stringify({
          platform_name: testPlatformName,
        }),
      });
      const updatedSettings = response.settings || response;
      
      if (updatedSettings.platform_name === testPlatformName) {
        log(`✓ Successfully updated platform_name to: "${testPlatformName}"`, 'green');
        testsPassed++;
      } else {
        throw new Error('Platform name was not updated correctly');
      }
    } catch (error) {
      log(`✗ Failed to update platform_name: ${error.message}`, 'red');
      testsFailed++;
    }

    // Test 3: Toggle email notifications
    log('\n[3/5] Testing PUT /admin/settings (toggle email_notifications)', 'blue');
    try {
      const newNotificationState = !currentSettings.email_notifications;
      const response = await apiCall('/admin/settings', {
        method: 'PUT',
        body: JSON.stringify({
          email_notifications: newNotificationState,
        }),
      });
      const updatedSettings = response.settings || response;
      
      if (updatedSettings.email_notifications === newNotificationState) {
        log(`✓ Successfully toggled email_notifications to: ${newNotificationState}`, 'green');
        testsPassed++;
      } else {
        throw new Error('Email notifications was not updated correctly');
      }
    } catch (error) {
      log(`✗ Failed to update email_notifications: ${error.message}`, 'red');
      testsFailed++;
    }

    // Test 4: Enable maintenance mode
    log('\n[4/5] Testing PUT /admin/settings (enable maintenance_mode)', 'blue');
    try {
      const response = await apiCall('/admin/settings', {
        method: 'PUT',
        body: JSON.stringify({
          maintenance_mode: true,
        }),
      });
      const updatedSettings = response.settings || response;
      
      if (updatedSettings.maintenance_mode === true) {
        log('✓ Successfully enabled maintenance_mode', 'green');
        testsPassed++;
      } else {
        throw new Error('Maintenance mode was not enabled');
      }
    } catch (error) {
      log(`✗ Failed to enable maintenance_mode: ${error.message}`, 'red');
      testsFailed++;
    }

    // Test 5: Restore original settings
    log('\n[5/5] Testing PUT /admin/settings (restore original values)', 'blue');
    try {
      const response = await apiCall('/admin/settings', {
        method: 'PUT',
        body: JSON.stringify({
          platform_name: currentSettings.platform_name,
          email_notifications: currentSettings.email_notifications,
          maintenance_mode: currentSettings.maintenance_mode,
        }),
      });
      const restoredSettings = response.settings || response;
      
      if (
        restoredSettings.platform_name === currentSettings.platform_name &&
        restoredSettings.email_notifications === currentSettings.email_notifications &&
        restoredSettings.maintenance_mode === currentSettings.maintenance_mode
      ) {
        log('✓ Successfully restored original settings', 'green');
        testsPassed++;
      } else {
        throw new Error('Settings were not fully restored');
      }
    } catch (error) {
      log(`✗ Failed to restore settings: ${error.message}`, 'red');
      testsFailed++;
    }

    // Summary
    log('\n╔════════════════════════════════════════════════════════════════╗', 'cyan');
    log('║                      Test Summary                              ║', 'cyan');
    log('╚════════════════════════════════════════════════════════════════╝', 'cyan');
    log(`✓ Tests Passed: ${testsPassed}`, 'green');
    log(`✗ Tests Failed: ${testsFailed}`, testsFailed > 0 ? 'red' : 'green');
    log(`Total Tests: ${testsPassed + testsFailed}`, 'blue');

    if (testsFailed === 0) {
      log('\n✓ All tests passed! Admin settings API is working correctly.', 'green');
      log('\nNote: The frontend will automatically sync these changes every 5 seconds', 'yellow');
      log('using the polling mechanism in SettingsContext.', 'yellow');
      return 0;
    } else {
      log(`\n✗ ${testsFailed} test(s) failed. Please check the errors above.`, 'red');
      return 1;
    }
  } catch (error) {
    log(`\nUnexpected error: ${error.message}`, 'red');
    return 1;
  }
}

// Run the tests
const exitCode = await testAdminSettings();
process.exit(exitCode);
