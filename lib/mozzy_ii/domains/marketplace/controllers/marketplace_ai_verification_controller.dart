import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/marketplace_provider.dart';
import '../../../core/payment/models/payment_request.dart';
import '../../../core/payment/models/payment_purpose.dart';
import '../../../core/payment/widgets/xendit_payment_sheet.dart';
import '../payment/marketplace_payment_config.dart';
import 'package:easy_localization/easy_localization.dart';

final marketplaceAiVerificationControllerProvider = Provider((ref) {
  return MarketplaceAiVerificationController(ref);
});

class MarketplaceAiVerificationController {
  final Ref _ref;
  
  MarketplaceAiVerificationController(this._ref);

  Future<void> requestVerification(BuildContext context, ProductModel product, String userId) async {
    final request = PaymentRequest(
      purpose: PaymentPurpose.aiVerification,
      userId: userId,
      amountIdr: MarketplacePaymentConfig.aiVerificationPriceIdr,
      description: 'Marketplace AI Verification for ${product.title}',
      sourceType: 'product',
      sourceId: product.id,
      metadata: {
        'productId': product.id,
        'feature': 'marketplace',
        'countryCode': product.countryCode,
      },
    );

    await XenditPaymentSheet.show(
      context,
      request,
      onPaymentCreated: (result) async {
        // Record payment pending status
        final repo = _ref.read(marketplaceRepositoryProvider);
        await repo.updateProduct(product.copyWith(
          aiVerificationStatus: 'payment_pending',
          aiVerificationPaymentId: result.paymentId,
          aiVerificationRequestedAt: DateTime.now().toUtc(),
          updatedAt: DateTime.now().toUtc(),
        ));
      },
      onPaymentPaid: (result) async {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('marketplace.aiVerification.processing'.tr())),
          );
        }
      },
    );
  }
}
