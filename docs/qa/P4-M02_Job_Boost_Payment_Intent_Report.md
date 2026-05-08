# P4-M02 — Job Boost Payment Intent & Server-side Invoice Creation Report

## 1. 구현 요약
Jobs 도메인의 첫 수익화 기능인 "Job Boost"의 결제 생성 흐름을 구현했습니다. 사용자가 구인글 상세 화면에서 부스트 버튼을 누르면, 기간별 패키지를 선택하고 결제를 시작할 수 있습니다. 결제 생성은 서버 사이드(Cloud Functions)에서 수행되어 금액 및 상태 무결성을 보장하며, Xendit Sandbox 인보이스 생성 및 `payments` 문서 생성이 완료된 후 사용자에게 결제창 링크를 제공합니다.

## 2. 생성/수정 파일
- **Monetization Domain**:
  - `lib/mozzy_ii/domains/monetization/models/boost_package_model.dart`
  - `lib/mozzy_ii/domains/monetization/providers/boost_package_provider.dart`
- **Jobs Domain**:
  - `lib/mozzy_ii/domains/jobs/screens/job_boost_purchase_screen.dart`
  - `lib/mozzy_ii/domains/jobs/widgets/job_boost_package_card.dart`
  - `lib/mozzy_ii/domains/jobs/screens/job_detail_screen.dart` (수정: Boost 버튼 추가)
- **Payments Domain**:
  - `lib/mozzy_ii/domains/payments/providers/payment_action_provider.dart`
- **Infrastructure & App**:
  - `functions-v2/index.js` (수정: `createJobBoostPayment` 추가)
  - `lib/mozzy_ii/app/navigation/app_router.dart` (수정: Route 추가)
  - `pubspec.yaml` (수정: `cloud_functions` 추가)
  - `assets/translations/id.json`, `en.json`, `ko.json` (수정: 키 추가)

## 3. Job Boost Package 정책
| Package ID | 기간 | 금액 (IDR) |
|---|---|---|
| job_boost_1_day | 1일 | 15,000 |
| job_boost_3_days | 3일 | 40,000 |
| job_boost_7_days | 7일 | 90,000 |

## 4. createJobBoostPayment Cloud Function 동작
1. **인증 확인**: 로그인된 사용자만 호출 가능.
2. **소유권 검증**: 구인글의 `ownerId`와 호출자의 `uid`가 일치하는지 확인.
3. **상태 검증**: 구인글이 `open` 상태이며 삭제되지 않았는지 확인.
4. **패키지 검증**: 서버에 정의된 `BOOST_PACKAGES` 정책에 따라 금액 결정 (클라이언트 입력 금액 무시).
5. **중복 결제 방지**: 이미 활성화된 부스트가 있는 경우 요청 거부.
6. **Payment 문서 생성**: `payments` 컬렉션에 `status: created`로 문서 생성.
7. **Xendit 인보이스 생성**: Xendit Sandbox API(Mock)를 통해 `external_id`와 `paymentId`를 매핑하여 인보이스 발행.
8. **결과 반환**: 생성된 `paymentId`와 `invoiceUrl`을 클라이언트에 반환.

## 5. Payment 문서 구조 (예시)
```json
{
  "id": "PAY_ID_123",
  "provider": "xendit",
  "providerMode": "sandbox",
  "productType": "jobBoost",
  "relatedDomain": "jobs",
  "relatedId": "JOB_ID_ABC",
  "buyerId": "USER_OWNER_XYZ",
  "amount": 15000,
  "currency": "IDR",
  "status": "pending",
  "providerInvoiceId": "inv_PAY_ID_123",
  "providerInvoiceUrl": "https://checkout-staging.xendit.co/...",
  "metadata": {
    "packageId": "job_boost_1_day",
    "durationDays": 1,
    "jobTitle": "Flutter Developer"
  },
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

## 6. 테스트 결과
- **Flutter Analyze**: 0 Issues (Payments/Jobs/Monetization 전역 확인)
- **Flutter Test**:
  - `boost_package_model_test.dart`: PASS
  - `job_boost_purchase_screen_test.dart`: PASS (Widget/Rendering)
  - `payments/jobs` 전체 테스트 (27종): ALL PASS
- **Functions Test**:
  - `job_boost_payment.test.js`: PASS (Export/Structure 확인)

## 7. 남은 이슈
- **P4-M03 Webhook Reconciliation**: 결제 완료 시 Webhook을 수신하여 `payments` 문서 상태를 `paid`로 갱신하는 로직.
- **P4-M04 Boost Activation**: `paid` 상태가 확인된 후 실제 `job_posts` 문서에 부스트 필드를 업데이트하여 상단 노출을 활성화하는 로직.

## 8. Git 정보
- **Commit SHA**: 1088010
- **Push 여부**: YES
- **Git Status Clean**: YES

---
**작성일**: 2026-05-08
**담당 에이전트**: Antigravity
