# P4-M01 — Monetization Foundation & Payment Provider Architecture Report

## 1. 작업 개요
Phase 4 수익화 시스템의 기반이 되는 공통 결제 아키텍처를 설계하고 구현했습니다. Xendit과 Midtrans 등 멀티 PG 지원을 고려한 추상화 레이어를 도입했습니다.

## 2. 구현 내용

### A. 도메인 모델 (Models)
- `PaymentModel`: 결제 정보를 통합 관리하는 표준 모델 (Freezed 기반)
- `PaymentStatus`: 결제 상태 (created, pending, paid, failed 등) 정의
- `PaymentProviderType`: PG사 구분 (Xendit, Midtrans, Manual)
- `PaymentProductType`: 결제 대상 구분 (Marketplace Deal, Job Boost 등)

### B. 아키텍처 및 어댑터 (Services)
- `PaymentProviderAdapter`: PG사별 연동 로직을 위한 인터페이스 정의
- `XenditPaymentAdapter`: 기존 Marketplace Xendit 흐름을 수용하기 위한 어댑터 (기본 로직 포함)
- `MidtransPaymentAdapter`: 향후 확장을 위한 Midtrans 연동 스켈레톤 구현

### C. 데이터 레이어 (Repositories & Providers)
- `PaymentRepository`: Firestore 기반 결제 데이터 영속화 인터페이스
- `FirestorePaymentRepository`: `payments` 컬렉션 CRUD 및 상태 업데이트 로직 구현
- `paymentRepositoryProvider`: Riverpod을 통한 의존성 주입

### D. 보안 및 인프라 (Security & Infra)
- **Firestore Rules**: `payments` 컬렉션 보안 강화 (클라이언트 생성/수정 차단, 서버 전용)
- **Firestore Indexes**: `buyerId`, `sellerId` 기반 복합 인덱스 추가
- **i18n**: `id.json`, `en.json`, `ko.json`에 결제 관련 번역 키 추가

### E. UI
- `PaymentStatusScreen`: 결제 완료/대기/실패 상태를 보여주는 공통 화면 구현

## 3. 주요 파일 위치
- `lib/mozzy_ii/domains/payments/models/`: 결제 데이터 모델
- `lib/mozzy_ii/domains/payments/services/`: PG 어댑터 및 추상화 레이어
- `lib/mozzy_ii/domains/payments/repositories/`: 데이터 영속화 로직
- `lib/mozzy_ii/domains/payments/screens/`: 공통 결제 UI

## 4. 향후 작업 (Phase 4-M02)
- Cloud Functions를 통한 서버 사이드 결제 검증 (Webhook 처리)
- Job Boost 기능과 결제 시스템 연동
- Midtrans 연동 로직 구체화

## 5. 증빙 (Commits)
- `P4-M01` 작업 완료 후 `git commit` 및 `push` 예정
