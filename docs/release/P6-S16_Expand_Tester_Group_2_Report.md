# P6-S16 Expand Tester Group 2 Report

## 1. Scope
- Expand Android Beta 1 tester group after stable 24h monitoring
- Address low tester activity by increasing sample size

## 2. Base State
- Build: 1.0.0+7
- Firebase project: mozzy-v2
- Tester group: mozzy-private-beta
- P6-S15 status: Continue
- P0: 0
- P1: 0
- P2: 1 (Tester activity low)

## 3. Tester Expansion
- Previous tester count: 5
- Added tester count: 10
- Total tester count: 15
- Tester emails:
  - [redacted]
- Invitation status: Sent via Firebase App Distribution
- Install guide: Sent to new testers

## 4. Distribution
- Firebase App Distribution: mozzy-v2 Android App
- Build: 1.0.0+7
- Release notes: P6-S14_Android_Beta1_Build7_Tester_Release_Notes.md
- Tester instruction: P6-S16_Beta_Tester_Group2_Instruction.md

## 5. Monitoring Plan
- Observation period: 48 hours
- Crashlytics: Monitor for fatal crashes, non-fatal errors, app start crash, login crash, affected users.
- Feedback: Monitor for bug reports, usability issues, login/install issues, chat issues, marketplace issues.
- Firestore: Monitor for permission-denied, failed-precondition, chat_rooms query errors, feedback write errors, account deletion errors.
- Adoption: Track invited, accepted invite, installed app, opened app, logged in, submitted feedback.

## 6. Go / Stop Criteria
- Continue: P0=0, P1=0, successful login, no app start crash, no permission-denied loops, no chat infinite loading.
- Hotfix Required: 1+ P1 bugs, login failure on specific devices, Chat/Pesan issues, Account Settings/Logout failure, Feedback submission failure.
- Stop / Rollback: App start crash, complete login failure, privacy/PII exposure, production payment exposure, account deletion failure.

## 7. Decision
- Beta 1 tester group 2:
  - **Started**

## 8. Next Step
- P6-S17 Beta Monitoring 48h Report
