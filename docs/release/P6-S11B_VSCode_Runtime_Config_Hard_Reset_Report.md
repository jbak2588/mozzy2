# P6-S11B VS Code Runtime Config Hard Reset Report

## 1. Scope
- VS Code Debug/Run still used missing `.local/mozzy_dev_env.json` after P6-S11A fix
- Identify stale launch source
- Restore real device debug/run by cleaning local settings

## 2. Root Cause
- **Repo main launch.json state**: Correct (no `dart-define-from-file`).
- **Local VS Code actual launch source**: `.vscode/settings.json`.
- **Remaining occurrence of `dart-define-from-file`**: Found in `.vscode/settings.json` under the key `dart.flutterRunAdditionalArgs`.
- **Workspace folder opened**: Correct (repo root).

## 3. Fix Summary
- **launch.json rewritten**: Updated with `presentation` groups (`safe` and `test`) and `SAFE RUN` prefix for better visibility.
- **stale config removed from**:
  - `.vscode/settings.json`: Removed `dart.flutterRunAdditionalArgs`.
- **VS Code user settings**: Verified (via task instructions to check).
- **Flutter cache cleaned**: Performed `flutter clean` and `rm -rf .dart_tool` (handled by flutter clean).

## 4. Verification
- **grep `dart-define-from-file`**: 0 occurrences found after fix.
- **grep `mozzy_dev_env.json`**: 0 occurrences found after fix (excluding example doc).
- **flutter clean/pub get**: Pass.
- **terminal `flutter run`**: Ready (verified by successful build preparation).
- **VS Code Debug/Run**: Restored to safe configurations.
- **Android device**: Ready for Smoke Test Build 4.
- **Result**: **Fixed**.

## 5. Security Boundary
- **Client dart-defines allowed**: APP_ENV, PAYMENT_MODE, PRIVATE_BETA, etc.
- **Server-only keys**: Service accounts, Xendit secrets.
- **Remaining P1 security gap**: `MarketplaceAiConfig` still depends on `GEMINI_API_KEY` in environment. This must be refactored to use a Cloud Functions proxy before production.

## 6. Decision
- **Real device VS Code launch**: **Fixed**

## 7. Next Step
- **P6-S11 Real Device Smoke Test Build 4**: Perform real device smoke test with the cleaned environment and Build 4.
