// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/screens/admin_guard_screen.dart
// Purpose       : Route-level guard that blocks non-admin UIDs from accessing
//                 admin screens even via direct URL navigation.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../providers/marketplace_provider.dart';
import '../models/admin_role_model.dart';
import '../security/marketplace_admin_allowlist.dart';

/// Wraps admin screens to enforce UID allowlist + role-based access control.
/// If the current user is not in the allowlist or lacks admin permissions,
/// an Access Denied screen is shown instead of the child.
class MarketplaceAdminGuardScreen extends ConsumerWidget {
  const MarketplaceAdminGuardScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(currentMarketplaceUserIdProvider);

    // First gate: UID allowlist check (hard block)
    if (!isMarketplaceAdminUidAllowed(uid)) {
      return const _AdminAccessDeniedScreen();
    }

    // Second gate: Role-based check from async provider
    final roleAsync = ref.watch(marketplaceAdminRoleAsyncProvider);

    return roleAsync.when(
      data: (role) {
        if (!role.canViewReviewQueue) {
          return const _AdminAccessDeniedScreen();
        }
        return child;
      },
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Admin')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => const _AdminAccessDeniedScreen(),
    );
  }
}

class _AdminAccessDeniedScreen extends StatelessWidget {
  const _AdminAccessDeniedScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin')),
      body: Center(
        key: const Key('adminGuardAccessDenied'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'marketplace.adminAccessDenied'.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('marketplace.adminAccessDeniedDesc'.tr()),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/marketplace');
                }
              },
              child: Text('common.back'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
