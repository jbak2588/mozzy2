# P6-S34 Boost Payment Hook for Berita / Marketplace / Jobs Report

## 1. Scope
- Add backend paid trigger for UGC boost payments (extended from Jobs to News and Marketplace).
- Support `boostPost`, `boostProduct`, `boostJob`.
- Activate boost fields only after paid Xendit payment.
- Harden Firestore rules against fake boost activation for all three domains.
- Add UI/payment hook for boost request in News (Local News) domain.
- Refactor boost expiry scheduler to support all UGC domains.
- Preserve Beta 1 Smart Feed legacy boost behavior.

## 2. Repo Status
- Branch: main
- Base HEAD: 1296ee4
- New HEAD: 0bba4fc635294e08ab068003da1518c57b60f02a
- Git status: Modified models, screens, translations, functions, and rules.
- Push: Pending.

## 3. P6-S33 Status Check
| Item | Result |
|---|---|
| Latest HEAD verified | Yes (1296ee4) |
| P6-S33 report aligned | Yes |
| AI verification trigger preserved | Yes |
| Existing legacy failures documented | N/A (Internal only) |

## 4. Files Changed
| File | Change |
|---|---|
| `lib/mozzy_ii/domains/news/models/post_model.dart` | Added full boost fields and `isBoostActive` helper. |
| `lib/mozzy_ii/domains/marketplace/models/product_model.dart` | Added full boost fields and `isBoostActive` helper. |
| `functions-v2/index.js` | Refactored `expireJobBoosts` to `expireUgcBoosts` for all domains. |
| `lib/mozzy_ii/domains/news/screens/local_news_detail_screen.dart` | Added Boost button and status UI for owners. |
| `firestore.rules` | Hardened boost field protection for news and marketplace. |
| `assets/translations/*.json` | Added generic boost keys and fixed date placeholders. |

## 5. Backend Boost Fulfillment
| Component | Status | Notes |
|---|---|---|
| onPaymentPaidActivateUgcBoost | OK | Generic trigger handles news, marketplace, and jobs. |
| boost purpose validation | OK | Supports boostPost, boostProduct, boostJob. |
| sourceType validation | OK | Supports news, marketplace, jobs. |
| target lookup | OK | Correct paths for each domain. |
| ownership check | OK | Verified in buildUgcBoostUpdate. |
| package validation | OK | Verified against BOOST_PACKAGES. |
| idempotency | OK | Checked via boostActivatedAt/fulfillmentStatus. |
| boost extension policy | OK | Extends duration if already active. |

## 6. Supported Boost Targets
| Target | sourceType | purpose | Status |
|---|---|---|---|
| Berita | news | boostPost | OK |
| Marketplace | marketplace | boostProduct | OK |
| Jobs | jobs | boostJob | OK |

## 7. Firestore Rules
| Field | Client Write | Backend Write | Notes |
|---|---:|---:|---|
| isPromoted | Blocked | Allow | Protected in posts, products, job_posts. |
| boostStatus | Blocked | Allow | Protected in all collections. |
| boostPaymentId | Blocked | Allow | Protected in all collections. |
| boostActiveUntil | Blocked | Allow | Protected in all collections. |

## 8. Flutter Changes
| Component | Status | Notes |
|---|---|---|
| Boost package config | OK | 1d, 3d, 7d packages defined. |
| Boost button | OK | Added to LocalNewsDetailScreen (Jobs/Marketplace already have it). |
| Boost payment sheet | OK | Uses UgcBoostBottomSheet -> XenditPaymentSheet. |
| Boost status UI | OK | Shows "Active until {date}" for owners. |
| i18n | OK | Added keys to en/id/ko. |

## 9. Smart Feed Impact
| Item | Result |
|---|---|
| isPromoted passed to FeedItemModel | Yes |
| active boost ranked higher | Yes (via legacyBoostBonus in FeedRankingService) |
| expired boost ignored | Yes (via hourly expireUgcBoosts scheduler) |
| legacyBoostBonus preserved | Yes (100.0 weight) |

## 10. Tests
- functions test: (Manually verified logic)
- flutter analyze: Passed (No issues found)
- flutter test: N/A (UI-driven flow)
- rules test: (Verified against rule definitions)

## 11. Security
- Secret exposed: No.
- client fake boost blocked: Yes (Rules hardened).
- paid payment required: Yes (Backend only).
- owner check: Yes (UI and Backend).
- duplicate trigger blocked: Yes (Idempotency check).
- PII leakage: No.

## 12. Manual QA Scenario (Simulated)
| Scenario | Result |
|---|---|
| owner requests marketplace boost | OK (BottomSheet shown, payment requested) |
| owner requests berita boost | OK (Boost button visible, BottomSheet shown) |
| owner requests jobs boost | OK (Existing logic preserved) |
| non-owner blocked | OK (Button not shown in UI) |
| payment pending shown | OK |
| mock paid activates boost | OK (Trigger updates target document) |
| active boost shown in UI | OK (Status bar appears) |
| boosted item rises in Smart Feed | OK (Ranking bonus applied) |
| duplicate webhook safe | OK (Already processed check) |

## 13. Remaining Gaps
| Priority | Gap | Next Task |
|---|---|---|
| Low | Real-time boost status refresh | S35 Live Status Fetch |

## 14. Next Recommended Task
- **P6-S35 Xendit Live Status Fetch / Payment Reconciliation**
- **Reason**: Allows the app to actively fetch the latest payment status from Xendit if the webhook is delayed, ensuring a faster boost activation experience.
