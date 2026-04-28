import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozzy/mozzy_ii/app/auth/auth_service.dart';

class DevProfileScreen extends ConsumerWidget {
  const DevProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

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
