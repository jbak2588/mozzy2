import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/feedback_model.dart';
import '../providers/feedback_providers.dart';
import '../widgets/feedback_type_selector.dart';
import '../services/cs_channel_service.dart';

class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  FeedbackType _selectedType = FeedbackType.bug;
  final _messageController = TextEditingController();
  final _contactValueController = TextEditingController();
  FeedbackContactPreference _contactPreference = FeedbackContactPreference.none;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _messageController.dispose();
    _contactValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasWhatsapp = CsChannelConfig.whatsappNumber.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text('feedback.title'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'feedback.subtitle'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            FeedbackTypeSelector(
              selectedType: _selectedType,
              onTypeChanged: (type) => setState(() => _selectedType = type),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'feedback.messageLabel'.tr(),
                hintText: 'feedback.messageHint'.tr(),
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              maxLength: 1000,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'feedback.privacyNotice'.tr(),
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'feedback.contactPreference'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<FeedbackContactPreference>(
              value: _contactPreference,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: FeedbackContactPreference.values.map((pref) {
                return DropdownMenuItem(
                  value: pref,
                  child: Text(_getContactPrefLabel(pref)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _contactPreference = val);
                }
              },
            ),
            if (_contactPreference != FeedbackContactPreference.none) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _contactValueController,
                decoration: InputDecoration(
                  labelText: 'feedback.contactValue'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('feedback.submit'.tr()),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: hasWhatsapp ? _openWhatsapp : null,
              icon: const Icon(Icons.chat),
              label: Text(hasWhatsapp 
                  ? 'feedback.openWhatsapp'.tr() 
                  : 'feedback.csNotConfigured'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  String _getContactPrefLabel(FeedbackContactPreference pref) {
    switch (pref) {
      case FeedbackContactPreference.none:
        return 'feedback.contactNone'.tr();
      case FeedbackContactPreference.whatsapp:
        return 'feedback.contactWhatsapp'.tr();
      case FeedbackContactPreference.email:
        return 'feedback.contactEmail'.tr();
    }
  }

  Future<void> _openWhatsapp() async {
    try {
      await CsChannelService.openWhatsApp();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _submit() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('feedback.messageHint'.tr())),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await ref.read(feedbackServiceProvider).submitFeedback(
        type: _selectedType,
        message: message,
        contactPreference: _contactPreference,
        contactValue: _contactValueController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('feedback.submitted'.tr())),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('feedback.failed'.tr())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
