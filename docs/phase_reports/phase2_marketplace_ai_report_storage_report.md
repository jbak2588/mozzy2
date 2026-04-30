# Phase 2-B11: Marketplace AI Verification Report Storage & Moderation Queue Foundation

## 1. 개요 (Overview)
본 작업은 마켓플레이스 상품 등록 시 수행되는 AI 검수 결과를 상세 리포트로 저장하고, 관리가 필요한 항목(실패, 검토 필요 등)을 관리자 대기열에 자동으로 추가하는 백엔드 및 데이터 레이어 파운데이션을 구현함. 이는 P2-B14 관리자 리뷰 UI의 필수 전제 조건임.

## 2. 주요 구현 내용 (Key Implementations)

### 2.1 데이터 모델 (Models)
- **`AiVerificationReportModel`**:
  - AI 검수 결과의 상세 내역 저장 (Score, Summary, Issues, Category, Condition 등).
  - `productId`, `sellerId` 연결.
  - `promptVersion`, `modelName` 기록으로 추적성 확보.
- **`AiReviewQueueItemModel`**:
  - 관리자 검토가 필요한 항목의 대기열 데이터.
  - `reviewStatus` (open, resolved, dismissed) 관리.
  - `priority` 자동 계산 (score 또는 status 기반).

### 2.2 저장소 (Repositories)
- **`AiVerificationReportRepository`**:
  - Firestore 경로: `countries/ID/domains/marketplace/products/{productId}/ai_reports/{reportId}`
  - Firestore 경로 (Queue): `countries/ID/domains/marketplace/ai_review_queue/{queueId}`
  - `saveReport`: 상품별 하위 컬렉션에 리포트 저장.
  - `enqueueReviewIfNeeded`: `passed`가 아닌 경우 대기열에 자동 추가.
  - `fetchReportsByProduct`: 상품 상세에서 이력 조회를 위한 메서드.
  - `fetchOpenReviewQueue`: 대기열 조회를 위한 메서드.
- **`InMemoryAiVerificationReportRepository`**:
  - 유닛 및 통합 테스트를 위한 Mock 구현.

### 2.3 UI 통합 (UI Integration)
- **`CreateProductScreen`**:
  - 상품 저장 성공 후, AI 검수 결과를 `saveReport` 및 `enqueueReviewIfNeeded`를 통해 저장 (Non-blocking).
- **`ProductDetailScreen`**:
  - `aiVerificationReportSection` 추가.
  - 해당 상품의 AI 검수 이력을 최신순으로 표시.

### 2.4 보안 및 인프라 (Security & Infrastructure)
- **Firestore Rules**:
  - `ai_reports`: 인증된 사용자가 본인 상품의 리포트 작성 가능, 읽기 허용.
  - `ai_review_queue`: 인증된 사용자가 항목 추가 가능, 일반 사용자 읽기 불가.
- **Firestore Indexes**:
  - `ai_review_queue`: `reviewStatus` ASC + `createdAt` DESC 복합 인덱스 정의.

## 3. 테스트 결과 (Test Results)

### 3.1 Unit/Widget Tests
- `ai_verification_report_repository_test.dart`: 저장, 필터링, 대기열 추가 로직 검증 완료.
- `create_product_screen_test.dart`: 상품 생성 시 리포트 저장 여부 검증 완료.
- `product_detail_screen_test.dart`: 리포트 섹션 렌더링 검증 완료.

### 3.2 Integration Test
- `marketplace_e2e_test.dart`: 
  - 흐름: 상품 생성 -> 상세 진입 -> AI 리포트 섹션 확인.
  - 결과: **PASS** (기기: RR8N109B4JM)

## 5. 결론 (Conclusion)
- P2-B11 AI Verification Report Storage & Moderation Queue Foundation 완료.
- 기술적 무결성 확인 (Unit, Widget, Analyze, E2E 통과).
- **Latest Commit SHA**: PENDING_UNTIL_COMMIT
