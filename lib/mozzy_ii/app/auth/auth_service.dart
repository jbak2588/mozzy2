import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_failure.dart';
import 'google_sign_in_config.dart';

part 'auth_service.g.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  /// Google 로그인
  Future<UserCredential?> signInWithGoogle() async {
    // 0. 필수 설정 확인
    if (!GoogleSignInConfig.hasWebClientId) {
      debugPrint('[AuthService] Aborting: GOOGLE_WEB_CLIENT_ID is missing.');
      throw AuthFailure(AuthFailure.googleWebClientIdMissing);
    }

    try {
      debugPrint('[AuthService] Starting GoogleSignIn.authenticate()');
      
      // 1. Google 로그인 프로세스 시작
      final googleUser = await GoogleSignIn.instance.authenticate();

      debugPrint('[AuthService] Google user email=${googleUser.email}');

      // 2. Google 인증 세부 정보 획득
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      debugPrint('[AuthService] idToken length=${idToken?.length ?? 0}');

      if (idToken == null || idToken.isEmpty) {
        debugPrint('[AuthService] Error: idToken is null or empty');
        throw AuthFailure(AuthFailure.googleIdTokenMissing);
      }

      // 3. Firebase용 새 자격 증명 생성
      final credential = GoogleAuthProvider.credential(idToken: idToken);

      debugPrint('[AuthService] Attempting _auth.signInWithCredential(credential)');

      // 4. Firebase 인증을 통해 로그인
      final result = await _auth.signInWithCredential(credential);
      debugPrint('[AuthService] Firebase login successful. uid=${result.user?.uid}');
      return result;
    } on GoogleSignInException catch (gse) {
      final codeString = gse.code.toString();
      debugPrint('[AuthService] GoogleSignInException:');
      debugPrint('  - Code: $codeString');
      debugPrint('  - Details: ${gse.details}');
      
      // GoogleSignInExceptionCode check (package dependent)
      if (codeString.contains('canceled')) {
        throw AuthFailure(AuthFailure.googleSignInCancelled);
      }
      
      throw AuthFailure(AuthFailure.googleSignInUnknown, message: codeString);
    } on FirebaseAuthException catch (fae) {
      debugPrint('[AuthService] FirebaseAuthException:');
      debugPrint('  - Code: ${fae.code}');
      debugPrint('  - Message: ${fae.message}');
      
      if (fae.code == 'invalid-credential') {
        throw AuthFailure(AuthFailure.firebaseAuthInvalidCredential);
      }
      if (fae.code == 'network-request-failed') {
        throw AuthFailure(AuthFailure.firebaseAuthNetworkRequestFailed);
      }
      
      rethrow;
    } catch (e, stack) {
      debugPrint('[AuthService] Unknown Google login error: $e');
      debugPrint('Stack trace: $stack');
      if (e is AuthFailure) rethrow;
      throw AuthFailure(AuthFailure.googleSignInUnknown, message: e.toString());
    }
  }

  /// 익명 로그인 (둘러보기 모드)
  Future<UserCredential> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      rethrow;
    }
  }

  /// 전화번호 인증 - 코드 전송 (추후 사용)
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  /// 전화번호 인증 - 코드 검증 및 로그인 (추후 사용)
  Future<UserCredential> signInWithPhoneNumber(
    String verificationId,
    String smsCode,
  ) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return await _auth.signInWithCredential(credential);
  }

  /// 로그아웃
  Future<void> signOut({bool disconnectGoogle = false}) async {
    try {
      if (disconnectGoogle) {
        try {
          await GoogleSignIn.instance.disconnect();
        } catch (e) {
          if (kDebugMode) {
            debugPrint('[AuthService] Google disconnect failed, fallback to signOut: $e');
          }
          await GoogleSignIn.instance.signOut();
        }
      } else {
        await GoogleSignIn.instance.signOut();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[AuthService] Google signOut failed: $e');
      }
    }

    await _auth.signOut();
  }
}

@riverpod
AuthService authService(Ref ref) {
  return AuthService();
}

@riverpod
Stream<User?> authState(Ref ref) {
  return ref.watch(authServiceProvider).authStateChanges;
}
