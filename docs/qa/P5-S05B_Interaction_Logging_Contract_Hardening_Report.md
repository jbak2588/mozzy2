# P5-S05B — Interaction Logging Contract & Test Hardening Report

## 1. 구현 요약
P5-S05에서 구축된 Interaction Logging 인프라를 기반으로, 서버와 클라이언트 간의 데이터 계약(Contract)을 강화하고 보안 및 안정성 검증을 완료했습니다.

## 2. P5-S05 Report SHA 수정 내용
- `docs/qa/P5-S05_Feed_Interaction_Logging_Report.md`의 Final Docs Commit SHA를 `591544b`로 정정했습니다.

## 3. eventType wire format 정리
- Flutter Enum에 `wireValue` 프로퍼티를 추가하여 서버 표준인 snake_case로 전송되도록 보장했습니다.
- **표준값**: `impression`, `card_tap`, `detail_open`, `cta_tap`
- `FeedInteractionEvent.toSafeJson()`에서 `eventType.wireValue`를 사용하도록 수정했습니다.

## 4. Flutter safe payload 보강 내용
- `FeedInteractionEvent`에 `forbiddenMetadataKeys`를 정의하여 `query`, `intent`, `email`, `phone`, `userId` 등 민감한 정보가 메타데이터에 포함되지 않도록 클라이언트 측 필터링(`_safeMetadata`)을 추가했습니다.

## 5. Cloud Function validation helper 보강 내용
- `functions-v2/index.js` 내 로직을 `sanitizeFeedInteractionPayload`, `clampInteractionPosition` 등의 독립 헬퍼 함수로 분리했습니다.
- 서버 측에서도 `FORBIDDEN_FEED_INTERACTION_FIELDS`를 강화하여 2중 방어 체계를 구축했습니다.
- `intentLengthBucket`에 대한 허용값(`none`, `short`, `medium`, `long`) 검증 로직을 추가했습니다.

## 6. Repository logging 방식 정리
- `CloudFunctionsFeedInteractionRepository`에서 `await`를 사용하여 호출하되, UI 레이어(`SmartFeedScreen`, `FeedItemCard`)에서는 `unawaited`를 사용하여 비동기로 호출함으로써 사용자 경험(화면 전환 등)을 방해하지 않도록 개선했습니다.
- `FirebaseFunctionsException` 및 일반 예외에 대한 처리를 강화하고 `debugPrint`를 통해 민감 정보 누출을 방지했습니다.

## 7. 테스트 결과
- **Functions Test**: `feed_interaction_logging.test.js` PASS (신규 밸리데이션 시나리오 포함)
- **Flutter Model Test**: `feed_interaction_event_test.dart` PASS (wire format 및 필터링 검증)
- **Flutter Session Test**: `feed_session_provider_test.dart` PASS (UUID 안정성 검증)
- **Flutter Widget Test**: `feed_item_card_interaction_test.dart` PASS (Tap 시 로깅 및 내비게이션 검증)
- **도메인 회귀**: Jobs, Marketplace, Payments, Monetization, Admin 전 도메인 테스트 PASS

## 8. Firestore Rules 유지 여부
- `feed_interactions` 컬렉션에 대한 클라이언트 직접 읽기/쓰기 차단 규칙(`allow read, write: if false;`)을 그대로 유지했습니다.

## 9. 남은 이슈
- **Impression 고도화**: 현재 리스트 빌더 기반의 Approximate Impression을 사용 중이며, 향후 실제 노출 시간 및 가시 영역을 고려한 정밀 로깅 도입을 검토할 수 있습니다.

## 10. Git Status
- **Branch**: main
- **Implementation Commit SHA**: a96e078
- **Final Docs Commit SHA**: 25c8cb1
- **Status**: clean
- **Push 여부**: YES
