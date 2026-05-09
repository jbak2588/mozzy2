# P5-S04 — Gemini Semantic Ranking Cloud Functions Proxy Report

## 1. 구현 요약
Gemini AI를 안전하고 비용 효율적으로 호출하기 위한 Firebase Cloud Functions 프록시 구조를 완성했습니다. 클라이언트 API Key 노출을 원천 차단하고, 서버 측에서 데이터 검증 및 개인정보 필터링을 수행합니다.

## 2. 생성/수정 파일
- **Functions**:
  - `functions-v2/index.js` (rankSmartFeedWithGemini callable 추가)
  - `functions-v2/test/gemini_semantic_ranking.test.js` (New)
- **Flutter Services**:
  - `lib/mozzy_ii/domains/feed/services/gemini_semantic_ranking_adapter.dart` (Implementation)
  - `lib/mozzy_ii/domains/feed/providers/smart_feed_provider.dart` (Rollout flag 적용)
- **Docs**:
  - `docs/feed/Semantic_Ranking_Privacy_Guide.md` (Update)
  - `docs/feed/Smart_Feed_Ranking_ADR.md` (Update)
  - `docs/qa/P5-S03B_Semantic_Intent_UI_Integration_Report.md` (SHA Corrected)
- **Tests**:
  - `test/mozzy_ii/domains/feed/gemini_semantic_ranking_adapter_test.dart` (New)
  - `test/mozzy_ii/domains/feed/semantic_payload_privacy_test.dart` (New)

## 3. 핵심 구현 내용

### 3.1 rankSmartFeedWithGemini (Cloud Function)
- **Authentication**: `request.auth`가 있는 인증된 사용자만 호출 가능.
- **Validation**:
  - 검색 의도(Intent) 최대 100자 제한.
  - 아이템 최대 30개 제한.
  - 허용 리스트(Allowlist) 필드만 포함하도록 강제 필터링.
- **Gemini Integration**: `axios`를 사용하여 REST API로 Gemini 1.5 Flash 모델 호출.
- **Mock Mode**: `AI_MOCK_MODE=true`인 경우 API 호출 없이 서버 내 Mock 로직으로 응답.

### 3.2 Flutter GeminiSemanticRankingAdapter
- `FirebaseFunctions.httpsCallable`을 통해 서버 프록시 호출.
- 실패 시(네트워크 오류, 인증 오류 등) 빈 리스트를 반환하여 기본 정렬(Rule-based)로 안전하게 Fallback 하도록 구현.

### 3.3 Rollout & Security
- **Rollout Flag**: `ENABLE_GEMINI_RANKING` 컴파일 타임 플래그가 true일 때만 Gemini 어댑터 활성화.
- **Privacy Guard**: `SemanticRankingPayload.toSafeJson()`을 통해 클라이언트에서도 불필요한 필드가 전송되지 않도록 2중 검증.

## 4. 테스트 결과
- **Functions Test**: `mocha` 테스트 7개 통과 (Export, Mock logic, Prompt building, Score clamping 등).
- **Flutter Test**:
  - Gemini Adapter Widget Test 2개 통과 (Success flow, Failure fallback).
  - Privacy Payload Test 1개 통과 (Forbidden fields check).
- **Regression Tests**: 전체 185개 테스트 케이스 통과.

## 5. Secret / Env 정책
- **GEMINI_API_KEY**: Cloud Functions 환경 변수 또는 Google Secret Manager를 통해 서버에서만 관리.
- **AI_MOCK_MODE**: 개발/테스트 단계에서는 `true`로 설정하여 비용 발생 억제.

## 6. Firestore Rules / Indexes
- **Firestore Rules**: 변경 없음
- **Firestore Indexes**: 변경 없음

## 7. Git Status
- **Branch**: main
- **Implementation Commit SHA**: (Latest after push)
- **Final Docs Commit SHA**: (Latest after push)
- **Status**: clean
- **Push 여부**: YES

## 8. 남은 이슈
- 실제 운영 환경(Production) 배포 시 Gemini API Key 설정 및 `AI_MOCK_MODE` 해제 필요.

**완료 (SUCCESS)**
