// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/models/ai_verification_result.dart
// Purpose       : AI 검수 결과 데이터 모델.
// ============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_verification_result.freezed.dart';
part 'ai_verification_result.g.dart';

@freezed
abstract class AiVerificationResult with _$AiVerificationResult {
  const AiVerificationResult._();

  const factory AiVerificationResult({
    required String id,
    required String productId,
    required String status, // passed | failed | needs_review | pending | not_requested | error
    @Default(0.0) double score,
    @Default('') String summary,
    @Default([]) List<String> detectedIssues,
    String? suggestedCategory,
    String? conditionLabel,
    String? rawResponse,
    required DateTime createdAt,
  }) = _AiVerificationResult;

  factory AiVerificationResult.fromJson(Map<String, dynamic> json) =>
      _$AiVerificationResultFromJson(json);
}
