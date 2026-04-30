// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/models/ai_verification_report_model.dart
// Purpose       : AI 검수 리포트 상세 데이터 모델.
// ============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_verification_report_model.freezed.dart';
part 'ai_verification_report_model.g.dart';

@freezed
abstract class AiVerificationReportModel with _$AiVerificationReportModel {
  const AiVerificationReportModel._();

  const factory AiVerificationReportModel({
    required String id,
    required String productId,
    required String sellerId,
    required String status, // passed | failed | needs_review | error
    @Default(0.0) double score,
    @Default('') String summary,
    @Default([]) List<String> detectedIssues,
    String? suggestedCategory,
    String? conditionLabel,
    @Default('gemini-3-flash-preview') String modelName,
    @Default('marketplace_ai_v1') String promptVersion,
    @Default('') String rawResponseSummary,
    required DateTime createdAt,
    @Default('create_product') String source,
  }) = _AiVerificationReportModel;

  factory AiVerificationReportModel.fromJson(Map<String, dynamic> json) =>
      _$AiVerificationReportModelFromJson(json);
}
