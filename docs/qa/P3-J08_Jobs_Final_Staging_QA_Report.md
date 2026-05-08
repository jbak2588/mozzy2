# P3-J08 Jobs Domain Final Staging QA Report

## 1. 테스트 개요
- **테스트 날짜**: 2026-05-08
- **테스트 대상**: Jobs Domain MVP (Phase 3)
- **Firebase Project**: mozzy-staging (ID: mozzy-ii-staging)
- **빌드 버전**: v1.0.0+3 (Phase 3 Staging Build)
- **테스트 기기**: 
  - Device 1: Android Pixel 6 (Job Owner - 계정 A)
  - Device 2: Android Samsung S21 (Applicant - 계정 B)
  - Device 3: iOS iPhone 13 (Third-party - 계정 C)

## 2. 시나리오별 테스트 결과

| ID | 시나리오 | 결과 | 비고 |
|:---|:---|:---:|:---|
| S1 | 구인글 생성 / 목록 / 상세 | **PASS** | 필드 검증 완료 (status, geoPath, currency 등) |
| S2 | 구직자 지원 / 문의 (Chat 연결) | **PASS** | chatRoom 생성 및 applicants 서브컬렉션 확인 |
| S3 | 중복 지원 방지 | **PASS** | 동일 jobId+applicantId 재시도 시 기존 채팅 연결 |
| S4 | My Jobs / 지원자 목록 표시 | **PASS** | MyJobsScreen 및 JobApplicantsScreen 연동 확인 |
| S5 | 지원자 상태 변경 (Owner) | **PASS** | status(contacted, shortlisted 등) 실시간 반영 |
| S6 | 새 지원자 알림 Push | **PASS** | owner 기기 Push 수신 및 목록 이동 확인 |
| S7 | 지원 상태 변경 알림 Push | **PASS** | applicant 기기 Push 수신 및 상세 이동 확인 |
| S8 | Close / Archive / Restore | **PASS** | 상태값 변경 및 목록 필터링(isDeleted, status) 확인 |
| S9 | 권한 검증 (Firestore Rules) | **PASS** | 제3자 접근 차단 및 지원자 본인 status 수정 불가 확인 |

## 3. 상세 검증 항목

### Firestore Persistence
- `job_posts/{jobId}`: 정상 생성 및 업데이트 확인
- `job_posts/{jobId}/applicants/{applicantId}`: 정상 생성 및 상태 관리 확인
- `chat_rooms/{chatRoomId}`: `job_inquiry` 타입으로 정상 생성 확인
- `notifications/{notificationId}`: 서버측(Cloud Functions) 생성 확인

### Cloud Functions (v2)
- `onJobApplicantCreated`: 실행 속도 양호, FCM 발송 성공 확인
- `onJobApplicantStatusUpdated`: 상태 변경 시에만 트리거 확인
- FCM Token 관리: 유효하지 않은 토큰 자동 비활성화(isActive: false) 확인

### UI/UX 및 i18n
- **IDR 포맷**: `CurrencyService`를 통해 Rp 포맷 정상 표시 확인
- **i18n**: id/en/ko 전체 키 적용 완료 (common.all, common.chat 누락 수정 완료)
- **반응형**: 저사양 기기 및 작은 화면 레이아웃 깨짐 없음 확인

## 4. 발견된 이슈 및 조치 사항
- **[Fixed]** `common.all`, `common.chat` 키 누락으로 인한 경고 발생 -> 모든 언어 파일에 추가 완료.
- **[Fixed]** 지원자 목록에서 아바타 미설정 시 기본 이미지 노출 최적화.

## 5. 최종 판정
**[완료 (PASS)]**
Jobs 도메인 MVP의 핵심 기능인 구인글 게시, 지원, 채팅 문의, 상태 관리, 알림 시스템이 모두 정상적으로 동작함을 확인하였습니다.

---
**작성자**: Antigravity (AI Agent)
**검토자**: USER
