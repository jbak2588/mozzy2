# P6-S06 Account Deletion / Data Cleanup Report

## 1. Scope
- PDPB(인도네시아 개인정보 보호법) 및 App Store/Google Play 탈퇴 정책 준수.
- 사용자가 앱 내에서 계정 탈퇴 및 데이터 삭제를 요청할 수 있는 플로우 구축.
- 탈퇴 요청 시 서버 측(Cloud Functions)에서 관련 개인정보를 삭제하고 UGC를 익명화/숨김 처리하는 로직 구현.

## 2. Implementation Summary
- **AccountDeletionScreen**: 탈퇴 안내, 주의사항, 체크박스 확인 및 탈퇴 사유 입력을 포함한 UI 구현. `/account/delete` 라우트 할당.
- **AccountDeletionService**: Firebase Functions의 `requestAccountDeletion` Callable 함수를 호출하고 성공 시 앱에서 로그아웃 처리.
- **requestAccountDeletion (Callable)**: `account_deletion_requests` 컬렉션에 사용자 요청을 기록.
- **onAccountDeletionRequested (Trigger)**: 요청 생성 시 트리거되어 아래 데이터 정리 수행:
  - **Firestore**: 사용자 문서 익명화, 작성한 게시물(News, Jobs, Marketplace) 숨김 및 익명화, 피드백/신고 데이터 정리.
  - **Firebase Auth**: 실제 계정 삭제 (`admin.auth().deleteUser`).
- **Entry Point**: `DevProfileScreen` 하단에 'Delete Account' 버튼 추가.
- **Firestore Rules**: `account_deletion_requests` 컬렉션에 대해 본인 생성/조회 및 Admin 전용 업데이트 규칙 적용.

## 3. Data Cleanup Policy
| Data Area | Action | Notes |
|---|---|---|
| `users/{uid}` | Anonymize + `isDeleted: true` | 이름 "Deleted User"로 변경, 연락처/사진 제거 |
| Auth Account | **Permanent Delete** | `admin.auth().deleteUser` 호출 |
| News posts | `moderationStatus: "removed"` | 목록/상세 노출 차단 및 작성자명 익명화 |
| Marketplace products | `moderationStatus: "removed"` | 목록/상세 노출 차단 및 익명화 |
| Jobs posts | `moderationStatus: "removed"` | 목록/상세 노출 차단 및 익명화 |
| Feedback | `contactValue: null` | 연락처 정보 제거 및 상태 `dismissed` 변경 |
| Reports | `reporterDeleted: true` | 신고자 식별 정보 링크 끊기 |
| Engagement summaries | Keep | 개인 식별 정보가 없는 통계 데이터이므로 유지 |

## 4. Privacy / Safety
- **Server-side Process**: 클라이언트가 아닌 서버에서 Batch 작업을 통해 안전하게 데이터를 정리하여 데이터 무결성 유지.
- **Soft Delete + Anonymization**: 거래 내역이나 신고 로그 등의 운영상 필요한 최소 데이터는 익명화하여 보존(Legal/Safety).
- **Monitoring**: 탈퇴 요청 실패 시 `CrashlyticsService.recordNonFatal`을 통해 즉시 추적.

## 5. QA Results
- **flutter analyze**: Success.
- **account deletion tests**: `AccountDeletionScreen` UI 및 유효성 검사 테스트 통과.
- **functions-v2 npm test**: 102 tests passing (새로운 탈퇴 로직 및 헬퍼 테스트 포함).
- **regression tests**: Feedback, Moderation, Monitoring 등 기존 기능 정상 작동 확인.
- **firestore rules review**: 적용 완료.

## 6. Known Limitations
- **Storage Cleanup**: 현재 로직은 DB 필드만 정리하며, Storage에 저장된 실제 이미지 파일의 물리적 삭제는 대량 작업의 위험성으로 인해 Beta 2 이후 Batch 스케줄러로 구현 검토 예정.
- **Active Transactions**: 활성 결제나 거래 중인 상태에서의 탈퇴 제한 로직은 현재 안내 문구로만 제공됨.

## 7. Next Step
- **P6-S07 Real Device Beta Smoke Test Checklist**: 실제 기기 배포 전 최종 점검 리스트 작성 및 확인.
