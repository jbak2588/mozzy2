# Marketplace Firestore DB Schema

이 문서는 Mozzy Marketplace 도메인의 Firestore 데이터 구조와 경로를 정의합니다.

## 1. 개요
Marketplace는 하이퍼로컬 상거래 기능을 담당하며, 상품 관리, AI 검수 대기열, 관리자 감사 로그를 포함합니다.

## 2. 데이터 경로 (Paths)

### A. 상품 (Product)
- **Path**: `countries/ID/domains/marketplace/products/{productId}`
- **설명**: 개별 상품의 상세 정보.
- **주요 필드**:
  - `id` (String): UUID
  - `sellerId` (String): 판매자 UID
  - `title`, `description`, `price`
  - `isAiVerified` (Boolean): AI 검수 완료 여부
  - `aiVerificationStatus` (String): `passed` | `failed` | `needs_review` | `error`
  - `createdAt`, `updatedAt` (Timestamp)

### B. AI 검수 리포트 (AI Report) - Subcollection
- **Path**: `countries/ID/domains/marketplace/products/{productId}/ai_reports/{reportId}`
- **설명**: 개별 상품에 대해 Gemini AI가 생성한 검수 결과.
- **주요 필드**:
  - `status` (String): `passed` | `failed` | `needs_review`
  - `score` (Number): 0.0 ~ 1.0
  - `summary` (String): 검수 요약
  - `detectedIssues` (Array): 감지된 문제 항목들

### C. 관리자 검토 대기열 (Admin Review Queue)
- **Path**: `countries/ID/domains/marketplace/ai_review_queue/{reportId}`
- **설명**: AI가 `passed` 이외의 상태를 반환했을 때 관리자가 수동으로 검토해야 할 항목들.
- **주요 필드**:
  - `id` (String): 리포트 ID와 동일
  - `productId`, `sellerId`, `reportId`
  - `reviewStatus` (String): `open` | `resolved` | `dismissed` (화면은 `open`만 조회)
  - `status` (String): AI가 판단한 원래 상태
  - `createdAt` (Timestamp)

### D. 관리자 감사 로그 (Admin Audit Logs)
- **Path**: `countries/ID/domains/marketplace/admin_audit_logs/{logId}`
- **설명**: 관리자의 승인/거절 액션 이력.
- **주요 필드**:
  - `action` (String): `approve` | `reject` | `dismiss`
  - `productId`, `queueItemId`
  - `reviewerId` (String): 관리자 UID
  - `decision` (String): `approved` | `rejected` | `dismissed`
  - `createdAt` (Timestamp)

## 3. 검증 가이드 (Console Check)

1. **상품 등록 후**: `products` 컬렉션에 새 문서가 생겼는지 확인.
2. **AI 검수 확인**: 해당 상품 하위의 `ai_reports`에 문서가 생겼는지 확인.
3. **대기열 확인**: `MOZZY_FORCE_AI_REVIEW=true`인 경우, `ai_review_queue`에 `reviewStatus: open`인 문서가 생겼는지 확인.
4. **관리자 액션 확인**: 관리자 화면에서 승인/거절 후 `admin_audit_logs`에 로그가 생기고 `ai_review_queue`의 `reviewStatus`가 `resolved`로 바뀌었는지 확인.

## 4. 필수 복합 인덱스 (Composite Indexes)

- `products` (Collection): `isDeleted` ASC, `locationParts.idAddress.kecamatan` ASC, `createdAt` DESC
- `products` (Collection): `isDeleted` ASC, `category` ASC, `createdAt` DESC
- `ai_review_queue` (Collection): `reviewStatus` ASC, `createdAt` DESC
- `admin_audit_logs` (Collection): `productId` ASC, `createdAt` DESC
