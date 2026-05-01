/**
 * Mozzy Marketplace Admin Claims Management Tool
 * 
 * Secure local utility for managing marketplaceAdminRole custom claims.
 * 
 * Usage:
 *   node marketplace_admin_claims.js get --uid <uid>
 *   node marketplace_admin_claims.js set --uid <uid> --role <reviewer|admin|superAdmin> [--dry-run]
 *   node marketplace_admin_claims.js clear --uid <uid> [--dry-run]
 * 
 * Security:
 *   - Requires GOOGLE_APPLICATION_CREDENTIALS environment variable.
 *   - Does not store or commit secrets.
 */

const admin = require('firebase-admin');

const CLAIM_KEY = 'marketplaceAdminRole';
const ALLOWED_ROLES = ['reviewer', 'admin', 'superAdmin'];

function printHelp() {
  console.log(`
Mozzy Marketplace Admin Claims Management Tool

Usage:
  node marketplace_admin_claims.js get --uid <uid>
  node marketplace_admin_claims.js set --uid <uid> --role <reviewer|admin|superAdmin> [--dry-run]
  node marketplace_admin_claims.js clear --uid <uid> [--dry-run]

Options:
  --uid      The Firebase User ID (Required)
  --role     Role to assign: ${ALLOWED_ROLES.join(', ')}
  --dry-run  Show changes without applying them
  --help     Show this help message

Environment:
  GOOGLE_APPLICATION_CREDENTIALS  Path to service account JSON file (Required)
`);
}

function parseArgs(args) {
  const params = {};
  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    if (arg === '--uid' && args[i + 1]) {
      params.uid = args[++i];
    } else if (arg === '--role' && args[i + 1]) {
      params.role = args[++i];
    } else if (arg === '--dry-run') {
      params.dryRun = true;
    } else if (arg === '--help') {
      params.help = true;
    } else if (!params.command) {
      params.command = arg;
    }
  }
  return params;
}

async function main() {
  const args = process.argv.slice(2);
  const params = parseArgs(args);

  if (params.help || args.length === 0) {
    printHelp();
    return;
  }

  if (!params.uid) {
    console.error('Error: --uid is required.');
    process.exit(1);
  }

  // Initialize Firebase Admin
  try {
    if (!process.env.GOOGLE_APPLICATION_CREDENTIALS && !admin.apps.length) {
       console.warn('Warning: GOOGLE_APPLICATION_CREDENTIALS not set. Using default credentials if available.');
    }
    admin.initializeApp({
      credential: admin.credential.applicationDefault()
    });
  } catch (err) {
    console.error('Error: Failed to initialize Firebase Admin SDK. Check GOOGLE_APPLICATION_CREDENTIALS.');
    console.error(err.message);
    process.exit(1);
  }

  const auth = admin.auth();

  switch (params.command) {
    case 'get':
      await getRole(auth, params.uid);
      break;
    case 'set':
      if (!params.role || !ALLOWED_ROLES.includes(params.role)) {
        console.error(`Error: --role must be one of: ${ALLOWED_ROLES.join(', ')}`);
        process.exit(1);
      }
      await setRole(auth, params.uid, params.role, params.dryRun);
      break;
    case 'clear':
      await clearRole(auth, params.uid, params.dryRun);
      break;
    default:
      console.error(`Error: Unknown command "${params.command}"`);
      printHelp();
      process.exit(1);
  }
}

async function getRole(auth, uid) {
  try {
    const user = await auth.getUser(uid);
    const claims = user.customClaims || {};
    const role = claims[CLAIM_KEY] || 'none';
    
    console.log(`[get] User: ${uid}`);
    console.log(`[get] Current Role: ${role}`);
    console.log(`[get] All Claims: ${JSON.stringify(claims, null, 2)}`);
  } catch (err) {
    console.error(`Error fetching user ${uid}: ${err.message}`);
    process.exit(1);
  }
}

async function setRole(auth, uid, role, dryRun) {
  try {
    const user = await auth.getUser(uid);
    const existingClaims = user.customClaims || {};
    const newClaims = { ...existingClaims, [CLAIM_KEY]: role };

    console.log(`[set] User: ${uid}`);
    console.log(`[set] New Role: ${role}`);
    console.log(`[set] New Claims Set: ${JSON.stringify(newClaims, null, 2)}`);
    
    if (dryRun) {
      console.log('[set] DRY-RUN: No changes applied.');
    } else {
      await auth.setCustomUserClaims(uid, newClaims);
      console.log('[set] Success: Claims updated.');
    }
  } catch (err) {
    console.error(`Error updating user ${uid}: ${err.message}`);
    process.exit(1);
  }
}

async function clearRole(auth, uid, dryRun) {
  try {
    const user = await auth.getUser(uid);
    const existingClaims = { ...(user.customClaims || {}) };
    const hadRole = CLAIM_KEY in existingClaims;
    
    delete existingClaims[CLAIM_KEY];

    console.log(`[clear] User: ${uid}`);
    if (!hadRole) {
      console.log(`[clear] No ${CLAIM_KEY} found to clear.`);
    }
    console.log(`[clear] Resulting Claims: ${JSON.stringify(existingClaims, null, 2)}`);

    if (dryRun) {
      console.log('[clear] DRY-RUN: No changes applied.');
    } else {
      await auth.setCustomUserClaims(uid, existingClaims);
      console.log('[clear] Success: Claims cleared.');
    }
  } catch (err) {
    console.error(`Error clearing user ${uid}: ${err.message}`);
    process.exit(1);
  }
}

main().catch(err => {
  console.error('Fatal Error:', err);
  process.exit(1);
});
