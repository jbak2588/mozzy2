# Mozzy Marketplace Admin Claims Tool

Secure local utility for managing `marketplaceAdminRole` custom claims using the Firebase Admin SDK.

## 🎯 Purpose
Custom claims are the source of truth for administrative roles in Mozzy Marketplace. Because they grant sensitive permissions, they must be assigned from a secure environment, never from the client app.

## 🔑 Claim Key & Roles
- **Key**: `marketplaceAdminRole`
- **Roles**:
  - `reviewer`: Read-only queue access.
  - `admin`: Full moderation access.
  - `superAdmin`: Full administrative access.

## 🔒 Security Requirements
1. **Never commit service account JSON files** to version control.
2. **Never commit `.env` files** containing sensitive paths or secrets.
3. Use the `--dry-run` flag to verify changes before applying them.

## 🚀 Setup

1. **Install Dependencies**:
   ```powershell
   cd tools/admin_claims
   npm install
   ```

2. **Set Credentials**:
   Download your service account JSON from Firebase Console > Project Settings > Service Accounts and set the environment variable:
   ```powershell
   $env:GOOGLE_APPLICATION_CREDENTIALS="C:\path\to\your\service-account.json"
   ```

## 🛠️ Usage

### Get Current Role
```powershell
node marketplace_admin_claims.js get --uid <USER_UID>
```

### Set Admin Role (Dry Run)
```powershell
node marketplace_admin_claims.js set --uid <USER_UID> --role admin --dry-run
```

### Set Admin Role (Execution)
```powershell
node marketplace_admin_claims.js set --uid <USER_UID> --role admin
```

### Clear Admin Role
```powershell
node marketplace_admin_claims.js clear --uid <USER_UID>
```

## ⏳ Token Refresh
After updating claims, the user's ID token must be refreshed on the client to reflect the changes.
- The user can log out and log back in.
- The app can force a refresh using `getIdTokenResult(forceRefresh: true)`.
