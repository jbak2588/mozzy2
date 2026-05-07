import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/fcm_token_model.dart';

class FcmTokenRepository {
  final FirebaseFirestore _firestore;

  FcmTokenRepository(this._firestore);

  CollectionReference _tokensRef(String userId) =>
      _firestore.collection('users').doc(userId).collection('fcm_tokens');

  Future<void> saveToken(String userId, FcmTokenModel tokenModel) async {
    await _tokensRef(userId).doc(tokenModel.token).set(tokenModel.toJson());
  }

  Future<void> updateLastSeen(String userId, String token) async {
    await _tokensRef(userId).doc(token).update({
      'lastSeenAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'isActive': true,
    });
  }

  Future<void> deactivateToken(String userId, String token) async {
    await _tokensRef(userId).doc(token).update({
      'isActive': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<FcmTokenModel>> getActiveTokens(String userId) async {
    final snapshot = await _tokensRef(userId)
        .where('isActive', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((doc) => FcmTokenModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
