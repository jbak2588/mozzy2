# Beta Real Device Test Run Template — 2026-05-11

## 1. Test Run Info
- **Date:** 2026-05-11
- **Tester:** [이름]
- **Device:** [기기명, 예: Samsung Galaxy S23]
- **OS:** [OS 버전, 예: Android 14]
- **Build:** [빌드 버전, 예: 1.0.0+1]
- **Firebase project:** mozzy-v2 (Staging)
- **APK source:** Local build / Firebase App Distribution
- **Network condition:** Wi-Fi / 5G / 4G / Offline

## 2. Result Summary
- **Overall Status:** [Pass / Fail / Conditional Pass]
- **Go / No-Go Recommendation:** [Go / Conditional Go / No-Go]
- **Critical failures:** [치명적 결함 목록 또는 없음]
- **Non-blocking issues:** [사소한 결함 목록 또는 없음]
- **Screenshots/logs:** [첨부 링크 또는 경로]

## 3. Scenario Results

| ID | Area | Scenario | Result | Notes |
|---|---|---|---|---|
| 1.1 | Install | APK Installation |  |  |
| 1.2 | Launch | Initial Launch (Auth Gate) |  |  |
| 2.1 | Auth | Google Login |  |  |
| 3.1 | Feed | Smart Feed Loading |  |  |
| 3.3 | Logging | Viewport Impression Logging |  |  |
| 4.3 | News | News Report Button |  |  |
| 5.2 | Market | Product Detail (AI Badge) |  |  |
| 6.4 | Jobs | Sandbox Payment Warning |  |  |
| 7.3 | Admin | Hide Content Action |  |  |
| 8.3 | Feedback| Feedback Submission |  |  |
| 9.2 | Monitor | Non-fatal Error Send |  |  |
| 10.2| Guard | Beta Module "Coming Soon" |  |  |
| 11.3| Account | Account Deletion Request |  |  |

## 4. Crash / Performance Observations
- **Crashlytics event sent:** [Yes / No]
- **Non-fatal event sent:** [Yes / No]
- **Performance trace visible:** [Yes / No]
- **App startup time:** [느낌 상 빠름 / 보통 / 느림]
- **Smart Feed scroll performance:** [부드러움 / 약간의 버벅임 / 심한 버벅임]

## 5. Follow-up Bugs
| Priority | Area | Issue | Owner | Status |
|---|---|---|---|---|
| P0 | Auth | ... |  | New |
| P1 | UI | ... |  | New |
| P2 | Perf | ... |  | New |
