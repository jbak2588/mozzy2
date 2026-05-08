import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/payments/screens/payment_status_screen.dart';
import 'package:mozzy/mozzy_ii/domains/payments/providers/payment_provider.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_model.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_status.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_provider_type.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_product_type.dart';

void main() {
  testWidgets('PaymentStatusScreen renders pending status correctly', (WidgetTester tester) async {
    final now = DateTime.now().toUtc();
    final mockPayment = PaymentModel(
      id: 'pay_pending',
      provider: PaymentProviderType.xendit,
      providerMode: PaymentProviderMode.sandbox,
      productType: PaymentProductType.jobBoost,
      relatedDomain: RelatedDomain.jobs,
      relatedId: 'job_456',
      buyerId: 'user_789',
      amount: 150000,
      currency: 'IDR',
      status: PaymentStatus.pending,
      providerInvoiceUrl: 'https://checkout.xendit.co/v2/inv_123',
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          paymentDetailProvider('pay_pending').overrideWith((ref) => Stream.value(mockPayment)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PaymentStatusScreen(paymentId: 'pay_pending'),
          ),
        ),
      ),
    );

    // Initial pump for the stream
    await tester.pump();
    
    // Check if it's loading initially or already has data
    if (find.byType(CircularProgressIndicator).evaluate().isNotEmpty) {
      await tester.pump(Duration.zero);
    }
    
    await tester.pumpAndSettle();
    
    expect(find.byIcon(Icons.pending_outlined), findsOneWidget);
    // We expect the key since translations aren't loaded in this simple setup
    expect(find.text('payment.openInvoice'), findsOneWidget);
  });

  testWidgets('PaymentStatusScreen renders paid status correctly', (WidgetTester tester) async {
    final now = DateTime.now().toUtc();
    final mockPayment = PaymentModel(
      id: 'pay_paid',
      provider: PaymentProviderType.midtrans,
      providerMode: PaymentProviderMode.production,
      productType: PaymentProductType.marketplaceDeal,
      relatedDomain: RelatedDomain.marketplace,
      relatedId: 'prod_001',
      buyerId: 'user_abc',
      amount: 50000,
      currency: 'IDR',
      status: PaymentStatus.paid,
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          paymentDetailProvider('pay_paid').overrideWith((ref) => Stream.value(mockPayment)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PaymentStatusScreen(paymentId: 'pay_paid'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();
    
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.text('payment.openInvoice'), findsNothing);
  });
}
