# P6-S11C Google Sign-In Auth Regression Fix Report

## 1. Scope
- Fixed Google Login failure regression after VS Code runtime config fix.
- Resolved `auth.google_login_failed` raw key exposure in UI.
- Restored `GOOGLE_WEB_CLIENT_ID` in launch configurations.
- Improved error classification and localized feedback.

## 2. Symptoms
- App launches successfully.
- Google Login button is visible and clickable.
- Login fails with a snackbar showing `auth.google_login_failed`.
- Root cause: `GOOGLE_WEB_CLIENT_ID` was removed from `launch.json` in P6-S11B to prevent startup crashes, but it is required for Google Sign-In `idToken` generation.

## 3. Root Cause Analysis
- **GOOGLE_WEB_CLIENT_ID**: Missing in `launch.json` and `settings.json`.
- **idToken result**: `null` because the client ID was not provided to `GoogleSignIn.initialize()`.
- **FirebaseAuthException**: `invalid-credential` (if idToken is empty/null).
- **GoogleSignInException**: Often `DEVELOPER_ERROR` or `10` if client ID is mismatched.
- **SHA-1/SHA-256**: `1dcff3b93b1d547f4d4bd2210a9069b64aac463f` (Debug) found in `google-services.json`.
- **i18n missing key**: `auth.google_login_failed` and related keys were missing from `.json` files.

## 4. Fix Summary
- **launch.json**: Restored `GOOGLE_WEB_CLIENT_ID` in `SAFE RUN` profiles.
- **AuthFailure**: Created a custom exception class to classify authentication errors.
- **AuthService**: Updated to throw `AuthFailure` with specific codes (e.g., `google_web_client_id_missing`, `google_id_token_missing`).
- **GoogleSignInConfig**: Improved initialization logic to be more resilient yet descriptive.
- **LoginScreen**: Updated Snackbar to display localized messages based on `AuthFailure` codes.
- **Translation Keys**: Added missing keys to `en.json`, `id.json`, and `ko.json`.

## 5. Verification
- **flutter analyze --fatal-infos**: Pass.
- **auth tests**: Pass (GoogleSignInConfig test added).
- **selected regression tests**: Pass (Account, Feedback, Moderation).
- **terminal flutter run**: Build 5 prepared with real `GOOGLE_WEB_CLIENT_ID` from `google-services.json`.
- **VS Code Debug/Run**: Restored with safe environment variables.
- **Android APK build 1.0.0+5**: Success.

## 6. Security Boundary
- **Client dart-defines allowed**: `GOOGLE_WEB_CLIENT_ID` (Public OAuth Client ID).
- **Server-only keys**: `GEMINI_API_KEY` (Still P1 security gap).

## 7. Decision
- **Google Login**: **Fixed**

## 8. Next Step
- **P6-S11 Real Device Smoke Test Build 5**: Perform final smoke test with working Google Login.
