# P4-M05 Boost Expiry Audit Foundation Report

## 1. 구현 요약
- **Cloud Scheduler**: 만료된 Job Boost를 매 시간 자동으로 `expired` 처리하는 `expireJobBoosts` 구현.
- **Audit Logs**: 결제 상태 변경, 부스트 활성화, 부스트 만료 이력을 기록하는 `monetization_audit_logs` 컬렉션 도입.
- **Security Hardening**: Audit Log에 대해 클라이언트 읽기/쓰기를 전면 차단하는 Firestore Rules 적용.
- **Helper Extraction**: 테스트 용이성을 위해 Boost expiry 및 Audit log 로직을 전용 helper로 분리 및 export.
- **Dart Skeleton**: 향후 관리자 대시보드 활용을 위한 Audit Log 모델, 레포지토리, 프로바이더 구현.

## 2. 생성/수정 파일
- `functions-v2/index.js`: Scheduler, Audit Log 로직 및 Helper 추가.
- `functions-v2/test/boost_expiry_scheduler.test.js`: (New) 유닛 테스트 추가.
- `firestore.indexes.json`: Scheduler 쿼리용 복합 인덱스 추가 (`boostStatus` + `boostActiveUntil`).
- `firestore.rules`: `monetization_audit_logs` 보안 규칙 추가 및 `job_posts` 규칙 수정.
- `lib/mozzy_ii/domains/monetization/`: (New) 모델, 레포지토리, 프로바이더 추가.
- `docs/payments/Payment_Architecture_ADR.md`: P4-M05 정책 내용 추가.

## 3. expireJobBoosts Scheduler 정책
- **주기**: 매 1시간 (`every 1 hours`).
- **대상**: `boostStatus == "active"` AND `boostActiveUntil <= now`.
- **동작**: 
  - `boostStatus = "expired"`
  - `boostSignalScore = 0.0`
  - `updatedAt = serverTimestamp()`
  - `monetization_audit_logs`에 `job_boost_expired` 기록.

## 4. Audit Log 컬렉션 구조 (`monetization_audit_logs`)
- `id`: Unique ID (일부는 Deterministic ID 사용).
- `type`: `payment_status_changed`, `job_boost_activated`, `job_boost_expired`.
- `relatedDomain`, `relatedId`, `paymentId`, `jobId`.
- `actorType`: `webhook`, `system`, `scheduler`.
- `beforeStatus`, `afterStatus`, `amount`, `currency`, `metadata`.
- `createdAt`: Server Timestamp.

## 5. 테스트 결과
- **Functions Test**: `npm test` PASS (42 passing).
  - `boost_expiry_scheduler.test.js` 포함.
- **Flutter Analyze**: 0 issues (in monetization domain).
- **Flutter Test**: `jobs`, `payments` 도메인 테스트 PASS.

## 6. Git Status
- **Branch**: main
- **Commit SHA**: 580f188
- **Status**: clean
- **Push 여부**: YES

## 7. P4-M05 검증 요약
- expireJobBoosts scheduler 구현 완료
- monetization_audit_logs 보안 규칙 적용 완료
- functions test 42 passing
- Flutter analyze PASS
- Jobs/Payments tests PASS

## 8. 남은 이슈
- 관리자용 UI 대시보드 전체 구현 (향후 단계).
- Audit Log 보존 정책 (TTL 등) 검토 필요.
