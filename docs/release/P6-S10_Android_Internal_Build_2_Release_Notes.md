# Mozzy Private Beta — Android Internal Build 2

Version:
- 1.0.0+2

Purpose:
- Beta Bug Fix Sprint after Build 1 smoke test.

Fixes:
- Firebase App Distribution tester group 'mozzy-private-beta' created and verified.
- Analyzer warnings reduced (fixed use_build_context_synchronously, cleaned up unused imports in Build 1.5).
- Account deletion test import/mocking issue verified and fixed in repo.
- Internal beta release readiness improved.

Environment:
- APP_ENV=staging
- PAYMENT_MODE=sandbox
- PRIVATE_BETA=true
- PAYMENT_PRODUCTION_ENABLED=false
- CRASHLYTICS_ENABLED=true
- PERFORMANCE_ENABLED=true

Known limitations:
- iOS TestFlight is not ready yet.
- Payments are sandbox only.
- Storage image physical deletion is deferred.
- GitHub Actions workflow still pending unless separately fixed.
