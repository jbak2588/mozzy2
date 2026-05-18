import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/payment_request.dart';
import '../models/payment_result.dart';
import '../models/payment_status.dart';
import '../payment_provider.dart';

class XenditPaymentSheet extends ConsumerStatefulWidget {
  final PaymentRequest request;

  const XenditPaymentSheet({
    super.key,
    required this.request,
  });

  static Future<PaymentResult?> show(BuildContext context, PaymentRequest request) {
    return showModalBottomSheet<PaymentResult>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => XenditPaymentSheet(request: request),
    );
  }

  @override
  ConsumerState<XenditPaymentSheet> createState() => _XenditPaymentSheetState();
}

class _XenditPaymentSheetState extends ConsumerState<XenditPaymentSheet> {
  bool _isLoading = false;
  PaymentResult? _result;
  String? _error;

  Future<void> _initiatePayment() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final repository = ref.read(paymentRepositoryProvider);
      final result = await repository.requestPayment(widget.request);
      setState(() {
        _result = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'payment.method'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildSummary(),
          const SizedBox(height: 24),
          if (_error != null)
            _buildError()
          else if (_result == null)
            _buildPaymentOptions()
          else
            _buildPaymentStatus(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(widget.request.description),
          const SizedBox(height: 8),
          Text(
            'Rp ${widget.request.amountIdr.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.qr_code_scanner),
          title: Text('payment.qris'.tr()),
          onTap: _initiatePayment,
          enabled: !_isLoading,
        ),
        ListTile(
          leading: const Icon(Icons.account_balance),
          title: Text('payment.virtualAccount'.tr()),
          onTap: _initiatePayment,
          enabled: !_isLoading,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isLoading ? null : _initiatePayment,
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('payment.continue'.tr()),
        ),
      ],
    );
  }

  Widget _buildPaymentStatus() {
    final status = _result?.status ?? MozzyPaymentStatus.pending;
    return Column(
      children: [
        Icon(
          status == MozzyPaymentStatus.paid ? Icons.check_circle : Icons.pending,
          size: 64,
          color: status == MozzyPaymentStatus.paid ? Colors.green : Colors.orange,
        ),
        const SizedBox(height: 16),
        Text(
          status == MozzyPaymentStatus.paid ? 'payment.success'.tr() : 'payment.pending'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 24),
        if (_result?.invoiceUrl != null)
          ElevatedButton(
            onPressed: () {
              // Open URL logic would go here
            },
            child: const Text('Open Invoice'),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context, _result),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildError() {
    return Column(
      children: [
        const Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 16),
        Text('payment.failed'.tr()),
        const SizedBox(height: 8),
        Text(_error!, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _initiatePayment,
          child: Text('payment.retry'.tr()),
        ),
      ],
    );
  }
}
