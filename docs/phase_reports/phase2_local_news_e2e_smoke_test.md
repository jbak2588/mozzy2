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
- Manual Android test: pending

## Android Test Command
```powershell
flutter run --dart-define=GOOGLE_WEB_CLIENT_ID=<Firebase Web Client ID>
```

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

## Known Deferred Items
- Image upload
- Comments
- AI moderation
- Push notification
- Firestore emulator CI
- Full integration test automation

## Phase Decision
Local News core screen flow is ready for manual smoke testing.