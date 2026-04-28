import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozzy/mozzy_ii/app/auth/auth_service.dart';
import 'package:mozzy/mozzy_ii/domains/users/presentation/providers/user_provider.dart';

// Dev/Profile screen: development-only diagnostics for current user

class DevProfileScreen extends ConsumerWidget {
  const DevProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final userModelAsync = user != null
        ? ref.watch(userModelProvider(user.uid))
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Dev Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user?.email ?? "-"}'),
            const SizedBox(height: 12),
            Text('UID: ${user?.uid ?? "-"}'),
            const SizedBox(height: 12),
            Text('DisplayName: ${user?.displayName ?? "-"}'),
            const SizedBox(height: 16),
            userModelAsync == null
                ? const SizedBox.shrink()
                : userModelAsync.when(
                    data: (model) {
                      if (model == null) return const Text('No user doc');
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
                    loading: () => const CircularProgressIndicator(),
                    error: (e, st) => Text('Error: $e'),
                  ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authServiceProvider).signOut();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
