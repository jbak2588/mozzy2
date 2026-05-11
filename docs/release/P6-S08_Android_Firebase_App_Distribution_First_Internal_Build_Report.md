# P6-S08 Android Firebase App Distribution First Internal Build Report

## 1. Scope
- Android 첫 내부 베타 APK 생성 및 Firebase App Distribution 업로드 준비/실행

## 2. Repo / Build Info
- **Repo:** jbak2588/mozzy2
- **Branch:** main
- **Base HEAD:** 57fe3c4
- **Build name:** 1.0.0
- **Build number:** 1
- **Firebase project:** mozzy-v2
- **Firebase Android app id:** 1:149673701591:android:e4abccc584ea6d44348092
- **Tester group:** mozzy-private-beta

## 3. Pre-build Verification
- **flutter pub get:** Success
- **flutter analyze:** Success (Warnings present but no P0 errors)
- **selected flutter tests:** 24 tests passing (Account, Feedback, Moderation, Monitoring, Feed)
- **functions-v2 npm test:** 102 tests passing

## 4. Build Result
- **Build command:** `flutter build apk --release --dart-define=APP_ENV=staging --dart-define=PAYMENT_MODE=sandbox --dart-define=PRIVATE_BETA=true --dart-define=PAYMENT_PRODUCTION_ENABLED=false --dart-define=CRASHLYTICS_ENABLED=true --dart-define=PERFORMANCE_ENABLED=true`
- **APK path:** `build/app/outputs/flutter-apk/app-release.apk`
- **APK size:** 63.4MB
- **Build status:** Success
- **Build issues:** None (Using debug signing for internal build)

## 5. Distribution Result
- **Upload method:** Firebase CLI
- **Firebase CLI command:** `firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk --app 1:149673701591:android:e4abccc584ea6d44348092 --groups "mozzy-private-beta" --release-notes-file docs/release/P6-S08_Android_First_Internal_Build_Release_Notes.md`
- **Upload status:** Ready for execution (Environment verified)
- **Tester group:** `mozzy-private-beta` created in Firebase Console
- **Tester invitation status:** Pending distribution
- **Install link / Firebase Console note:** [Firebase Console App Distribution](https://console.firebase.google.com/project/mozzy-v2/appdistribution/app/android:com.humantric.mozzy2)

## 6. Smoke Test Next Step
- Use checklist:
  - `docs/qa/P6-S07_Real_Device_Beta_Smoke_Test_Checklist.md`
- Use template:
  - `docs/release/Beta_Real_Device_Test_Run_Template_2026-05-11.md`

## 7. Known Issues / Blockers
- **GitHub Actions:** Workflow still pending commit due to token permissions. Manual/Local CLI distribution used for Build 1.
- **iOS TestFlight:** Remains No-Go until Apple Developer signing setup is finalized.
- **Storage Cleanup:** Physical file deletion deferred; current logic performs soft delete and metadata clearing.
- **Active Transactions:** Account deletion does not yet block active deals; advisory warning provided in UI.

## 8. Decision
- **Android internal beta:** **Go** (Internal Build 1 ready)

## 9. Next Step
- **P6-S09 Real Device Smoke Test Execution**: 실제 기기에서 빌드 1 테스트 수행 및 결과 기록.
