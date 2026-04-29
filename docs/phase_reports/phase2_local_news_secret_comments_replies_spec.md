# Phase 2 Local News P2-U10 — Secret Comments / Replies Spec

## 1. Purpose
Define the secure architecture for Local News secret comments and replies before implementation.

## 2. Current Comment System
- CommentModel exists.
- parentCommentId is already nullable and reserved for replies.
- Basic top-level comments are implemented.
- Firestore path:
  countries/ID/domains/local_news/posts/{postId}/comments/{commentId}

## 3. Feature Scope
### Included in P2-U10 Implementation
- Reply support using `parentCommentId`
- One-level replies first
- Secret comment option
- Secret reply option
- UI labels for secret comments
- Integration test coverage

### Excluded for P2-U10
- Deep nested replies
- Likes
- AI moderation
- Push notifications
- Rich media/image comments

## 4. Privacy Principle
Secret comment content must never be readable by users who are not allowed to view it.

Allowed viewers:
- Comment author
- Parent post author
- Reply author, if applicable
- Admin/moderator in future admin flow only, not implemented now

## 5. Recommended Data Model Extension
Add fields to CommentModel:

```dart
bool isSecret;
String postOwnerId;
String? parentCommentId;
String? parentCommentOwnerId;
List<String> visibleToUserIds;
```

Rules:
- `isSecret == false`: visible to authenticated users.
- `isSecret == true`: visible only to users in `visibleToUserIds`.
- `visibleToUserIds` should include:
  - comment author
  - post owner
  - parent comment owner if reply

## 6. Firestore Security Strategy
Do not rely only on UI hiding.
Firestore rules must prevent unauthorized reads.

Suggested rule:
- public comments can be read by authenticated users.
- secret comments can be read only when `request.auth.uid in resource.data.visibleToUserIds`.

Important:
Firestore queries must be compatible with rules.

## 7. Query Strategy
Because mixed public + secret comments may break query authorization, use separate queries:

1. Public comments query:
```text
where isDeleted == false
where isSecret == false
orderBy createdAt asc
```

2. Secret comments visible to current user:
```text
where isDeleted == false
where isSecret == true
where visibleToUserIds array-contains currentUserId
orderBy createdAt asc
```

Then merge and sort in Dart by createdAt.

## 8. Repository Strategy
Add methods:

```dart
Future<List<CommentModel>> fetchVisibleComments({
  required String postId,
  required String currentUserId,
});
```

Internally:
- fetch public comments
- fetch secret comments visible to current user
- merge
- deduplicate
- sort by createdAt

## 9. UI Strategy
CommentsSection should show:
- Public comment normally
- Secret comment badge: `Rahasia` / `Secret` / `비밀`
- Reply button
- Reply input mode
- Secret toggle

Minimum UI keys:

```dart
Key('commentSecretToggle')
Key('commentReplyButton_<commentId>')
Key('commentReplyInputField')
Key('commentReplySubmitButton')
```

## 10. Firestore Rules Draft
Write draft rules but do not apply in this task unless specifically implementing.

## 11. Integration Test Plan
Extend existing integration test:
1. Create public comment.
2. Create secret comment.
3. Create reply.
4. Verify visible comments render.
5. Verify secret badge appears.
6. Verify reply content appears.

Authorization boundary test is deferred to Firebase emulator CI.

## 12. Risks
- Firestore query rejection if rules and queries do not align.
- Secret content leakage if UI-only hiding is used.
- Need `postOwnerId` on comment to avoid repeated parent post lookups.
- Need array-contains query index for `visibleToUserIds`.

## 13. Implementation Recommendation
Implement P2-U10 in two commits:
1. Reply support foundation
2. Secret comment visibility and rules
## 14. Progress
- P2-U10-A Reply support foundation: Implemented / Commit: c43ddd53a6375ba162d581df43df2a0582bffdd4
- P2-U10-B Secret visibility and rules: Implemented / Commit: 51340cf132b5d7efa22205dbb855038918fd3f4e
