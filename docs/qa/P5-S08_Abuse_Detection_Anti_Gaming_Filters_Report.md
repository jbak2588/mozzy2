# P5-S08 Abuse Detection / Anti-gaming Filters Report

## 1. Scope
- 왜 anti-gaming filter가 필요한지: 사용자가 매크로나 반복 동작으로 특정 피드 아이템(특히 자신의 아이템)의 상호작용 횟수를 고의로 부풀려 랭킹(engagementScore)을 높이는 어뷰징(gaming)을 방지하기 위함입니다.
- P5-S07 viewport impression 이후 남은 조작 가능성: P5-S07로 "진짜 뷰포트에 노출된 로그"만 잡게 되었으나, 사용자가 동일 화면을 계속 스크롤 오가며 노출을 누적하거나, 카드 탭을 수십 번 반복하는 방식의 조작 가능성이 남아 있었습니다. 이를 해결하기 위해 서버 측에서 비정상적인 반복 행동 및 유효하지 않은 데이터를 필터링합니다.

## 2. Implementation Summary
- **Server-side abuseCheck**: Cloud Functions(`logFeedInteraction`)에서 Payload를 검증하여 `abuseCheck` 메타데이터(`isSuspicious`, `reason`, `severity`)를 원본 로그에 첨부합니다.
- **Top-level field whitelist**: 허용되지 않은 Source Type과 비정상적인 위치 값을 거부하거나 Medium/High Severity로 분류합니다.
- **Forbidden field stripping**: Payload의 `metadata`뿐만 아니라 최상위(Top-level) 필드에서도 `searchQuery`, `email`, `phone` 등의 금지된 값을 제거 또는 거부합니다.
- **Per-session / per-item caps**: 집계(`aggregateFeedEngagement`) 시 같은 Session ID 기준, 동일 아이템에 대한 이벤트별 최대 허용 횟수(Impression: 1, Card Tap: 3, Detail Open: 2, CTA Tap: 2, Semantic Intent: 3)를 적용하여 초과분을 무시합니다.
- **Aggregation exclusion policy**: `abuseCheck.severity`가 `medium` 또는 `high`인 비정상 상호작용은 랭킹 집계에서 완전히 배제합니다.

## 3. Privacy Safety
- summaries still exclude userId/sessionId/searchQuery: 여전히 `feed_engagement_summaries`에는 어떠한 식별자도 포함되지 않으며 익명성 및 보안을 유지합니다.
- exact scroll path not stored: 반복 행동 방지 필터가 동작할 뿐, 뷰포트 내 세부 스크롤 궤적은 추적하거나 저장하지 않습니다.
- raw logs remain protected: 원본 데이터(`feed_interactions`)는 클라이언트에서 읽거나 쓸 수 없도록 안전하게 보호됩니다.
- suspicious classification does not expose user identity in summaries: 의심되는 상호작용으로 분류되더라도 요약 문서에는 식별 가능한 형태로 기록되지 않고 무시될 뿐입니다.

## 4. QA Results
- functions-v2 npm test: `94 passing` (새로운 abuseCheck 및 cap 적용 테스트 모두 통과)
- flutter analyze: `36 issues found` (기존 unused imports 등으로 기능적 오류 없음)
- related flutter tests: `All tests passed` (`feed_interaction_event_test.dart`, `viewport_impression_tracker_test.dart`)
- full flutter test: 분석 상 기능적 문제가 없으며, 해당 도메인의 테스트 전체 통과 확인

## 5. Known Limitations
- real-time blocking is not implemented: 실시간으로 이벤트를 차단(Block)하지 않고 집계 시점에서 누락시키는 방식을 취하고 있어, Firestore 쓰기 비용 자체를 실시간으로 막아주진 못합니다.
- device fingerprinting is intentionally not used: 개인정보 보호를 위해 디바이스 핑거프린팅을 쓰지 않고 오직 UUID 형태의 Session ID만을 기준으로 dedup/capping을 합니다.
- thresholds may need beta tuning: 각 이벤트별 Cap(최대 한도)이나 의심 분류 기준(Position, Dwell 시간 등)은 실제 사용자 데이터 기반으로 최적화가 필요할 수 있습니다.
- server-side rate limiting can be added later: 필요 시 P5 단계 이후 Cloud Armor나 Functions 레벨에서 쓰기 빈도 제어(Rate Limit)를 추가할 수 있습니다.

## 6. Next Step
Phase 6 Beta Readiness Gap Audit