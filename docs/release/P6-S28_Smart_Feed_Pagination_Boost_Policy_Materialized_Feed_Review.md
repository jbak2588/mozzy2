# P6-S28 Smart Feed Pagination / Boost Policy / Materialized Feed Review

## 1. Scope
- Review Smart Feed pagination safety and implementation status.
- Review current boost policy and its interaction with `signalScore`.
- Review the feasibility and triggers for transitioning to a materialized `smart_feed_items` collection.
- Document decisions in ADR-005.

## 2. Repo Status
- Branch: main
- Base HEAD: 2efce72
- New HEAD: b374826
- Git status: Clean
- Push: origin main pushed

## 3. Current Smart Feed State
| Area | Status | Notes |
|---|---|---|
| Sources | Active | Berita, Marketplace, Jobs. |
| Ranking | Complete | Official `signalScore` formula implemented. |
| Time weighting | Complete | WIB/WITA/WIT support via `FeedTimeWeightService`. |
| Diversity reranking| Complete | Iterative penalty logic in `FeedRankingService`. |
| Pagination | Partial | First-page optimized. No deep scrolling support yet. |
| Boost | Legacy | Fixed `+100.0` override. |

## 4. Pagination Review
| Source | Current Query | Limit | Cursor | Risk | Recommendation |
|---|---|---:|---|---|---|
| Berita | `posts` | 20 | None | Data inconsistency on deep scroll | Maintain for Beta 1 |
| Marketplace | `products` | 20 | None | Ranking skew on page boundary | Maintain for Beta 1 |
| Jobs | `job_posts` | 20 | None | High Firestore read count | Maintain for Beta 1 |

**Decision**: The feed is "First-page optimized" for Beta 1. Global limit capped at 60.

## 5. Boost Policy Review
| Policy | Current | Risk | Decision |
|---|---|---|---|
| Fixed Override | `+100.0` | Overwhelms signalScore (0~1) | Keep for Beta 1 for reliability |
| Promoted Layer | N/A | Complexity in UI logic | Implement in Beta 2 / P6-S29 |

## 6. Materialized Feed Feasibility
| Criteria | Current Client Merge | Future smart_feed_items | Decision |
|---|---|---|---|
| Query complexity | Low (3 sources) | High (Sync triggers) | Client Merge for now |
| Pagination | Broken/Limited | Native/Stable | Materialized for Scale |
| Ranking consistency | Dynamic/Expensive | Pre-calculated/Fast | Materialized for Scale |
| Firestore reads | 3 queries | 1 query | Materialized for Scale |

**Trigger for transition**: Exceeding 5 sources or requiring stable deep pagination.

## 7. Recommended Architecture Decision
- **Beta 1**: Client Merge (3 sources, 60 items max).
- **Beta 2**: Implement Promoted Layer for ads.
- **Scale phase**: Materialized `smart_feed_items` collection via Cloud Functions.
- **Boost policy**: Separate from `signalScore` calculation.
- **Pagination policy**: First-page optimized until Materialized Feed.

## 8. Minimal Code Changes
| File | Change |
|---|---|
| `firestore_smart_feed_repository.dart` | Added `defaultFeedLimit` and `perSourceLimit` constants. |
| `feed_ranking_service.dart` | Added `legacyBoostBonus` constant and TODO for Promoted Layer. |

## 9. Tests
- flutter analyze: Pass.
- flutter test: Pass.
- New tests: Not required for constant refactoring.

## 10. Firestore / Index Impact
- Index added: None.
- smart_feed_items created: No (Deferred).
- Cloud Functions added: No (Deferred).

## 11. Risks / Follow-up
| Priority | Issue | Next Action |
|---|---|---|
| Low | Deep scrolling returns same items | Document as "intended limitation" for Beta 1 |
| Medium | Boosted items hide new content | Review in Beta 2 |

## 12. Next Recommended Task
- **P6-S29 Xendit Flutter Payment Foundation**
- Reason: The Smart Feed logic is now stable enough for Beta 1. The next major hurdle is enabling real-world monetization testing with Xendit.
