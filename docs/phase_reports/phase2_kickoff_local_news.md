# Phase 2 Kickoff — Local News

Date: 2026-04-28
Commit: 4554a4a

## Summary
- First Feature for Phase 2: Local News (Berita Lokal)
- Reason: lower external dependencies (no payment/AI/complex uploads), good for validating Firestore CRUD + location-based feed and Shared Contract application.
 - Progress: P2-U3 LocalNewsListScreen implemented (list UI, category chips, kecamatan-based query, empty/loading/error states). Commit: 62a1220
 - Progress: P2-U5 CreatePostScreen implemented and validated (basic validation + geoPath + fixed test hang). Commit: 6991b45

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
