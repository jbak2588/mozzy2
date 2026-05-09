# P4-M06B Admin Role Scope Hardening & Report Finalization

## 1. 구현 요약
- **P4-M06 문서 정정**: `P4-M06_Admin_Role_Foundation_Report.md`의 Commit SHA를 실제 최종본(`5bda619`)으로 정정함.
- **Firestore Rules Hardening**: `canReadMonetizationAudit()` 헬퍼를 추가하여 `monetization_audit_logs` 읽기 권한을 `super_admin` 및 `finance_admin`으로 제한함.
- **AdminClaimsModel 보완**: `isSuperAdmin`, `isFinanceAdmin`, `canReadMonetizationAudit` 등 역할별 접근 권한 판단을 위한 getter 추가.
- **AdminAuthProvider 보완**: UI에서 사용하기 쉬운 `canReadMonetizationAuditProvider` 추가.
- **Screen Guard 강화**: `AdminMonetizationAuditScreen`이 이제 `canReadMonetizationAudit` 기반으로 접근을 제어하며, 권한 부족 시 현재 역할을 명시하는 Access Denied 화면을 표시함.
- **i18n 보완**: 역할 표시 및 세부 거부 메시지를 위한 다국어(id/en/ko) 키 추가 완료.

## 2. 생성/수정 파일
- `lib/mozzy_ii/domains/admin/models/admin_claims_model.dart`: getter 추가.
- `lib/mozzy_ii/domains/admin/providers/admin_auth_provider.dart`: `canReadMonetizationAuditProvider` 추가.
- `lib/mozzy_ii/domains/monetization/screens/admin_monetization_audit_screen.dart`: Guard 로직 강화 및 UI 보완.
- `firestore.rules`: 역할 기반 접근 제어 헬퍼 추가 및 적용.
- `assets/translations/*.json`: admin 관련 신규 키 추가.
- `docs/admin/Admin_Role_Setup_Guide.md`: 역할별 접근 범위 표 업데이트.
- `docs/payments/Payment_Architecture_ADR.md`: P4-M06B 정책 반영.
- `docs/qa/P4-M06_Admin_Role_Foundation_Report.md`: SHA 수정 및 섹션 업데이트.

## 3. 역할별 접근 정책 (Monetization Audit)
| Role | Database (Rules) | UI (Guard) | 결과 |
| :--- | :--- | :--- | :--- |
| `super_admin` | Allow | Allow | 접근 가능 |
| `finance_admin` | Allow | Allow | 접근 가능 |
| `ops_admin` | Deny | Deny | 접근 차단 |
| `support_admin` | Deny | Deny | 접근 차단 |
| `unknown` | Deny | Deny | 접근 차단 |

## 4. 테스트 결과
- **Unit Test**: `AdminClaimsModel`의 역할별 getter가 올바르게 동작함을 확인 (**PASS**).
- **Widget Test**: `AdminMonetizationAuditScreen`이 각 역할별로 올바르게 접근을 허용/차단하고 Access Denied UI를 표시함을 확인 (**PASS**).
- **Flutter Analyze**: 0 issues (**PASS**).
- **Functions Test**: 회귀 테스트 통과 (**PASS**).

## 5. Git Status
- **Branch**: main
- **Commit SHA**: 7d1fe5a
- **Status**: clean
- **Push 여부**: YES

## 6. 남은 이슈
- 관리자 권한 변경 후 토큰 갱신 없이 즉시 반영을 위한 Firebase Auth Re-authentication 흐름 검토.
- 향후 Admin 전용 대시보드(Home) 도입 시 역할별 카드 노출 로직 추가 필요.
