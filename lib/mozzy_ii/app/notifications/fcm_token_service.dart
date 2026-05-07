import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domains/users/data/models/fcm_token_model.dart';
import '../../domains/users/data/repositories/fcm_token_repository.dart';

final fcmTokenRepositoryProvider = Provider<FcmTokenRepository>((ref) {
  return FcmTokenRepository(FirebaseFirestore.instance);
});

final fcmTokenServiceProvider = Provider<FcmTokenService>((ref) {
  return FcmTokenService(FirebaseMessaging.instance, ref.watch(fcmTokenRepositoryProvider));
});

class FcmTokenService {
  final FirebaseMessaging _messaging;
  final FcmTokenRepository _repository;

  FcmTokenService(this._messaging, this._repository);

  Future<void> initialize(String userId) async {
    // Permission request
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      if (token != null) {
        await _saveToken(userId, token);
      }
    }

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      _saveToken(userId, newToken);
    });
  }

  Future<void> _saveToken(String userId, String token) async {
    final tokenModel = FcmTokenModel(
      token: token,
      platform: Platform.isAndroid ? 'android' : 'ios',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastSeenAt: DateTime.now(),
      isActive: true,
    );

    await _repository.saveToken(userId, tokenModel);
  }

  Future<void> deactivateToken(String userId) async {
    String? token = await _messaging.getToken();
    if (token != null) {
      await _repository.deactivateToken(userId, token);
    }
  }
}
