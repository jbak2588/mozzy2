import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozzy/mozzy_ii/domains/users/data/repositories/user_repository.dart';
import 'package:mozzy/mozzy_ii/geo/providers/location_provider.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/geo/utils/default_indonesia_location.dart';

/// Bootstraps user data after sign-in. Family keyed by uid so it's run once per uid.
final authBootstrapProvider = FutureProvider.family<void, String>((
  ref,
  uid,
) async {
  final repo = ref.read(userRepositoryProvider);
  final shortUid = uid.substring(0, uid.length > 6 ? 6 : uid.length);

  if (kDebugMode) {
    debugPrint('[AuthBootstrap] start uid=$shortUid...');
  }

  // Ensure user doc exists and update last login
  final firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser == null) {
    if (kDebugMode) debugPrint('[AuthBootstrap] firebaseUser is null');
    return;
  }

  await repo.createUserIfNotExists(firebaseUser);
  if (kDebugMode) debugPrint('[AuthBootstrap] user doc ensured');

  await repo.updateLastLogin(uid);
  if (kDebugMode) debugPrint('[AuthBootstrap] last login updated');

  // If user already has location, nothing to do
  final existing = await repo.getUser(uid);
  if (existing?.locationParts != null) {
    if (kDebugMode) debugPrint('[AuthBootstrap] existing location found');
    return;
  }

  // Fallback location
  final fallback = defaultJakartaSenayanLocation();

  // Try to get device location from provider
  if (kDebugMode) debugPrint('[AuthBootstrap] requesting device location');
  LocationParts? loc;
  try {
    loc = await ref
        .read(locationProvider.future)
        .timeout(const Duration(seconds: 5), onTimeout: () => null);
  } catch (e) {
    if (kDebugMode) {
      debugPrint('[AuthBootstrap] locationProvider failed: $e');
    }
    loc = null;
  }

  if (loc != null) {
    if (kDebugMode) debugPrint('[AuthBootstrap] device location obtained');
    await repo.updateLocation(uid, loc);
  } else {
    if (kDebugMode) {
      debugPrint('[AuthBootstrap] device location timeout/failure, using fallback');
    }
    await repo.updateLocation(uid, fallback);
    if (kDebugMode) debugPrint('[AuthBootstrap] fallback location saved');
  }

  if (kDebugMode) debugPrint('[AuthBootstrap] completed');
});
