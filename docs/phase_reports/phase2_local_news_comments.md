# Phase 2 Local News Comments Report

## Scope
Implemented basic top-level comments for Local News posts. Sub-comments (replies), secret comments, likes, and AI moderation are deferred to future tasks.

## Firestore Path
`countries/ID/domains/local_news/posts/{postId}/comments/{commentId}`

## Model fields
- `id` (String)
- `postId` (String)
- `userId` (String)
- `content` (String)
- `createdAt` (DateTime/Timestamp)
- `updatedAt` (DateTime/Timestamp, nullable)
- `isDeleted` (bool)
- `reportCount` (int)
- `trustScore` (double)
- `parentCommentId` (String, nullable)

*No sensitive PII (NIK, Phone, etc.) is included in this model.*

## Rules summary
- Read: Authenticated users can read all non-deleted comments.
- Create: Authenticated users can create comments containing non-empty content string for their own `userId`. `postId` must match the parent document path. `isDeleted` must be false initially.
- Update/Delete: Only the author can soft delete their own comment (updating `isDeleted`).

## Test results
Unit tests (`comment_model_test.dart`) and mock repository tests (`in_memory_comment_repository_test.dart`) passed successfully, confirming parsing and query behavior.
Widget tests (`comments_section_test.dart`) verified UI component rendering, validation, and interaction behavior without full app bootstrap.

## Integration test result
Extended `local_news_e2e_test.dart` to cover writing and displaying comments in the E2E user flow. The modified test execution successfully confirmed end-to-end functionality via the `MOZZY_INTEGRATION_TEST` flag routing to the in-memory provider.

## Deferred items
- Replies (`parentCommentId`)
- Secret comments
- Comment likes
- AI moderation checks for comment text
