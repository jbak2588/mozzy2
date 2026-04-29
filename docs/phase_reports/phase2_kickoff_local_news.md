# Phase 2 Kickoff — Local News

Date: 2026-04-28
Latest Docs Commit: 29b46c46557654a62fddfcbf93abf838e99e9e72

## Summary
- First Feature for Phase 2: Local News (Berita Lokal)
- Reason: lower external dependencies (no payment/AI/complex uploads), good for validating Firestore CRUD + location-based feed and Shared Contract application.

## Progress Log

### P2-U1 / P2-U2 — PostModel + PostRepository
- Status: Completed
- Commit: 20eecc080c4c9be21633b600ce1b232f52e3445e

### P2-U3 — LocalNewsListScreen
- Status: Completed
- Commit: 62a122045369305de708de1d55cc8b12870f6e20

### P2-U5 — CreatePostScreen
- Status: Completed
- Feature Commit: 4554a4a39b46475231bff8f9af4651fa12c9eb0a
- Docs Commit: c9be5d168e61f57a07024b769886cfeb0f8d854c
- Scope:
  - CreatePostScreen
  - /news/create route
  - LocalNewsListScreen FAB navigation
  - geoPath builder
  - validation tests

### P2-U4 — LocalNewsDetailScreen
- Status: Completed
- Scope:
  - LocalNewsDetailScreen
  - /news/:postId route
  - LocalNewsCard navigation
  - CrossLinkSection foundation
  - detail screen widget tests
- Commit: 5a0cfc0c7ba95b5e38e38e5a51327d9472d91af0

### P2-U4 Hotfix — DetailScreen Compile Verification
- Status: Completed
- Fix:
  - Removed unnecessary intl import (handled by easy_localization)
  - Fixed retry button i18n key to `news.retry`
  - Re-ran analyze/test successfully
- Commit: 6d9cc2b6185d519512073aa005565db818955ce8

## Scope (Initial)
- PostModel (Freezed) implementing `MozzyPostContract`
- PostRepository (Firestore CRUD, cursor pagination, fetchByKecamatan)
- PostsProvider (Riverpod AsyncNotifier / Stream)
- LocalNewsListScreen (category tabs, infinite scroll, signalScore sorting)
- LocalNewsDetailScreen (content, images, comments, CrossLinkSection)
- CreatePostScreen (image upload basic, category, location auto-insert)
- Firestore rules & indexes for `posts` collection
- Unit & widget tests

## Implementation Notes
- Keep `image` upload basic for kickoff; WebP and compression improvements deferred to Phase 4.
- Use `startAfterDocument` cursor pagination for list endpoints.
- `MozzyPostContract` must include `geoScope`, `reachMode`, `translationState`, `trustScore`, and `mapVisibility`.
- Firestore indexes: begin with minimal 6 indexes for list and query patterns; expand as queries are discovered.

## Out of Scope (Kickoff)
- AI moderation (Gemini) — deferred
- Smart Feed ranking tuning — deferred
- Push notifications — deferred
- Advanced image upload/resizing — deferred

## Acceptance Criteria for Kickoff
- `PostModel` serializes/deserializes correctly (Freezed + JSON)
- `PostRepository` can create and fetch posts by Kecamatan and category with cursor pagination
- `LocalNewsListScreen` renders list and category tabs without errors
- Basic `CreatePostScreen` saves posts to Firestore (emulator or dev project)
- Tests: at least 8 unit/widget tests for model/repo/list/create

## Next Steps
1. Assign owners for each P2-U unit.
2. Create initial `PostModel` and `PostRepository` PR.
3. Add Firestore emulator job to CI for rule/index verification.

Prepared by: GitHub Copilot
