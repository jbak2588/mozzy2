import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozzy/mozzy_ii/domains/users/data/models/user_model.dart';

void main() {
  group('UserModel Timestamp Parsing', () {
    const baseJson = {
      'uid': 'test-uid',
      'email': 'test@example.com',
      'displayName': 'Test User',
      'photoUrl': 'https://example.com/photo.jpg',
      'authProvider': 'google',
      'countryCode': 'ID',
      'trustScore': 0.8,
      'trustLevel': 'verified',
    };

    test('should parse Firestore Timestamp correctly', () {
      final now = Timestamp.now();
      final json = {
        ...baseJson,
        'createdAt': now,
        'updatedAt': now,
        'lastLoginAt': now,
      };

      final user = UserModel.fromJson(json);

      expect(user.createdAt, now.toDate().toUtc());
      expect(user.updatedAt, now.toDate().toUtc());
      expect(user.lastLoginAt, now.toDate().toUtc());
    });

    test('should parse ISO String correctly', () {
      final now = DateTime.now().toUtc();
      final isoString = now.toIso8601String();
      final json = {
        ...baseJson,
        'createdAt': isoString,
        'updatedAt': isoString,
        'lastLoginAt': isoString,
      };

      final user = UserModel.fromJson(json);

      // DateTime.parse might lose some microsecond precision depending on platform, 
      // but for ISO strings it should be exact.
      expect(user.createdAt, now);
      expect(user.updatedAt, now);
      expect(user.lastLoginAt, now);
    });

    test('should parse DateTime correctly', () {
      final now = DateTime.now().toUtc();
      final json = {
        ...baseJson,
        'createdAt': now,
        'updatedAt': now,
        'lastLoginAt': now,
      };

      final user = UserModel.fromJson(json);

      expect(user.createdAt, now);
      expect(user.updatedAt, now);
      expect(user.lastLoginAt, now);
    });

    test('should allow null lastLoginAt', () {
      final now = Timestamp.now();
      final json = {
        ...baseJson,
        'createdAt': now,
        'updatedAt': now,
        'lastLoginAt': null,
      };

      final user = UserModel.fromJson(json);

      expect(user.lastLoginAt, isNull);
    });

    test('should throw FormatException for unsupported types', () {
      final now = Timestamp.now();
      final json = {
        ...baseJson,
        'createdAt': 12345678, // int not supported
        'updatedAt': now,
        'lastLoginAt': null,
      };

      expect(() => UserModel.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
