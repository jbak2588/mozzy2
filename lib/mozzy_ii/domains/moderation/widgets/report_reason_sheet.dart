import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/report_model.dart';
import '../providers/moderation_providers.dart';

class ReportReasonSheet extends ConsumerStatefulWidget {
  final ReportTargetType targetType;
  final String targetId;
  final String? targetOwnerId;

  const ReportReasonSheet({
    super.key,
    required this.targetType,
    required this.targetId,
    this.targetOwnerId,
  });

  @override
  ConsumerState<ReportReasonSheet> createState() => _ReportReasonSheetState();
}

class _ReportReasonSheetState extends ConsumerState<ReportReasonSheet> {
  ReportReason? _selectedReason;
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'moderation.reportContent'.tr(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('moderation.selectReason'.tr(), style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: ReportReason.values.map((reason) {
                  return RadioListTile<ReportReason>(
                    title: Text('moderation.reason.${reason.name}'.tr()),
                    value: reason,
                    groupValue: _selectedReason,
                    onChanged: (val) => setState(() => _selectedReason = val),
                    contentPadding: EdgeInsets.zero,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'moderation.descriptionOptional'.tr(),
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              maxLength: 500,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSubmitting || _selectedReason == null ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('moderation.submitReport'.tr()),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);

    try {
      await ref.read(moderationServiceProvider).submitReport(
        targetType: widget.targetType,
        targetId: widget.targetId,
        targetOwnerId: widget.targetOwnerId,
        reason: _selectedReason!,
        description: _descriptionController.text.trim(),
        // Cannot easily get route from GoRouter here in a clean way without context, so skipping it
      );
      
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('moderation.reportSubmitted'.tr())),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('moderation.reportFailed'.tr())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
