# Mozzy New Chat Handoff - 2026-05-01 (Timestamp Hotfix)

## 🎯 Current Task: P2-B22 Marketplace Staging Firebase Live Verification

## ⚠️ Critical Context
The Google Login `DEVELOPER_ERROR` was found to be secondary to a **Firestore Timestamp parsing crash**. After account selection, the app would crash when trying to parse the `users` document because Firestore `Timestamp` objects were being cast to `String` in `UserModel.fromJson`.

## ✅ Hotfix Applied
- **UserModel Update**: Added `_dateTimeFromJson` and `_dateTimeToJson` helpers to handle `Timestamp`, `DateTime`, and `String` inputs.
- **Riverpod/json_serializable**: Re-ran `build_runner` to apply changes to `user_model.g.dart`.
- **Validation**: Added unit test `test/mozzy_ii/domains/users/user_model_timestamp_test.dart`. **PASS**.

## 🚀 Next Steps (Action Plan)
1.  **Live Login**: Run the app and select a Google account.
2.  **Verify UI**: Ensure the app proceeds to `/home` after login without the `Timestamp` error.
3.  **Marketplace Flow**:
    - Create a product (Marketplace -> Add Product).
    - Verify image upload to Firebase Storage.
    - Verify Gemini AI screening triggers (Check moderation queue).
4.  **Admin Review**: Verify admin test user can see/act on the moderation queue.

## 🔑 Environment Variables Required
- `GEMINI_API_KEY`: [IN_ENV]
- `GOOGLE_WEB_CLIENT_ID`: `149673701591-oml428ssc9hon7mla0rvsn6e528hgdv9.apps.googleusercontent.com`
- `MOZZY_STAGING_ADMIN_TEST_UID`: `F1RhoJnK0uUQ1jPzvA9GuIG6U2w1`

## 📦 Reference Commits
- Fix Commit: `fix(auth): handle Firestore timestamp fields in user model` (to be committed)
