# Phase 2 Local News P2-U10-A — Replies Foundation Report

## 1. Scope
This report documents the completion of the reply support foundation, which is the first half of P2-U10 (Secret Comments / Replies).

## 2. Implementation Summary
- **CommentModel**: Leveraged the existing `parentCommentId` field and added a convenience `isReply` getter.
- **CommentRepository**: Split fetch methods into `fetchTopLevelComments` and `fetchReplies` to securely handle UI separation while delegating the legacy `fetchComments` method to `fetchTopLevelComments` for backward compatibility.
- **Providers**: Added a `ReplyQuery` and `repliesByCommentProvider` to enable localized, sub-widget fetching of replies to keep the Riverpod graph clean.
- **UI Structure**: Refactored `CommentsSection` to separate out a `_CommentItem` widget that autonomously fetches and displays its replies with one-level nesting below the parent.
- **Firestore Path**: Continues using `countries/ID/domains/local_news/posts/{postId}/comments/{commentId}` without changes.

## 3. Test Coverage
- Unit tests added to `in_memory_comment_repository_test.dart` asserting top-level fetching logic and isolated reply queries.
- Widget tests updated in `comments_section_test.dart` to simulate "replying" mode and visually confirm rendering of replies.
- End-to-end integration test (`local_news_e2e_test.dart`) expanded to successfully reply to the initial test comment.

## 4. Deferred Items (P2-U10-B)
- Secret visibility flags (`isSecret`, `visibleToUserIds`, etc.).
- Update of Firestore Rules to securely restrict reads.
- Deep nested replies (not planned for Phase 2).