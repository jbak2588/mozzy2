import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/payment_repository.dart';
import '../repositories/firestore_payment_repository.dart';
import '../models/payment_model.dart';

part 'payment_provider.g.dart';

@riverpod
PaymentRepository paymentRepository(Ref ref) {
  return FirestorePaymentRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<PaymentModel?> paymentDetail(Ref ref, String paymentId) {
  final repo = ref.watch(paymentRepositoryProvider);
  return repo.watchPayment(paymentId);
}
