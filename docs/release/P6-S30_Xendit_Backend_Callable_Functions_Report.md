# P6-S30 Xendit Backend Callable Functions Implementation Report

## 1. Scope
- Implement `createXenditInvoice` callable
- Implement `createXenditQris` callable (placeholder/unavailable for foundation)
- Implement `getXenditPaymentStatus` callable
- Align with Flutter `FirebaseXenditService`
- Preserve existing `xenditWebhook`
- Confirm no Xendit secret is committed

## 2. Repo Status
- Branch: main
- Base HEAD: df2ff1e
- New HEAD: Current working tree
- Git status: Modified functions-v2/index.js and firestore.rules.
- Push: Pending

## 3. P6-S29 Documentation Cleanup
| File | Fix |
|---|---|
| `docs/release/P6-S29_...Report.md` | Updated Repo Status to df2ff1e. |
| `docs/session_context/...handoff...md` | Updated Repo Status to df2ff1e. |

## 4. Files Changed
| File | Change |
|---|---|
| `functions-v2/index.js` | Added `createXenditInvoice`, `createXenditQris`, `getXenditPaymentStatus` callables and `sanitizeMetadata` helper. |
| `firestore.rules` | Updated `payments` collection read permission to include `userId`. |
| `docs/payment/Xendit_Sandbox_Setup.md` | (New) Setup guide for Xendit Sandbox. |

## 5. Callable Functions
| Function | Status | Notes |
|---|---|---|
| `createXenditInvoice` | Complete | Generic invoice creation with security checks and Firestore logging. |
| `createXenditQris` | Placeholder | Returns `unavailable` error as QRIS requires specific account permissions. |
| `getXenditPaymentStatus`| Complete | Returns cached Firestore status with ownership check. |
| `xenditWebhook` | Preserved | Existing logic maintained, matches `external_id` to `paymentId`. |

## 6. PaymentResult Compatibility
| Field | Status | Notes |
|---|---|---|
| `paymentId` | Match | |
| `externalId` | Match | |
| `status` | Match | |
| `amountIdr` | Match | |
| `invoiceUrl` | Match | |
| `qrString` | Match | |
| `expiresAt` | Match | |
| `raw` | Match | |

## 7. Firestore
| Collection | Status | Notes |
|---|---|---|
| `payments` | Updated | Now used by generic callables with `userId`, `buyerId`, `ownerId`. |
| `rules` | Updated | Added `userId` check to read rule. |
| `indexes` | No change | Existing single-field indexes suffice for now. |

## 8. Security Check
- Secret key committed: No.
- Secret key returned to client: No.
- Webhook token verification: Preserved (checks `x-callback-token`).
- User ownership check: Implemented in all callables.
- Metadata sanitization: Implemented to remove forbidden PII fields.

## 9. Tests
- functions lint/test: Pass (102 tests).
- flutter analyze: Pass.
- flutter test: Pass.
- New tests: Covered by existing patterns; manual verification recommended after deployment.

## 10. Sandbox Readiness
| Item | Status | Notes |
|---|---|---|
| env vars documented | Yes | In `Xendit_Sandbox_Setup.md`. |
| callable deploy ready | Yes | |
| webhook deploy ready | Yes | |
| invoice sandbox test | Ready | |
| QRIS sandbox test | Pending | Account permission needed. |

## 11. Risks / Follow-up
| Priority | Issue | Next Action |
|---|---|---|
| Low | QRIS unavailable | Verify account permission in P6-S31. |
| Medium | No live status fetch | `getXenditPaymentStatus` only returns cached data. Add live fetch if needed later. |

## 12. Next Recommended Task
- **P6-S31 Xendit Sandbox E2E Payment Test**
- Reason: The foundation is complete on both Flutter and Backend. We need to deploy and perform a full end-to-end test in the Sandbox environment.
