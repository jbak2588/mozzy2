import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import '../providers/payment_provider.dart';
import '../models/payment_status.dart';
import '../../../core/utils/formatters.dart';

class PaymentStatusScreen extends ConsumerWidget {
  final String paymentId;

  const PaymentStatusScreen({super.key, required this.paymentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentAsync = ref.watch(paymentDetailProvider(paymentId));

    return Scaffold(
      appBar: AppBar(
        title: Text('payment.status'.tr()),
      ),
      body: paymentAsync.when(
        data: (payment) {
          if (payment == null) {
            return Center(child: Text('common.error'.tr()));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                _buildStatusIcon(payment.status),
                const SizedBox(height: 24),
                Text(
                  'payment.${payment.status.name}'.tr(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _buildDetailRow('payment.amount'.tr(), MozzyFormatters.formatIDR(payment.amount)),
                _buildDetailRow('payment.provider'.tr(), payment.provider.name.toUpperCase()),
                _buildDetailRow('common.id'.tr(), payment.id),
                const SizedBox(height: 48),
                if (payment.status == PaymentStatus.pending && payment.providerInvoiceUrl != null)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _launchURL(payment.providerInvoiceUrl!),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('payment.openInvoice'.tr()),
                    ),
                  ),
                const SizedBox(height: 16),
                if (payment.status == PaymentStatus.paid && payment.productType.name == 'jobBoost')
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.push('/jobs/${payment.relatedId}'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('monetization.viewBoostedJob'.tr()),
                      ),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => ref.invalidate(paymentDetailProvider(paymentId)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('payment.checkStatus'.tr()),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('common.error'.tr())),
      ),
    );
  }

  Widget _buildStatusIcon(PaymentStatus status) {
    IconData iconData;
    Color color;

    switch (status) {
      case PaymentStatus.paid:
        iconData = Icons.check_circle_outline;
        color = Colors.green;
        break;
      case PaymentStatus.failed:
      case PaymentStatus.cancelled:
        iconData = Icons.error_outline;
        color = Colors.red;
        break;
      case PaymentStatus.expired:
        iconData = Icons.history;
        color = Colors.orange;
        break;
      default:
        iconData = Icons.pending_outlined;
        color = Colors.blue;
    }

    return Icon(iconData, size: 80, color: color);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
