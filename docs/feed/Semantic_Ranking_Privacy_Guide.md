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
- **Server Proxy 사용**: 모든 AI Ranking 요청은 Firebase Cloud Functions 또는 백엔드 프록시를 통해서만 수행되어야 합니다 (P5-S04 구현 예정).
- **Mocking**: 개발 및 테스트 환경에서는 `MockSemanticRankingAdapter`를 사용하여 실제 외부 API 호출 없이 기능을 검증합니다.

## 4. 비용 및 통제
- **Intent-based Execution**: 무분별한 API 호출을 방지하기 위해 사용자 의도(Search Intent)가 명확한 경우에만 AI Ranking을 실행합니다.
- **Score Limitation**: AI 점수는 기존 Rule-based 점수 체계를 보조하는 용도로만 사용하며, 최대 30점 이내로 가중치를 제한합니다.

---
최종 수정일: 2026-05-09
상태: P5-S03 준비 단계 반영
