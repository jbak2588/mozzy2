import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozzy/mozzy_ii/domains/users/data/repositories/user_repository.dart';
import 'package:mozzy/mozzy_ii/geo/providers/location_provider.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Bootstraps user data after sign-in. Family keyed by uid so it's run once per uid.
final authBootstrapProvider = FutureProvider.family<void, String>((
  ref,
  uid,
) async {
  final repo = ref.read(userRepositoryProvider);

  // Ensure user doc exists and update last login
  final firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser == null) return;

  await repo.createUserIfNotExists(firebaseUser);
  await repo.updateLastLogin(uid);

  // If user already has location, nothing to do
  final existing = await repo.getUser(uid);
  if (existing?.locationParts != null) return;

  // Try to get device location from provider
  try {
    final loc = await ref.read(locationProvider.future);
    if (loc != null) {
      await repo.updateLocation(uid, loc);
      return;
    }
  } catch (_) {}

  // Fallback location
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
    geoHash: GeoFirePoint(GeoPoint(-6.2275, 106.7996)).geohash,
  );

  await repo.updateLocation(uid, fallback);
});
