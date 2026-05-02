import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/users/data/models/user_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/trust/trust_score_service.dart';

class UserRepository {
  final FirebaseFirestore _fs;

  UserRepository([FirebaseFirestore? fs])
    : _fs = fs ?? FirebaseFirestore.instance;

  CollectionReference get _users => _fs.collection('users');

  Future<UserModel?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;

    if (kDebugMode) {
      // ignore: avoid_print
      print('[UserRepository] doc exists for $uid');
      // ignore: avoid_print
      print('[UserRepository] createdAt type: ${data['createdAt']?.runtimeType}');
      // ignore: avoid_print
      print('[UserRepository] updatedAt type: ${data['updatedAt']?.runtimeType}');
      // ignore: avoid_print
      print('[UserRepository] lastLoginAt type: ${data['lastLoginAt']?.runtimeType}');
    }

    // ensure uid included
    return UserModel.fromJson({...data, 'uid': uid});
  }

  Future<void> createUserIfNotExists(fb.User firebaseUser) async {
    final uid = firebaseUser.uid;
    final docRef = _users.doc(uid);
    final snapshot = await docRef.get();
    if (snapshot.exists) return;

    final now = DateTime.now().toUtc();
    final trustScore = TrustScoreService.initialForGoogle();
    final trustLevel = TrustScoreService.initialLevel();

    final userModel = UserModel(
      uid: uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      authProvider: 'google',
      countryCode: 'ID',
      locationParts: null,
      trustScore: trustScore,
      trustLevel: trustLevel,
      createdAt: now,
      updatedAt: now,
      lastLoginAt: now,
    );

    await docRef.set(userModel.toJson());
  }

  Future<void> updateLastLogin(String uid) async {
    final now = DateTime.now().toUtc();
    await _users.doc(uid).set({
      'lastLoginAt': now,
      'updatedAt': now,
    }, SetOptions(merge: true));
  }

  Future<void> updateLocation(String uid, LocationParts locationParts) async {
    final now = DateTime.now().toUtc();
    await _users.doc(uid).set({
      'locationParts': locationParts.toJson(),
      'countryCode': locationParts.countryCode,
      'updatedAt': now,
    }, SetOptions(merge: true));
  }
}

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(),
);
