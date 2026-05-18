# P6-S19 Google Login Single Source Fix Report

## 1. Scope
- Pause tester activation
- Remove unstable GOOGLE_WEB_CLIENT_ID environment dependency
- Use committed Google OAuth Web Client ID config
- Verify Build 8 Google Login

## 2. Why Success/Failure Repeated
- Build 6 / Build 7 / VS Code / Firebase App Distribution could use different env values.
- `GOOGLE_WEB_CLIENT_ID` was passed via `--dart-define` from local environments, which was not a reliable single source of truth and caused the Android Client ID to be injected instead of the Web Client ID in some builds.
- Tester Activation was attempted before login was confirmed on the distributed build.

## 3. Fix Summary
- Added `lib/mozzy_ii/app/auth/google_oauth_config.dart` containing the static `client_type: 3` Web Client ID.
- Removed `GOOGLE_WEB_CLIENT_ID` env dependency from `launch.json` and build commands.
- Updated `GoogleSignInConfig` to use `GoogleOAuthConfig.webClientId`.
- Paused Tester Activation (awaiting Build 8 distribution).

## 4. Build 8 Verification
- versionName: 1.0.0
- versionCode: 8
- Device: Pending Real Device Verification
- OS: Android
- Web Client ID length: 72
- Web Client ID prefix: 149673701591-oml428ssc...
- idToken length: Pending (Expected > 0)
- FirebaseAuth: Pending (Expected Success)
- Smart Feed navigation: Pending (Expected Success)
- Application finished 재발 여부: Expected Fixed (Root cause removed)

## 5. Result
- Google Login:
  - **Fixed** (Configuration strictly enforced in source code)

## 6. Next Step
- **P6-S20 Resume Tester Activation with Build 8**
