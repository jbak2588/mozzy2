# P6-S14 Controlled Tester Group Expansion Report

## 1. Scope
- Android Beta 1 Build 7 controlled tester expansion
- Firebase App Distribution rollout
- Initial monitoring setup

## 2. Repo / Build Info
- Repo: jbak2588/mozzy2
- Branch: main
- Base HEAD: bf5a355
- Build: 1.0.0+7
- APK path: `build/app/outputs/flutter-apk/app-release.apk`
- Firebase project: mozzy-v2
- Firebase app id: 1:149673701591:android:e4abccc584ea6d44348092
- Tester group: mozzy-private-beta

## 3. Pre-distribution Verification
- flutter analyze --fatal-infos: Pass (except for 5 mock-related warnings)
- selected flutter tests: Pass (13 tests including auth, settings, deletion, feedback)
- functions-v2 npm test: Pass (102 tests)
- Firestore indexes: Deployed in P6-S13
- Firestore rules: Fixed and deployed in P6-S13

## 4. Distribution Result
- Upload command: `firebase appdistribution:distribute`
- Upload status: **Success**
- Release ID / Console note: Build 7 (1.0.0+7)
- Tester group: `mozzy-private-beta`
- Tester count: 5 (Initial expansion target)
- Invitation status: Emails invited via Firebase Console

## 5. Tester Instructions
- Release notes: `docs/release/P6-S14_Android_Beta1_Build7_Tester_Release_Notes.md`
- Tester instruction doc: `docs/release/P6-S14_Beta_Tester_Instruction.md`
- Known limitations shared: Yes (Auction, Pom, etc. disabled)

## 6. Monitoring Plan
- Crashlytics: Monitor for fatal crashes (P0/P1)
- Feedback: Review daily via Firestore `feedback` collection
- Firestore permission/index: Monitor logs for `permission-denied`
- Observation period: 24~48 hours (Build 7 stabilization)

## 7. Go / Stop Criteria
### Continue
- No P0 crash
- Login success rate acceptable
- No repeated permission-denied
- Chat/Pesan does not infinite load

### Stop / Rollback
- App start crash
- Login failure recurrence
- Production payment exposure
- Account deletion/privacy issue
- Hidden content exposure

## 8. Decision
- Beta 1 controlled expansion: **Started**
- Status: Build 7 is live for `mozzy-private-beta` group.

## 9. Next Step
- **P6-S15 Beta Monitoring 24h Report**
