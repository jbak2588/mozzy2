# P5-S04B — Gemini Proxy Staging Validation & Test Hardening Report

## 1. 구현 요약
Gemini Cloud Functions 프록시의 Staging 배포 안정성을 확보하기 위해 서버/클라이언트 양측의 하드닝 작업을 완료했습니다. 프롬프트 프라이버시 검증을 강화하고, 비정상 응답에 대한 안전한 Fallback 구조를 확립했습니다.

## 2. 생성/수정 파일
- **Functions**:
  - `functions-v2/index.js` (Helper 모듈화 및 Refactoring)
  - `functions-v2/test/gemini_semantic_ranking.test.js` (테스트 케이스 대폭 보강)
- **Flutter**:
  - `lib/mozzy_ii/domains/feed/services/gemini_semantic_ranking_adapter.dart` (Hardening 적용)
- **Docs**:
  - `docs/feed/Gemini_Ranking_Staging_Setup.md` (New: Staging 가이드)
  - `docs/feed/Semantic_Ranking_Privacy_Guide.md` (하드닝 정책 반영)
  - `docs/feed/Smart_Feed_Ranking_ADR.md` (P5-S04B 단계 추가)
  - `docs/qa/P5-S04_Gemini_Semantic_Ranking_Proxy_Report.md` (SHA 수정)

## 3. 하드닝 상세 내용

### 3.1 Cloud Functions (Server-side)
- **Modular Helpers**: `normalizeSemanticIntent`, `sanitizeSemanticRankingItems`, `parseGeminiRankingResponse` 등 핵심 로직을 분리하여 유닛 테스트 가능성을 확보했습니다.
- **Privacy Enforcement**: `sanitizeSemanticRankingItems`에서 허용 리스트(Allowlist)를 강제하여 `ownerId`, `email` 등 금지 필드가 프롬프트에 포함되지 않도록 차단했습니다.
- **Robust Parsing**: Gemini의 응답이 JSON 형식이 아니거나 예상 필드가 누락된 경우 Crash 없이 안전하게 에러를 처리하고 빈 결과를 반환합니다.

### 3.2 Flutter Adapter (Client-side)
- **Empty Input Handling**: 검색 의도가 공백이거나 페이로드가 비어있는 경우 불필요한 네트워크 호출을 사전에 차단합니다.
- **Item Truncation**: 클라이언트에서도 최대 30개 아이템 제한을 적용하여 데이터 전송량을 최적화했습니다.
- **Score Clamping**: 서버와 클라이언트 양측에서 AI 점수를 0~30 범위로 강제 고정(Clamp)합니다.
- **Safe Fallback**: `FirebaseFunctionsException` 및 일반 예외 상황에서 빈 리스트를 반환하여 사용자가 기존 Rule-based 피드를 계속 이용할 수 있도록 보장합니다.

## 4. Staging 설정 가이드
- `docs/feed/Gemini_Ranking_Staging_Setup.md`를 통해 `AI_MOCK_MODE`와 `ENABLE_GEMINI_RANKING` 플래그를 활용한 단계별 검증 절차를 문서화했습니다.

## 5. 테스트 결과
- **Functions Test**: 57개 테스트 PASS (Gemini 관련 15개 케이스 포함: Validation, Privacy, Parsing 등).
- **Flutter Test**:
  - `gemini_semantic_ranking_adapter_test.dart`: 7개 테스트 PASS.
  - `semantic_payload_privacy_test.dart`: 2개 테스트 PASS.
- **Regression Tests**: 전체 191개 테스트 케이스 PASS.

## 6. Firestore Rules / Indexes
- **Firestore Rules**: 변경 없음
- **Firestore Indexes**: 변경 없음

## 7. Git Status
- **Branch**: main
- **Implementation Commit SHA**: d3ee69b
- **Final Docs Commit SHA**: 5d23f23
- **Status**: clean
- **Push 여부**: YES

## 8. 남은 이슈
- Staging 환경 배포 후 실제 `AI_MOCK_MODE=false` 설정에서의 Gemini 1.5 Flash 응답 품질 및 속도 최종 확인 필요.

**완료 (SUCCESS)**
