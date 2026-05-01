# Phase 2-B14: Marketplace Admin Review UI Foundation

## 1. 개요 (Overview)
본 작업은 AI 검수 결과가 'passed'가 아닌 상품들을 관리자가 확인하고 조치할 수 있도록 하는 'Admin Review' 화면의 기초 UI를 구현함. 이는 P2-B11에서 구축된 AI 검토 대기열(Moderation Queue)을 시각화하고 관리자 진입점을 제공하는 파운데이션 단계임.

## 2. 주요 구현 내용 (Key Implementations)

### 2.1 UI 구성 (AdminReviewScreen)
- **위치**: `lib/mozzy_ii/domains/marketplace/screens/admin_review_screen.dart`
- **주요 기능**:
  - `aiReviewQueueProvider`를 통한 실시간 대기열 조회.
  - **상태별 처리**:
    - **Loading**: 통합 테스트 모드 시 텍스트 표시, 일반 모드 시 인디케이터 표시.
    - **Empty**: `adminReviewEmptyState`를 통해 검토 항목 없음 표시.
    - **Error**: 로드 실패 시 재시도 버튼 제공.
    - **Data**: `adminReviewQueueList`를 통해 대기열 항목들을 카드 형태로 리스트업.
  - **항목 표시 정보**:
    - Product ID (클릭 시 해당 상품 상세 페이지로 이동).
    - AI 검수 상태 (Needs Review, Failed, Error) 배지.
    - 검토 사유 (AI 요약 내용).
    - 우선순위 (High, Normal, Low) 플래그.
    - 생성 일시.
- **개인정보 보호**: PII(이메일, 전화번호, 주소 등) 및 AI의 raw response는 노출하지 않음.

### 2.2 라우팅 및 진입점 (Route & Entry Point)
- **Route**: `/marketplace/admin-review` (Gouter 중첩 라우트로 등록).
- **진입점**: `MarketplaceListScreen`의 AppBar 액션 버튼.
  - **보안 정책**: `kDebugMode` 또는 `IntegrationTestConfig.enabled`인 경우에만 노출되어 일반 사용자에게는 숨김 처리됨.

### 2.3 다국어 지원 (i18n)
- `id.json`, `en.json`, `ko.json`에 관련 키 추가 완료:
  - `adminReview`, `noReviewItems`, `reviewReason`, `reviewPriority` 등.

## 3. 테스트 결과 (Test Results)

### 3.1 Unit/Widget Tests
- `admin_review_screen_test.dart`:
  - 렌더링 검증, 빈 상태 검증, 리스트 렌더링 검증 완료.
  - 승인/거절 버튼이 없는 'Read-only' 상태임을 검증 완료.
- `marketplace_list_screen_test.dart`:
  - 테스트 모드에서 관리자 버튼 노출 여부 검증 완료.

### 3.2 Integration Test
- `marketplace_e2e_test.dart`:
  - 마켓플레이스 리스트 -> 관리자 리뷰 화면 진입 -> 다시 돌아오기 흐름 추가 및 검증 완료.

## 4. 향후 계획 (Future Plans / Deferred Items)
- **P2-B15**: 관리자 승인(Approve) / 거절(Reject) 액션 및 데이터 업데이트 로직 구현.
- **P2-B16**: 관리자 역할(Role) 및 권한(Permission) 시스템 연동.
- 상품 차단(Blocking) 및 관리자 배정(Assignment) 기능.

## 5. 결론 (Conclusion)
- P2-B14 Admin Review UI Foundation 완료.
- 관리자용 대기열 확인 기능이 안전하게(Debug/Test 전용) 마켓플레이스 도메인에 통합됨.
- **Latest Commit SHA**: [FEATURE_SHA_HERE]
