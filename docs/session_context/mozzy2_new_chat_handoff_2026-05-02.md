# P2-B22-D Handoff: Live Staging Flow Verification

## 🎯 Current Focus
Confirming the `UserModel` timestamp fix on a physical device (Samsung SM A715F) and completing the Marketplace staging verification flow.

## 🏁 State of Play
- **Auth Fix**: `UserModel` now uses a custom `DateTime` converter. Unit tests pass. Linter warnings resolved.
- **Diagnostics**: All debug prints in Auth/User repositories are wrapped in `kDebugMode`.
- **Marketplace**: Product creation, image upload, and Gemini AI screening are implemented and ready for live testing.
- **Repo Status**: `flutter analyze` is CLEAN.

## 🚀 Execution Instructions for User
1. **Prepare Device**: Ensure SM A715F is connected and authorized.
2. **Clean Install**: `adb uninstall com.humantric.mozzy2 && flutter clean && flutter pub get`
3. **Run App**:
   ```powershell
   flutter run -d RR8N109B4JM `
     --dart-define=GOOGLE_WEB_CLIENT_ID=<WEB_CLIENT_ID> `
     --dart-define=GEMINI_API_KEY=<GEMINI_API_KEY>
   ```
4. **Login**: Perform Google Login. Verify NO CRASH.
5. **Marketplace Flow**:
   - Go to Marketplace -> Create Product.
   - Upload a test item with real photos.
   - Check if the saving status progresses through 'optimizing' -> 'uploading' -> 'verifying'.
   - Confirm the item appears in the list and the Admin Queue (for the test admin UID).

## ⚠️ Known Blockers
- **None currently identified**. The previous timestamp crash is theoretically resolved and verified via unit tests.

## 📑 Reference Documents
- `docs/phase_reports/phase2_marketplace_staging_firebase_verification_report.md`
- `docs/session_context/mozzy2_session_summary_2026-05-02.md`
