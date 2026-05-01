# Marketplace Admin Claims Setup

This document describes how to assign administrative roles for the Marketplace moderation queue.

## 🎯 Admin Role Contract

Mozzy uses Firebase Custom Claims to enforce administrative roles. The key used is `marketplaceAdminRole`.

| Role | Claim Value | Description |
| :--- | :--- | :--- |
| **None** | `none` or missing | No administrative access. |
| **Reviewer** | `reviewer` | Can view the AI review queue but cannot approve/reject. |
| **Admin** | `admin` | Can view and moderate (approve/reject/dismiss) items. |
| **Super Admin**| `superAdmin` | Full administrative access. |

## 🔒 Security Principles

1. **Server-Side Only**: Custom claims **must never** be set from the Flutter client. This would be a major security vulnerability.
2. **Read-Only Client**: The Flutter app only reads the claims from the ID token to show/hide UI elements and perform client-side validation.
3. **Rules Enforcement**: Firestore Security Rules strictly enforce these claims. Even if a user bypasses the UI, Firestore will deny unauthorized writes.

## 🛠️ How to Assign Claims

Claims must be assigned using the Firebase Admin SDK (Node.js, Python, Go, or Java) or via the Firebase CLI (using a script).

### Example: Node.js (Firebase Admin SDK)

```javascript
const admin = require('firebase-admin');

// Initialize admin SDK...

async function setMarketplaceAdmin(uid, role) {
  await admin.auth().setCustomUserClaims(uid, {
    marketplaceAdminRole: role
  });
  console.log(`Successfully assigned ${role} role to user ${uid}`);
}

// Usage
setMarketplaceAdmin('USER_UID_HERE', 'admin');
```

### Example: Python (Firebase Admin SDK)

```python
from firebase_admin import auth

def set_marketplace_admin(uid, role):
    auth.set_custom_user_claims(uid, {
        'marketplaceAdminRole': role
    })
    print(f"Successfully assigned {role} role to user {uid}")

# Usage
set_marketplace_admin('USER_UID_HERE', 'admin')
```

## ⏳ Propagation

After claims are updated on the server:
- The user's ID token must be refreshed for the client to see the changes.
- In the Mozzy app, this can be forced by calling `user.getIdTokenResult(true)`.
- Alternatively, the user can re-login.
