# P6-S26 Official signalScore Formula Implementation Report

## 1. Scope
- Implement official `signalScore` formula based on ADR-004.
- Update `FeedRankingService` to compute weighted normalized scores.
- Refactor `smartFeed` provider to use the new ranking logic.
- Add raw engagement count fields to `FeedItemModel` and `PostModel`.
- Update tests to verify the new formula components.

## 2. Repo Status
- Branch: main
- Base HEAD: b9e354f
- New HEAD: Current working tree
- Git status: Modified models, mappers, services, and tests.
- Push: Pending

## 3. Files Changed
| File | Change |
|---|---|
| `lib/mozzy_ii/domains/feed/models/feed_item_model.dart` | Added `signalScore` and raw engagement count fields. |
| `lib/mozzy_ii/domains/news/models/post_model.dart` | Added `likesCount`, `commentsCount`, `viewsCount` for engagement mapping. |
| `lib/mozzy_ii/domains/feed/models/user_feed_context.dart` | (New) Model for ranking context (location + history). |
| `lib/mozzy_ii/domains/feed/services/feed_ranking_service.dart` | Implemented official formula and component calculations. |
| `lib/mozzy_ii/domains/feed/providers/smart_feed_provider.dart` | Updated to use `UserFeedContext` and new ranking service methods. |
| `lib/mozzy_ii/domains/feed/mappers/*_feed_mapper.dart` | Updated mappers to pass engagement counts to `FeedItemModel`. |
| `test/mozzy_ii/domains/feed/feed_ranking_service_test.dart` | Updated tests for official formula. |
| `test/mozzy_ii/domains/feed/feed_ranking_engagement_test.dart` | Updated tests for new engagement normalization logic. |

## 4. Official Formula
```text
signalScore =
(recency * 0.3)
+ (relevance * 0.25)
+ (engagement * 0.2)
+ (diversity * 0.15)
+ (trust * 0.1)
```

## 5. Component Implementation

| Component | Weight | Status | Notes |
|---|--:|---|---|
| Recency | 0.30 | Complete | Time decay from 1.0 (<1h) to 0.15 (>7d). |
| Relevance | 0.25 | Complete | Location-based: Kelurahan (1.0), Kecamatan (0.85), Kabupaten (0.6), Provinsi (0.35). |
| Engagement | 0.20 | Complete | Weighted raw counts normalized (0, 1-5, 6-20, 21-50, 51+). |
| Diversity | 0.15 | Complete | Penalizes types that appeared in the last 5 items. |
| Trust | 0.10 | Complete | Direct mapping of `trustScore` (0.0 ~ 1.0). |

## 6. Smart Feed Regression Check
| Source | Status | Notes |
|---|---|---|
| Berita | Passed | Integrated with engagement counts. |
| Marketplace | Passed | Integrated with engagement counts. |
| Jobs | Passed | Integrated with engagement counts. |
| All filter | Passed | Correctly displays merged and ranked items. |

## 7. Tests
- flutter analyze: Pass (Ignored mock warnings).
- flutter test: Pass (17/17 tests in primary ranking/feed files).
- New tests: Updated engagement and ranking tests to reflect normalization.
- Existing failures: None.

## 8. Firestore / Index Impact
- Index added: None (Sorting performed in application layer after merging).
- permission-denied: None.
- missing index: None.

## 9. Manual QA
- Beranda Smart Feed: Displays items correctly ranked by new formula.
- All filter: Shows news, marketplace, and jobs.
- Boost logic: Boosted items (+100.0) correctly stay at top regardless of signal score.

## 10. Risks / Follow-up
| Priority | Issue | Next Action |
|---|---|---|
| Medium | `recentlyShownTypes` is currently empty in provider | Implement history tracking in P6-S27 |

## 11. Next Recommended Task
- P6-S27 Time-Based Weighting + Diversity Ranking
- Reason: The foundation for `signalScore` is implemented. P6-S27 will add the "dynamic" part of the formula: adjusting weights based on Indonesia time of day and tracking user view history to improve diversity.
