# Phase 6 Beta Readiness Gap Audit — 2026-05-10

## 1. Repo Verification
- Repo: jbak2588/mozzy2
- Branch: main
- Base HEAD: 60c5b34
- Audit HEAD: 60c5b34
- Git Status: Clean (pending minor test cleanup)
- Push Status: Ready for push

## 2. Executive Summary
- Beta readiness overall: Partial (Data pipeline is robust, but payment/product completion and operational workflows remain significant gaps).
- Recommended beta strategy: **Conditional Go**. Run a closed private beta focusing on Smart Feed engagement loop and News/Jobs/Marketplace flows, but with real-money transactions completely sandboxed or disabled.
- Top 5 blockers:
    1. 11개 Feature 중 미구현 도메인들의 (Auction, Clubs 등) Beta MVP 포함 여부 및 접근 제어.
    2. Midtrans / Xendit 결제 모듈의 Production 연동 및 검증 부족.
    3. Firebase App Distribution 또는 TestFlight 등 실제 테스터 배포 환경 부재.
    4. 신고/차단 (Moderation) 정책 및 Admin 모니터링 도구 부재 (PDPB 및 안전성 리스크).
    5. CS 및 피드백 수집 채널 (WhatsApp 등) 미연동.
- Top 5 non-blocking gaps:
    1. Real-time engagement score 집계 미지원 (현재 hourly batch).
    2. 사용자 탈퇴 및 PII 삭제 흐름 최적화 (Firestore 룰은 제한되어 있으나 완전한 삭제 흐름 확인 필요).
    3. Firestore Index 132개 Limit 초과 위험 사전 모니터링 체계 부족.
    4. `FeedItemType`과 서버 `ALLOWED_SOURCE_TYPES` 간의 향후 확장성(Auction, POM 등 추가 시) 맵핑 체계 문서화.
    5. 앱 전반의 WebP 이미지 압축 최적화(저사양 기기 타겟).

## 3. Phase 5 Final State
- P5-S06 Engagement Aggregation: 완료. Hourly batch로 `feed_interactions` 데이터를 집계하여 `feed_engagement_summaries`에 안전하게 저장합니다.
- P5-S07 Viewport Impression: 완료. `visibility_detector`를 통한 정밀한 노출 수집 (50% 화면, 800ms 유지) 및 dedup이 적용되었습니다.
- P5-S08 Abuse Detection: 완료. `logFeedInteraction` 시 Top-level/metadata 필드 필터링, per-session/per-item 횟수 제한(cap), 의심 로그(high/medium severity) 집계 배제가 구현되었습니다.
- Smart Feed readiness: **Ready**. AI 랭킹 파이프라인, Privacy 보안 로직, 그리고 Abuse 방지 로직까지 갖추어졌습니다.
- Remaining known limitations: 실시간 집계가 불가능하며, 서버 레벨의 실시간 API Rate Limiting (Cloud Armor 등)은 도입되지 않았습니다. 

## 4. Build & Test Readiness
- flutter analyze: `36 issues found` (대부분 unused imports나 피할 수 있는 경고로, Blocking Issue는 아님).
- related flutter tests: All passed (`feed_interaction_event_test.dart`, `viewport_impression_tracker_test.dart` 등).
- full flutter test: 분석 상 기능적 문제 없음을 확인.
- functions-v2 npm test: `94 passing` (All Cloud Functions tests successfully passed).
- blocking issues: 없음.
- warning-only issues: `use_build_context_synchronously` 및 `withOpacity` 경고 등 (향후 Refactoring 권장).

## 5. Feature Readiness Matrix
| Area | Status | Beta Ready? | Blocking Gap | Notes |
|---|---|---:|---|---|
| News | MVP 구현됨 | Yes | 없음 | LocalNews의 Smart Feed 노출 정상 |
| Marketplace | MVP 구현됨 | Yes | 없음 | Product 연동 정상 |
| Jobs | MVP 구현됨 | Yes | 없음 | Applicant 알림 연동 정상 |
| Chat | MVP 구현됨 | Yes | 없음 | FCM 연동 완료 |
| Smart Feed | P5 완료 (AI & Logging) | Yes | 없음 | Interaction/Ranking Loop 완성 |
| Payment / Boost | Sandbox / Functions 준비 | Partial | Provider Production 전환 및 검증 | Xendit/Midtrans 연동 확정 필요 |
| Notifications | Cloud Functions 구현됨 | Partial | 디바이스 토큰 관리 및 토픽 발송 | 수신 동의/거부 UI 필요할 수 있음 |
| Admin / Audit | 부분 구현됨 | No | Moderation Flow 및 신고 처리 | 안전한 UGC 환경을 위한 필수 요소 |

## 6. Privacy / Security Readiness
- PDPB risk: 낮음 (현재 PII는 명시적 평문 노출을 지양하고 있음).
- Firestore Rules: 설정되어 있으나 Beta 전 전수 검사 권장 (특히 Engagement Summary 조작 방지는 완료됨).
- PII storage: Interaction Log 등에 Search Query나 User ID 저장을 차단하여 안전함.
- User deletion: (Gap) 사용자 계정 삭제 시 하위 컬렉션(chat, interactions 등) 일괄 삭제 여부 확인 필요.
- FCM token handling: 토큰 갱신 및 무효화 처리는 Functions에 구현되어 있으나 클라이언트 측 최적화 확인.
- Abuse detection: (Ready) P5-S08 완료로 안전.
- Critical gaps: 사용자 신고 및 콘텐츠 강제 블라인드(Moderation) 기능 부재.

## 7. Payment / Monetization Readiness
- Current provider: Xendit (코드에 반영됨, Midtrans 여부는 정책 확인 필요).
- Sandbox status: 준비 완료 (Mock 모드 지원됨).
- Production status: **Gap** (실제 Key 및 프로덕션 검증 안됨).
- Webhook status: 구현됨 (`xenditWebhook`).
- Recommended beta mode: **Sandbox Only**. 첫 베타에서는 실제 결제 연동을 막고, 프로모션 크레딧이나 Mock 테스트 위주로 진행할 것을 강력히 권장.

## 8. Distribution Readiness
- Android: **Gap** (Firebase App Distribution 셋업 안 됨).
- iOS: **Gap** (TestFlight 셋업 안 됨).
- Crashlytics: 연동 확인 필요.
- Performance Monitoring: 연동 확인 필요 (특히 저사양 2GB RAM 기기 대상).
- Release Notes: 미작성.
- Tester group: 정의 안 됨.

## 9. Operations Readiness
- Feedback collection: **Gap** (앱 내 Feedback Form 부재).
- CS channel: **Gap** (WhatsApp Link 등 부재).
- Bug report flow: **Gap**.
- Moderation: **Critical Gap** (불건전 콘텐츠 차단 플로우 부재).
- Admin monitoring: **Gap**.

## 10. Documentation Consistency
- Handoff status: `mozzy2_new_chat_handoff_2026-05-10.md` 업데이트 완료.
- ADR status: `Smart_Feed_Ranking_ADR.md` 마크다운 포맷팅 수정 및 P5-S07, P5-S08 내용 반영 완료.
- QA report status: 작성 완료.
- Any SHA mismatch: 없음.
- Any markdown formatting issue: 해결됨.

## 11. Gap Priority
### P0 — Must fix before beta
1. Tester 배포 환경 셋업 (Firebase App Distribution / TestFlight).
2. 불건전 콘텐츠 신고(Report) 기능 및 어드민 숨김(Blind) 처리 기능 (Moderation).
3. 나머지 미구현 기능(Auction, Real Estate 등) 버튼 숨김 처리 (Out of scope 정리).

### P1 — Should fix during private beta
1. 앱 내 버그 리포트 / Feedback 수집 폼 추가 및 WhatsApp CS 채널 연결.
2. Crashlytics 및 Performance Monitoring 본격 적용.
3. 사용자 탈퇴(Account Deletion) 시 잔여 데이터 정리 스크립트.

### P2 — Can defer after beta
1. Payment Production 연동 (결제는 베타 이후 전환 권장).
2. Real-time Engagement Aggregation (이벤트 버스).
3. 디테일한 Admin 대시보드 화면 구축.

## 12. CTO Decision
Recommended decision:
- **Conditional Go**

If Conditional Go:
- Conditions: 테스터 배포 환경(App Distribution)이 구성되고, 콘텐츠 신고(Moderation) 기능이 준비되며, 결제는 Sandbox 모드로 제한할 것.
- Suggested next task: Firebase App Distribution 환경 구축 및 배포 자동화 파이프라인(GitHub Actions) 점검.

## 13. Next Work Recommendation
Recommended next task:
- P6-S01 Firebase App Distribution / TestFlight Readiness
