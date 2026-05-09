# Phase 4 Monetization Handoff Document

## 1. 개요
본 문서는 Mozzy 프로젝트 Phase 4 (Monetization)의 구현 결과물을 요약하고, 다음 개발 단계 및 운영을 위한 인수인계 사항을 담고 있습니다.

## 2. 구현 완료 범위
- **Payment Foundation**: 다중 PG 대응이 가능한 추상화 구조 및 `PaymentModel` 표준 확립.
- **Xendit 연동**: Sandbox 환경의 Invoice 생성, 결제창 연동, 웹후크 동기화 구현.
- **Job Boost**: 구인 공고 유료 홍보 시스템(구매 → 활성화 → 상단 노출 → 자동 만료).
- **Monetization Audit**: 모든 수익화 관련 상태 변화를 추적하는 읽기 전용 감사 로그 시스템.
- **Admin Role Guard**: Custom Claims 기반의 관리자 역할 분담(Super, Finance, Ops, Support) 및 접근 제어.

## 3. 핵심 기술 명세

### A. Cloud Functions (V2)
| Function | Trigger | Description |
| :--- | :--- | :--- |
| `createJobBoostPayment` | `onCall` | 사용자의 결제 요청을 받아 Xendit 인보이스 생성 및 Payment 문서 초기화. |
| `xenditWebhook` | `onRequest` (HTTP) | Xendit으로부터 결제 완료 알림을 받아 상태 동기화 및 감사 로그 기록. |
| `onPaymentPaidActivateJobBoost` | `onDocumentUpdated` | 결제 완료(`paid`) 감지 시 Job Post의 부스트 필드 활성화. |
| `expireJobBoosts` | `onSchedule` (Hourly) | 만료 시간이 지난 부스트를 찾아 비활성화 처리. |

### B. Firestore Collections
- **`payments`**: 결제 이력. 클라이언트 쓰기 금지.
- **`job_posts`**: `boostStatus`, `boostActiveUntil`, `boostSignalScore` 등 부스트 필드 포함.
- **`monetization_audit_logs`**: 수익화 감사 로그. 시스템 전용 기록.

### C. Security Policy (Firestore Rules)
- 모든 수익화 관련 컬렉션은 클라이언트의 직접적인 `write`가 불가능하며, 오직 Cloud Functions(Admin SDK)를 통해서만 변경됩니다.
- 감사 로그 및 관리자 페이지는 `adminRole`이 `super_admin` 또는 `finance_admin`인 경우에만 `read`가 허용됩니다.

## 4. Staging 설정 가이드 (Secrets)
배포 시 아래 Secret 설정이 필수적입니다.
```bash
# Xendit API Secret Key (Sandbox/Production)
firebase functions:config:set xendit.secret_key="xnd_development_..."

# Xendit Dashboard에서 설정한 Webhook Verification Token
firebase functions:config:set xendit.webhook_token="your_callback_token"

# Mock 모드 사용 여부 (true/false)
firebase functions:config:set payment.mock_mode="false"
```

## 5. 테스트 결과 요약
- **Flutter Analyze**: 0 issues.
- **Flutter Test**: Payments/Jobs/Admin 도메인 테스트 100% 통과.
- **Functions Test**: Xendit 연동 및 멱등성 로직 42개 케이스 통과.

## 6. 남은 이슈 및 향후 과제
- **환불(Refund) 로직**: 현재 결제 취소 시 수동 처리가 필요하며, 향후 자동 환불 API 연동이 필요함.
- **정산(Settlement)**: 판매자 수익 정산 및 출금 시스템은 차기 Phase에서 다룰 예정.
- **Admin Dashboard UI**: 현재 감사 로그 조회 외에 실시간 통계 및 그래프 UI가 부재함.
- **Token Refresh UX**: 관리자 권한 변경 후 앱 재실행 없이 토큰을 즉시 갱신하는 흐름 고도화 필요.

## 7. 결론
Phase 4 Monetization의 핵심 엔진인 **"결제-동기화-활성화-감사"** 흐름이 안정적으로 구축되었으며, Staging 검증을 완료하였습니다. 본 모듈을 기반으로 Phase 5의 Smart Feed 및 광고 시스템 확장이 가능합니다.
