# P6-S07 Real Device Beta Smoke Test Checklist

## 1. Scope
- Private Beta 배포 전 실제 Android/iOS 기기에서의 핵심 유저 시나리오 전수 점검.
- Android APK 설치 및 실행 우선 검증, iOS는 TestFlight readiness 및 빌드 가능 여부 확인.
- P6-S01~P6-S06에서 구현된 안전장치(Moderation, Monitoring, Feedback, Account Deletion)의 통합 동작 확인.

## 2. Base Repo State
- **Repo:** jbak2588/mozzy2
- **Branch:** main
- **Base HEAD:** 2404fd7 (fix: add missing import for AccountDeletionScreen)
- **Build version:** 1.0.0+1
- **Firebase project:** mozzy-v2 (Staging/Beta)
- **Payment mode:** Sandbox (PAYMENT_MODE=sandbox)

## 3. Device Matrix
| Platform | Device | OS | Build Type | Tester | Status | Notes |
|---|---|---|---|---|---|---|
| Android | Low-end (e.g. 2GB RAM) | Android 10~12 | APK release |  | Pending | 성능/메모리 부족 여부 확인 |
| Android | Mid-range (Samsung/Oppo) | Android 12~14 | APK release |  | Pending | 일반적인 배포 환경 |
| Android | High-end / Recent | Android 14~15 | APK release |  | Pending | 최신 API 호환성 |
| iOS | iPhone Physical | iOS 17+ | no-codesign |  | Pending | 빌드 및 기본 렌더링 확인 |

## 4. Pre-test Commands
테스트 실행 전 아래 명령어를 통해 환경이 정상인지 확인합니다.

```bash
flutter pub get
flutter analyze

# 핵심 단위/위젯 테스트 실행
flutter test test/mozzy_ii/domains/account/account_deletion_screen_test.dart
flutter test test/mozzy_ii/domains/feedback/feedback_screen_test.dart
flutter test test/mozzy_ii/domains/moderation/report_reason_sheet_test.dart
flutter test test/mozzy_ii/core/monitoring/monitoring_debug_screen_test.dart

# Cloud Functions 테스트
cd functions-v2
npm test
cd ..

# Android APK Build
flutter build apk --release \
  --build-name=1.0.0 \
  --build-number=1 \
  --dart-define=APP_ENV=staging \
  --dart-define=PAYMENT_MODE=sandbox \
  --dart-define=PRIVATE_BETA=true \
  --dart-define=PAYMENT_PRODUCTION_ENABLED=false \
  --dart-define=CRASHLYTICS_ENABLED=true \
  --dart-define=PERFORMANCE_ENABLED=true
```

## 5. Smoke Test Checklist

### 5.1 Install / Launch
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 1.1 | APK Installation | APK가 정상적으로 설치됨 |  |  |
| 1.2 | Initial Launch | Splash 화면 이후 Auth Gate(Login) 진입 성공 |  |  |
| 1.3 | Re-launch | 앱 강제 종료 후 재실행 시 이전 로그인 상태 유지 |  |  |
| 1.4 | Offline Startup | 인터넷 연결 없을 때 에러 메시지 또는 Offline 안내 표시 |  |  |

### 5.2 Auth / Account
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 2.1 | Google Login | Google 계정으로 정상 가입 및 로그인 |  |  |
| 2.2 | Profile Creation | 신규 유저 닉네임/위치 설정 성공 |  |  |
| 2.3 | Logout | 로그아웃 후 로그인 화면으로 리다이렉트 |  |  |
| 2.4 | Auto Login | 재실행 시 자동 로그인 처리 |  |  |

### 5.3 Smart Feed
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 3.1 | Feed Loading | Smart Feed 목록이 정상 노출됨 |  |  |
| 3.2 | Multi-domain Cards | News, Marketplace, Jobs 카드가 혼합되어 노출 |  |  |
| 3.3 | Impression Logging | 스크롤 시 Viewport Impression이 로깅됨 (콘솔/네트워크 확인) |  |  |
| 3.4 | Detail Navigation | 카드 탭 시 해당 도메인 상세 화면 이동 |  |  |
| 3.5 | Feedback Button | AppBar에 피드백 아이콘 노출 |  |  |

### 5.4 News
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 4.1 | News List | 로컬 뉴스 목록 정상 조회 |  |  |
| 4.2 | News Detail | 뉴스 본문 및 댓글 영역 정상 노출 |  |  |
| 4.3 | Report Entry | AppBar에 신고 버튼 노출 |  |  |
| 4.4 | Own Post Filter | 본인이 쓴 글에는 신고 버튼 미노출 |  |  |

### 5.5 Marketplace
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 5.1 | Product List | 중고 물품 목록 및 카테고리 필터 동작 |  |  |
| 5.2 | Product Detail | 상품 이미지, 가격, AI 검증 배지 노출 |  |  |
| 5.3 | Image Loading | 이미지 캐싱 및 Lazy loading 동작 |  |  |
| 5.4 | Report Button | 타인 상품 상세에서 신고 가능 |  |  |

### 5.6 Jobs
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 6.1 | Jobs List | 구인 공고 목록 정상 노출 |  |  |
| 6.2 | Job Detail | 급여, 위치, 업무 내용 노출 |  |  |
| 6.3 | Job Boost Entry | 내 공고 상세에서 Boost 구매 화면 진입 |  |  |
| 6.4 | Sandbox Warning | 결제 화면에서 "Sandbox payment only" 배너 노출 |  |  |

### 5.7 Moderation / Admin
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 7.1 | Report Submit | 신고 제출 시 성공 스낵바 노출 및 창 닫힘 |  |  |
| 7.2 | Admin Access | `/admin/moderation` 접근 시 Admin 권한 체크 |  |  |
| 7.3 | Hide Action | Admin이 콘텐츠 숨김 처리 시 일반 유저에게 미노출 |  |  |
| 7.4 | Unauthorized Block | 일반 유저가 Admin 경로 접근 시 Home 리다이렉트 |  |  |

### 5.8 Feedback / CS
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 8.1 | Feedback Form | 카테고리 선택 및 1000자 이내 메시지 입력 |  |  |
| 8.2 | Privacy Notice | 개인정보 입력 금지 안내 문구 확인 |  |  |
| 8.3 | Feedback Submit | 피드백 저장 성공 및 Firestore `feedback` 컬렉션 확인 |  |  |
| 8.4 | WhatsApp CS | WhatsApp 버튼 클릭 시 딥링크 이동 (번호 설정 시) |  |  |

### 5.9 Crashlytics / Performance
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 9.1 | Debug Screen | `/dev/monitoring` 진입 및 상태 표시 확인 |  |  |
| 9.2 | Non-fatal Error | 테스트 에러 전송 버튼 클릭 후 Crashlytics 기록 확인 |  |  |
| 9.3 | Perf Trace | 테스트 트레이스 실행 후 Performance Monitoring 기록 확인 |  |  |
| 9.4 | Force Crash | 강제 크래시 발생 시 다음 앱 실행 시 전송 여부 확인 |  |  |

### 5.10 Beta Module Guard
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 10.1 | Hidden Modules | Auction, Clubs 등 미구현 모듈이 홈/메뉴에서 미노출 |  |  |
| 10.2 | Route Guard | 미구현 라우트 직접 접근 시 "Coming Soon" 화면 노출 |  |  |
| 10.3 | App Stability | 미구현 기능 접근 시도 시 크래시 없음 |  |  |

### 5.11 Account Deletion
| ID | Scenario | Expected Result | Status | Notes |
|---|---|---|---|---|
| 11.1 | Deletion Entry | 프로필/설정 메뉴에서 탈퇴 진입 |  |  |
| 11.2 | Agreement Check | 체크박스 선택 시에만 삭제 버튼 활성화 |  |  |
| 11.3 | Request Submit | 탈퇴 요청 후 자동 로그아웃 및 홈 이동 |  |  |
| 11.4 | Data Anonymized | 서버 처리 후 Firestore 유저명 "Deleted User" 확인 |  |  |

## 6. Go / No-Go Criteria

### Go (배포 가능)
- 핵심 시나리오(1.x ~ 3.x) 전원 통과.
- 신고/피드백 제출 및 Admin 처리 확인.
- 탈퇴 플로우 정상 동작 (로그아웃 및 익명화).
- Android Release APK 빌드 성공.

### Conditional Go (조건부 배포)
- iOS TestFlight는 준비 중이나 Android 우선 배포 가능.
- Crashlytics 데이터 도달에 지연이 있으나 로깅 호출 성공 확인.
- 특정 저사양 기기에서 UI 렉이 있으나 기능상 문제 없음.

### No-Go (배포 불가)
- 앱 시작 시 즉시 크래시 발생.
- 로그인/가입 불가.
- 스마트 피드 로딩 무한 대기.
- 실제 결제(Production) 채널이 실수로 열려 있음.
- 탈퇴 후에도 개인정보가 원본 그대로 노출됨.

## 7. Known Limitations
- **Storage Cleanup:** 이미지 파일의 물리적 삭제는 Beta 2에서 지원 예정.
- **Active Transactions:** 활성 거래 중 탈퇴 시 결제 정산 로직은 현재 안내 문구로 대체.
- **iOS TestFlight:** Apple Developer 계정 연동 후 별도 서명 작업 필요.
- **Auto Moderation:** AI를 통한 자동 숨김 처리는 미포함 (Admin 수동 처리).

## 8. Next Step Recommendation
- **P6-S08 Android Firebase App Distribution First Internal Build**
- **P6-S08 Firebase Workflow Manual Commit / Secrets Setup**
