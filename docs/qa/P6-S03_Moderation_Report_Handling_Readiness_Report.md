# P6-S03 Moderation / Report Handling Readiness Report

## 1. Scope
- Beta 1 UGC(사용자 생성 콘텐츠) 안전성 확보를 위한 최소한의 Moderation 로직 추가
- 대상 도메인: News, Marketplace, Jobs

## 2. Implementation Summary
- **ReportModel**: `ReportModel` 및 `ReportTargetType`, `ReportReason`, `ReportStatus`, `ModerationStatus` enum 설계 및 적용. (Freezed 활용)
- **ModerationService / ReportRepository**: Firestore `reports` 컬렉션에 사용자 신고를 접수하고, 어드민 권한으로 target document를 `hidden` 처리하는 비즈니스 로직 작성.
- **UI Components**:
  - `ReportButton`: 각 콘텐츠 상세 화면(News, Marketplace, Jobs) AppBar 액션에 추가. 본인 게시물은 보이지 않도록 필터링.
  - `ReportReasonSheet`: 신고 사유(Spam, Scam, Offensive 등)를 선택하고 세부 설명을 기재할 수 있는 BottomSheet.
  - `AdminModerationScreen`: 관리자가 Pending 상태의 신고 목록을 조회하고 'Hide content', 'Dismiss' 등의 액션을 취할 수 있는 최소 대시보드. `/admin/moderation` 경로 할당.
- **Hidden content filtering**: News, Marketplace, Jobs 및 Smart Feed(Repository 계층)에서 `moderationStatus == 'hidden' || 'removed'`인 콘텐츠를 목록 및 상세 보기에서 제외.
- **Cloud Function**: `onReportCreated` 함수를 추가하여 신고 누적 시 target의 `reportCount`를 증가시키고, 3회 누적 시 `moderationStatus`를 자동으로 `underReview`로 변경.
- **Firestore Rules**: 
  - `reports` 컬렉션 생성. 일반 사용자는 자신의 reporterId로 'pending' 상태만 생성 가능.
  - `isAdmin()` 함수 활용하여 관리자만 reports 읽기/수정 권한 부여 및 target 콘텐츠의 moderation 필드 수정 권한 부여.
- **i18n**: 영어, 인도네시아어, 한국어 번역 키 추가.

## 3. Firestore Schema
- **`reports` collection**: 신고 내역 문서화 (`targetType`, `targetId`, `reason`, `reporterId` 등)
- **Target content (News, Marketplace, Jobs)**: `moderationStatus`, `reportCount`, `hiddenBy`, `hiddenAt` 등의 필드 추가 대응.

## 4. Privacy / Safety
- reporterId는 데이터베이스에만 기록되며 노출되지 않음.
- 일반 사용자는 report 데이터를 읽을 수 없으며 쓰기 권한은 본인 UID & pending 생성으로 엄격히 제한.
- hidden/removed 처리된 콘텐츠는 일반 사용자 데이터 쿼리에서 노출이 차단됨.

## 5. QA Results
- **flutter analyze**: No blocking issues.
- **moderation tests**: `ReportModel`, `ReportReasonSheet` 등 테스트 완료. 
- **beta/feed regression tests**: 통과.
- **functions-v2 npm test**: 99 tests passing (onReportCreated helper test 추가).
- **firestore rules review**: 적용 완료.

## 6. Known Limitations
- AI 기반 자동 검열/스팸 필터링은 포함되지 않음.
- 악성 유저의 계정 정지(Suspension) 기능은 추후 개발 예정.
- Chat 도메인의 신고 플로우는 메시지 문맥 저장이 필요하여 Beta 2 이후로 연기.

## 7. Next Step
- **P6-S04 Crashlytics / Performance Monitoring Setup** (또는 Feedback/CS Channel Setup)
