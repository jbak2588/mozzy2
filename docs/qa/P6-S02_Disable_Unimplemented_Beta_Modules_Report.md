# P6-S02 Disable Unimplemented Beta Modules Report

## 1. Scope
- Beta 1에서 미구현 기능을 숨긴 이유:
  - Phase 6 Audit 결과, 11개 도메인 중 일부가 미완성 상태이거나 테스트가 부족함.
  - 실제 테스터에게 앱 배포 시 미구현 기능이 노출되면 빈 화면, 오류 화면으로 진입할 위험이 있음.
  - 이를 방지하여 핵심 피드 순환 경험(Smart Feed, News, Marketplace, Jobs, Chat)에 집중하도록 유도.

## 2. Beta Feature Policy
### Enabled in Beta 1
- News
- Marketplace
- Jobs
- Chat
- Smart Feed
- Notifications
- Payment / Boost (Sandbox only)

### Disabled in Beta 1
- Auction
- Clubs
- Lost & Found
- POM
- Real Estate
- Stores
- Together

## 3. Implementation Summary
- **BetaFeatureFlags 추가**: `lib/mozzy_ii/core/config/beta_feature_flags.dart` 생성하여 환경변수 기반(isPrivateBeta) Feature toggle 구현.
- **Coming Soon 화면 추가**: `lib/mozzy_ii/shared/screens/feature_coming_soon_screen.dart` 구현.
- **Navigation/Route Guard 적용**: `app_router.dart`의 `DummyScreen` 라우트 및 `Stores` 탭을 BetaFeatureFlags로 검사하여 비활성화 시 `FeatureComingSoonScreen`으로 리다이렉트하도록 수정.
- **Payment Production 제한**: `JobBoostPurchaseScreen`에 Sandbox 결제만 지원함을 명시하는 경고 배너 추가.
- **i18n 번역 추가**: en, id, ko 번역 파일에 `beta.comingSoonTitle`, `beta.comingSoonBody` 등 추가.

## 4. QA Results
- **flutter analyze**: No blocking issues.
- **beta feature flag tests**: Passed (`beta_feature_flags_test.dart`).
- **coming soon screen tests**: Passed (`feature_coming_soon_screen_test.dart`).
- **related UI tests**: Passed feed interaction/impression tests.
- **functions-v2 tests**: Passed (94 tests).

## 5. Known Limitations
- 비활성화 기능은 Beta 2 이후 Remote Config 기반 동적 제어로 전환 재검토 필요.
- Admin에서 모듈별 on/off 동적 제어 UI는 아직 구현되지 않음.
- 앱 내 다른 곳에 하드코딩된 크로스링크가 있을 수 있으나 라우트 레벨 Guard로 크래시 예방.

## 6. Next Step
- **P6-S03 Moderation / Report Handling Readiness**: UGC 환경에서 사용자 보호를 위한 신고 및 콘텐츠 블라인드 처리 플로우 구축.
