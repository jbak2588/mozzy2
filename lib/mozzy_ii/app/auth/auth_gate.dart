import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'auth_service.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          // 로그인 상태 감지 시 라우터의 메인 경로로 이동
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              try {
                context.go('/home');
              } catch (_) {
                // In tests there may be no GoRouter; ignore navigation error
              }
            }
          });
          // 기본 동작: 라우터가 없으면(테스트 환경 등) placeholder를 보여줌
          // 실제 앱에서는 addPostFrameCallback에서 navigation을 시도함
          return Scaffold(
            body: Center(child: Text('Home (navigation not configured)')),
          );
        }
        return const LoginScreen();
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFCC0001)),
        ),
      ),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authServiceProvider).signInWithGoogle();
    } catch (e) {
      // 개발용 로깅
      debugPrint('signInWithGoogle error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('auth.google_login_failed'.tr()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('app_name'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'geo.location_desc'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton.icon(
                onPressed: _handleGoogleSignIn,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(Icons.g_mobiledata, size: 32),
                label: Text('auth.google_login'.tr()),
              ),
          ],
        ),
      ),
    );
  }
}
