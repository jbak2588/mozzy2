# P3-J09 Jobs Firestore Rules Hardening Report

## 1. 개요
Jobs 도메인 MVP 완료 후, 보안 취약점을 최소화하기 위해 Firestore Rules를 강화하였습니다. 기존 `hasAny` 중심의 정책을 `hasOnly`로 변경하여 허용되지 않은 필드에 대한 수정을 차단하고, 데이터 무결성을 보장하기 위한 제약 조건을 추가하였습니다.

## 2. 주요 Rules 변경 사항

### A. Applicants Subcollection (`job_posts/{jobId}/applicants/{applicantId}`)
- **Create**: 
  - 본인만 생성 가능 (`request.auth.uid == applicantId`).
  - 문서 내 `applicantId`, `jobId`가 실제 경로 정보와 일치해야 함.
  - 해당 구인글이 `open` 상태이며 `isDeleted == false`일 때만 지원 가능.
  - 지원 상태 초기값은 `new` 또는 `newApplicant`만 허용.
  - 구인글 작성자(Owner)는 본인 공고에 지원 불가.
- **Update (Owner)**:
  - 지원자 상태(`status`) 및 관리용 메타데이터(`updatedAt`, `lastInteractionAt`, `messagePreview`)만 수정 가능하도록 `hasOnly` 적용.
  - `applicantId`, `jobId`, `appliedAt` 등 핵심 필드 수정 불가.
- **Update (Applicant)**:
  - 채팅 관련 필드(`chatRoomId`, `lastInteractionAt`, `messagePreview`) 및 `updatedAt`만 수정 가능하도록 `hasOnly` 적용.
  - **지원 상태(`status`) 직접 변경 절대 불가** (`request.resource.data.status == resource.data.status`).

### B. Job Posts (`job_posts/{jobId}`)
- **Update**:
  - 소유자(Owner)도 `ownerId`, `createdAt` 필드는 수정 불가 (Immutable).
  - 제3자는 `applicantCount`, `chatCount`, `updatedAt` 필드만 수정 가능하도록 제한 (지원/문의 시 카운트 증가용).
- **Delete**:
  - 물리적 삭제 차단 (`allow delete: if false`). 대신 `isDeleted` 플래그 사용 권장.

### C. Notifications (`notifications/{notificationId}`)
- **Update**:
  - 수신자 본인만 `isRead`, `readAt` 필드 수정 가능하도록 `hasOnly` 적용.
- **Create/Delete**:
  - 클라이언트 사이드 생성/삭제 차단. 서버(Cloud Functions)에서만 관리.

### D. Chat Rooms (`chat_rooms/{roomId}`)
- **Update**:
  - 메시지 메타데이터 및 읽지 않은 개수 관련 필드만 수정 가능하도록 `hasOnly` 적용.

## 3. 회귀 테스트 결과
| 항목 | 결과 | 비고 |
|:---|:---:|:---|
| 구인글 생성 | **PASS** | Owner 권한 정상 동작 |
| 구직 지원 | **PASS** | Applicant 생성 규칙 준수 시 정상 지원 |
| 상태 변경 (Owner) | **PASS** | `status` 업데이트 정상 반영 |
| 상태 변경 시도 (Applicant) | **PASS** | 지원자 본인이 status 변경 시도 시 차단 확인 |
| 알림 읽음 처리 | **PASS** | `isRead` 업데이트 정상 반영 |
| 채팅 메시지 전송 | **PASS** | `chat_rooms` 메타데이터 업데이트 정상 반영 |

## 4. 결론
이번 보안 강화를 통해 Jobs 도메인의 데이터 무결성이 한층 강화되었습니다. 특히 지원자가 자신의 상태를 조작하거나, 타인의 공고에 비정상적으로 지원하는 행위를 규칙 레벨에서 차단하였습니다.

---
**작성자**: Antigravity (AI Agent)
**Git Commit**: [SHA를 작업 완료 보고 시 기입 예정]
