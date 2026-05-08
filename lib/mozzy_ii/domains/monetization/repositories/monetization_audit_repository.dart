import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/monetization_audit_log_model.dart';

class MonetizationAuditRepository {
  final FirebaseFirestore _firestore;

  MonetizationAuditRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('monetization_audit_logs');

  /// Admin-only / future admin console
  Stream<List<MonetizationAuditLogModel>> watchRecentAuditLogs({int limit = 50}) {
    return _collection
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MonetizationAuditLogModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  /// Admin-only / future admin console
  Stream<List<MonetizationAuditLogModel>> watchAuditLogsByType(String type,
      {int limit = 50}) {
    return _collection
        .where('type', isEqualTo: type)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MonetizationAuditLogModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  Stream<List<MonetizationAuditLogModel>> watchLogsByJobId(String jobId) {
    return _collection
        .where('jobId', isEqualTo: jobId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MonetizationAuditLogModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  Stream<List<MonetizationAuditLogModel>> watchLogsByPaymentId(String paymentId) {
    return _collection
        .where('paymentId', isEqualTo: paymentId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MonetizationAuditLogModel.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }
}
