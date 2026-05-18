# P6-S25 Product / Job Shared Contract Normalization Report

## 1. Scope
- Normalize `ProductModel` to Shared Contract.
- Normalize `JobPostModel` to Shared Contract.
- Stabilize `ProductFeedMapper` and `JobFeedMapper` (e.g., standardizing IDs to `marketplace_xxx` and `jobs_xxx`).
- Preserve P6-S24 Berita Smart Feed integration.

## 2. Repo Status
- Branch: main
- Base HEAD: 76c231f
- New HEAD: Current working tree
- Git status: Clean, ready to commit
- Push: Pending

## 3. Files Changed
| File | Change |
|---|---|
| `lib/mozzy_ii/domains/marketplace/models/product_model.dart` | Added `discoveryChannels`, `mapVisibility` fields. |
| `lib/mozzy_ii/domains/marketplace/models/product_model.g.dart` | Regenerated JSON serialization. |
| `lib/mozzy_ii/domains/marketplace/models/product_model.freezed.dart` | Regenerated Freezed classes. |
| `lib/mozzy_ii/domains/feed/mappers/job_feed_mapper.dart` | Changed prefix from `job_` to `jobs_`. |
| `lib/mozzy_ii/domains/feed/mappers/product_feed_mapper.dart` | Changed prefix from `prod_` to `marketplace_`. |
| `test/mozzy_ii/domains/feed/feed_item_mapper_test.dart` | Updated test expectations for normalized IDs. |
| `test/mozzy_ii/domains/marketplace/product_model_contract_test.dart` | Created integration test verifying Shared Contract fallback defaults. |
| `test/mozzy_ii/domains/jobs/job_post_model_contract_test.dart` | Created integration test verifying Shared Contract fallback defaults. |

## 4. ProductModel Contract Status
| Field | Status | Notes |
|---|---|---|
| geoScope | Complete | Existed previously. Freezed provides robust JSON fallback. |
| reachMode | Complete | Existed previously. |
| trustScore | Complete | Existed previously. |
| signalScore | Complete | Existed previously. |
| translationState | Complete | Existed previously. |
| discoveryChannels | Complete | Added. Defaults to `['feed', 'map', 'search']`. |
| mapVisibility | Complete | Added. Defaults to `true`. |

## 5. JobPostModel Contract Status
| Field | Status | Notes |
|---|---|---|
| geoScope | Complete | Existed previously. Freezed provides robust JSON fallback. |
| reachMode | Complete | Existed previously. |
| trustScore | Complete | Existed previously. |
| signalScore | Complete | Existed previously. |
| translationState | Complete | Existed previously. |
| discoveryChannels | Complete | Existed previously. |
| mapVisibility | Complete | Existed previously. |

## 6. Feed Mapper Status
| Mapper | Status | Notes |
|---|---|---|
| NewsFeedMapper | Preserved | Prefix `news_` functioning correctly. |
| ProductFeedMapper | Complete | Updated to use `marketplace_` prefix. |
| JobFeedMapper | Complete | Updated to use `jobs_` prefix. |

## 7. Smart Feed Regression Check
| Source | Status | Notes |
|---|---|---|
| Berita | Passed | Retained in `FirestoreSmartFeedRepository`. |
| Marketplace | Passed | Normalized `ProductModel` seamlessly decodes. |
| Jobs | Passed | `JobPostModel` maps cleanly to Feed Item. |
| All filter | Passed | All domains merge correctly. |

## 8. Tests
- flutter analyze: Pass (Ignored harmless duplicate ignore warnings in `.mocks.dart`).
- flutter test: Pass.
- New tests: `product_model_contract_test.dart`, `job_post_model_contract_test.dart`.
- Existing failures: None.

## 9. Firestore Compatibility
- Existing product docs: Transparent fallback provided by Freezed `@Default`.
- Existing job docs: Transparent fallback provided by Freezed `@Default`.
- Default fallback: Safely injects missing fields at runtime during `fromJson()`.
- Migration required: None. Data structure evolves lazily without breaking backwards compatibility.

## 10. Risks / Follow-up
| Priority | Issue | Next Action |
|---|---|---|
| High | Feed uses basic ranking rather than official signalScore | Execute P6-S26 |

## 11. Next Recommended Task
- P6-S26 Official signalScore Formula Implementation
- Reason: The data models and repository pipelines are now fully normalized and conformant to the Shared Contract. The prerequisite foundation is set to drop in the true `signalScore` calculation algorithm defined in ADR-004 (`(recency * 0.3) + (relevance * 0.25) + ...`).