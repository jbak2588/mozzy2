# ADR-004: Smart Feed Official Architecture

## Status
Accepted

## Context
P6-S22 found that the current Smart Feed only includes limited sources (`job_posts`, `products`) and does not yet fully match the official Mozzy Indonesia development plan. 

The current ranking logic (`FeedRankingService`) uses a simple additive score (`boost + freshness + trust + distance + engagement + semantic`).

The official plan requires:
- 5-Layer architecture
- Discovery Layer with Smart Feed, Search, Cross-Link, Relay
- 11 Feature Domains
- Shared Contract fields (`geoScope`, `reachMode`, etc.)
- `signalScore` based ranking formula: `(recency * 0.3) + (relevance * 0.25) + (engagement * 0.2) + (diversity * 0.15) + (trust * 0.1)`
- Indonesia time-based feature weighting

## Decision

Mozzy Smart Feed will be implemented as a Discovery Layer service that consumes normalized feed items adhering to a common `SmartFeedItem` contract.

It must not directly depend on UI screens.

### SmartFeedItem Contract

Required fields (mapping from `FeedItemModel` to align with Dev Plan):
- `id`
- `sourceType` (e.g., news, marketplace)
- `sourceCollection`
- `sourceId`
- `title`
- `description`
- `thumbnailUrl`
- `authorId`
- `locationParts`
- `geoScope`
- `reachMode`
- `trustScore`
- `signalScore`
- `translationState`
- `discoveryChannels`
- `mapVisibility`
- `createdAt`
- `updatedAt`
- `engagementSummary`

### Source Mapping

| Feature | Source Collection | Feed Type | Priority |
|---|---|---|---|
| Local News / Berita | `posts` | `news` | P0 |
| Marketplace | `products` or `used_items` | `marketplace` | P0 |
| Jobs | `job_posts` | `jobs` | P0 |
| Chat | `chat_rooms` | not public feed | excluded |
| Local Stores | `shops` | `stores` | P1 |
| Auction | `auctions` | `auction` | P2 |
| Clubs | `groups` | `clubs` | P2 |
| Lost & Found | `lost_found` | `lost_found` | P2 |
| POM | `pom` | `pom` | P2 |
| Real Estate | `real_estate` | `real_estate` | P2 |
| Together | `together_posts` | `together` | P2 |

### Ranking Formula

The `FeedRankingService` must be updated to output a unified `signalScore` based on the official formula rather than the current arbitrary additive values.

`signalScore = (recency * 0.3) + (relevance * 0.25) + (engagement * 0.2) + (diversity * 0.15) + (trust * 0.1)`

*(Note: Boost score remains a separate high-priority override above `signalScore`)*

### Time-Based Weighting

A time-based diversity multiplier will be applied during the `diversity` calculation:

| Time | Feature Weight |
|---|---|
| 07:00-09:00 | Jobs, News |
| 12:00-14:00 | Stores, POM |
| 17:00-20:00 | Marketplace, Together |
| 21:00-23:00 | POM, Clubs, News |
| Weekend | Together, Marketplace, POM |

### Firestore Strategy

**Option A (Client-Side Merge):**
- Query multiple source collections separately
- Normalize in repository using Adapters
- Merge and sort client-side or service-side

**Option B (Materialized View):**
- Create `smart_feed_items` materialized collection
- Update via Cloud Functions triggers
- Query one collection by `location` + `signalScore`

**Decision:**
- For Beta 1, use **Option A** with strict pagination and a small source set (News, Marketplace, Jobs).
- For scale, prepare Option B as a future migration once all 11 features are stable.

## Beta 1 Source Scope

Beta 1 Smart Feed must include:
- Berita / `posts`
- Marketplace / `products`
- Jobs / `job_posts`

Stores, POM, Together, and other features remain future source candidates until their domain implementation is complete.

## Consequences

- Berita will be added in P6-S24 after this architecture is accepted.
- `ProductModel` and `JobPostModel` must be aligned to the `MozzyPostContract` before full feed normalization.
- The current `FeedRankingService` will need to be refactored to use the official weights.
- Xendit is unrelated to Smart Feed ranking but remains the official monetization direction.