# Mozzy Private Beta — Android Internal Build 1

Version:
- 1.0.0+1

Environment:
- APP_ENV=staging
- PAYMENT_MODE=sandbox
- PRIVATE_BETA=true
- PAYMENT_PRODUCTION_ENABLED=false

Focus areas:
- **Smart Feed**: Core discovery loop and viewport-based engagement tracking.
- **News**: Local news listing and details.
- **Marketplace**: Used items listing, details, and AI verification status.
- **Jobs**: Job postings and applicant management.
- **Chat**: Real-time messaging between users.
- **Report / Moderation**: Ability to report inappropriate content and admin actions.
- **Feedback / CS**: In-app feedback form and WhatsApp CS channel link.
- **Account Deletion**: Complete user data cleanup and anonymization request.
- **Crashlytics / Performance Monitoring**: Real-time error tracking and latency measurement.

Known limitations:
- iOS TestFlight is not ready yet (waiting for Apple Developer setup).
- Payments are restricted to Sandbox mode only.
- Storage image physical deletion is deferred to Beta 2 (currently soft delete + metadata cleanup).
- Some modules are disabled for Beta 1:
  - Auction, Clubs, Lost & Found, POM, Real Estate, Stores, Together.

Tester instructions:
1. Install the APK from Firebase App Distribution.
2. Log in with your Google account.
3. Explore Smart Feed, News, Marketplace, and Jobs.
4. Try submitting one feedback item.
5. Test the report button on various content items (if you find anything suspicious).
6. **Do not attempt real payments.** Use the sandbox flow if prompted.
7. Report any bugs via the feedback form with screenshots and your device model.
