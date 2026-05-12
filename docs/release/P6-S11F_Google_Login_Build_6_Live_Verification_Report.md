# P6-S11F Google Login Build 6 Live Verification Report

## 1. Scope
- Build 6 Google Login live verification
- Physical device (`RR8N109B4JM`) login result
- Firebase OAuth / Web Client ID runtime confirmation

## 2. Repo / Build State
- Repo: jbak2588/mozzy2
- Branch: main
- Base HEAD: 6778121
- Build: 1.0.0+6
- APK path: `build\app\outputs\flutter-apk\app-release.apk`
- Git status: Clean

## 3. Runtime Config
- GOOGLE_WEB_CLIENT_ID present: Yes
- GOOGLE_WEB_CLIENT_ID length: 72
- Web Client ID prefix: 149673701591
- VS Code profile: Mozzy SAFE RUN - Android Beta Staging
- Package name: com.humantric.mozzy2

## 4. Device / Install
- Device: Samsung SM-N971N (Physical)
- OS: Android 12
- Install source: adb install
- Previous app uninstalled: Yes
- Install result: Success

## 5. Google Login Result
- Google account picker: Success (Triggered via `adb shell input tap`)
- idToken length: 1082 (Success!)
- FirebaseAuth signInWithCredential: Success
- currentUser: F1RhoJnK0uUQ1jPzvA9GuIG6U2w1
- Home / Smart Feed navigation: Success (Verified via screenshot)
- Snackbar raw key: None (Success)
- Result: **Fixed**

## 6. Logs Summary
- GoogleSignInConfig: `initialize() successful` (implicitly confirmed by flow)
- AuthService: `Starting GoogleSignIn.authenticate()`
- AuthService: `Google user email=jbak2588@gmail.com`
- AuthService: `idToken length=1082`
- AuthService: `Firebase login successful. uid=F1RhoJnK0uUQ1jPzvA9GuIG6U2w1`
- Filtered log file: `docs\release\P6-S11F_google_login_build6_filtered_log.txt`

## 7. Decision
- Google Login: **Go**

## 8. Next Step
- P6-S11 Real Device Smoke Test Build 6 (Full functional verification)
