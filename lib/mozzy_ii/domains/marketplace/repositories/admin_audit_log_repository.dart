// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/repositories/admin_audit_log_repository.dart
// Purpose       : 관리자 작업 감사 로그 저장 및 조회를 위한 저장소 추상 클래스 및 Firestore 구현.
// ============================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/admin_audit_log_model.dart';

abstract class AdminAuditLogRepository {
  Future<void> recordModerationAction(AdminAuditLogModel log);

  Future<List<AdminAuditLogModel>> fetchAuditLogsByProduct({
    required String productId,
    int limit = 20,
  });

  Future<List<AdminAuditLogModel>> fetchRecentAuditLogs({
    int limit = 50,
  });

  factory AdminAuditLogRepository() = FirestoreAdminAuditLogRepository;
}

class FirestoreAdminAuditLogRepository implements AdminAuditLogRepository {
  final FirebaseFirestore _firestore;

  FirestoreAdminAuditLogRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('countries/ID/domains/marketplace/admin_audit_logs');

  @override
  Future<void> recordModerationAction(AdminAuditLogModel log) async {
    await _collection.doc(log.id).set(log.toJson());
  }

  @override
  Future<List<AdminAuditLogModel>> fetchAuditLogsByProduct({
    required String productId,
    int limit = 20,
  }) async {
    final snapshot = await _collection
        .where('productId', isEqualTo: productId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => AdminAuditLogModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<AdminAuditLogModel>> fetchRecentAuditLogs({
    int limit = 50,
  }) async {
    final snapshot = await _collection
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => AdminAuditLogModel.fromJson(doc.data()))
        .toList();
  }
}
