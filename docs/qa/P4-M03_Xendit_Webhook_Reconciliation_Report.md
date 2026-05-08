# P4-M03 — Xendit Webhook Reconciliation & Payment Status Sync Report

## 1. 구현 요약
Xendit PG사로부터 수신되는 결제 상태 변경 알림(Webhook)을 처리하여 시스템 내 `payments` 문서의 상태를 실시간으로 동기화하는 기능을 구현했습니다. 보안을 위해 Xendit Callback Token 검증을 수행하며, 상태 전환 로직(Precedence)을 통해 데이터 무결성을 보장합니다.

## 2. 생성/수정 파일
- **Infrastructure & App**:
  - `functions-v2/index.js` (수정: `xenditWebhook` HTTP 함수 추가, 상태 매핑 로직 추가)
  - `assets/translations/id.json`, `en.json`, `ko.json` (수정: 결제 확인 관련 i18n 키 추가)
- **Tests**:
  - `functions-v2/test/xendit_webhook.test.js` (신규: 웹후크 헬퍼 유닛 테스트)
- **Documentation**:
  - `docs/qa/P4-M03_Xendit_Webhook_Reconciliation_Report.md` (신규: 본 문서)
  - `docs/payments/Payment_Architecture_ADR.md` (수정: 웹후크 정책 추가)

## 3. 구현 세부 사항

### 3.1. xenditWebhook HTTP Endpoint
- **URL**: `POST /xenditWebhook`
- **인증**: `x-callback-token` 헤더와 서버 환경변수 `XENDIT_WEBHOOK_VERIFICATION_TOKEN` 비교 검증.
- **Mock Mode**: `PAYMENT_MOCK_MODE === "true"`인 경우 토큰 검증을 건너뛰어 테스트 용이성 확보.

### 3.2. 상태 매핑 (Xendit -> Mozzy)
| Xendit Status | Mozzy PaymentStatus | 비고 |
|---|---|---|
| PAID, SETTLED | paid | 최종 결제 완료 |
| EXPIRED | expired | 인보이스 만료 |
| FAILED | failed | 결제 실패 |
| PENDING, ACTIVE | pending | 결제 대기 중 |

### 3.3. 무결성 및 멱등성 정책
- **Firestore Transaction**: 상태 업데이트 시 트랜잭션을 사용하여 동시성 제어.
- **Status Downgrade 방지**: 이미 `paid`, `failed`, `expired` 등 최종 상태에 도달한 문서는 하위 상태(`pending`)로 전환되지 않음.
- **Exception (Expired -> Paid)**: 만료 후 실제 결제가 발생한 특이 케이스의 경우 비즈니스 가치를 우선하여 `paid` 전환 허용.
- **Amount Validation**: Webhook 페이로드의 금액과 DB 내 결제 요청 금액이 일치하지 않는 경우 `paid` 전환 차단 및 경고 로그 기록.

## 4. 테스트 결과
- **Functions Unit Test**: `mapXenditInvoiceStatus`, `shouldSkipUpdate` 로직 검증 완료 (8개 케이스).
- **Total Functions Tests**: 19 passing.
- **Flutter Analyze**: 0 Issues.
- **Flutter Test**: Payments/Jobs/Monetization 관련 29개 테스트 전원 PASS.

## 5. Staging 확인 가이드
1. Firebase Functions 환경변수 설정:
   ```bash
   firebase functions:secrets:set XENDIT_WEBHOOK_VERIFICATION_TOKEN
   ```
2. Xendit Dashboard에 Webhook URL 등록: `https://<region>-<project>.cloudfunctions.net/xenditWebhook`
3. Sandbox 결제 시뮬레이션 후 `payments` 컬렉션의 `status` 필드가 실시간으로 변경되는지 확인.
4. 앱의 `PaymentStatusScreen`에서 결제 완료 아이콘(초록색 체크)이 나타나는지 확인.

## 6. 남은 이슈
- **P4-M04 Boost Activation**: `payments` 상태가 `paid`로 변경됨을 트리거로 하여 실제 `job_posts`의 부스트 필드를 업데이트하는 로직 구현 필요.

## 7. Git 정보
- **Commit SHA**: [SHA를 작업 완료 보고 시 기입 예정]
- **Push 여부**: YES
- **Git Status Clean**: YES

---
**작성일**: 2026-05-08
**담당 에이전트**: Antigravity
