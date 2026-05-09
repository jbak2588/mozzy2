# P5-S05 — Smart Feed Interaction Logging Foundation Report

## 1. 구현 요약
Smart Feed에서 사용자의 상호작용(`impression`, `card_tap`)을 수집하기 위한 기반 인프라를 구축했습니다. Privacy-safe 정책을 적용하여 민감한 개인정보(검색어 원문, PII)는 저장하지 않으며, Cloud Functions Proxy를 통해 안전하게 Firestore에 기록됩니다.

## 2. 생성/수정 파일
- `functions-v2/index.js`: `logFeedInteraction` callable function 추가
- `firestore.rules`: `feed_interactions` 컬렉션 접근 제한 추가
- `lib/mozzy_ii/domains/feed/models/feed_interaction_type.dart`: 이벤트 타입 Enum
- `lib/mozzy_ii/domains/feed/models/feed_interaction_event.dart`: 이벤트 데이터 모델
- `lib/mozzy_ii/domains/feed/repositories/feed_interaction_repository.dart`: Repository 인터페이스
- `lib/mozzy_ii/domains/feed/repositories/cloud_functions_feed_interaction_repository.dart`: Functions 연동 구현체
- `lib/mozzy_ii/domains/feed/providers/feed_interaction_provider.dart`: Repository 및 SeenItems 추적 Provider
- `lib/mozzy_ii/domains/feed/providers/feed_session_provider.dart`: 세션 UUID Provider
- `lib/mozzy_ii/domains/feed/screens/smart_feed_screen.dart`: Impression 로깅 연동
- `lib/mozzy_ii/domains/feed/widgets/feed_item_card.dart`: Card Tap 로깅 연동

## 3. logFeedInteraction Cloud Function 구조
- **허용 이벤트**: `impression`, `card_tap`, `detail_open`, `cta_tap`
- **보안**: `FORBIDDEN_FEED_INTERACTION_FIELDS` (email, phone, intent 원문 등) 차단 및 필터링
- **저장 위치**: `feed_interactions` 컬렉션
- **검증**: `eventType`, `feedItemId`, `sourceId`, `sourceType` 필수값 체크 및 `position` 클램핑(0~100)

## 4. FeedInteractionEvent 구조
- `eventType`, `feedItemId`, `sourceId`, `sourceType`, `position`, `isPromoted`, `hasSemanticIntent`, `intentLengthBucket`, `sessionId` 등을 포함합니다.
- `toSafeJson()`을 통해 민감 정보가 제외된 상태로 서버에 전송됩니다.

## 5. Privacy 정책 적용
- **검색어 원문 저장 안 함**: `intentLengthBucket` 정보를 통해 의도의 길이 정도만 익명화하여 저장합니다.
- **PII 저장 안 함**: 이메일, 전화번호, 상세 주소 등은 수집 대상에서 제외됩니다.
- **비식별 세션**: UUID 기반의 `sessionId`를 사용하여 앱 실행 단위로만 이벤트를 묶습니다.

## 6. Firestore Rules 변경 사항
- `feed_interactions` 컬렉션에 대해 클라이언트의 직접적인 `read`, `write`를 금지했습니다 (`allow read, write: if false;`). 오직 Cloud Functions Admin SDK를 통해서만 기록 가능합니다.

## 7. 테스트 결과
- **Functions Test**: `feed_interaction_logging.test.js` PASS
- **Flutter Model Test**: `feed_interaction_event_test.dart` PASS
- **Flutter Analyze**: PASS
- **핵심 도메인 회귀**: PASS

## 8. 남은 이슈
- **Impression 로직 고도화**: 현재는 `ListView.builder`의 `itemBuilder`에서 1회 노출 시 기록하는 단순 방식을 사용합니다. 향후 실제 화면 점유율 기반 로깅이 필요할 수 있습니다.
- **Engagement Score**: 수집된 로그를 바탕으로 `engagementScore`를 계산하여 랭킹 엔진에 반영하는 작업은 P5-S06에서 진행할 예정입니다.

## 9. Git Status
- **Branch**: main
- **Implementation Commit SHA**: 9012669
- **Final Docs Commit SHA**: 591544b
- **Status**: clean
- **Push 여부**: YES
