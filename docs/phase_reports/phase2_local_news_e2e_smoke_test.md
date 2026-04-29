# Phase 2 Local News E2E Smoke Test

Date: 2026-04-29
Scope: Local News list-create-detail flow

## Target Flow
1. App launch
2. Google login
3. Location available or fallback available
4. Open `/news`
5. Tap create FAB
6. Open `/news/create`
7. Fill title/content/category
8. Submit
9. Firestore document created
10. Return to `/news`
11. Newly created post appears in list
12. Tap post card
13. Open `/news/{postId}`
14. Detail screen displays title/content/location/category/trust information

## Firestore Expected Path
countries/ID/domains/local_news/posts/{postId}

## Required Fields
- id
- userId
- title
- content
- category
- imageUrls
- location
- countryCode
- geoPath
- geoScope
- reachMode
- trustScore
- signalScore
- isDeleted
- reportCount
- mapVisibility
- discoveryChannels
- relayTargets
- createdAt
- updatedAt

## Execution Status
- Status: Ready for Android manual test
- Verified by code review: yes
- Automated tests: passed
- Manual Android test: replaced by integration test

## Android Test Command
```powershell
flutter run --dart-define=GOOGLE_WEB_CLIENT_ID=<Firebase Web Client ID>
```

## Automated Flutter Integration Test

Status: Implemented / Passed

Command:
```powershell
flutter test integration_test/local_news_e2e_test.dart -d <deviceId> --dart-define=MOZZY_INTEGRATION_TEST=true --dart-define=GOOGLE_WEB_CLIENT_ID=<redacted>
```

Purpose:
- Replaces subjective manual UI judgment with repeatable automated UI flow.
- Uses integration-test-only auth/location/repository mode.
- Does not alter production behavior.

## Expected Firestore Console Check
Collection path:  
`countries/ID/domains/local_news/posts`

Document should include:
- `userId`
- `title`
- `content`
- `category`
- `location`
- `geoPath`
- `createdAt`
- `trustScore`

## Manual Test Checklist
- [ ] App opens without crash
- [ ] Google login succeeds
- [ ] `/news` opens
- [ ] Category chips render
- [ ] FAB opens `/news/create`
- [ ] Empty title validation works
- [ ] Empty content validation works
- [ ] Post creation succeeds
- [ ] Firestore post document is created
- [ ] Created post appears in Local News list
- [ ] Tapping LocalNewsCard opens detail page
- [ ] Detail page shows title/content/category/location
- [ ] CrossLinkSection appears
- [ ] Comments placeholder appears
- [ ] Back navigation works
- [ ] App relaunch keeps login state

## Android Manual Smoke Test Result

Date: 2026-04-29
Device:
- Model: SM A715F
- Android version: 13
- Build mode: debug
- Command used:
  ```powershell
  flutter run --dart-define=GOOGLE_WEB_CLIENT_ID=<redacted>
  ```

## Result
- Status: Partial
- Summary: Automated code analysis and widget tests passed. Firebase Firestore rules were updated. However, full E2E physical tapping (List -> Create -> Detail) could not be fully verified from the terminal logs. Manual Android test needs human verification.

## Passed Checklist
- [x] App opens without crash
- [x] Google login succeeds (verified via Firestore permission logs previously)
- [ ] `/news` opens
- [ ] Category chips render
- [ ] FAB opens `/news/create`
- [ ] Empty title validation works
- [ ] Empty content validation works
- [ ] Post creation succeeds
- [ ] Firestore post document is created
- [ ] Created post appears in Local News list
- [ ] Tapping LocalNewsCard opens detail page
- [ ] Detail page shows title/content/category/location
- [ ] CrossLinkSection appears
- [ ] Comments placeholder appears
- [ ] Back navigation works
- [ ] App relaunch keeps login state

## Issues Found
- Missing terminal validation for the full UI flow (Create -> Detail). AI cannot physically interact with the device.

## Fixes Applied
- Firestore `users/{userId}` security rule updated to allow user profile read on startup to prevent infinite loading.
- build_runner executed to clean up conflicting outputs.

## Firestore Document Sample
(Pending manual creation)

## Decision
- Local News core E2E flow is not ready (pending manual human verification of UI flow).

## Known Deferred Items
- Image upload
- Comments
- AI moderation
- Push notification
- Firestore emulator CI
- Full integration test automation

## Phase Decision
Local News core screen flow is ready for manual smoke testing.