# P4-M06 Admin Role & Custom Claims Foundation Report

## 1. 구현 요약
- **P4-M05B 문서 정합성 수정**: `P4-M05B_Admin_Audit_Foundation_Report.md`에 최신 Commit SHA(`ae55606`)를 기록하고 상태를 업데이트함.
- **Admin Role Foundation**: Firebase Custom Claims 기반의 관리자 권한 모델(`AdminClaimsModel`) 및 프로바이더(`AdminAuthProvider`) 구현.
- **Admin Route Guard**: `AdminMonetizationAuditScreen`에 Custom Claims 기반의 실질적인 권한 검사 로직 적용. 권한 없을 시 `Access Denied` 화면 표시.
- **Firestore Rules 업데이트**: `isAdmin()` 헬퍼 함수를 추가하고, `monetization_audit_logs` 컬렉션에 대해 관리자(`admin: true`)의 읽기 권한을 허용함 (쓰기는 여전히 차단).
- **Setup Guide 작성**: 관리자 권한 부여 및 보안 정책을 담은 `Admin_Role_Setup_Guide.md` 작성.
- **UI 보완**: Audit Log 카드에서 금액 포맷팅(IDR) 및 긴 ID 값의 생략(ellipsis) 처리를 추가하여 가독성 개선.
- **i18n**: 관리자 권한 확인 및 역할 표시를 위한 다국어 키 추가 완료.

## 2. 생성/수정 파일
- `lib/mozzy_ii/domains/admin/models/admin_claims_model.dart`: (New) 모델.
- `lib/mozzy_ii/domains/admin/providers/admin_auth_provider.dart`: (New) 프로바이더.
- `lib/mozzy_ii/domains/monetization/screens/admin_monetization_audit_screen.dart`: 가드 로직 변경.
- `lib/mozzy_ii/domains/monetization/widgets/audit_log_card.dart`: 포맷팅 보완.
- `firestore.rules`: `isAdmin()` 추가 및 audit logs read 허용.
- `assets/translations/*.json`: admin 관련 키 추가.
- `docs/admin/Admin_Role_Setup_Guide.md`: (New) 운영 가이드.
- `docs/qa/P4-M05B_Admin_Audit_Foundation_Report.md`: SHA 수정.
- `docs/payments/Payment_Architecture_ADR.md`: P4-M06 정책 추가.
- `test/mozzy_ii/domains/admin/admin_claims_model_test.dart`: (New) 유닛 테스트.

## 3. Admin Claims Model 구조
```dart
class AdminClaimsModel {
  bool isAdmin;
  String? adminRole; // super_admin, ops_admin, finance_admin, support_admin
  DateTime? claimsUpdatedAt;
}
```

## 4. Firestore Rules 변경 사항
```js
function isAdmin() {
  return isAuthenticated() && request.auth.token.admin == true;
}

match /monetization_audit_logs/{auditId} {
  allow read: if isAdmin();
  allow write: if false;
}
```

## 5. 테스트 결과
- **Unit Test**: `AdminClaimsModel` 파싱 및 직렬화 테스트 통과 (**PASS**).
- **Widget Test**: `AdminMonetizationAuditScreen` 가드 동작 및 카드 렌더링 테스트 통과 (**PASS**).
- **전체 테스트**: `flutter test` 결과 모든 테스트 통과 (**PASS**).
- **Functions Test**: `npm test` 결과 회귀 테스트(Xendit, Boost) 모두 통과 (**PASS**).

## 6. Git Status
- **Branch**: main
- **Commit SHA**: 5bda619
- **Status**: clean
- **Push 여부**: YES

## 7. 남은 이슈
- 관리자 권한 변경 시 실시간 반영을 위한 Token Refresh UX 고도화.
- Admin 전용 Composite Index 추가 (데이터 양 증가 시 필요).
- 세부 역할(`adminRole`)별 화면 항목 필터링 적용.
