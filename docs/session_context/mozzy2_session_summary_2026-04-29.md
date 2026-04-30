# Mozzy2 Session Summary — 2026-04-29

## 1. Purpose
This document summarizes the current Mozzy2 development state for future AI sessions.

## 2. Latest Verified Commits
- Latest Local News Feature Commit: 51340cf132b5d7efa22205dbb855038918fd3f4e
- Latest Marketplace Feature Commit: 382ebef9ffc16f18a3cae7ca116aff47b9ba453f
- Latest Session Handoff Commit: 382ebef9ffc16f18a3cae7ca116aff47b9ba453f

## 3. Current Development Phase
- Phase 1: Completed / locked
- Phase 2 Local News: Core flow completed
- Current Local News status:
  - List: completed
  - Create: completed
  - Detail: completed
  - CrossLinkSection foundation: completed
  - Basic comments: completed
  - P2-U10-A Reply support foundation: completed
  - P2-U10-B Secret comments visibility: completed
  - Automated integration test: completed
  - Human manual Android smoke test: pending
  - Image upload: deferred
  - Comment likes: deferred
  - AI moderation: deferred
- Current Marketplace status:
  - P2-B1 ProductModel + Repository foundation: completed
  - P2-B2 MarketplaceListScreen foundation: completed
  - P2-B3 ProductDetailScreen foundation: completed

## 4. Confirmed Architecture
- Flutter + Firebase
- Riverpod
- GoRouter
- easy_localization JSON
- Firestore path:
  countries/ID/domains/local_news/posts/{postId}
- Comments path:
  countries/ID/domains/local_news/posts/{postId}/comments/{commentId}
- Integration test mode:
  --dart-define=MOZZY_INTEGRATION_TEST=true

## 5. Important Test Mode Architecture
To bypass the real Google UI and Firebase calls during automated E2E testing, an `IntegrationTestConfig` singleton is triggered by the `MOZZY_INTEGRATION_TEST=true` flag.
- **AuthGate bypass**: The app routing bypasses `AuthGate` logic directly to `/home`, supplying a deterministic `testUserId`.
- **GoogleSignInConfig skip**: It skips the physical initialization of Google Sign-In missing Client ID exceptions in tests.
- **Deterministic location**: In test mode, an `effectiveLocationProvider` intercepts location requests, emitting a static Jakarta location (`Kebayoran Baru, Jakarta Selatan, Senayan`).
- **InMemoryPostRepository / InMemoryCommentRepository**: In-memory fake repositories replace the actual `PostRepository` and `CommentRepository` within Riverpod DI to allow CRUD without interacting with Firebase or needing real auth permissions.
- **Why this does not affect production**: These mocks are strictly walled behind the compile-time flag or `bool.fromEnvironment` check, seamlessly switching to live Firebase mechanisms when compiled normally.

## 6. Local News Implemented Files
Key files implemented:
- `lib/mozzy_ii/domains/news/models/post_model.dart`
- `lib/mozzy_ii/domains/news/models/comment_model.dart`
- `lib/mozzy_ii/domains/news/repositories/post_repository.dart`
- `lib/mozzy_ii/domains/news/repositories/comment_repository.dart`
- `lib/mozzy_ii/domains/news/repositories/in_memory_post_repository.dart`
- `lib/mozzy_ii/domains/news/repositories/in_memory_comment_repository.dart`
- `lib/mozzy_ii/domains/news/providers/posts_provider.dart`
- `lib/mozzy_ii/domains/news/providers/comments_provider.dart`
- `lib/mozzy_ii/domains/news/screens/local_news_list_screen.dart`
- `lib/mozzy_ii/domains/news/screens/create_post_screen.dart`
- `lib/mozzy_ii/domains/news/screens/local_news_detail_screen.dart`
- `lib/mozzy_ii/domains/news/widgets/local_news_card.dart`
- `lib/mozzy_ii/domains/news/widgets/cross_link_section.dart`
- `lib/mozzy_ii/domains/news/widgets/comments_section.dart`
- `integration_test/local_news_e2e_test.dart`

## 7. Firestore Rules Summary
- **Posts Rules (`countries/{country}/domains/local_news/posts/{postId}`)**:
  - Read: Allowed for all authenticated users.
  - Create: Requires authenticated user, matching `userId`, non-null `location`, and a string `geoPath`.
  - Update/Delete: Permitted only for the matching `userId`.
- **Comments Subcollection Rules (`.../comments/{commentId}`)**:
  - Read: Allowed for all authenticated users.
  - Create: Requires authenticated user, matching `userId`, matching `postId`, a non-empty string `content`, and initial `isDeleted == false`.
  - Update/Delete: Permitted only for the matching `userId`, and `userId` and `postId` fields are immutable.
- **Auth Requirements**: Core dependency on `request.auth != null`.
- **Soft Delete**: Deletion flag updates `isDeleted` to true instead of removing the document directly.

## 8. Test Status
- `flutter analyze`: passed
- `flutter test`: passed
- Local News integration test: passed on connected Android device
- Human manual smoke test: pending

## 9. Known Deferred Items
- Human manual Android smoke test
- Image upload
- Comment likes
- AI moderation
- Marketplace ProductModel
- MarketplaceRepository
- Firebase emulator CI

## 10. Next Recommended Task
Recommended next task:
P2-B4 CreateProductScreen foundation

Reason:
Marketplace detail foundation is now locked.

Keep warning:
Do not start payment, Xendit, chat, escrow, or AI verification API yet.

## 11. Rules for Future AI Sessions
- Do not duplicate `domains/news` into `domains/local_news`.
- Do not hardcode GOOGLE_WEB_CLIENT_ID.
- Do not remove integration test mode.
- Do not mark manual Android smoke test as passed unless a human actually confirms.
- Always update CHECKLIST.md and Sprint Guide.
- Always run analyze/test/integration test before commit.
- Always commit and push with clear message.
## 12. Session Summary Regeneration Trigger
Regenerate or update this session summary when:
- A new chat session starts
- CHECKLIST.md or Sprint Guide changes
- A phase report is created
- A new feature commit is pushed
- Context/token limit is approaching
- Before switching from Local News to Marketplace
