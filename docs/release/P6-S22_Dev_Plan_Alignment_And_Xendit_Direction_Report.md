# P6-S22 Dev Plan Alignment & Xendit Direction Report

## 1. Scope
- Official baseline: `docs/planning/Mozzy_Indonesia_Dev_Plan_2026.md`
- Payment override: Xendit (Midtrans deprecated)
- Excluded references: Any other planning or legacy version documents.

## 2. Repo Status
- Branch: main
- Base HEAD: dc7f9bc
- Latest HEAD: Current working tree
- Git status: Clean before audit, new ADR added.

## 3. Official Development Goals
- 5-Layer architecture: App Shell, Discovery, Geo, Trust, Feature Domains
- 11 Feature Domains: News, Marketplace, Jobs, Auction, Clubs, Lost & Found, POM, Real Estate, Stores, Together, Chat
- Shared Contract: `MozzyPostContract` ensuring uniform discovery fields
- Smart Feed: Aggregated discovery with semantic ranking
- Geo Track 1+2: Dual-track address resolution
- Trust Layer: Trust scores, AI verification, moderation
- Xendit payment: Override for all monetization features

## 4. Current Implementation Summary
| Area | Status | Notes |
|---|---|---|
| App Shell | Complete | Navigation router, 5 bottom tabs set up. |
| Smart Feed | Partial | Currently only sources from `job_posts` and `products`. |
| Shared Contract | Partial | Exists in `ProductModel` and `PostModel` (News), others missing. |
| Xendit Payment | Pending | Found `xendit_webhook.test.js` and basic function setup, but full Dart implementation is missing. |

## 5. Feature Domain Alignment
| Feature | Planned | Current | Status | Gap |
|---|---|---|---|---|
| Local News | Berita Lokal | /news | Complete | No gap |
| Marketplace | Jual Beli | /marketplace | Complete | No gap |
| Jobs | Lowongan Kerja | /jobs | Complete | Not in bottom tab |
| Local Stores | Toko Sekitar | /stores | Placeholder | Coming Soon screen only |
| Chat | Pesan | /chat | Complete | No gap |
| Auction | Lelang | - | Missing | Need planning |
| Clubs | Komunitas | - | Missing | Need planning |
| Lost & Found | Barang Hilang | - | Missing | Need planning |
| POM | Pamer | - | Missing | Need planning |
| Real Estate | Properti | - | Missing | Need planning |
| Together | Bareng Yuk | - | Missing | Need planning |

## 6. Shared Contract Alignment
| Model | Required Fields Present | Missing Fields | Status |
|---|---|---|---|
| ProductModel | geoScope, reachMode, trustScore, signalScore, translationState | discoveryChannels, mapVisibility | Partial |
| PostModel (News) | All | None | Complete |
| JobPostModel | None | All | Missing |

## 7. Smart Feed Alignment
| Item | Planned | Current | Status | Gap |
|---|---|---|---|---|
| Source collections | 11 Features | 2 (Jobs, Marketplace) | Partial | Needs News, Stores, etc. |
| Berita included | Yes | No | Gap | Must be added |
| Marketplace included| Yes | Yes | Complete | No gap |
| Jobs included | Yes | Yes | Complete | No gap |
| Stores included | Yes | No | Gap | Must be added when built |
| signalScore formula | Required | Yes | Complete | No gap |

## 8. Geo / Trust / i18n Alignment
| Area | Planned | Current | Status | Gap |
|---|---|---|---|---|
| Track 1 address | provinsi/kabupaten/kecamatan/kelurahan | Yes | Complete | No gap |
| Timezone | WIB/WITA/WIT | Partial | Partial | Needs full integration |
| Location permission| Required | Yes | Complete | No gap |
| Trust Score | 0.0~1.0 | Yes | Complete | No gap |
| Report system | Required | Yes | Complete | No gap |

## 9. Xendit Direction
- Midtrans references found: 0
- Xendit references found: Exists in `functions-v2/index.js` and `xendit_webhook.test.js`
- Required migration: Need to implement Xendit payment flows in Flutter app.
- Recommended first Xendit task: Payment Foundation Architecture

## 10. Risk Assessment
| Priority | Risk | Reason | Action |
|---|---|---|---|
| High | Smart Feed misses News | News is a core beta feature but not in the main feed | P6-S24 Berita Feed Integration |
| High | JobPost missing Shared Contract | Cannot unify feed queries | Update JobPost model |
| Medium| Xendit Dart integration missing | Cannot test monetization in Beta | Implement Xendit services |

## 11. CTO Decision Needed
- Continue current Build 8 beta stabilization: Yes
- Start Smart Feed plan alignment: Yes (Next immediate phase)
- Start Xendit foundation: Yes (After feed alignment)
- Implement missing feature routes: Defer
- Freeze new feature work until alignment complete: Yes

## 12. Recommended Next Sprint
- Next task name: P6-S23 Smart Feed Official Architecture Implementation Plan
- Reason: Before blindly adding Berita, we need a solid architectural plan to scale the Smart Feed to support all 11 features efficiently.
- Scope: Architectural design and indexing strategy for Smart Feed multi-collection queries.
- Files to modify: ADRs and Planning Docs.
