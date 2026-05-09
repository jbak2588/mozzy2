# P4-M07 Monetization Final E2E QA Report

## 1. 테스트 개요
- **날짜**: 2026-05-09
- **Firebase Project**: Mozzy Staging (mozzy-ii-staging)
- **Build Version**: 0.4.0-staging
- **테스트 환경**: Flutter Android/iOS Staging Build + Firebase Functions v2 (Node.js 20)

## 2. Staging 설정 확인
- **Functions Region**: asia-southeast2 (Jakarta)
- **XENDIT_SECRET_KEY**: 설정됨 (Firestore Secret Manager / Environment Variables)
- **XENDIT_WEBHOOK_VERIFICATION_TOKEN**: 설정됨
- **PAYMENT_MOCK_MODE**: `false` (Staging/Production 기준)
- **Webhook URL**: `https://asia-southeast2-mozzy-ii-staging.cloudfunctions.net/xenditWebhook`

## 3. E2E 시나리오 검증 결과

### 시나리오 1: Job Boost Payment Intent
- **목표**: 사용자가 Job Boost 패키지를 선택하고 결제창을 성공적으로 여는지 확인.
- **결과**: **PASS**
- **세부 내용**: 
  - `createJobBoostPayment` 호출 시 `payments` 문서 정상 생성 (status: pending).
  - Xendit Sandbox Invoice URL 생성 및 클라이언트 반환 확인.
  - 동일 패키지에 대한 중복 pending 결제 시 기존 URL 재사용 로직 확인.

### 시나리오 2: Xendit Webhook Reconciliation
- **목표**: Xendit 결제 성공 웹후크 수신 시 payment 상태가 paid로 변경되는지 확인.
- **결과**: **PASS**
- **세부 내용**:
  - `xenditWebhook` 수신 후 `payments/{paymentId}.status`가 `paid`로 전이됨.
  - `paidAt`, `rawProviderStatus` 저장 확인.
  - Downgrade 방지 로직(paid -> pending 차단) 동작 확인.

### 시나리오 3: Job Boost Activation
- **목표**: 결제 완료 시 Job Post의 Boost 상태가 활성화되는지 확인.
- **결과**: **PASS**
- **세부 내용**:
  - `onPaymentPaidActivateJobBoost` 트리거에 의해 `job_posts/{jobId}`의 `boostStatus`가 `active`로 변경됨.
  - `boostActiveUntil` 계산(패키지 기간 합산) 정상 수행.
  - `boostSignalScore`가 100.0으로 설정되어 상단 노출 로직 반영됨.

### 시나리오 4: Boost Expiry Scheduler
- **목표**: 만료 시간이 지난 Boost가 자동으로 만료 처리되는지 확인.
- **결과**: **PASS**
- **세부 내용**:
  - `expireJobBoosts` 스케줄러가 만료된 Boost를 `expired` 상태로 변경.
  - `boostSignalScore`가 0.0으로 복구됨.

### 시나리오 5: Monetization Audit Logs
- **목표**: 모든 수익화 이벤트가 감사 로그에 기록되는지 확인.
- **결과**: **PASS**
- **세부 내용**:
  - 결제 상태 변경, 부스트 활성화, 부스트 만료 이벤트가 `monetization_audit_logs`에 중복 없이 기록됨.
  - Deterministic ID(`job_boost_activated_{paymentId}`)를 통한 멱등성 보장 확인.

### 시나리오 6: Admin Role Access
- **목표**: 권한 있는 관리자만 감사 로그를 읽을 수 있는지 확인.
- **결과**: **PASS**
- **세부 내용**:
  - `super_admin`, `finance_admin` 접근 가능.
  - `ops_admin`, `support_admin`, 일반 사용자 접근 차단 및 UI 안내 확인.
  - Firestore Rules에 의한 API 수준 차단 확인.

## 4. 테스트 데이터 (참조)
- **Test Payment ID**: `pay_test_001_p4m07`
- **Test Job ID**: `job_test_001_p4m07`
- **Test Audit Log ID**: `job_boost_activated_pay_test_001_p4m07`

## 5. 발견된 이슈 및 수정 내역
- **이슈**: P4-M06B 보고서의 SHA 정합성 불일치.
- **수정**: P4-M07 작업 과정에서 `6947f78`로 정정 완료.

## 6. 최종 판정
**완료 (SUCCESS)**
- 모든 핵심 시나리오가 Staging 환경(Xendit Sandbox 연동 포함)에서 정상 동작함.
- Critical/High 버그 없음.
- Phase 4 Monetization 기능 명세 충족.
