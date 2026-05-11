import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/report_model.dart';

class ReportRepository {
  final FirebaseFirestore _firestore;

  ReportRepository(this._firestore);

  CollectionReference get _reportsRef => _firestore.collection('reports');

  Future<void> createReport(ReportModel report) async {
    final docRef = _reportsRef.doc();
    final newReport = report.copyWith(id: docRef.id);
    await docRef.set(newReport.toJson());
  }

  Stream<List<ReportModel>> watchPendingReports() {
    return _reportsRef
        .where('status', isEqualTo: ReportStatus.pending.name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ReportModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateReportStatus(String reportId, ReportStatus status, String adminId, {String? adminNote}) async {
    await _reportsRef.doc(reportId).update({
      'status': status.name,
      'reviewedBy': adminId,
      'reviewedAt': FieldValue.serverTimestamp(),
      if (adminNote != null) 'adminNote': adminNote,
    });
  }
}
