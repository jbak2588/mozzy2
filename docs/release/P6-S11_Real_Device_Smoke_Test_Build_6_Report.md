# P6-S11 Real Device Smoke Test Build 6 Report

## 1. Scope
- Build 6 full real-device smoke test
- Android Beta 1 Go/No-Go decision

## 2. Repo / Build Info
- Repo: jbak2588/mozzy2
- Branch: main
- Base HEAD: bb16200
- Build: 1.0.0+6
- APK path: `build/app/outputs/flutter-apk/app-release.apk`
- Install source: adb install
- Device: Samsung SM-N971N (Physical)
- OS: Android 12
- Network: Wi-Fi
- Git status: Clean

## 3. PII Redaction Check
- Email redacted: Yes
- Firebase UID redacted: Yes
- Device serial redacted: Yes
- Token not logged: Yes
- Full log committed: No

## 4. Pre-test Verification
- flutter analyze --fatal-infos: Success (No issues found)
- selected flutter tests: Success (11 tests passed)
- functions-v2 npm test: Success (102 tests passed)

## 5. Smoke Test Results

### 5.1 Install / Launch
| ID | Scenario | Result | Notes |
|---|---|---|---|
| L01 | APK Install | Success | adb install successful |
| L02 | Splash/Launch | Success | App starts quickly without crash |
| L03 | Firebase Init | Success | Logs show successful initialization |

### 5.2 Auth / Account
| ID | Scenario | Result | Notes |
|---|---|---|---|
| A01 | Google Login | Success | Verified with real idToken (len 1082) |
| A02 | Firebase Auth | Success | Login successful (uid_redacted) |
| A03 | Smart Feed Nav | Success | Automatically redirects to Home |

### 5.3 Smart Feed
| ID | Scenario | Result | Notes |
|---|---|---|---|
| S01 | Feed Loading | Success | UI renders correctly |
| S02 | Content Empty | Success | Shows "Belum ada konten" (Empty state works) |
| S03 | Refresh | Success | Refresh indicator works |

### 5.4 News
| ID | Scenario | Result | Notes |
|---|---|---|---|
| N01 | News Tab | Success | Navigates to 'Berita Lokal' |
| N02 | News Empty | Success | Shows empty state correctly |

### 5.5 Marketplace
| ID | Scenario | Result | Notes |
|---|---|---|---|
| M01 | Product List | Success | Displays test products (Airpod, iPhone) |
| M02 | AI Badges | Success | 'Terverifikasi AI' / 'Tidak lolos AI' visible |
| M03 | Sold Badge | Success | 'TERJUAL' badge visible |

### 5.6 Jobs
| ID | Scenario | Result | Notes |
|---|---|---|---|
| J01 | Jobs Filter | Success | 'Lowongan' chip in Smart Feed works |
| J02 | Jobs Empty | Success | Empty state works |

### 5.7 Moderation / Admin
| ID | Scenario | Result | Notes |
|---|---|---|---|
| D01 | Admin Access | **Blocked** | No entry point in production UI |

### 5.8 Feedback / CS
| ID | Scenario | Result | Notes |
|---|---|---|---|
| F01 | Feedback UI | Success | Accessible via Smart Feed top icon |
| F02 | Form Fields | Success | Type selection and message input work |

### 5.9 Crashlytics / Performance
| ID | Scenario | Result | Notes |
|---|---|---|---|
| C01 | Trace logs | Success | Logs show trace events |

### 5.10 Beta Module Guard
| ID | Scenario | Result | Notes |
|---|---|---|---|
| G01 | Toko (Stores) | Success | Displays 'Segera Hadir' (Coming Soon) |
| G02 | Hidden Tabs | Success | Auction/Clubs/etc. are not visible |

### 5.11 Account Deletion
| ID | Scenario | Result | Notes |
|---|---|---|---|
| X01 | UI Entry | **Blocked** | No entry point in production UI (Dev profile only) |

## 6. Bugs Found
| Priority | Area | Issue | Repro Steps | Status |
|---|---|---|---|---|
| P1 | Chat | Firestore index missing for `chat_rooms` query | Navigate to 'Pesan' tab -> Infinite loading | New |
| P1 | Account | No production entry point for Profile/Settings | Try to find logout or delete account in release build | New |
| P2 | Feed | Empty states for News/Jobs | Default view has no sample content for new users | New |

## 7. Known Limitations
- iOS TestFlight remains No-Go.
- Storage image physical deletion deferred.
- Active transaction deletion blocking is advisory only.
- GitHub Actions workflow/secrets automation pending.

## 8. Decision
- Android Beta 1: **Conditional Go**
  - **Reason**: Google Login and Core UI are stable, but crucial features like Profile/Settings entry point and Chat index must be fixed before public beta release.

## 9. Next Step
- **P6-S12 Beta Fix Sprint**: 
  1. Add production Profile/Settings entry point (e.g., in Bottom Nav or Smart Feed).
  2. Register required Firestore indexes.
  3. Finalize Beta 1 distribution.
