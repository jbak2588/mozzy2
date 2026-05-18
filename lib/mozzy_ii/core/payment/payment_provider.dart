import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'xendit_service.dart';
import 'firebase_xendit_service.dart';
import 'payment_repository.dart';

part 'payment_provider.g.dart';

@riverpod
XenditService xenditService(Ref ref) {
  return FirebaseXenditService();
}

@riverpod
PaymentRepository paymentRepository(Ref ref) {
  return PaymentRepository(
    service: ref.watch(xenditServiceProvider),
  );
}
