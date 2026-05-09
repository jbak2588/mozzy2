# Semantic Ranking Privacy Guide

이 문서는 Mozzy Smart Feed의 AI Semantic Ranking 구현 시 준수해야 하는 개인정보 보호 가이드라인을 정의합니다.

## 1. 데이터 최소화 원칙 (Data Minimization)
AI Ranking을 위해 외부 API(예: Gemini)로 전송되는 데이터는 서비스 제공에 반드시 필요한 최소한의 정보로 제한되어야 합니다.

### 1.1 전송 허용 데이터 (Allowlist)
- `feedItemId`, `sourceId`: 결과 매핑을 위한 식별자
- `type`: 콘텐츠 유형 (job, marketplaceProduct 등)
- `title`: 콘텐츠 제목
- `publicSummary`: `FeedSemanticSanitizer`에 의해 정규화된 요약문
- `category`: 카테고리 정보
- `locationHint`: 대략적인 위치 텍스트 (상세 주소 제외)
- `isPromoted`, `isTrusted`: 비즈니스 신호 플래그
- `ageBucket`: 생성 시점 버킷 (new, recent, week, old)
- `languageCode`: 요청 언어

### 1.2 전송 금지 데이터 (Blocklist)
- **PII (Personally Identifiable Information)**:
  - 전화번호 (Phone numbers)
  - 이메일 주소 (Email addresses)
  - 상세 주소 (Exact addresses)
  - NIK 또는 기타 신원 정보
- **IDs**:
  - `userId`, `ownerId` 등 사용자 식별 원문 데이터
- **Private Content**:
  - 채팅 내용 (Chat logs)
  - 결제 정보 (Payment data)
  - 관리자 로그 (Audit logs)

## 2. FeedSemanticSanitizer 역할
`FeedSemanticSanitizer`는 데이터를 AI 서버로 보내기 전 아래의 보호 조치를 수행합니다.

- **패턴 제거**: 정규 표현식을 사용하여 이메일 및 전화번호 패턴을 마스킹(`[EMAIL]`, `[PHONE]`)합니다.
- **길이 제한**: 프롬프트 토큰 최적화 및 정보 유출 방지를 위해 텍스트를 300자 이내로 자릅니다.
- **위치 추상화**: 위경도 좌표 대신 추상화된 `locationText`만 사용하여 상세 위치 노출을 방지합니다.

## 3. 보안 아키텍처
- **Client-side Secret 금지**: Gemini API Key 등 민감한 API Key를 Flutter 클라이언트 코드에 직접 포함하지 않습니다.
- **Server Proxy 사용**: 모든 AI Ranking 요청은 Firebase Cloud Functions (`rankSmartFeedWithGemini`) 프록시를 통해서만 수행됩니다.
- **Request Validation**: 서버 측에서 `request.auth`를 필수로 확인하며, 허용되지 않은 필드(Blocklist)가 포함된 경우 요청을 거부하거나 필터링합니다.

## 4. 비용 및 통제
- **Intent-based Execution**: 무분별한 API 호출을 방지하기 위해 사용자 의도(Search Intent)가 명확한 경우에만 AI Ranking을 실행합니다.
- **Batch Limitation**: 한 번의 요청당 최대 30개의 아이템으로 제한하여 API 비용 및 응답 속도를 최적화합니다.
- **Score Limitation**: AI 점수는 기존 Rule-based 점수 체계를 보조하는 용도로만 사용하며, 최대 30점 이내로 가중치를 제한합니다.

## 5. 검색 의도(Intent) 데이터 처리
- **Intent Sanitization**: 사용자가 입력한 검색 의도 데이터 또한 100자 이하의 길이 제한을 적용하여 남용을 방지합니다.
- **Log Retention**: 사용자의 검색 의도를 영구 저장하거나 로그로 수집하지 않습니다.

## 6. Rollout 정책
- **Feature Flag**: `ENABLE_GEMINI_RANKING` 컴파일 타임 플래그를 통해 활성화 여부를 제어합니다.
- **Mock Fallback**: API Key가 없거나 `AI_MOCK_MODE`가 활성화된 경우 서버 측 Mock 로직을 통해 결정론적 결과를 반환하여 안정성을 유지합니다.

## 7. P5-S04B 검증 및 하드닝
- **Prompt Privacy**: 서버 측 `sanitizeSemanticRankingItems`를 통해 허용되지 않은 필드가 프롬프트 JSON에 포함되는 것을 원천 차단합니다.
- **Strict Limits**: 클라이언트와 서버 모두에서 요청당 최대 30개 아이템, 검색 의도 100자 제한을 강제합니다.
- **Safe Fallback**: API 장애나 부적절한 응답(Malformed JSON) 발생 시, 시스템은 즉시 빈 결과를 반환하고 기존 Rule-based 랭킹 체계로 Fallback 합니다.

## 8. P5-S04C E2E Privacy 검증 완료
- **Sanitization Check**: `FeedSemanticSanitizer`를 통해 전송 전 데이터 마스킹이 정상 수행됨을 확인했습니다.
- **Log Masking**: Functions 로그에 민감정보나 API Key가 노출되지 않음을 확인했습니다.
- **Intent Storage**: 사용자의 검색 Intent는 랭킹 계산을 위한 휘발성 데이터로만 사용되며, DB에 저장되지 않음을 보장합니다.

## 9. P5-S04D 모델 표준화 및 Secret 관리
- **Standard Model**: `gemini-3-flash-preview` 모델을 표준으로 사용하며, 서버 환경 변수를 통해 모델명을 제어합니다.
- **Secret Management**: `GEMINI_API_KEY`는 Firebase Secret Manager를 통해 관리하며, 클라이언트와 격리된 환경에서만 사용됩니다.

---
최종 수정일: 2026-05-09
상태: P5-S04D Gemini Model & Secret Setup 단계 반영
