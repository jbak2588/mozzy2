import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/product_model.dart';

class ProductVerificationBadge extends StatelessWidget {
  const ProductVerificationBadge({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final status = product.aiVerificationStatus;

    if (product.isAiVerified && status == 'passed') {
      return _Badge(
        icon: Icons.auto_awesome,
        label: 'marketplace.aiVerified'.tr(),
        color: Colors.red,
        background: Colors.red.shade50,
      );
    }

    if (status == 'needs_review') {
      return _Badge(
        icon: Icons.rate_review_outlined,
        label: 'marketplace.aiNeedsReview'.tr(),
        color: Colors.orange,
        background: Colors.orange.shade50,
      );
    }

    if (status == 'failed') {
      return _Badge(
        icon: Icons.error_outline,
        label: 'marketplace.aiRejected'.tr(),
        color: Colors.red,
        background: Colors.red.shade50,
      );
    }

    return const SizedBox.shrink();
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
