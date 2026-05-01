// ============================================================================
// Mozzy DocHeader
// Module        : Trust Layer
// File          : lib/mozzy_ii/trust/widgets/trust_score_badge.dart
// Purpose       : 사용자의 신뢰 등급을 시각적으로 표시하는 배지 위젯입니다.
// ============================================================================

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mozzy/mozzy_ii/trust/models/trust_level.dart';

class TrustScoreBadge extends StatelessWidget {
  final double score;
  final bool showLabel;

  const TrustScoreBadge({
    super.key,
    required this.score,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final level = TrustLevel.fromScore(score);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: level.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: level.color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getIconForLevel(level), size: 14, color: level.color),
          if (showLabel) ...[
            const SizedBox(width: 4),
            Text(
              level.labelKey.tr(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: level.color,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getIconForLevel(TrustLevel level) {
    return switch (level) {
      TrustLevel.anggotaBaru => Icons.person_outline,
      TrustLevel.terpercaya => Icons.verified_user_outlined,
      TrustLevel.terverifikasi => Icons.verified,
      TrustLevel.heroLokal => Icons.stars,
    };
  }
}
