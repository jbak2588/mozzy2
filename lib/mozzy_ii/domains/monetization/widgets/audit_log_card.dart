import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/monetization_audit_log_model.dart';

class AuditLogCard extends StatelessWidget {
  final MonetizationAuditLogModel log;

  const AuditLogCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    log.displayTypeKey.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm').format(log.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildDetailRow(context, 'Domain', log.relatedDomain),
            _buildDetailRow(context, 'Related ID', log.relatedId),
            if (log.paymentId != null)
              _buildDetailRow(context, 'Payment ID', log.paymentId!),
            if (log.jobId != null)
              _buildDetailRow(context, 'Job ID', log.jobId!),
            if (log.beforeStatus != null || log.afterStatus != null)
              _buildDetailRow(
                context,
                'Status',
                'admin.beforeAfter'.tr(namedArgs: {
                  'before': log.beforeStatus ?? 'N/A',
                  'after': log.afterStatus ?? 'N/A',
                }),
              ),
            if (log.amount != null)
              _buildDetailRow(
                context,
                'Amount',
                '${log.currency ?? 'IDR'} ${log.amount}',
              ),
            const SizedBox(height: 8),
            Text(
              'Actor: ${log.actorType} (${log.actorId ?? 'N/A'})',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
