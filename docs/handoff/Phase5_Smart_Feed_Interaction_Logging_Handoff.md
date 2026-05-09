# Phase 5: Smart Feed Interaction Logging Handoff

## 1. 개요 (Scope)
사용자가 Smart Feed에서 수행하는 상호작용(노출, 클릭 등)을 수집하여 향후 랭킹 고도화 및 사용자 경험 분석의 기초 데이터로 활용하기 위한 로깅 시스템을 구축했습니다.

## 2. 구현된 기능
- **Multi-domain Logging**: Jobs, Marketplace 등 다양한 도메인 아이템에 대한 통합 로깅.
- **Privacy-safe Architecture**: 민감 정보(PII)를 클라이언트와 서버에서 2중으로 필터링.
- **Non-blocking Logging**: UI 스레드와 내비게이션을 방해하지 않는 비동기 로깅 구현.
- **Session Management**: UUID 기반의 휘발성 세션 관리를 통해 사용자 동선 추적 기반 마련.

## 3. 핵심 구조 (Architecture)

### 3.1 Cloud Functions (`logFeedInteraction`)
- **Type**: Callable Function (2nd Gen)
- **Validation**: `sanitizeFeedInteractionPayload`를 통해 데이터 정합성 검증.
- **Storage**: `feed_interactions` Firestore 컬렉션에 데이터 저장.
- **Security**: Admin SDK를 사용하여 클라이언트 권한 없이도 안전하게 쓰기 수행.

### 3.2 Schema (`feed_interactions`)
```json
{
  "userId": "string (UID)",
  "sessionId": "string (UUID)",
  "eventType": "string (impression | card_tap | detail_open | cta_tap)",
  "feedItemId": "string",
  "sourceId": "string",
  "sourceType": "string",
  "route": "string",
  "position": "number (0-100)",
  "isPromoted": "boolean",
  "hasSemanticIntent": "boolean",
  "intentLengthBucket": "string (none | short | medium | long)",
  "metadata": "object (sanitized)",
  "clientCreatedAt": "timestamp",
  "createdAt": "serverTimestamp"
}
```

## 4. Privacy Policy
- **Intent Protection**: 사용자의 검색 의도(Intent) 원문은 절대 저장하지 않으며, 존재 여부와 길이 버킷만 기록합니다.
- **PII Filtering**: `email`, `phone`, `exactAddress` 등의 필드는 메타데이터에서 자동 제외됩니다.
- **Direct Access Block**: `firestore.rules`를 통해 클라이언트의 직접적인 로깅 데이터 접근을 완전히 차단했습니다.

## 5. 현재 한계 및 특이사항
- **Approximate Impression**: 리스트 빌더의 `itemBuilder` 호출 시점을 기준으로 기록하므로, 실제 눈에 보인 시간(Dwell time)은 반영되지 않습니다.
- **No Aggregation**: 현재는 Raw Log 수집 단계이며, 실시간 집계(Aggregation)는 Phase 5-S06에서 진행될 예정입니다.
- **No Rate Limiting**: 클라이언트 측의 과도한 호출에 대한 별도의 제한 로직이 없으므로 모니터링이 필요합니다.

## 6. 다음 단계 제안
- **P5-S06 Engagement Aggregation**: 수집된 로그를 바탕으로 아이템별 `engagementScore`를 계산하여 랭킹에 반영.
- **P5-S07 Detailed Impression**: Viewport visibility detection을 통한 정밀 노출 로깅 도입.
- **BigQuery Export**: 대규모 데이터 분석을 위한 Firestore-to-BigQuery 연동.

## Final Status
P5-S05 Interaction Logging line is complete after P5-S05C runtime QA. Raw interaction events are now ready for aggregation in P5-S06.
