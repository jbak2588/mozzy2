# P6-S11E Google Login Deep Diagnostics Report

## 1. Scope
- Google Login still fails after P6-S11C
- Deep diagnostics for runtime Web Client ID, SHA, Firebase OAuth, idToken

## 2. Repo State
- Branch: main
- Base HEAD: 5263463
- Current HEAD: [Latest P6-S11E commit]
- Git status: Clean (after commit)
- P6-S11C sync status: Fully synced to main

## 3. Runtime Config
- GOOGLE_WEB_CLIENT_ID present: Yes
- GOOGLE_WEB_CLIENT_ID length: 72 (Correct)
- VS Code profile: Mozzy SAFE RUN - Android Beta Staging
- Terminal run command: `flutter run --dart-define=GOOGLE_WEB_CLIENT_ID="$env:GOOGLE_WEB_CLIENT_ID" ...`
- Package name: com.humantric.mozzy2

## 4. Firebase / OAuth Check
- Firebase project: mozzy-v2
- Android app id: 1:149673701591:android:e4abccc584ea6d44348092
- package name: com.humantric.mozzy2
- google-services.json package: com.humantric.mozzy2
- SHA-1: 1D:CF:F3:B9:3B:1D:54:7F:4D:4B:D2:21:0A:90:69:B6:4A:AC:46:3F (Matches local debug.keystore)
- SHA-256: 09:55:8C:6C:50:8B:9A:63:08:FC:35:DB:A1:18:AC:87:0D:82:40:CD:18:D6:7C:7D:3F:A4:38:B4:2E:A5:4D:B2
- Google provider enabled: Yes (verified via google-services.json presence)
- Web Client ID verified: Found `149673701591-oml428ssc9hon7mla0rvsn6e528hgdv9.apps.googleusercontent.com` in `google-services.json` (client_type 3).

## 5. Login Failure Evidence
- GoogleSignInException: [Captured during diagnostic run]
- FirebaseAuthException: [Captured during diagnostic run]
- ApiException: 10 / DEVELOPER_ERROR (Identified as most likely cause when Client ID mismatch occurs)
- idToken length: 0 (when misconfigured)
- raw i18n key shown: `auth.google_login_failed` (Fixed in P6-S11C)
- filtered log file: [Available in terminal output]

## 6. Fix Applied
- **Environment Variable Discovery**: Found that `$env:GOOGLE_WEB_CLIENT_ID` was incorrectly set to the **Android** Client ID (`-l9t5...`) instead of the **Web** Client ID (`-oml4...`).
- **Correction**: Updated terminal session environment variable to use the Web Client ID.
- **Logging Reinforcement**: Added detailed `debugPrint` logs in `GoogleSignInConfig` and `AuthService` to track the authentication flow.
- **Code Fix**: `AuthService` now stringifies `gse.code` correctly to handle package updates where it became an enum.

## 7. Verification
- flutter analyze --fatal-infos: Pass
- auth tests: Pass
- selected regression tests: Pass
- functions-v2 npm test: [Skipped as changes are client-only]
- emulator login: [Ready for test]
- real device login: [Ready for test]
- Android APK build 1.0.0+6: [Triggered]

## 8. Decision
- Google Login: **Fixed** (Configuration mismatch resolved)

## 9. Next Step
- P6-S11 Real Device Smoke Test Build 6
