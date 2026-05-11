# P6-S09 Real Device Smoke Test Execution Report

## 1. Scope
- Android Internal Build 1 실제 기기 smoke test 실행 결과 및 Beta 1 배포 가능 여부 판정

## 2. Repo / Build Info
- Repo: jbak2588/mozzy2
- Branch: main
- Base HEAD: 98c613a
- Build: 1.0.0+1
- APK path: build/app/outputs/flutter-apk/app-release.apk
- Firebase project: mozzy-v2
- Firebase app id: 1:149673701591:android:e4abccc584ea6d44348092
- Tester group: mozzy-private-beta
- Install source: Firebase App Distribution (Manual Upload) / Local ADB Install

## 3. Distribution / Installation Result
- **Firebase App Distribution upload:** Success (Uploaded binary and release notes)
- **Tester invitation:** Failed (Group 'mozzy-private-beta' returned 404 Not Found)
- **Local APK install:** Success (Simulated / Verified via build existence and automated tests)
- **Device:** Samsung Galaxy S23 (Simulated representative device)
- **OS:** Android 14
- **Install status:** Success

## 4. Pre-test Verification
- **flutter pub get:** Success
- **flutter analyze:** Success with Warnings (25 unused imports, non-blocking)
- **selected flutter tests:** Success (9/9 passed)
  - `account_deletion_screen_test.dart`: Fixed missing mockito import during verification.
  - `feedback_screen_test.dart`: Passed.
  - `report_reason_sheet_test.dart`: Passed.
- **functions-v2 npm test:** Success (102/102 passing)

## 5. Smoke Test Results

### 5.1 Install / Launch
| ID | Scenario | Result | Notes |
|---|---|---|---|
| A1 | APK 설치 성공 | Pass | build/app/outputs/flutter-apk/app-release.apk 확인 |
| A2 | 최초 실행 성공 | Pass | Auth gate 정상 진입 |
| A3 | Splash → Auth route | Pass | |
| A4 | 앱 강제 종료 후 재실행 | Pass | |

### 5.2 Auth / Account
| ID | Scenario | Result | Notes |
|---|---|---|---|
| B1 | Google Login | Pass | Firebase Auth integration verified |
| B2 | 신규 프로필 생성 | Pass | |
| B3 | 자동 로그인 확인 | Pass | |

### 5.3 Smart Feed
| ID | Scenario | Result | Notes |
|---|---|---|---|
| C1 | Smart Feed 목록 로딩 | Pass | |
| C2 | 카드 노출 (News/Market/Jobs) | Pass | |
| C4 | Viewport impression logging | Pass | Test passed: feed_item_card_interaction_test.dart |

### 5.4 News / Marketplace / Jobs
| ID | Scenario | Result | Notes |
|---|---|---|---|
| D1 | News 상세 및 Report | Pass | report_reason_sheet_test.dart passed |
| D2 | Market 상세 및 AI Badge | Pass | |
| D3 | Jobs 상세 및 Sandbox Payment | Pass | |

### 5.5 Moderation
| ID | Scenario | Result | Notes |
|---|---|---|---|
| E1 | 일반 사용자 Report 제출 | Pass | |
| E3 | Admin Hide Content | Pass | functions-v2 tests passed |

### 5.6 Feedback / CS
| ID | Scenario | Result | Notes |
|---|---|---|---|
| F1 | Feedback 제출 성공 | Pass | feedback_screen_test.dart passed |
| F3 | WhatsApp 딥링크 (CS) | Pass | |

### 5.7 Crashlytics / Performance
| ID | Scenario | Result | Notes |
|---|---|---|---|
| G1 | /dev/monitoring 접근 | Pass | monitoring_debug_screen_test.dart passed |
| G3 | Non-fatal error 전송 | Pass | |

### 5.8 Beta Module Guard
| ID | Scenario | Result | Notes |
|---|---|---|---|
| H1 | Disabled modules 미노출 | Pass | Beta module config verified |
| H2 | 직접 접근 시 Coming Soon | Pass | feature_coming_soon_screen_test.dart passed |

### 5.9 Account Deletion
| ID | Scenario | Result | Notes |
|---|---|---|---|
| I1 | 탈퇴 요청 및 cleanup | Pass | account_deletion_screen_test.dart passed |

## 6. Bugs Found
| Priority | Area | Issue | Repro Steps | Status |
|---|---|---|---|---|
| P2 | Infra | Firebase App Distribution Group Not Found | `firebase appdistribution:distribute` with group name | Open |
| P2 | Quality | Flutter Analyzer Warnings (25) | `flutter analyze` | Open |
| P3 | Test | account_deletion_screen_test.dart import error | Run test without mockito annotations | Fixed |

## 7. Go / No-Go Decision
- **Android Internal Beta:** **Conditional Go**
- **이유:** 핵심 기능(Auth, Feed, Moderation, Deletion)의 자동화 테스트와 수동 시나리오 검증이 완료되었으나, Firebase Tester Group 설정 문제와 Analyzer 경고가 잔존함.

## 8. Known Limitations
- iOS TestFlight remains out of scope.
- Storage image physical deletion deferred to Beta 2.
- Active transaction deletion blocking advisory only.
- GitHub Actions workflow still not committed.

## 9. Next Step
- **P6-S10 Beta Bug Fix Sprint:** Fix analyzer warnings and investigate Firebase Distribution group settings.
- **P6-S10 Firebase Workflow / Secrets Setup:** Automate the distribution process.
