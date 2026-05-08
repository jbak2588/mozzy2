# P4-M02B — Real Xendit Sandbox Invoice Integration & Report Correction Report

## 1. 구현 요약
P4-M02에서 구축한 Job Boost 결제 흐름을 실제 Xendit Sandbox Invoice API와 연동했습니다. 기존의 Mock 응답 방식을 실제 API 호출 방식으로 전환하여 실제 결제창(Checkout URL)을 생성하고, 중복 결제 방지 및 기존 인보이스 재사용 로직을 추가하여 안정성을 높였습니다. 또한 P4-M02 보고서의 내용을 실제 구현 상태와 일치하도록 수정했습니다.

## 2. 생성/수정 파일
- **Infrastructure & App**:
  - `functions-v2/index.js` (수정: 실제 Xendit API 연동, 중복 결제 방지 로직 추가)
- **Documentation**:
  - `docs/qa/P4-M02_Job_Boost_Payment_Intent_Report.md` (수정: Mock 상태 정정)
  - `docs/qa/P4-M02B_Real_Xendit_Integration_Report.md` (신규: 본 문서)
  - `docs/payments/Payment_Architecture_ADR.md` (수정: P4-M02B 이력 추가)

## 3. 주요 구현 세부 사항

### 3.1. 실제 Xendit Sandbox API 연동
- **Endpoint**: `POST https://api.xendit.co/v2/invoices`
- **인증**: `XENDIT_SECRET_KEY`를 사용한 Basic Auth 적용.
- **데이터 매핑**:
  - `external_id`: `paymentId`와 동일하게 설정하여 Webhook 수신 시 식별 용이성 확보.
  - `success_redirect_url` & `failure_redirect_url`: 앱 딥링크(`mozzy://payments/{paymentId}`) 설정.
  - `metadata`: `jobId`, `packageId`, `ownerId` 등을 포함하여 후속 처리(P4-M04)를 위한 데이터 보존.
- **결과 처리**: 응답받은 `id`, `invoice_url`, `status`, `expiry_date` 등을 `payments` 문서에 저장.

### 3.2. 중복 결제 방지 및 재사용 정책
- 동일한 사용자(`buyerId`)가 동일한 구인글(`jobId`)에 대해 동일한 패키지(`packageId`)로 결제를 요청할 경우:
  - 기존에 `created` 또는 `pending` 상태의 결제 문서가 있는지 확인.
  - 유효한 `providerInvoiceUrl`이 존재하는 경우 새로 생성하지 않고 기존 결제 정보(Invoice URL 포함)를 반환.
  - 이를 통해 PG사측에 불필요한 인보이스 중복 생성을 방지하고 사용자 경험 개선.

### 3.3. Mock Mode 정책
- `process.env.PAYMENT_MOCK_MODE === "true"` 환경에서만 Mock 인보이스를 생성함.
- 실제 환경에서 `XENDIT_SECRET_KEY`가 누락된 경우 조용히 Mock으로 대체하지 않고 `failed-precondition` 에러를 반환하여 설정 오류를 명시적으로 알림.

## 4. Secret / Environment 설정 방법
Cloud Functions 배포 시 다음 환경 변수 설정이 필요합니다:
- `XENDIT_SECRET_KEY`: Xendit Dashboard에서 발급받은 Sandbox Secret Key.
- `PAYMENT_MOCK_MODE`: (선택) `"true"`로 설정 시 실제 API 호출 없이 Mock 동작.

```bash
firebase functions:config:set xendit.secret_key="xnd_development_..."
# 또는 functions-v2 환경 변수 설정 방식에 따름
```

## 5. 테스트 결과
- **Functions Unit Test**:
  - `npm test` 결과 4개 테스트 모두 PASS.
  - `createJobBoostPayment` 내보내기 및 구조 검증 완료.
- **Flutter Analyze**: 0 Issues.
- **Flutter Test**: 
  - `boost_package_model_test.dart`: PASS
  - `job_boost_purchase_screen_test.dart`: PASS
  - Jobs/Payments 도메인 관련 테스트 전원 PASS.

## 6. Firestore Rules 확인
- `payments` 컬렉션은 여전히 클라이언트 측 쓰기가 차단되어 있으며, 오직 서버(Cloud Functions)를 통해서만 인보이스 정보가 업데이트됨을 확인.

## 7. 남은 이슈
- **P4-M03 Webhook Reconciliation**: Xendit의 결제 완료 알림을 수신하여 `payments` 문서 상태를 `paid`로 자동 전환하는 기능 필요.
- **P4-M04 Boost Activation**: `paid` 상태 확인 시 실제 구인글의 노출 가중치(signalScore) 및 만료 시간 업데이트 로직 필요.

## 8. Git 정보
- **Commit SHA**: 5ae9659
- **Push 여부**: YES
- **Git Status Clean**: YES

---
**작성일**: 2026-05-08
**담당 에이전트**: Antigravity
