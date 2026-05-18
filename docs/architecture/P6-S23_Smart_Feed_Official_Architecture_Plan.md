# P6-S23 Smart Feed Official Architecture Plan

## 1. Purpose
- Align Smart Feed with official Mozzy Indonesia development plan.
- Prepare Beta 1 feed integration without breaking Build 8 stability.

## 2. Official Requirements
- 5-Layer Discovery Layer architecture.
- Integrate 11 Feature Domains eventually.
- Adhere to the `MozzyPostContract` Shared Contract.
- Use the official `signalScore` ranking formula.
- Apply Indonesia time-based weighting for feature diversity.
- Ensure strict Kecamatan relevance.

## 3. Current State
| Area | Current | Gap |
|---|---|---|
| Sources | Jobs (`job_posts`), Marketplace (`products`) | Missing News (`posts`) and others. |
| Ranking Logic | Simple additive `boost + freshness + trust + ...` | Missing the proportional `(recency * 0.3) + ...` formula. |
| Time Weighting | None | Needs implementation based on time of day. |
| Shared Contract | Partial (`ProductModel` missing fields, `JobPostModel` missing all) | Must update models to align with `MozzyPostContract`. |

## 4. Target Architecture
- `SmartFeedRepository`: Executes queries across multiple collections.
- `SmartFeedService`: Handles merging, sorting, and pagination.
- `FeedItemModel`: The normalized DTO (Data Transfer Object) for UI consumption.
- Source Adapters (Mappers): E.g., `ProductFeedMapper`, `JobFeedMapper`, `NewsFeedMapper`.
- `FeedRankingService`: Applies the new `signalScore` and time-based logic.

## 5. Source Adapter Design

| Adapter | Source Collection | Status | Next Action |
|---|---|---|---|
| `NewsFeedAdapter` | `posts` | Missing | P6-S24 (Integration) |
| `MarketplaceFeedAdapter` | `products` | Existing | Needs Contract alignment |
| `JobsFeedAdapter` | `job_posts` | Existing | Needs Contract alignment |
| `StoresFeedAdapter` | `shops` | Future | Wait until Toko activation |
| `PomFeedAdapter` | `pom` | Future | Wait until POM activation |
| `TogetherFeedAdapter` | `together_posts` | Future | Wait until Together activation |

## 6. Firestore Query Strategy

**Beta 1 (Current & Near-term):**
- Query News, Marketplace, Jobs separately.
- Normalize into `FeedItemModel` via Adapters.
- Merge, rank via `FeedRankingService`, and paginate client-side.

**Scale Phase (Future):**
- Create a materialized `smart_feed_items` collection.
- Use Cloud Functions to synchronize updates from the 11 feature collections.
- Query efficiently by `locationParts.kecamatan`, `geoScope`, `signalScore`, and `createdAt`.

## 7. Required Shared Fields

| Model | Missing Fields | Required Action |
|---|---|---|
| `PostModel` (News) | None | Ready for feed. |
| `ProductModel` | `discoveryChannels`, `mapVisibility` | Add to model. |
| `JobPostModel` | All `MozzyPostContract` fields | Implement contract and add fields. |

## 8. Index Impact

| Collection | Query | Required Index | Existing? | Action |
|---|---|---|---|---|
| `posts` | `location.idAddress.kecamatan` + `isDeleted` + `createdAt` | Composite | Check/Create | Verify in Firebase console |
| `products` | `locationParts.idAddress.kecamatan` + `status` + `createdAt` | Composite | Check/Create | Verify in Firebase console |
| `job_posts` | `locationParts.idAddress.kecamatan` + `status` + `createdAt` | Composite | Check/Create | Verify in Firebase console |

## 9. Test Plan
- `SmartFeedItem` normalization test for News.
- `signalScore` formula calculation test.
- Time weight modifier test (mocking different times of day).
- Source merge and sorting test.
- Empty source handling test.
- Pagination test.

## 10. Implementation Order

1. **P6-S23**: Architecture plan and ADR (Current Task).
2. **P6-S24**: Berita Smart Feed Integration (Immediate Next).
3. **P6-S25**: `ProductModel` and `JobPostModel` Shared Contract normalization.
4. **P6-S26**: `signalScore` formula refactoring.
5. **P6-S27**: Time-based weighting and diversity ranking.
6. **P6-S28**: Materialized feed feasibility review.

## 11. Decision
**Recommended next task:**
- **P6-S24 Berita Smart Feed Integration**
