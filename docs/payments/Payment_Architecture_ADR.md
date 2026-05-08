# Payment Architecture ADR — Mozzy Phase 4

## 1. 결정 배경
- **Marketplace**: 현재 Xendit Sandbox 기반의 결제 흐름이 문서화되어 있으며, 실제 연동을 위한 통일된 구조가 필요함.
- **Jobs**: 향후 Job Boost 등의 수익화 모델을 도입하기 위해 확장 가능한 결제 시스템 기반이 필수적임.
- **운영 유연성**: 인도네시아 시장 특성상 Midtrans와 Xendit 중 상황에 맞는 PG사를 선택하거나 병행 사용할 수 있어야 함.
- **관심사 분리**: 각 PG사의 파편화된 API 사양을 앱 내부의 비즈니스 로직과 분리하여 유지보수성을 높여야 함.

## 2. 결정 사항
- **통일된 결제 모델**: 앱 내 모든 결제 관련 데이터는 `PaymentModel` 표준을 따름.
- **추상화 레이어**: PG사별 연동 로직은 `PaymentProviderAdapter`를 통해 추상화하며, 실제 도메인 로직은 인터페이스에만 의존함.
- **서버 중심 상태 관리**: 결제 생성 및 상태 업데이트(Paid, Expired 등)는 보안을 위해 Cloud Functions 또는 Admin SDK에서만 수행함.
- **클라이언트 역할 최소화**: 클라이언트는 결제 상태 조회(Polling/Streaming)와 PG사 제공 Invoice URL 호출 기능만 수행함.
- **보안 최우선**: Secret Key 등 민감 정보는 클라이언트 코드에 절대 노출하지 않으며, Firebase Secrets 또는 Environment Variables에서 관리함.

## 3. PaymentModel 표준
`PaymentModel`은 다음과 같은 핵심 필드를 포함함:
- `id`: 고유 식별자 (Firestore Document ID)
- `provider`: 결제 대행사 (Xendit, Midtrans, Manual)
- `providerMode`: 운영 환경 (Sandbox, Production)
- `productType`: 결제 대상 상품 (Marketplace Deal, Job Boost 등)
- `relatedDomain`: 연관 도메인 (Marketplace, Jobs, Stores, Ads)
- `relatedId`: 연관 상품/글 ID
- `buyerId`: 결제자 UID
- `sellerId`: 판매자/수혜자 UID (선택 사항)
- `ownerId`: 소유자 UID (선택 사항)
- `amount`: 결제 금액 (IDR 단위)
- `currency`: 통화 (기본값 IDR)
- `status`: 결제 상태 (created, pending, paid, failed, expired, cancelled, refunded)
- `providerInvoiceId`: PG사측 인보이스 ID
- `providerInvoiceUrl`: PG사 결제 페이지 URL
- `externalId`: PG사 연동용 외부 식별자
- `metadata`: 추가 정보 저장을 위한 Map
- `createdAt`, `updatedAt`, `paidAt`, `expiredAt`: 시계열 데이터
- `webhookLastReceivedAt`: 최종 웹후크 수신 시간
- `rawProviderStatus`: PG사에서 전달한 원본 상태값

## 4. Product Type 정책
현재 및 향후 지원 예정 상품:
- `marketplaceDeal`: 중고 거래 결제
- `jobBoost`: 구인 공고 상단 노출 및 홍보
- `marketplaceBoost`: 상품 홍보
- `storeSubscription`: 상점 프리미엄 구독
- `adCampaign`: 광고 캠페인 집행

## 5. Provider 정책
- **Xendit**: 기존 Sandbox 흐름 호환 및 최우선 적용.
- **Midtrans**: 향후 확장성을 고려한 Skeleton 구현 완료.
- **Manual**: 관리자 승인 또는 현장 결제 등 수동 처리를 위한 예약 타입.

## 6. 보안 정책
- **Firestore Rules**: 
  - `payments` 컬렉션에 대한 클라이언트의 `create`, `update`, `delete`를 엄격히 금지함.
  - `read`는 결제 당사자(Buyer, Seller) 및 관리자만 가능함.
- **Webhook 검증**: Cloud Functions에서 PG사별 Signature 또는 Callback Token 검증을 필수 수행함.
- **Key 관리**: 모든 API Secret은 서버 환경에서만 안전하게 관리함.

## 7. 향후 확장 방향
- **P4-M02**: Job Boost 결제 Intent 생성 및 서버 측 인보이스 생성 연동 (Mock).
- **P4-M02B**: 실제 Xendit Sandbox Invoice API 연동 및 중복 결제 방지 로직 추가.
- **P4-M03**: Xendit 웹후크(Webhook) 연동을 통한 결제 상태 자동 동기화 및 상태 전이 무결성 로직 구현.
- **P4-M04**: 결제 완료(`paid`) 이벤트를 트리거로 하는 Job Boost 자동 활성화 로직 구현 (기간 계산, 시그널 가중치 부여, 클라이언트 정렬 반영).
- **P4-M04B**: 부스트 관련 필드(8종)에 대한 클라이언트 직접 수정 전면 차단 (`firestore.rules` hardening) 및 Activation 로직 helper 분리.
- **P4-M05**: 관리자용 결제 정산 및 감사(Audit) 뷰 구현.
