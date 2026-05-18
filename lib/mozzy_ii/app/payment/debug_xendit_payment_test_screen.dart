import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/payment/models/payment_request.dart';
import '../../core/payment/models/payment_purpose.dart';
import '../../core/payment/widgets/xendit_payment_sheet.dart';
import '../../app/auth/auth_service.dart';

class DebugXenditPaymentTestScreen extends ConsumerWidget {
  const DebugXenditPaymentTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xendit Sandbox Payment E2E Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final userId = ref.read(authStateProvider).value?.uid ?? 'debug_user_001';
            final request = PaymentRequest(
              purpose: PaymentPurpose.aiVerification,
              userId: userId,
              amountIdr: 15000,
              description: 'Mozzy AI Verification Sandbox Test',
              sourceType: 'product',
              sourceId: 'sandbox_product_001',
              metadata: {
                'testRun': 'P6-S31',
              },
            );
            XenditPaymentSheet.show(context, request);
          },
          child: const Text('Open Payment Sheet'),
        ),
      ),
    );
  }
}
