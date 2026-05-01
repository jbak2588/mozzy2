# Mozzy Indonesia - New Chat Session Handoff (2026-05-01)

## 🎯 Project Identity
- **Project Folder**: `E:\hni-project\mozzy`
- **GitHub Repository**: `github.com/jbak2588/mozzy2`
- **Branch**: `main`
- **Note**: Work ONLY in the above paths. Do not modify `bling` or `mozzy-v6` shell branches.

## 📦 Latest Commits
- `f1051d32d943c6983fe82ca7eef39ed85a8f0484`: test(marketplace): record staging Firebase live verification results
- `a39fd3bccea866c5972716e5491110cfd174d4cc`: docs(session): record completed staging Firebase verification commit

## ✅ Completed Marketplace Milestones
- **Core UI/Logic**: `ProductModel`, `MarketplaceRepository`, `MarketplaceListScreen`, `ProductDetailScreen`, `CreateProductScreen`.
- **Media**: Image upload foundation, **WebP optimization** (compression & resizing).
- **AI Integration**: **Gemini 3.0 Flash** verification, AI report storage, live Gemini smoke test passed.
- **User Engagement**: **Simpan/Like** functionality, **Saved Items** screen.
- **Admin Infrastructure**:
    - AI review moderation queue.
    - **Admin Review UI** (Approve/Reject/Dismiss actions).
    - **Admin Custom Claims** role source (Firebase auth).
    - **Admin Audit Log** storage & UI.
    - **Admin Claims Assignment Script** (Node.js/Firebase Admin SDK).
- **Quality Assurance**: Automated integration tests (E2E), full production readiness review.

## 🛠️ Current Active Task: P2-B22 Marketplace Staging Firebase Verification
- **Status**: ⚠️ **PARTIAL / BLOCKED**
- **Goal**: Verify end-to-end functionality in a real staging Firebase environment.
- **Admin Verification**: ✅ **SUCCESS**. Admin role `admin` assigned to staging test UID.
- **Auth Verification**: ❌ **BLOCKED**.

## 🛑 Google Login Blocker Details
- **Error**: `DEVELOPER_ERROR` (statusCode=10).
- **Device**: Physical Android device (SM A715F / RR8N109B4JM).
- **Extracted SHA-1**: `1D:CF:F3:B9:3B:1D:54:7F:4D:4B:D2:21:0A:90:69:B6:4A:AC:46:3F`.
- **Critical Context**:
    - The extracted SHA-1 reportedly **already matches** the one registered in the Firebase Console.
    - A **timestamp-related error** was observed on the physical device screen.
    - **Do not assume only SHA-1 mismatch.**

### Next Diagnostic Steps:
1.  **Device Clock**: Verify if the phone's date/time/timezone are set to "Automatic".
2.  **SHA-256**: Ensure SHA-256 is also registered in the Firebase Console.
3.  **Config Sync**: Re-download and place a fresh `google-services.json` after any SHA changes.
4.  **Identity Match**: Double-check `applicationId` / package name matching between Firebase and `app/build.gradle`.
5.  **Web Client ID**: Verify `GOOGLE_WEB_CLIENT_ID` passed via dart-define matches the one in the staging project's OAuth clients.
6.  **Provider Status**: Confirm Google Auth provider is enabled in Firebase Console.
7.  **Cache/Cleanup**: Perform a full app uninstall, reinstall, and possibly clear Play Services cache on the device.

## 🔐 Required Environment Variables
(Secrets are present in the local environment; do not print values)
- `GOOGLE_WEB_CLIENT_ID`
- `GEMINI_API_KEY`
- `GOOGLE_APPLICATION_CREDENTIALS`
- `MOZZY_STAGING_ADMIN_TEST_UID`

## 🚀 Next Recommended Task
- **P2-B22-C**: Google Login `DEVELOPER_ERROR` diagnosis.
- **Gate**: Do not start **P2-B23 Payment / Xendit** until staging login is unblocked.

## 💻 Commands for Next Session
```powershell
cd e:\hni-project\mozzy
git status --short --branch
git log --oneline -12
# Verify env vars
if ($env:GOOGLE_WEB_CLIENT_ID) { "GOOGLE_WEB_CLIENT_ID=PRESENT" }
# Check device connectivity
flutter devices
# Run app with defines
flutter run -d RR8N109B4JM --dart-define=GOOGLE_WEB_CLIENT_ID=$env:GOOGLE_WEB_CLIENT_ID --dart-define=GEMINI_API_KEY=$env:GEMINI_API_KEY
```
