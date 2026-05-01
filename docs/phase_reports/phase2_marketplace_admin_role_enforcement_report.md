# Phase 2-B16: Marketplace Admin Role Enforcement Foundation

## 1. 개요 (Overview)
본 작업은 Marketplace 관리자 기능(Admin Review Queue)에 대한 보안 경계를 설정함. 생산 환경에서는 모든 사용자의 관리자 권한을 기본적으로 거부(Deny-all)하며, 통합 테스트 환경에서만 관리자 권한을 부여하여 안전하게 테스트할 수 있도록 구현함.

## 2. 주요 구현 내용 (Key Implementations)

### 2.1 관리자 역할 모델 (AdminRoleModel)
- **위치**: `lib/mozzy_ii/domains/marketplace/models/admin_role_model.dart`
- **역할 정의**: `none`, `reviewer`, `admin`, `superAdmin` 4단계 정의.
- **권한 로직**: Extension을 통해 `canViewReviewQueue`, `canModerate` 등의 로직을 캡슐화함.

### 2.2 권한 프로바이더 (Providers)
- **위치**: `lib/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart`
- **`marketplaceAdminRoleProvider`**: 
  - `IntegrationTestConfig.enabled`인 경우 `admin` 부여.
  - 그 외(Release/Production)에는 `none` 부여 (Security by Default).
- **`canViewMarketplaceAdminReviewProvider`**: 현재 사용자의 역할이 검토 대기열을 볼 수 있는지 여부를 실시간으로 제공.

### 2.3 UI 보호 (UI Guarding)
- **MarketplaceListScreen**: `canViewMarketplaceAdminReviewProvider`를 감시하여 권한이 있는 경우에만 관리자 진입 버튼 노출.
- **AdminReviewScreen**: 화면 빌드 시 권한을 체크하며, 권한이 없는 경우 `adminReviewAccessDenied` 화면(잠금 아이콘 및 안내 문구)을 표시함.

### 2.4 다국어 및 보안 규정 (i18n & Security)
- `adminAccessDenied`, `adminAccessDeniedDesc` 및 역할 이름들을 `id.json`, `en.json`, `ko.json`에 추가 완료.
- `firestore.rules`에 향후 Custom Claims 기반 서버 사이드 검증을 위한 주석 가이드 추가.

## 3. 테스트 결과 (Test Results)

### 3.1 Unit Tests
- `admin_role_provider_test.dart`: 기본 역할(`none`) 및 권한 로직(`reviewer` 이상 허용) 검증 완료.
- `admin_review_screen_test.dart`: 권한 유무에 따른 화면 전환(Data vs Access Denied) 검증 완료.
- `marketplace_list_screen_test.dart`: 권한 유무에 따른 버튼 노출 여부 검증 완료.

### 3.2 Integration Test
- `marketplace_e2e_test.dart`: 
  - `MOZZY_INTEGRATION_TEST=true` 환경에서 관리자 버튼 노출 및 화면 진입 정상 작동 확인.
  - 전체 시나리오(등록 -> AI 검수 -> 찜하기 -> 관리자 화면 확인) 통과 완료.

## 4. 향후 계획 (Future Plans)
- **P2-B15**: 관리자 승인/거절 액션 구현.
- **P2-B17**: Firebase Custom Claims 연동을 통해 정적 역할 정의를 서버 사이드 권한으로 전환.

## 5. 결론 (Conclusion)
- P2-B16 Admin Role Enforcement Foundation 완료.
- 관리자 기능에 대한 1차 UI 보안 경계가 확립되었으며, 테스트 자동화 환경을 유지하면서도 일반 사용자에게는 안전하게 숨김 처리됨.
