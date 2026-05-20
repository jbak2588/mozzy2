import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_purpose.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_request.dart';
import 'package:mozzy/mozzy_ii/core/payment/widgets/xendit_payment_sheet.dart';
import 'package:mozzy/mozzy_ii/core/utils/formatters.dart';
import '../boost_payment_config.dart';

class UgcBoostBottomSheet extends ConsumerWidget {
  final String title;
  final PaymentPurpose purpose;
  final String sourceType;
  final String sourceId;
  final String userId;
  final String? countryCode;

  const UgcBoostBottomSheet({
    super.key,
    required this.title,
    required this.purpose,
    required this.sourceType,
    required this.sourceId,
    required this.userId,
    this.countryCode,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required PaymentPurpose purpose,
    required String sourceType,
    required String sourceId,
    required String userId,
    String? countryCode,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => UgcBoostBottomSheet(
        title: title,
        purpose: purpose,
        sourceType: sourceType,
        sourceId: sourceId,
        userId: userId,
        countryCode: countryCode,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pilih Paket Boost',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...BoostPaymentConfig.packages.map(
            (pkg) => _buildPackageCard(context, pkg),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, BoostPackage pkg) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handlePackageSelected(context, pkg),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pkg.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Naikkan posisi selama ${pkg.durationDays} hari',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              Text(
                MozzyFormatters.formatIDR(pkg.amountIdr),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePackageSelected(BuildContext context, BoostPackage pkg) {
    Navigator.of(context).pop(); // Close bottom sheet

    final request = PaymentRequest(
      purpose: purpose,
      userId: userId,
      amountIdr: pkg.amountIdr,
      description: 'Boost $title (${pkg.label})',
      sourceType: sourceType,
      sourceId: sourceId,
      metadata: {
        'packageId': pkg.packageId,
        'durationDays': pkg.durationDays,
        ...?countryCode == null ? null : {'countryCode': countryCode},
        'title': title,
      },
    );

    XenditPaymentSheet.show(context, request);
  }
}
