import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AuditTypeFilterBar extends StatelessWidget {
  final String? selectedType;
  final ValueChanged<String?> onTypeChanged;

  const AuditTypeFilterBar({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final types = [
      null, // All
      'payment_status_changed',
      'job_boost_activated',
      'job_boost_expired',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: types.map((type) {
          final label = type == null ? 'common.all'.tr() : 'admin.$type'.tr();
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label),
              selected: selectedType == type,
              onSelected: (selected) {
                if (selected) {
                  onTypeChanged(type);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
