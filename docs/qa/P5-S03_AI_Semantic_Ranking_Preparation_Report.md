# P5-S03 — AI Semantic Ranking Preparation & Privacy-Safe Scoring Layer Report

## 1. 구현 요약
AI Semantic Ranking 도입을 위한 준비 단계로, 개인정보 보호(Privacy-Safe)를 고려한 데이터 정규화 계층과 AI 랭킹 신호를 수용할 수 있는 아키텍처를 구축했습니다.

## 2. 생성/수정 파일
- **Models**:
  - `lib/mozzy_ii/domains/feed/models/feed_item_model.dart` (Extended)
  - `lib/mozzy_ii/domains/feed/models/semantic_ranking_payload.dart` (New)
  - `lib/mozzy_ii/domains/feed/models/feed_ranking_signal.dart` (Updated constants)
- **Services**:
  - `lib/mozzy_ii/domains/feed/services/feed_semantic_sanitizer.dart` (New)
  - `lib/mozzy_ii/domains/feed/services/semantic_ranking_adapter.dart` (New Interface)
  - `lib/mozzy_ii/domains/feed/services/mock_semantic_ranking_adapter.dart` (New Mock)
  - `lib/mozzy_ii/domains/feed/services/gemini_semantic_ranking_adapter.dart` (New Skeleton)
  - `lib/mozzy_ii/domains/feed/services/semantic_ranking_service.dart` (New Orchestrator)
  - `lib/mozzy_ii/domains/feed/services/feed_ranking_service.dart` (Updated calculation)
- **Providers**:
  - `lib/mozzy_ii/domains/feed/providers/smart_feed_provider.dart` (Integrated Semantic Ranking)
- **Docs**:
  - `docs/feed/Semantic_Ranking_Privacy_Guide.md` (New)
  - `docs/feed/Smart_Feed_Ranking_ADR.md` (Updated)
  - `docs/qa/P5-S02_Smart_Feed_Home_Integration_Report.md` (SHA Corrected)

## 3. 핵심 구현 내용

### 3.1 FeedItemModel 확장
- `semanticScore` (0~30점), `semanticReason`, `semanticScoredAt` 필드를 추가하여 AI 점수를 반영할 수 있게 했습니다.
- 기존 Rule-based 점수와 결합되어 `finalScore`를 구성합니다.

### 3.2 Privacy-Safe Sanitizer
- AI 서버 전송 전 이메일, 전화번호 패턴을 마스킹(`[EMAIL]`, `[PHONE]`) 처리합니다.
- 설명글을 300자 내외로 Truncate하여 토큰 비용 절감 및 정보 노출을 최소화합니다.
- 상세 주소 대신 `locationText`만 사용하여 위치 정보를 추상화했습니다.

### 3.3 Semantic Ranking Adapter
- **Interface**: AI 랭킹 엔진의 교체 가능성을 위해 어댑터 패턴 적용.
- **Mock**: 키워드 및 도메인 매칭 기반의 결정론적 점수 반환 로직 구현 (테스트용).
- **Gemini Skeleton**: P5-S04에서 Cloud Functions 프록시를 통해 구현될 수 있도록 보안 가이드를 포함한 스켈레톤 작성.

### 3.4 Hybrid Ranking Logic
- AI 점수는 보조 신호로 활용하며, 유료 `boostScore`(100점)의 우선순위를 훼손하지 않도록 가중치를 제한(최대 30점)했습니다.
- 검색 의도(`userIntent`)가 있을 때만 비동기적으로 AI 랭킹을 수행하도록 `SmartFeedProvider`를 확장했습니다.

## 4. 테스트 결과
- **Unit Test**: `feed_semantic_sanitizer_test.dart`, `mock_semantic_ranking_adapter_test.dart`, `semantic_ranking_service_test.dart` 등 신규 테스트 8개 포함 총 24개 Feed 도메인 테스트 통과.
- **Regression Test**: 기존 Jobs, Marketplace, Payments, Admin 도메인 포함 총 173개 테스트 케이스 통과.
- **Analyzer**: 이슈 없음 (Clean).

## 5. Privacy 보호 정책
- 클라이언트에서 직접 Secret Key를 사용하지 않음.
- 전송 데이터 최소화 및 민감 정보 제거 로직 적용.
- `docs/feed/Semantic_Ranking_Privacy_Guide.md`에 세부 내용 문서화.

## 6. Git Status
- **Branch**: main
- **Commit SHA**: (Latest after push)
- **Status**: clean
- **Push 여부**: YES

## 7. 남은 이슈 및 다음 단계
- **P5-S04**: Firebase Cloud Functions를 이용한 Gemini API 실연동.
- **UI Intent Integration**: 검색바 입력을 `smartFeedSearchIntentProvider`와 연동.

**완료 (SUCCESS)**
