# P6-S04 Crashlytics / Performance Monitoring Setup Report

## 1. Scope
- Private Beta 안정성 및 성능 모니터링 체계 구축
- 예외 상황(Crash, Non-fatal error) 실시간 추적 및 분석 환경 마련
- 핵심 유저 시나리오의 지연 시간(Latency) 측정

## 2. Implementation Summary
- **CrashlyticsService**: `FirebaseCrashlytics`를 래핑하여 Flutter 및 Platform 레벨의 에러를 캡처. `recordNonFatal` 헬퍼를 통해 비정상 로직 흐름 추적 가능.
- **PerformanceMonitoringService**: `FirebasePerformance`를 래핑하여 커스텀 Trace(`trace` 헬퍼) 제공.
- **Main Initialization**: `lib/main.dart`에서 Firebase 초기화 직후 모니터링 서비스 활성화. `APP_ENV`, `CRASHLYTICS_ENABLED` 등의 dart-define 옵션 지원.
- **Monitoring Debug Screen**: 테스터 및 개발자가 Crashlytics 전송 및 Performance Trace 동작을 직접 확인할 수 있는 디버그 화면 추가 (`/dev/monitoring`).
- **Android Integration**: `build.gradle.kts` 및 `settings.gradle.kts`에 Crashlytics 및 Performance 플러그인 적용 완료.
- **Moderation Integration**: `ModerationService` 내 신고 제출 및 숨김 처리 실패 시 `recordNonFatal`을 통해 에러 기록 연동.

## 3. Error Capture Policy
- `FlutterError.onError`: Flutter 프레임워크 내에서 발생하는 에러 자동 기록.
- `PlatformDispatcher.instance.onError`: 비동기 루프 또는 네이티브 브릿지에서 발생하는 처리되지 않은 에러 기록.
- `recordNonFatal`: 사용자 식별 정보(PII)를 제외한 컨텍스트(예: `target_type`, `reason`)를 Custom Key와 함께 전송.

## 4. Performance Trace Policy
- 기본적으로 앱 시작 및 주요 화면 로딩에 대한 측정이 가능하도록 구조화.
- 주요 권장 Trace: `app_start`, `smart_feed_load`, `report_submit`, `moderation_admin_load`.
- 디버그 화면에서 `test_trace`를 통해 동작 확인 가능.

## 5. QA Results
- **flutter pub get**: Success. `firebase_crashlytics`, `firebase_performance` 패키지 추가 확인.
- **flutter analyze**: Success. No blocking issues.
- **monitoring tests**: 신규 단위/위젯 테스트 통과 (`monitoring_debug_screen_test.dart`, `performance_monitoring_service_test.dart`).
- **beta/feed/moderation regression tests**: 통과.
- **functions-v2 npm test**: 99 tests passing.
- **Android setup**: 플러그인 적용 확인. (APK 빌드는 실제 환경에서 추가 검증 필요)
- **iOS setup**: `GoogleService-Info.plist` 및 `Podfile` 존재 확인.

## 6. Known Limitations
- **dSYM/Mapping Upload**: 실제 배포용 빌드(iOS TestFlight, Android App Bundle) 시점에 기호화(Symbolication) 파일을 Firebase에 자동 업로드하는 설정은 배포 Workflow(GitHub Actions)와 연계가 필요함.
- **Real Device Verification**: 시뮬레이터가 아닌 실제 기기에서 Crash 발생 시 Firebase Console에 데이터가 나타나기까지 수 분의 지연이 발생할 수 있음.

## 7. Next Step
- **P6-S05 Feedback / CS Channel Setup**: 사용자 피드백 및 고객 지원 채널 연동.
