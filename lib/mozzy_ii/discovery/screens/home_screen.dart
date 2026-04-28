import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../geo/providers/location_provider.dart';
import '../../domains/users/presentation/providers/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user;
    try {
      user = FirebaseAuth.instance.currentUser;
    } catch (_) {
      user = null; // In tests Firebase may not be initialized
    }

    final locationAsync = ref.watch(locationProvider);

    // If we have a uid, watch user model; otherwise null
    final userModelAsync = user != null
        ? ref.watch(userModelProvider(user.uid))
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.go('/dev/profile'),
            tooltip: 'home.devProfile'.tr(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'app_name'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'home.welcome'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),

              // Current Location
              Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFFCC0001)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: locationAsync.when(
                      data: (loc) {
                        if (loc == null) {
                          return Text('home.locationUnavailable'.tr());
                        }
                        final kec = loc.idAddress?.kecamatan ?? '';
                        final kab = loc.idAddress?.kabupaten ?? '';
                        if (kec.isEmpty && kab.isEmpty) {
                          return Text('home.locationUnavailable'.tr());
                        }
                        return Text('$kec, $kab');
                      },
                      loading: () => Text('geo.detecting'.tr()),
                      error: (error, stack) =>
                          Text('home.locationUnavailable'.tr()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // User / Trust info
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'home.currentLocation'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'home.trustStatus'.tr(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (userModelAsync == null) ...[
                                  Text(user?.email ?? user?.displayName ?? '—'),
                                  const SizedBox(height: 6),
                                  Text('${'home.trustStatus'.tr()}: —'),
                                ] else ...[
                                  userModelAsync.when(
                                    data: (model) {
                                      final score = (model != null)
                                          ? model.trustScore.toStringAsFixed(2)
                                          : '—';
                                      final level = (model != null)
                                          ? model.trustLevel
                                          : '—';
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user?.email ??
                                                user?.displayName ??
                                                '—',
                                          ),
                                          const SizedBox(height: 6),
                                          Text('Trust: $score'),
                                          Text('Level: $level'),
                                        ],
                                      );
                                    },
                                    loading: () => const Text('Memuat...'),
                                    error: (error, stack) => const Text('—'),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFCC0001),
                            ),
                            onPressed: () => context.go('/dev/profile'),
                            child: Text('home.devProfile'.tr()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Placeholder for feed
              const Expanded(child: Center(child: Text('Feed placeholder'))),
            ],
          ),
        ),
      ),
    );
  }
}
