# P5-S06 — Smart Feed Engagement Signal Aggregation Report

## 1. 구현 요약
수집된 `feed_interactions` 데이터를 바탕으로 콘텐츠별 참여 지표를 집계하고, 이를 Smart Feed의 `engagementScore`에 반영하는 기반 시스템을 구축했습니다.

## 2. 생성/수정 파일
- `functions-v2/index.js`: `aggregateFeedEngagement` 스케줄 함수 및 집계 로직 추가.
- `firestore.rules`: `feed_engagement_summaries` 컬렉션 보안 규칙 추가.
- `firestore.indexes.json`: `feed_interactions` 집계용 인덱스 추가.
- `lib/mozzy_ii/domains/feed/models/feed_engagement_summary.dart`: 집계 데이터 모델.
- `lib/mozzy_ii/domains/feed/repositories/feed_engagement_repository.dart`: 레포지토리 인터페이스.
- `lib/mozzy_ii/domains/feed/repositories/firestore_feed_engagement_repository.dart`: Firestore 구현체 (chunked whereIn 적용).
- `lib/mozzy_ii/domains/feed/providers/feed_engagement_provider.dart`: 리버팟 프로바이더.
- `lib/mozzy_ii/domains/feed/providers/smart_feed_provider.dart`: 랭킹 시 집계 데이터 결합 로직 추가.

## 3. aggregateFeedEngagement 구조
- **Type**: Scheduled Function (every 1 hour).
- **Window**: 최근 7일간의 상호작용 데이터 집계.
- **Aggregation Logic**: `sourceType + sourceId` 기준으로 그룹화하여 각 이벤트 타입별 count 계산.
- **Batch Update**: 집계된 결과를 `feed_engagement_summaries` 컬렉션에 batch write로 업데이트.

## 4. feed_engagement_summaries Schema
```json
{
  "id": "{sourceType}_{sourceId}",
  "sourceType": "string",
  "sourceId": "string",
  "feedItemId": "string",
  "impressionCount": "number",
  "cardTapCount": "number",
  "detailOpenCount": "number",
  "cta_tapCount": "number",
  "semanticIntentCount": "number",
  "engagementScore": "number (max 30.0)",
  "uniqueSessionCount": "number",
  "lastInteractionAt": "timestamp",
  "lastAggregatedAt": "timestamp",
  "window": "all_time"
}
```

## 5. Engagement Score 계산 정책
- **Weights**:
  - Impression: 0.1
  - Card Tap: 2.0
  - Detail Open: 3.0
  - CTA Tap: 5.0
  - Semantic Intent Bonus: 0.5
- **Clamp**: 최종 점수는 최대 30.0점으로 제한하여 유료 Boost(100.0)의 가치를 훼손하지 않도록 함.

## 6. Smart Feed Ranking 연결 방식
1. `smartFeedProvider`에서 Feed 아이템 목록 조회.
2. 각 아이템의 `sourceType_sourceId`에 해당하는 engagement summary를 Firestore에서 watch (RxDart `switchMap` 및 `CombineLatestStream` 활용).
3. 아이템 모델의 `engagementScore` 필드에 집계된 점수 주입.
4. `FeedRankingService`에서 `engagementScore`를 합산하여 최종 정렬 점수 산출.

## 7. Privacy Policy
- **User Anonymity**: Summary 데이터에는 `userId`, `sessionId`, `searchQuery` 원문이 포함되지 않음.
- **Data Minimization**: 랭킹 품질 개선에 필요한 최소한의 집계 수치만 저장.
- **Access Control**: 클라이언트는 인증된 경우에만 읽기 가능, 직접 쓰기는 전면 차단.

## 8. 테스트 결과
- **Node.js (Mocha)**: 76 passing (집계 로직 및 스코어 계산 검증 완료).
- **Flutter Model/Service**: `FeedEngagementSummary` 파싱 및 `FeedRankingService` 점수 반영 검증 완료.
- **Build Runner**: 코드 생성 성공.

## 9. 남은 이슈
- **Real-time Aggregation**: 현재는 1시간 단위 집계이므로 실시간 반응성이 낮음 (향후 Trigger 기반 집계 고려 가능).
- **Abuse Detection**: 중복 클릭이나 매크로에 의한 점수 조작 방지 로직 고도화 필요.

## 10. Git Status
- **Branch**: main
- **Commit SHA**: [COMMIT_SHA]
- **Status**: clean
- **Push 여부**: YES
