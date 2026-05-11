import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/report_repository.dart';
import '../services/moderation_service.dart';
import '../models/report_model.dart';

part 'moderation_providers.g.dart';

@riverpod
ReportRepository reportRepository(Ref ref) {
  return ReportRepository(FirebaseFirestore.instance);
}

@riverpod
ModerationService moderationService(Ref ref) {
  final repo = ref.watch(reportRepositoryProvider);
  return ModerationService(repo, FirebaseFirestore.instance);
}

@riverpod
Stream<List<ReportModel>> pendingReports(Ref ref) {
  final repo = ref.watch(reportRepositoryProvider);
  return repo.watchPendingReports();
}
