# Admin Role Setup Guide

Mozzy uses Firebase Custom Claims to manage administrative roles. These claims are stored in the user's ID token and are used by both the Flutter app and Firestore Security Rules to enforce access control.

## 1. Custom Claims Structure

The standard custom claims for a Mozzy admin are:

```json
{
  "admin": true,
  "adminRole": "super_admin" | "ops_admin" | "finance_admin" | "support_admin"
}
```

- **admin**: (boolean) Must be `true` for any administrative access.
- **adminRole**: (string) Defines the specific scope of the administrator.

## 2. Admin Roles

| Role | Description |
| :--- | :--- |
| `super_admin` | Full access to all administrative screens, audit logs, and user management. |
| `finance_admin` | Access to monetization audit logs, payments, and settlement reports. |
| `ops_admin` | Access to operational reports, jobs, and marketplace moderation. |
| `support_admin` | Read-only access to user data and transaction history for customer support. |

## 3. Setting Admin Claims

Admin claims can **only** be set via the Firebase Admin SDK. For security reasons, the Flutter app does not have the capability to modify these claims.

### Using Node.js Admin SDK

```javascript
const admin = require('firebase-admin');

async function setAdminClaim(uid, role = 'super_admin') {
  await admin.auth().setCustomUserClaims(uid, {
    admin: true,
    adminRole: role
  });
  console.log(`Admin claims set for user: ${uid}`);
}

// Example usage:
// setAdminClaim('USER_UID_HERE', 'super_admin');
```

## 4. Applying Changes

After setting or updating custom claims, the user must **force refresh their ID token** or **log out and log back in** for the changes to take effect in the client application and Firestore Rules.

In the Flutter app, the `AdminAuth` provider handles this by listening to `idTokenChanges`.

## 5. Security Principles

1. **Principle of Least Privilege**: Grant only the role necessary for the user's task.
2. **No Client-Side Granting**: Never implement admin role assignment logic within the client application.
3. **Audit Claims**: Maintain a separate log of when and why admin roles were assigned (outside of this app's primary monetization audit).
4. **Regular Review**: Periodically review the list of users with admin claims.
