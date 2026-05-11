import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feedback_model.dart';

class FeedbackRepository {
  final FirebaseFirestore _firestore;

  FeedbackRepository(this._firestore);

  CollectionReference get _feedbackRef => _firestore.collection('feedback');

  Future<void> createFeedback(FeedbackModel feedback) async {
    final docRef = _feedbackRef.doc();
    final newFeedback = feedback.copyWith(id: docRef.id);
    await docRef.set(newFeedback.toJson());
  }

  Stream<List<FeedbackModel>> watchOpenFeedback() {
    return _feedbackRef
        .where('status', isEqualTo: FeedbackStatus.open.name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return FeedbackModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateFeedbackStatus(String feedbackId, FeedbackStatus status, String adminId, {String? adminNote}) async {
    await _feedbackRef.doc(feedbackId).update({
      'status': status.name,
      'resolvedBy': adminId,
      'resolvedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'adminNote': ?adminNote,
    });
  }
}
