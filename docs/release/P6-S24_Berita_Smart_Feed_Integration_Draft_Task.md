# Draft Task: P6-S24 Berita Smart Feed Integration

## Goal
Add Berita / Local News posts to Smart Feed using the official Smart Feed architecture outlined in ADR-004.

## Scope
- Create `NewsFeedMapper` (Adapter) to normalize `PostModel` into `FeedItemModel`.
- Update `FirestoreSmartFeedRepository` to query the `posts` collection and include the results in the merge logic.
- Ensure the `PostModel` query supports pagination logic identical to Jobs and Marketplace.
- Add `News` or `Berita` to the Smart Feed type filter chips (UI).
- Ensure current Marketplace and Jobs feed functionality does not regress.
- Add unit tests for `NewsFeedMapper` and updated repository logic.

## Out of Scope
- Adding Stores or POM feeds.
- Full `signalScore` formula refactoring (this is P6-S26).
- Xendit payment integration.
- Setting up the materialized `smart_feed_items` collection.

## Required Checks
- Verify `PostModel` fully complies with `MozzyPostContract` fields.
- Ensure `posts` query limits by `location.idAddress.kecamatan` and `isDeleted == false`.
- Do not introduce direct screen dependencies in the repository.
- Ensure no private user data (e.g., plaintext NIK or unhashed PII) is exposed during normalization.
