# P6-S05 Feedback / CS Channel Setup Report

## 1. Scope
- Private Beta 기간 동안 테스터의 피드백(버그, 개선 제안, 결제 문의 등) 수집 체계 구축.
- 테스터가 관리자에게 직접 연락할 수 있는 WhatsApp CS 채널 연동.
- 수집된 피드백을 관리자가 확인하고 상태를 관리할 수 있는 최소 관리 화면 구축.

## 2. Implementation Summary
- **FeedbackModel**: `bug`, `suggestion`, `usability`, `payment`, `account`, `safety`, `other` 등 상세 카테고리를 포함한 피드백 모델 설계. (Freezed 사용)
- **FeedbackRepository / FeedbackService**: Firestore `feedback` 컬렉션에 데이터를 저장하고, 제출 시 `PerformanceMonitoringService` 트레이스 및 실패 시 `CrashlyticsService` 에러 로깅 연동.
- **FeedbackScreen**: 피드백 유형 선택, 메시지 입력(최대 1000자), 연락처 정보(선택) 입력을 지원하는 제출 화면 구현. `/feedback` 라우트 할당.
- **WhatsApp CS channel service**: `url_launcher`를 사용하여 지정된 WhatsApp 번호로 딥링크 연결 지원. 번호는 `BETA_CS_WHATSAPP` dart-define으로 설정 가능.
- **AdminFeedbackScreen**: 관리자가 오픈된 피드백 목록을 조회하고 `In Review`, `Resolved`, `Dismissed` 상태로 업데이트할 수 있는 대시보드 구현. `/admin/feedback` 라우트 할당.
- **Entry Point**: 사용자 접근성을 위해 `SmartFeedScreen` 상단 AppBar에 피드백 버튼 추가.

## 3. Firestore Schema
- **`feedback` collection**:
  - `userId`: 제출자 UID
  - `type`: 피드백 카테고리
  - `message`: 상세 내용 (max 1000)
  - `contactPreference`: `none`, `whatsapp`, `email`
  - `contactValue`: 직접 입력한 연락처 정보
  - `appVersion`, `platform`, `appEnv`: 진단 정보
  - `status`: `open`, `inReview`, `resolved`, `dismissed`
  - `priority`: `low`, `medium`, `high` (기본 low/medium)

## 4. Privacy / Safety
- **개인정보 보호**: 이메일이나 전화번호를 자동으로 수집하지 않으며, 사용자가 명시적으로 입력한 경우에만 저장.
- **안내 문구**: NIK/KTP 등 민감 정보 입력을 지양하라는 안내 배너를 UI에 노출.
- **접근 제한**: Firestore Rules를 통해 일반 사용자는 자신의 피드백 생성만 가능하며, 타인의 피드백 읽기나 전체 목록 조희는 Admin만 가능하도록 제한.
- **Crashlytics**: 에러 로깅 시 피드백 메시지 원문이나 연락처 정보는 포함하지 않도록 처리.

## 5. QA Results
- **flutter analyze**: No issues found.
- **feedback tests**: `FeedbackModel` 직렬화 및 `FeedbackScreen` 위젯 렌더링/입력 테스트 통과.
- **monitoring regression tests**: `MonitoringDebugScreen` 및 `PerformanceMonitoringService` 테스트 정상.
- **moderation regression tests**: 신고 기능 및 Moderation 대시보드 영향 없음 확인.
- **functions-v2 npm test**: 99 tests passing.

## 6. Known Limitations
- **WhatsApp 번호 설정**: 실제 운영용 번호는 빌드 시 `dart-define`으로 주입해야 함. (미설정 시 버튼 비활성화)
- **앱 내 양방향 채팅**: 현재는 단방향 피드백 제출만 지원하며, 후속 응대는 입력된 연락처를 통해 외부 채널에서 진행해야 함.
- **첨부 파일**: 이미지나 스크린샷 첨부 기능은 Beta 2 이후 검토 예정.

## 7. Next Step
- **P6-S06 Account Deletion / Data Cleanup**: 개인정보 보호 및 PDPB 준수를 위한 계정 탈퇴 및 데이터 삭제 플로우 구축.
