# Beta Distribution Readiness — 2026-05-10

## 1. Purpose
Private beta 배포 준비 상태 정리.

## 2. Android Firebase App Distribution
- Firebase project: `mozzy-v2` (Staging/Beta)
- Android app id: `1:149673701591:android:e4abccc584ea6d44348092`
- Tester group: `mozzy-private-beta`
- Build command: `flutter build apk --release --build-name=1.0.0 --build-number=${{ github.run_number }} --dart-define=APP_ENV=staging --dart-define=PAYMENT_MODE=sandbox`
- Distribution method: GitHub Actions (`wzieba/Firebase-Distribution-Github-Action@v1`)
- Required secrets: `FIREBASE_ANDROID_APP_ID_STAGING`, `FIREBASE_SERVICE_ACCOUNT_STAGING`
- Current status: Workflow draft prepared and Android build is verified.
- Remaining gaps: Firebase console에서 App Distribution 활성화 및 서비스 어카운트/시크릿 등록.

## 3. iOS TestFlight
- Bundle identifier: `com.humantric.mozzy2`
- Apple Developer status: 확인 필요
- Signing status: No codesign verified, requires developer account setup
- Build command: `flutter build ios --release --no-codesign`
- Upload method: Manual TestFlight Upload or require Fastlane/App Store Connect API Key setup in Actions.
- Required secrets: `APP_STORE_CONNECT_API_KEY_ID`, `APP_STORE_CONNECT_ISSUER_ID`, `APP_STORE_CONNECT_API_KEY_P8`
- Current status: Basic build structure verified (minimum deployment target updated to 15.0).
- Remaining gaps: Apple Developer 계정 연동, 인증서 및 프로비저닝 프로파일 설정, App Store Connect API 키 발급 및 등록.

## 4. Version Strategy
- Current pubspec version: `1.0.0+1`
- Private beta version: `1.0.0`
- Build number rule: GitHub Actions Run Number 활용 (`${{ github.run_number }}`)
- Release branch strategy: `main` 브랜치 기준 워크플로우 수동 트리거(workflow_dispatch).

## 5. GitHub Actions
- Workflow file: `.github/workflows/beta_distribution.yml`
- Manual trigger: `workflow_dispatch` 
- Android beta job: Included (Builds APK and uploads to Firebase App Distribution).
- iOS readiness job: Included (Verifies build with `--no-codesign`).
- Required repository secrets: `FIREBASE_ANDROID_APP_ID_STAGING`, `FIREBASE_SERVICE_ACCOUNT_STAGING`

## 6. Required Secrets
| Secret | Purpose | Required For | Status |
|---|---|---|---|
| FIREBASE_ANDROID_APP_ID_STAGING | Firebase Android app id | Android | Missing/Ready |
| FIREBASE_SERVICE_ACCOUNT_STAGING | Firebase service account JSON | Android | Missing/Ready |
| APP_STORE_CONNECT_API_KEY_ID | App Store Connect API | iOS | Optional/Missing |
| APP_STORE_CONNECT_ISSUER_ID | App Store Connect API | iOS | Optional/Missing |
| APP_STORE_CONNECT_API_KEY_P8 | App Store Connect API | iOS | Optional/Missing |

## 7. Beta Release Notes Template
Mozzy Private Beta {version}+{build}
Focus:
* Smart Feed
* News
* Marketplace
* Jobs
* Chat
Known limitations:
* Payments are sandbox only.
* Some modules may be disabled.
* Report/Moderation is being prepared.
Feedback:
	•	Send bug reports through {feedback channel}.

## 8. Go / No-Go
- Android private beta: Go (Requires Secrets)
- iOS TestFlight: No-Go (Requires Apple Developer Setup)
- Overall: Conditional Go
- Next recommended task: P6-S02 Disable Unimplemented Beta Modules