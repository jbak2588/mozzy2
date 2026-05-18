# P6-S27 Time-Based Weighting + Diversity Ranking Report

## 1. Scope
- Add Indonesia time-based feature weighting (WIB, WITA, WIT)
- Add timezone handling for Smart Feed
- Track recentlyShownTypes (Reranking approach)
- Improve diversity ranking to prevent repetitive item types
- Preserve Berita, Marketplace, Jobs feed behavior

## 2. Repo Status
- Branch: main
- Base HEAD: dfb03b6
- New HEAD: Current working tree
- Git status: Modified ranking service, context, provider, and added time weight service.
- Push: Pending

## 3. Files Changed
| File | Change |
|---|---|
| `lib/mozzy_ii/domains/feed/services/feed_time_weight_service.dart` | (New) Service for time-based weights and timezone resolution. |
| `lib/mozzy_ii/domains/feed/models/user_feed_context.dart` | Added `timezoneCode` and `copyWith` method. |
| `lib/mozzy_ii/domains/feed/services/feed_ranking_service.dart` | Implemented reranking logic with diversity and time-based multipliers. |
| `lib/mozzy_ii/domains/feed/providers/smart_feed_provider.dart` | Resolved timezone from province and passed to ranking context. |
| `test/mozzy_ii/domains/feed/services/feed_time_weight_service_test.dart` | (New) Tests for timezone and time weighting logic. |
| `test/mozzy_ii/domains/feed/feed_ranking_service_test.dart` | Refactored to use `ProviderContainer` for reliable dependency injection. |

## 4. Time-Based Weighting
| Time Window | Planned Boost | Implemented | Notes |
|---|---|---|---|
| 07:00-09:00 | Jobs (1.15), News (1.12) | Yes | Targeted for morning peak. |
| 12:00-14:00 | Stores (1.15), POM (1.12), Marketplace (1.05) | Yes | Lunch break shopping/browsing. |
| 17:00-20:00 | Marketplace (1.15), Together (1.12) | Yes | Evening commute and planning. |
| 21:00-23:00 | POM (1.15), Clubs (1.12), News (1.07) | Yes | Night time social/community. |
| Weekend | Together (1.15), Marketplace (1.10), POM (1.08) | Yes | Leisure activities. |

## 5. Timezone Handling
| Timezone | Offset | Status | Notes |
|---|---:|---|---|
| WIB | UTC+7 | Complete | Default timezone. |
| WITA | UTC+8 | Complete | Applied for Bali, Sulawesi, East Kalimantan, etc. |
| WIT | UTC+9 | Complete | Applied for Maluku and Papua. |

## 6. Diversity Ranking
| Item | Status | Notes |
|---|---|---|
| recentlyShownTypes | Complete | Handled via reranking in `FeedRankingService`. |
| repeated sourceType penalty | Complete | Penalties: 1.0 (none) -> 0.8 -> 0.6 -> 0.4 -> 0.2 (4+ repeats). |
| All filter behavior | Complete | Actively mixes types using the diversity penalty. |
| Single filter behavior | Complete | Diversity applies but doesn't remove items, maintaining same-type feed. |

## 7. Smart Feed Regression Check
| Source | Status | Notes |
|---|---|---|
| Berita | Passed | Scores correctly with morning/night boosts. |
| Marketplace | Passed | Scores correctly with lunch/evening boosts. |
| Jobs | Passed | Scores correctly with morning boost. |
| All filter | Passed | Items are well-mixed based on the new diversity logic. |

## 8. Boost Policy Observation
| Current | Risk | Recommendation |
|---|---|---|
| boost +100.0 | Overwhelms signalScore (0.0~1.0) | Keep for now, but move to a separate 'Promoted' list layer in P6-S28. |

## 9. Tests
- flutter analyze: Pass (No issues found).
- flutter test: Pass (14 tests in the verified files).
- New tests: `feed_time_weight_service_test.dart` added.
- Existing failures: None.

## 10. Firestore / Index Impact
- Index added: None (Logic resides in the Application/Domain layer).
- permission-denied: None.
- missing index: None.

## 11. Manual QA
- Morning (08:00 WIB): Jobs and News appear higher in the feed.
- Evening (18:00 WIB): Marketplace items are prioritized.
- Diversity: When scrolling, the feed prevents too many consecutive items of the same type in the "All" view.

## 12. Risks / Follow-up
| Priority | Issue | Next Action |
|---|---|---|
| Low | Timezone mapping is province-based | Improve to coordinate-based if high precision is needed later. |

## 13. Next Recommended Task
- P6-S28 Smart Feed Pagination / Boost Policy / Materialized Feed Feasibility Review
- Reason: With complex ranking (reranking and time weights), standard Firestore pagination becomes tricky. We need to finalize the pagination strategy and decide on the Boost UI layer.
