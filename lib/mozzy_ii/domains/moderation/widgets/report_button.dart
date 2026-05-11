import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/report_model.dart';
import 'report_reason_sheet.dart';

class ReportButton extends ConsumerWidget {
  final ReportTargetType targetType;
  final String targetId;
  final String? targetOwnerId;
  final Widget? icon;
  final bool isMenuItem;

  const ReportButton({
    super.key,
    required this.targetType,
    required this.targetId,
    this.targetOwnerId,
    this.icon,
    this.isMenuItem = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null || currentUserId == targetOwnerId) {
      return const SizedBox.shrink();
    }

    if (isMenuItem) {
      return PopupMenuItem(
        value: 'report',
        onTap: () => _showReportSheet(context),
        child: Row(
          children: [
            const Icon(Icons.flag, color: Colors.red),
            const SizedBox(width: 8),
            Text('moderation.report'.tr()),
          ],
        ),
      );
    }

    return IconButton(
      icon: icon ?? const Icon(Icons.flag_outlined),
      tooltip: 'moderation.report'.tr(),
      onPressed: () => _showReportSheet(context),
    );
  }

  void _showReportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ReportReasonSheet(
        targetType: targetType,
        targetId: targetId,
        targetOwnerId: targetOwnerId,
      ),
    );
  }
}
