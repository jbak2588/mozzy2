import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/feedback_model.dart';
import '../repositories/feedback_repository.dart';
import '../services/feedback_service.dart';

part 'feedback_providers.g.dart';

@riverpod
FeedbackRepository feedbackRepository(Ref ref) {
  return FeedbackRepository(FirebaseFirestore.instance);
}

@riverpod
FeedbackService feedbackService(Ref ref) {
  final repo = ref.watch(feedbackRepositoryProvider);
  return FeedbackService(repo);
}

@riverpod
Stream<List<FeedbackModel>> openFeedback(Ref ref) {
  final service = ref.watch(feedbackServiceProvider);
  return service.watchOpenFeedback();
}
