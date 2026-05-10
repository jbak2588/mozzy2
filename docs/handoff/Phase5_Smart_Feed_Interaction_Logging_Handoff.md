# Phase 5: Smart Feed Interaction Logging Handoff

## 1. 개요 (Scope)
사용자가 Smart Feed에서 수행하는 상호작용(노출, 클릭 등)을 수집하여 향후 랭킹 고도화 및 사용자 경험 분석의 기초 데이터로 활용하기 위한 로깅 시스템을 구축했습니다.

## 2. 구현된 기능
- **Multi-domain Logging**: Jobs, Marketplace 등 다양한 도메인 아이템에 대한 통합 로깅.
- **Privacy-safe Architecture**: 민감 정보(PII)를 클라이언트와 서버에서 2중으로 필터링.
- **Non-blocking Logging**: UI 스레드와 내비게이션을 방해하지 않는 비동기 로깅 구현.
- **Session Management**: UUID 기반의 휘발성 세션 관리를 통해 사용자 동선 추적 기반 마련.
- **Engagement Aggregation**: Raw 로그를 1시간 주기로 집계하여 콘텐츠별 인기도(`engagementScore`)를 자동 산출.

## 3. 핵심 구조 (Architecture)

### 3.1 Cloud Functions (`logFeedInteraction`, `aggregateFeedEngagement`)
- **Logging**: Callable Function을 통해 상호작용 로그 수집.
- **Aggregation**: Scheduled Function을 통해 최근 7일간의 데이터를 집계하여 `feed_engagement_summaries` 생성.
- **Validation**: `isValidEngagementInteraction` 헬퍼를 통해 비정상 데이터 원천 차단.

### 3.2 Schema (`feed_engagement_summaries`)
```json
{
  "id": "{sourceType}_{sourceId}",
  "sourceType": "string",
  "sourceId": "string",
  "feedItemId": "string",
  "impressionCount": "number",
  "cardTapCount": "number",
  "detailOpenCount": "number",
  "ctaTapCount": "number",
  "semanticIntentCount": "number",
  "engagementScore": "number (max 30.0)",
  "uniqueSessionCount": "number",
  "lastInteractionAt": "timestamp",
  "lastAggregatedAt": "timestamp",
  "window": "all_time"
}
```

## 4. Privacy Policy
- **Anonymized Summaries**: 집계 테이블에는 `userId`, `sessionId` 등의 식별 정보가 포함되지 않음.
- **Intent Masking**: 검색 의도(Intent) 원문 대신 보너스 점수 가산 여부만 집계.
- **Strict Access**: `firestore.rules`를 통해 summary 데이터에 대한 클라이언트의 쓰기 권한 전면 차단.

## 5. 현재 한계 및 특이사항
- **Approximate Impression**: 리스트 빌더 호출 시점을 기준으로 기록하므로, 실제 Viewport 노출 시간은 미반영.
- **Batch Frequency**: 현재 1시간 주기 집계이므로 실시간 반응성(Real-time feedback)에는 한계가 있음.

## 6. 다음 단계 제안
- **P5-S07 Detailed Impression**: Viewport visibility detection을 통한 정밀 노출 로깅 도입.
- **Abuse Detection**: 매크로 등을 통한 점수 조작 방지 필터링 고도화.
- **Personalized Ranking**: 수집된 인기도 데이터를 넘어 사용자별 취향을 반영하는 개인화 엔진 도입.

## Final Status
P5-S06B Engagement Aggregation Runtime QA is complete.
The data feedback loop (Raw Log → Aggregated Summary → Smart Feed Ranking) is fully verified and functional in the Staging environment.
