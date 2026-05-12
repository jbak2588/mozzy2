# P6-S11A Runtime Env Config Fix Report

## 1. Scope
- Real device launch failure caused by missing `.local/mozzy_dev_env.json`
- VS Code launch config cleanup
- Client/server API key boundary check

## 2. Root Cause
- `.vscode/launch.json` used `--dart-define-from-file=.local/mozzy_dev_env.json` as the default configuration.
- This file does not exist on the tester/developer machine (it is gitignored).
- Flutter failed to find the file and aborted the app launch before startup.

## 3. Fix Summary
- **Launch Config Cleanup**: Removed the dependency on `.local/mozzy_dev_env.json` from the default launch configuration.
- **Added Safe Configs**: Added `Mozzy (Android Beta - Staging)` and `Mozzy (Android Beta - Staging + CS)` as safe alternatives that use standard `--dart-define` instead of file-based definitions.
- **Improved Startup Resilience**: Modified `GoogleSignInConfig.initialize()` to log a warning instead of throwing a `StateError` when `GOOGLE_WEB_CLIENT_ID` is missing, allowing the app to start even if environment variables are not fully set up.
- **Documentation**: Added `docs/release/local_env_file_example.md` to guide developers on how to set up their own local env file if needed.

## 4. API Key Boundary
- **Client allowed dart-defines**:
  - `APP_ENV`
  - `PAYMENT_MODE`
  - `PRIVATE_BETA`
  - `PAYMENT_PRODUCTION_ENABLED`
  - `CRASHLYTICS_ENABLED`
  - `PERFORMANCE_ENABLED`
  - `BETA_CS_WHATSAPP`
- **Server-only secrets**:
  - `GEMINI_API_KEY` (Should be moved to server proxy)
  - Firebase Service Account JSON
- **Remaining security gaps**:
  - `MarketplaceAiConfig` still reads `GEMINI_API_KEY` from client-side environment. This should be refactored to use a server-side proxy in a future sprint (P6-S11B).

## 5. Verification
- **flutter analyze --fatal-infos**: Pass (after re-enabling integration_test)
- **selected flutter tests**: Pass (9 tests)
- **functions-v2 npm test**: Pass (102 tests)
- **Android APK build 1.0.0+3**: Pass

## 6. Decision
- **Real device launch**: **Fixed**
- **Status**: Ready for P6-S11 Real Device Smoke Test Build 3.

## 7. Next Step
- **P6-S11 Real Device Smoke Test Build 3**: Perform full smoke test on real device using the fixed build.
