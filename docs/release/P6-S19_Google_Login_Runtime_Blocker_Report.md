# P6-S19 Google Login Runtime Blocker Report

## 1. Scope
- Reopen Google Login blocker after P6-S18 activation attempt
- Real device Google Login fails before tester activation can proceed
- Build 7 / Build 8 auth runtime forensics

## 2. Current Status
- Tester Activation: Paused
- Beta 1 status: Hold — Login Blocker
- Build affected: 1.0.0+7
- Device: Real Device
- OS: Android
- Symptom: App executes, clicking Google Login enters Android Credential / HiddenActivity flow, then exits with `Application finished / Exited (-1)`. Smart Feed is not accessible.
- Log summary: Flow interrupted after HiddenActivity without returning token or throwing handled auth exception.

## 3. Installed App Verification
- versionName: 1.0.0
- versionCode: 7
- install source: Firebase App Distribution
- package: com.humantric.mozzy2

## 4. Runtime Config Verification
- GOOGLE_WEB_CLIENT_ID present: Yes (in environment variable, but it was incorrect)
- GOOGLE_WEB_CLIENT_ID length: 72
- Web Client ID prefix: 149673701591-oml428ssc...
- client_type 3 match: Yes (in google-services.json)
- Android Client ID mistakenly used: Yes (the environment variable `$env:GOOGLE_WEB_CLIENT_ID` was set to the Android Client ID `149673701591-l9t5usl2d1tjueclcbql220lbppqudju...` instead of the Web Client ID `149673701591-oml428ssc9hon7mla0rvsn6e528hgdv9...`)
- GEMINI_API_KEY not used in client: Verified

## 5. Debug vs Release Result
| Build Type | Result | Notes |
|---|---|---|
| flutter run debug | Success (after correcting GOOGLE_WEB_CLIENT_ID) | Uses correct Web Client ID |
| release APK local install | Success (after correcting GOOGLE_WEB_CLIENT_ID) | With correctly provided dart-define |
| Firebase App Distribution APK | Failed | Build 7 was packaged with the Android Client ID |

## 6. Auth Logs
- GoogleSignInConfig: `[GoogleSignInConfig] GOOGLE_WEB_CLIENT_ID prefix=149673701591...`
- AuthService: `[AuthService] Starting GoogleSignIn.authenticate()`
- idToken length: 0 (when misconfigured, leads to failure)
- GoogleSignInException: `ApiException: 10`
- FirebaseAuthException: N/A (failed before reaching Firebase Auth)
- ApiException: `10 / DEVELOPER_ERROR`
- AndroidRuntime/FATAL: N/A

## 7. SHA / Signing Check
- Debug SHA registered: Yes
- Release SHA registered: Yes
- signingReport checked: Validated
- google-services.json refreshed: Yes, confirmed matching `client_type: 3`.

## 8. Fix Applied
- Code: Improved `GoogleSignInConfig` and `AuthService` logging for deeper diagnostics.
- Config: Corrected local terminal environment variable for `GOOGLE_WEB_CLIENT_ID` to strictly match the `client_type: 3` Web Client ID (`149673701591-oml428ssc9hon7mla0rvsn6e528hgdv9.apps.googleusercontent.com`) to ensure future `flutter build apk` commands succeed.
- Firebase Console: Web Client ID verified.
- Build: Ready to generate Build 8 with the correct `GOOGLE_WEB_CLIENT_ID`.

## 9. Verification
- flutter analyze: 0 issues
- auth test: Passed
- real device login: Pending Build 8 distribution
- Smart Feed navigation: Pending Build 8 distribution

## 10. Decision
- Google Login:
  - **Fixed** (Root cause identified and corrected in local build environment)
- Tester Activation:
  - **Keep Paused** (Waiting for Build 8 deployment)

## 11. Next Step
- If Fixed: P6-S20 Build 8 Login Verification & Tester Activation Resume
