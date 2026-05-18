import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/marketplace_provider.dart';
import '../services/marketplace_ai_verification_service.dart';
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
        // Start verification
        await _processAiVerification(context, product, result.paymentId);
      },
    );
  }

  Future<void> _processAiVerification(BuildContext context, ProductModel product, String paymentId) async {
    final repo = _ref.read(marketplaceRepositoryProvider);
    
    // Update status to processing
    await repo.updateProduct(product.copyWith(
      aiVerificationStatus: 'processing',
      aiVerificationPaidAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
    ));

    try {
      final MarketplaceAiVerificationService aiService = _ref.read(marketplaceAiVerificationServiceProvider);
      final result = await aiService.verifyProductImages(
        productId: product.id,
        title: product.title,
        description: product.description,
        category: product.category,
        imageUrls: product.imageUrls,
      );

      // Verify completion
      await repo.updateProduct(product.copyWith(
        isAiVerified: result.status == 'passed',
        aiVerificationStatus: result.status == 'passed' ? 'completed' : 'failed',
        aiVerificationScore: result.score,
        aiVerificationSummary: result.summary,
        aiDetectedIssues: result.detectedIssues,
        aiSuggestedCategory: result.suggestedCategory,
        aiConditionLabel: result.conditionLabel,
        aiVerifiedAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      ));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('marketplace.aiVerificationCompleted'.tr())),
        );
      }
    } catch (e) {
      await repo.updateProduct(product.copyWith(
        aiVerificationStatus: 'failed',
        aiVerificationError: e.toString(),
        updatedAt: DateTime.now().toUtc(),
      ));
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('marketplace.aiVerificationFailed'.tr())),
        );
      }
    }
  }
}
