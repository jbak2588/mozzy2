import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  /// Google 로그인
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Google 로그인 프로세스 시작
      final googleUser = await GoogleSignIn.instance.authenticate();

      // 2. Google 인증 세부 정보 획득
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null || idToken.isEmpty) {
        throw StateError('Google ID token is null or empty');
      }

      // 3. Firebase용 새 자격 증명 생성
      final credential = GoogleAuthProvider.credential(idToken: idToken);

      // 4. Firebase 인증을 통해 로그인
      return await _auth.signInWithCredential(credential);
    } on GoogleSignInException catch (gse) {
      throw StateError('Google sign-in failed: $gse');
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
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
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
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
