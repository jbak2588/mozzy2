# Phase 3 Jobs Domain Handoff Document

## 1. 개요
Mozzy Indonesia 프로젝트의 Phase 3 "Jobs Domain MVP" 개발이 완료되었습니다. 본 문서는 구현된 기능, 데이터 구조, 서버 로직 및 향후 작업 제안을 포함합니다.

## 2. 완료 범위 (MVP Scope)
- **구인글 관리**: 생성, 수정, 상세 조회, 마감(Close), 보관(Archive), 복구(Restore).
- **구직 프로세스**: 지원하기(Lamar Sekarang), 채팅 문의(Chat Pemasang), 중복 지원 방지.
- **채팅 통합**: `job_inquiry` 타입의 채팅방 생성 및 구인글 정보 컨텍스트 카드 제공.
- **지원자 관리**: 지원자 목록 조회, 지원 상태 변경(New, Contacted, Shortlisted, Rejected, Hired).
- **알림 시스템**: 새 지원자 알림(Owner향), 지원 상태 변경 알림(Applicant향), FCM Push 메시지 연동.

## 3. 주요 기술 구현 사항

### A. 데이터 모델 (Firestore)
- **`job_posts`**: 구인글 메타데이터, 위치(geoPath), 상태(status), 지원자 수(applicantCount) 등.
- **`job_posts/{jobId}/applicants/{applicantId}`**: 특정 공고의 지원자 상태 및 채팅 링크.
- **`chat_rooms`**: `type: 'job_inquiry'` 필드를 통해 구인 구직 전용 채팅방 식별.
- **`notifications`**: 알림 문서 (jobId, applicantId 포함 확장).

### B. 서버 로직 (Cloud Functions v2)
- **`onJobApplicantCreated`**: 새 지원자 발생 시 Owner에게 알림 및 Push 발송.
- **`onJobApplicantStatusUpdated`**: 지원 상태 변경 시 Applicant에게 알림 및 Push 발송.

### C. 라우팅 및 내비게이션
- `/jobs/{jobId}`: 구인글 상세 페이지.
- `/jobs/{jobId}/applicants`: 지원자 목록 페이지 (Owner 전용).
- 알림 클릭 시 해당 경로로 자동 이동 처리 완료.

## 4. 보안 및 권한 (Firestore Rules Hardening)
- **접근 제어**:
  - 구인글 읽기: 누구나 가능 (Archived는 Owner 전용).
  - 구인글 관리: Owner만 가능 (OwnerId, CreatedAt 수정 불가).
  - 지원자 목록: Owner만 가능.
  - 지원자 본인 데이터: 지원자 본인 및 Owner만 가능.
- **필드 하드닝 (hasOnly 적용)**:
  - 지원자 상태 변경: **Owner만 가능**. Applicant 본인은 `status` 필드 수정 불가.
  - Applicant 수정 범위: 채팅 메타데이터(`chatRoomId`, `lastInteractionAt` 등) 및 `updatedAt` 필드로 제한.
  - Immutable Fields: `jobId`, `applicantId`, `appliedAt` 등 핵심 식별자 필드는 생성 후 수정 불가.
  - 알림 및 채팅: `isRead` 등 허용된 필드 외 모든 수정 시도 차단.

## 5. 다국어 지원 (i18n)
- 인도네시아어(id), 영어(en), 한국어(ko) 완벽 지원.
- 모든 통화는 `CurrencyService`를 통해 **IDR (Rp)**로 표시.

## 6. 테스트 결과 요약
- **Flutter Analyze**: 0 Issues.
- **Flutter Test (Jobs)**: All PASS.
- **Cloud Functions Test**: All PASS.
- **Staging QA**: 핵심 시나리오 9종 PASS.

## 7. 향후 작업 제안 (Next Steps)
- **이력서 업로드**: PDF/이미지 형태의 이력서 첨부 기능.
- **AI 직무 설명**: 구인글 작성 시 제목을 바탕으로 상세 내용 자동 생성 (Gemini 3.0 연동).
- **면접 일정 관리**: 채팅 내에서 면접 일정을 제안하고 캘린더에 등록하는 기능.
- **Job Boost**: 유료 결제(Midtrans)를 통한 공고 상단 노출 기능.
- **자동 매칭**: 구직자 프로필과 공고의 기술 스택을 비교하여 매칭 점수 제공.

## 8. 작업 이력 (Commit History)
- **P3-J01 ~ P3-J07**: Jobs Domain MVP 구현 (`64bce1b`)
- **P3-J08**: Jobs Final QA & i18n Fix (`44090ab`)
- **P3-J09**: Firestore Rules Hardening (`[SHA]`)

---
**최종 업데이트**: 2026-05-08
**담당 에이전트**: Antigravity (AI Agent)
