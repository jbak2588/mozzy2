import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../geo/models/location_parts.dart';
import '../../../geo/providers/location_provider.dart';
import '../../../geo/utils/default_indonesia_location.dart';
import '../../users/data/repositories/user_repository.dart';
import 'marketplace_provider.dart';

/// Marketplace 전용 effective location provider.
/// 우선순위:
/// 1. users/{uid}.locationParts (저장된 사용자 위치)
/// 2. locationProvider의 device location (현재 기기 위치)
/// 3. Jakarta Senayan fallback (기본값)
final effectiveMarketplaceLocationProvider =
    FutureProvider.autoDispose<LocationParts>((ref) async {
  final uid = ref.watch(currentMarketplaceUserIdProvider);

  // 1. Prefer saved user profile location
  if (uid != null) {
    try {
      final userRepo = ref.read(userRepositoryProvider);
      final user = await userRepo.getUser(uid).timeout(
        const Duration(seconds: 5),
      );
      final savedLocation = user?.locationParts;
      if (savedLocation != null) {
        if (kDebugMode) {
          debugPrint('[MarketplaceLocation] using saved user location');
        }
        return savedLocation;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[MarketplaceLocation] saved user location fetch failed or timed out: $e');
      }
    }
  }

  // 2. Try device location
  try {
    if (kDebugMode) debugPrint('[MarketplaceLocation] requesting device location...');
    final deviceLocation = await ref.read(locationProvider.future).timeout(
      const Duration(seconds: 5),
      onTimeout: () => null,
    );
    if (deviceLocation != null) {
      if (kDebugMode) {
        debugPrint('[MarketplaceLocation] using device location');
      }

      // Optional: save it back to user profile if logged in
      if (uid != null) {
        try {
          final userRepo = ref.read(userRepositoryProvider);
          await userRepo.updateLocation(uid, deviceLocation);
        } catch (_) {}
      }

      return deviceLocation;
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('[MarketplaceLocation] device location failed: $e');
    }
  }

  // 3. Always fallback to Jakarta Senayan
  if (kDebugMode) {
    debugPrint('[MarketplaceLocation] using fallback Jakarta Senayan');
  }

  final fallback = defaultJakartaSenayanLocation();

  // Optional: save fallback to user profile if missing and logged in
  if (uid != null) {
    try {
      final userRepo = ref.read(userRepositoryProvider);
      await userRepo.updateLocation(uid, fallback);
    } catch (_) {}
  }

  return fallback;
});
