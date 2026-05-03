// ============================================================================
// Mozzy DocHeader
// Module        : Dev/Diagnostics
// File          : lib/mozzy_ii/dev/profile_screen.dart
// Purpose       : 개발 전용 진단 및 사용자 프로필 확인 화면.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../app/auth/auth_service.dart';
import '../domains/users/presentation/providers/user_provider.dart';

/// Dev/Profile screen: development-only diagnostics for current user
class DevProfileScreen extends ConsumerStatefulWidget {
  const DevProfileScreen({super.key});

  @override
  ConsumerState<DevProfileScreen> createState() => _DevProfileScreenState();
}

class _DevProfileScreenState extends ConsumerState<DevProfileScreen> {
  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userModelAsync = user != null
        ? ref.watch(userModelProvider(user.uid))
        : null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        title: const Text('Dev Profile'),
        actions: [
          IconButton(
            tooltip: 'Close',
            icon: const Icon(Icons.close),
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Email: ${user?.email ?? "-"}'),
            const SizedBox(height: 8),
            Text('UID: ${user?.uid ?? "-"}'),
            const SizedBox(height: 8),
            Text('DisplayName: ${user?.displayName ?? "-"}'),
            const Divider(height: 32),
            const Text(
              'Firestore Doc',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            userModelAsync == null
                ? const Text('No user signed in.')
                : userModelAsync.when(
                    data: (model) {
                      if (model == null) return const Text('No user doc found.');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('trustScore: ${model.trustScore}'),
                          Text('trustLevel: ${model.trustLevel}'),
                          Text('countryCode: ${model.countryCode}'),
                          Text('has location: ${model.locationParts != null}'),
                        ],
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Text('Error: $e'),
                  ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSigningOut
                    ? null
                    : () async {
                        setState(() => _isSigningOut = true);
                        try {
                          // disconnectGoogle: true를 통해 다음 로그인 시 계정 선택창이 뜨도록 함
                          await ref.read(authServiceProvider).signOut(
                            disconnectGoogle: true,
                          );

                          if (!context.mounted) return;
                          // AuthGate가 상태 변화를 감지하여 로그인 화면으로 보내겠지만, 명시적으로 이동
                          context.go('/');
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logout failed: $e')),
                          );
                        } finally {
                          if (mounted) {
                            setState(() => _isSigningOut = false);
                          }
                        }
                      },
                icon: _isSigningOut
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.logout),
                label: Text(
                  _isSigningOut ? 'Signing out...' : 'Logout / Switch Account',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
