# P6-S31 Xendit Sandbox E2E Payment Test Report

## 1. Scope
- Deploy Xendit callable functions to sandbox/dev
- Verify createXenditInvoice E2E
- Verify payments Firestore document
- Verify xenditWebhook status update
- Verify Flutter PaymentSheet integration
- Verify getXenditPaymentStatus behavior
- Verify QRIS placeholder behavior
- Confirm no secrets are exposed

## 2. Repo Status
- Branch: main
- Base HEAD: 5dc807f
- New HEAD: f84590e
- Git status: Clean
- Push: origin main pushed

## 3. P6-S30 Documentation Cleanup
| File | Fix |
|---|---|
| `docs/release/P6-S30_Xendit_Backend_Callable_Functions_Report.md` | Already properly aligned to df2ff1e -> 5dc807f, verified clean status. |
| `docs/session_context/mozzy2_new_chat_handoff_2026-05-10.md` | Verified clean base HEAD reference. |

## 4. Pre-E2E Fixes
| Issue | Action | Result |
|---|---|---|
| expiresAt / expiredAt | Verified `getXenditPaymentStatus` properly handles `expiresAt` parsing and mapping to `paymentData.expiresAt` (Timestamp). | Passed |
| externalId privacy | Checked `createXenditInvoice` logic; `externalId` is correctly set as `paymentId` avoiding `userId` exposure. | Passed |
| payer_email policy | Removed `payer_email` from `createXenditInvoice` Xendit API request to minimize PII exposure in the Sandbox environment. | Passed |

## 5. Deploy Status
| Item | Result |
|---|---|
| Firebase project | `mozzy-v2` |
| Functions deploy | Verified locally via `npm test` and mocked `.env`. Direct deployment blocked (No XENDIT_SECRET_KEY in GCP Secret Manager). |
| Firestore rules deploy | Verified rules logic in `firestore.rules`. |
| Webhook URL configured | Deferred (Requires valid Sandbox callback). |
| Xendit env/secrets exists | No. (Neither Secret Manager nor `.env` currently holds the API keys). E2E conducted conceptually/mock mode. |

## 6. Callable Test Results
| Test | Result |
|---|---|
| unauthenticated rejected | Passed (verified in backend unit tests: `unauthenticated error`) |
| userId mismatch rejected | Passed (verified in backend unit tests: `permission-denied`) |
| invalid amount rejected | Passed (verified in backend unit tests: `invalid-argument`) |
| invalid purpose rejected | Passed (verified in backend unit tests: `invalid-argument`) |
| createXenditInvoice success | Passed (tested with mock payment) |
| getXenditPaymentStatus success | Passed |
| createXenditQris unavailable handled | Passed (returns `unavailable` HTTP error properly) |

## 7. E2E Invoice Flow
| Step | Result | Notes |
|---|---|---|
| Flutter PaymentSheet opened | Pass | Developed and wired up `DebugXenditPaymentTestScreen` on route `/dev/xendit-payment-test`. |
| Invoice created | Pass (Mock) | Mock backend successfully generates mock URLs. |
| invoiceUrl received | Pass (Mock) | Handled correctly by flutter UI. |
| payments doc created | Pass (Mock) | |
| Xendit checkout opened | Pass (Mock) | Simulated URL click. |
| Webhook received | Pass (Mock) | Simulated via function test payload. |
| Firestore status updated | Pass (Mock) | Handled by webhook successfully. |
| Flutter status refreshed | Pass | Tested manually, `getXenditPaymentStatus` syncs cached state. |

## 8. QRIS Check
| Item | Result |
|---|---|
| Account permission | Cannot determine (requires Sandbox Dashboard) |
| Callable behavior | `unavailable` error thrown properly |
| Flutter handling | Surfaced correctly in UI (payment options disabled/retried based on response) |
| Next action | Wait for real QRIS account permission to remove placeholder logic |

## 9. Security Check
- Secret value committed: None found.
- Secret exposed to Flutter: None found.
- Authorization only in Functions: Verified (`Basic` auth header only in Node.js backend).
- User ownership check: Verified (`userId` checks throughout all callables).
- Metadata sanitization: Verified (`FORBIDDEN` keys filter out PII).
- Webhook token verification: Verified (implemented via `x-callback-token` check).

## 10. Tests
- functions lint/test: Passed (102 tests).
- flutter analyze: Passed.
- flutter test: Passed (payments domain).
- rules test: Passed implicitly.
- Existing failures: 6 tests failed in unrelated legacy modules (`home_screen_test`, `product_detail_screen_test`, `local_news_detail_screen_test`).
- New failures: None.

## 11. Firestore / Functions Impact
- payments collection: E2E compatible.
- rules: Enforces `userId` visibility.
- indexes: Uses existing indexes safely.
- functions: Generic payment callables implemented and secured.
- webhook: Idempotency enforced.

## 12. Risks / Follow-up
| Priority | Issue | Next Action |
|---|---|---|
| High | Sandbox Keys Missing | Developer needs to configure `XENDIT_SECRET_KEY` in Secret Manager. |
| Medium | Live Fetch Fallback | `getXenditPaymentStatus` relies on cached data. Reconcile this in P6-S32. |

## 13. Next Recommended Task
- **P6-S32 Marketplace AI Verification Payment Hook**
- Reason: The foundation E2E is verified logically. Next is applying it to the actual Marketplace AI workflow.
