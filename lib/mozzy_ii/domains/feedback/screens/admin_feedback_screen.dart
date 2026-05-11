import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import '../models/feedback_model.dart';
import '../providers/feedback_providers.dart';
import '../../marketplace/screens/admin_guard_screen.dart';

class AdminFeedbackScreen extends ConsumerWidget {
  const AdminFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MarketplaceAdminGuardScreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text('feedback.adminTitle'.tr()),
        ),
        body: const _FeedbackList(),
      ),
    );
  }
}

class _FeedbackList extends ConsumerWidget {
  const _FeedbackList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackAsync = ref.watch(openFeedbackProvider);

    return feedbackAsync.when(
      data: (list) {
        if (list.isEmpty) {
          return const Center(child: Text('No open feedback.'));
        }
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _FeedbackCard(feedback: list[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}

class _FeedbackCard extends ConsumerWidget {
  final FeedbackModel feedback;

  const _FeedbackCard({required this.feedback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getTypeColor(feedback.type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    feedback.type.name.toUpperCase(),
                    style: TextStyle(
                      color: _getTypeColor(feedback.type),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(feedback.createdAt),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              feedback.message,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.devices, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${feedback.platform} | ${feedback.appVersion} (${feedback.appEnv})',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            if (feedback.contactPreference != FeedbackContactPreference.none)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.contact_mail, size: 14, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      '${feedback.contactPreference.name}: ${feedback.contactValue ?? "-"}',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _handleAction(context, ref, FeedbackStatus.dismissed),
                  child: Text('feedback.dismiss'.tr()),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => _handleAction(context, ref, FeedbackStatus.inReview),
                  child: Text('feedback.markInReview'.tr()),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _handleAction(context, ref, FeedbackStatus.resolved),
                  child: Text('feedback.markResolved'.tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(FeedbackType type) {
    switch (type) {
      case FeedbackType.bug:
        return Colors.red;
      case FeedbackType.suggestion:
        return Colors.green;
      case FeedbackType.payment:
        return Colors.orange;
      case FeedbackType.safety:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  Future<void> _handleAction(BuildContext context, WidgetRef ref, FeedbackStatus status) async {
    try {
      await ref.read(feedbackServiceProvider).updateFeedbackStatus(
        feedbackId: feedback.id,
        status: status,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated to ${status.name}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
