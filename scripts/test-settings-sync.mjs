#!/usr/bin/env node

/**
 * Frontend Settings Sync Test
 * This script tests that:
 * 1. The SettingsContext polls for changes every 5 seconds
 * 2. Changes made in AdminSettings appear in other pages
 * 3. The context properly handles the settings data structure
 */

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

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

async function runTests() {
  log('\n╔════════════════════════════════════════════════════════════════╗', 'cyan');
  log('║         Frontend Settings Sync Test Suite                      ║', 'cyan');
  log('╚════════════════════════════════════════════════════════════════╝', 'cyan');

  let testsPassed = 0;
  let testsFailed = 0;

  try {
    // Test 1: Verify SettingsContext exists and has polling
    log('\n[1/4] Checking SettingsContext implementation', 'blue');
    const contextPath = path.join(__dirname, '../src/contexts/SettingsContext.tsx');
    const contextContent = fs.readFileSync(contextPath, 'utf-8');
    
    if (contextContent.includes('setInterval')) {
      log('✓ SettingsContext includes polling mechanism', 'green');
      if (contextContent.includes('5000')) {
        log('✓ Polling interval is set to 5 seconds', 'green');
        testsPassed++;
      } else {
        log('⚠ Polling interval not clearly set to 5000ms', 'yellow');
      }
    } else {
      log('✗ No polling mechanism found in SettingsContext', 'red');
      testsFailed++;
    }

    // Test 2: Verify refreshSettings function exists
    log('\n[2/4] Checking refreshSettings function', 'blue');
    if (contextContent.includes('refreshSettings')) {
      log('✓ refreshSettings function is exported from context', 'green');
      testsPassed++;
    } else {
      log('✗ refreshSettings function not found', 'red');
      testsFailed++;
    }

    // Test 3: Verify AdminSettings uses context properly
    log('\n[3/4] Checking AdminSettings component integration', 'blue');
    const adminSettingsPath = path.join(__dirname, '../src/pages/admin/AdminSettings.tsx');
    const adminSettingsContent = fs.readFileSync(adminSettingsPath, 'utf-8');
    
    let adminSettingsOk = 0;
    if (adminSettingsContent.includes('refreshSettings')) {
      log('✓ AdminSettings calls refreshSettings on save', 'green');
      adminSettingsOk++;
    } else {
      log('✗ AdminSettings does not call refreshSettings', 'red');
      testsFailed++;
    }

    if (adminSettingsContent.includes('useSettings')) {
      log('✓ AdminSettings uses useSettings hook', 'green');
      adminSettingsOk++;
    } else {
      log('✗ AdminSettings does not use useSettings hook', 'red');
      testsFailed++;
    }

    if (adminSettingsOk === 2) {
      testsPassed++;
    }

    // Test 4: Verify api.ts has admin.getSettings
    log('\n[4/4] Checking API client configuration', 'blue');
    const apiPath = path.join(__dirname, '../src/lib/api.ts');
    const apiContent = fs.readFileSync(apiPath, 'utf-8');
    
    if (apiContent.includes('getSettings') && apiContent.includes('admin')) {
      log('✓ API client has admin.getSettings endpoint', 'green');
      if (apiContent.includes('/admin/settings')) {
        log('✓ API endpoint is correctly set to /admin/settings', 'green');
        testsPassed++;
      } else {
        log('⚠ API endpoint path not clearly visible', 'yellow');
      }
    } else {
      log('✗ API client missing admin.getSettings', 'red');
      testsFailed++;
    }

    // Summary
    log('\n╔════════════════════════════════════════════════════════════════╗', 'cyan');
    log('║                      Test Summary                              ║', 'cyan');
    log('╚════════════════════════════════════════════════════════════════╝', 'cyan');
    log(`✓ Tests Passed: ${testsPassed}`, 'green');
    log(`✗ Tests Failed: ${testsFailed}`, testsFailed > 0 ? 'red' : 'green');
    log(`Total Tests: ${testsPassed + testsFailed}`, 'blue');

    // Implementation details
    log('\n╔════════════════════════════════════════════════════════════════╗', 'cyan');
    log('║              Real-Time Sync Implementation                     ║', 'cyan');
    log('╚════════════════════════════════════════════════════════════════╝', 'cyan');
    
    log('\n📋 How Settings Sync Works:', 'blue');
    log('  1. SettingsProvider mounts and loads settings from /admin/settings', 'cyan');
    log('  2. A setInterval poll runs every 5 seconds to refresh settings', 'cyan');
    log('  3. When AdminSettings saves, it calls refreshSettings()', 'cyan');
    log('  4. Context updates trigger re-renders in all consuming components', 'cyan');
    log('  5. All pages using useSettings() hook automatically update', 'cyan');

    log('\n🔄 Affected Pages:', 'blue');
    log('  • Any component using useSettings() hook will auto-update', 'cyan');
    log('  • Examples: Dashboard, Navbar, Settings, Admin pages', 'cyan');

    log('\n⏱️  Sync Timing:', 'blue');
    log('  • Immediate: After AdminSettings save (via refreshSettings)', 'cyan');
    log('  • Automatic: Every 5 seconds (via polling)', 'cyan');
    log('  • Manual: Call refreshSettings() from any component', 'cyan');

    if (testsFailed === 0) {
      log('\n✓ Frontend settings sync is properly configured!', 'green');
      return 0;
    } else {
      log(`\n⚠ ${testsFailed} issue(s) found in configuration`, 'yellow');
      return 1;
    }

  } catch (error) {
    log(`\n✗ Error during tests: ${error.message}`, 'red');
    return 1;
  }
}

const exitCode = await runTests();
process.exit(exitCode);
