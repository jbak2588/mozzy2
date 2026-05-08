import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/payment_provider_type.dart';

part 'payment_action_provider.g.dart';

class JobBoostPaymentResult {
  final String paymentId;
  final String invoiceUrl;
  final String status;

  JobBoostPaymentResult({
    required this.paymentId,
    required this.invoiceUrl,
    required this.status,
  });
}

@riverpod
class PaymentAction extends _$PaymentAction {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<JobBoostPaymentResult?> createJobBoostPayment({
    required String jobId,
    required String packageId,
    required PaymentProviderType provider,
  }) async {
    state = const AsyncValue.loading();
    try {
      final callable = FirebaseFunctions.instanceFor(region: 'asia-southeast2')
          .httpsCallable('createJobBoostPayment');
      
      final result = await callable.call({
        'jobId': jobId,
        'packageId': packageId,
        'provider': provider.name,
      });

      final data = result.data as Map<String, dynamic>;
      final boostResult = JobBoostPaymentResult(
        paymentId: data['paymentId'],
        invoiceUrl: data['invoiceUrl'],
        status: data['status'],
      );

      state = const AsyncValue.data(null);
      return boostResult;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}
