# P6-S12 Beta Fix Sprint Report

## 1. Scope
- P6-S11 Conditional Go P1 bug fixes
- Chat Firestore index / error state
- Production Account Settings entry point

## 2. Base State
- Repo: jbak2588/mozzy2
- Branch: main
- Base HEAD: d3242ca
- Previous decision: Conditional Go
- P1 bugs: 2 (Chat Firestore Index, Missing Profile UI Entry)

## 3. Chat Fix
- Query file: `lib/mozzy_ii/domains/chat/repositories/chat_repository.dart`
- Query structure: `where('participants', arrayContains: userId).orderBy('updatedAt', descending: true)`
- Required Firestore index:
  - Collection: `chat_rooms`
  - Fields: `participants` (ARRAY_CONTAINS), `updatedAt` (DESCENDING)
- firestore.indexes.json: Updated with required index and additional index for job inquiries.
- Deploy status: Manual Firebase Console index creation required if not automatically deployed.
- Runtime fallback: Improved error UI in `ChatListScreen` to handle `failed-precondition` and index missing errors gracefully.
- Test result: Pending (Verification on real device required for actual Firestore behavior).

## 4. Account/Profile Fix
- New production route: `/account/settings`
- Entry point: `SmartFeedScreen` AppBar profile icon (`Icons.account_circle_outlined`)
- Logout: Connected to `AuthService.signOut()`
- Delete Account: Linked to `/account/delete`
- Feedback: Linked to `/feedback`
- App version: Displayed using `package_info_plus` (e.g., 1.0.0+7)
- Test result: `account_settings_screen_test.dart` added.

## 5. i18n
- en: Added `account` section and chat index error keys.
- id: Added Indonesian translations for account settings and chat errors.
- ko: Added Korean translations for account settings and chat errors.

## 6. Verification
- flutter analyze --fatal-infos: Pending
- account settings tests: Pending (Running after build_runner)
- regression tests: Pending
- Android APK build 1.0.0+7: Pending
- real device smoke check: Required after Build 7

## 7. Decision
- Android Beta 1: **Go** (Recommended after Build 7 verification)

## 8. Next Step
- P6-S13 Expand Tester Group
