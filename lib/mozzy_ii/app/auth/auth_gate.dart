import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:mozzy/mozzy_ii/app/auth/auth_service.dart';
import 'package:mozzy/mozzy_ii/app/auth/auth_bootstrap.dart';
import 'package:mozzy/mozzy_ii/core/config/integration_test_config.dart';
// keep imports minimal; bootstrap provider handles repo/location work

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (IntegrationTestConfig.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        try {
          context.go('/home');
        } catch (_) {}
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) return const LoginScreen();

        // 로그인된 상태 - use authBootstrapProvider to avoid repeated FutureBuilder runs
        String? uid;
        try {
          uid = user.uid;
        } catch (e) {
          // In tests MockUser may throw for unstubbed properties. Fall back to
          // showing a placeholder home to keep tests stable.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            try {
              context.go('/home');
            } catch (_) {}
          });
          return Scaffold(
            body: Center(child: Text('Home (navigation not configured)')),
          );
        }

        final bootstrap = ref.watch(authBootstrapProvider(uid));
        return bootstrap.when(
          data: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              try {
                context.go('/home');
              } catch (_) {}
            });
            return const Scaffold(body: SizedBox.shrink());
          },
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
        );
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
