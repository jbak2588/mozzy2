# P5-S07 Precision Viewport-based Impression Logging Report

## 1. Scope
- Approximate impression 문제: 기존에는 리스트 빌더나 렌더 트리거 기반의 "어림짐작(approximate)" impression이 기록되고 있었습니다. 이로 인해 사용자가 화면에서 빠르게 스크롤해 지나간 카드나 화면 밖에 있는 카드도 노출로 처리되는 한계가 있었습니다.
- Viewport visibility 기반 정밀 impression 도입 목적: 카드가 실제 화면에 일정 비율 이상 보이고 일정 시간 머물렀을 때만(impression threshold 달성) 노출을 기록함으로써 Smart Feed Engagement Score의 정확도를 높이기 위함입니다.

## 2. Implementation Summary
- **Flutter tracker**: `visibility_detector` 패키지를 사용하여 `ViewportImpressionTracker` 위젯을 생성하였습니다.
- **Dedup logic**: 스크린 세션 당 하나의 feed item ID는 중복해서 기록되지 않도록 `SmartFeedScreen`의 `seenItemsProvider`와 연동하여 1회만 로깅되게 처리했습니다.
- **Dwell threshold**: 노출 기준은 `visibleRatio` >= 50%, `dwellMs` >= 800ms 로 설정되었습니다.
- **Server validation**: `functions-v2/index.js`의 `logFeedInteraction` 함수에서 `impressionMode === "viewport"` 일 때, `visibleRatio`와 `dwellMs` 메타데이터 필드의 유효성 (>=0.5, >=800)을 검증하도록 보강되었습니다.
- **Existing aggregation compatibility**: 기존 집계 로직(`aggregateFeedEngagement`)은 변경하지 않았으며, `impressionCount`는 viewport-based 데이터를 기반으로 자연스럽게 정확도가 향상되도록 호환성을 유지했습니다.

## 3. Privacy Safety
- No userId/sessionId/searchQuery in summaries: 집계된 요약 문서(`feed_engagement_summaries`)에는 사용자 개인 정보가 포함되지 않습니다.
- No exact scroll path stored: 사용자의 정확한 스크롤 경로나 뷰포트 위치를 저장하지 않습니다. 오직 '노출 달성' 이벤트만 기록합니다.
- No raw search query stored: 검색어 원문을 노출 이벤트에 남기지 않고, 길이에 따른 버킷(none, short, medium, long)만 전송합니다.
- Only qualified impression event stored: 엄격한 가시성 기준을 통과한 이벤트만 서버에 저장됩니다.

## 4. QA Results
- functions-v2 npm test: `87 passing`
- flutter analyze: `36 issues found (unused imports etc, exit 1)` (No functional issues directly related to P5-S07).
- flutter test test/mozzy_ii/domains/feed/viewport_impression_tracker_test.dart: `All tests passed`
- flutter test test/mozzy_ii/domains/feed/feed_engagement_summary_test.dart: `All tests passed`

## 5. Known Limitations
- 800ms / 50% 기준은 beta 이후조정 가능: 초기 기준이므로 베타 테스트 후 최적의 수치로 변경될 수 있습니다.
- 현재는 per-session local dedup 중심: 앱 클라이언트 세션 안에서만 중복을 방지하며, 서버 레벨의 실시간 디덥 로직은 포함되어 있지 않습니다.
- Real-time aggregation은 여전히 hourly batch: 인게이지먼트 스코어 집계는 1시간 주기의 배치 프로세스로 처리됩니다.

## 6. Next Step
P5-S08 Abuse Detection / Anti-gaming Filters
