import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/users/data/models/user_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  test('UserModel toJson/fromJson basic fields', () {
    final user = UserModel(
      uid: 'uid123',
      email: 'a@b.com',
      displayName: 'A',
      photoUrl: null,
      authProvider: 'google',
      countryCode: 'ID',
      locationParts: null,
      trustScore: 0.3,
      trustLevel: 'anggota_baru',
      createdAt: DateTime.parse('2026-01-01T00:00:00Z'),
      updatedAt: DateTime.parse('2026-01-01T00:00:00Z'),
      lastLoginAt: DateTime.parse('2026-01-01T00:00:00Z'),
    );

    final json = user.toJson();
    expect(json['uid'], 'uid123');
    expect(json['email'], 'a@b.com');
    expect(json['authProvider'], 'google');
    expect(json['trustScore'], 0.3);

    final restored = UserModel.fromJson(Map<String, dynamic>.from(json));
    expect(restored.uid, user.uid);
    expect(restored.email, user.email);
    expect(restored.trustLevel, user.trustLevel);
  });

  test('UserModel handles locationParts null and present', () {
    final noLoc = UserModel(
      uid: 'u1',
      email: null,
      displayName: null,
      photoUrl: null,
      authProvider: 'google',
      countryCode: 'ID',
      locationParts: null,
      trustScore: 0.3,
      trustLevel: 'anggota_baru',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: null,
    );
    final json = noLoc.toJson();
    expect(json.containsKey('locationParts'), true);

    final loc = LocationParts(
      countryCode: 'ID',
      idAddress: IndonesiaGeoAddress(
        provinsi: 'P',
        kabupaten: 'K',
        kecamatan: 'C',
        kelurahan: 'L',
      ),
      globalAddress: null,
      latitude: -6.0,
      longitude: 106.0,
      geoHash: 'dummy',
    );

    final withLoc = UserModel(
      uid: 'u2',
      email: null,
      displayName: null,
      photoUrl: null,
      authProvider: 'google',
      countryCode: 'ID',
      locationParts: loc,
      trustScore: 0.3,
      trustLevel: 'anggota_baru',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastLoginAt: null,
    );

    final encoded = withLoc.toJson();
    final decoded = UserModel.fromJson(Map<String, dynamic>.from(encoded));
    expect(decoded.locationParts, isNotNull);
    expect(decoded.locationParts!.countryCode, 'ID');
  });
}
