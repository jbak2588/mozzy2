import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/feedback_model.dart';

class FeedbackTypeSelector extends StatelessWidget {
  final FeedbackType selectedType;
  final ValueChanged<FeedbackType> onTypeChanged;

  const FeedbackTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'feedback.selectType'.tr(), // Add this key if missing
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: FeedbackType.values.map((type) {
            final isSelected = selectedType == type;
            return ChoiceChip(
              label: Text('feedback.type.${type.name}'.tr()),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onTypeChanged(type);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
