import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:mozzy/mozzy_ii/app/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozzy/mozzy_ii/domains/users/data/repositories/user_repository.dart';
import 'package:mozzy/mozzy_ii/geo/providers/location_provider.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
// user_provider and indonesia_location_service imports are unused here

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) return const LoginScreen();

        // 로그인된 상태 - Firestore 사용자 문서 확인 및 생성/업데이트
        return FutureBuilder<void>(
          future: _handleAfterSignIn(ref, user),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snap.hasError) {
              return Scaffold(
                body: Center(child: Text('Error: ${snap.error}')),
              );
            }
            // 준비 완료 시 라우팅: (location presence handled in _handleAfterSignIn)
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              try {
                context.go('/home');
              } catch (_) {}
            });
            return const Scaffold(body: SizedBox.shrink());
          },
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

  Future<void> _handleAfterSignIn(WidgetRef ref, User user) async {
    final repo = ref.read(userRepositoryProvider);
    // ensure user doc exists
    await repo.createUserIfNotExists(user);
    await repo.updateLastLogin(user.uid);

    // check stored user doc
    final userModel = await repo.getUser(user.uid);

    final hasLocation = userModel?.locationParts != null;
    if (hasLocation) return;

    // try to resolve device location via provider
    try {
      final loc = await ref.read(locationProvider.future);
      if (loc != null) {
        await repo.updateLocation(user.uid, loc);
        return;
      }
    } catch (_) {
      // ignore, fallback below
    }

    // fallback default location (development)
    final fallback = LocationParts(
      countryCode: 'ID',
      idAddress: IndonesiaGeoAddress(
        provinsi: 'DKI Jakarta',
        kabupaten: 'Jakarta Selatan',
        kecamatan: 'Kebayoran Baru',
        kelurahan: 'Senayan',
      ),
      latitude: -6.2275,
      longitude: 106.7996,
      geoHash: '',
    );

    await repo.updateLocation(user.uid, fallback);
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
