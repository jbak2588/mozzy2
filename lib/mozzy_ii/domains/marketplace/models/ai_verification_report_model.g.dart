// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_verification_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiVerificationReportModel _$AiVerificationReportModelFromJson(
  Map<String, dynamic> json,
) => _AiVerificationReportModel(
  id: json['id'] as String,
  productId: json['productId'] as String,
  sellerId: json['sellerId'] as String,
  status: json['status'] as String,
  score: (json['score'] as num?)?.toDouble() ?? 0.0,
  summary: json['summary'] as String? ?? '',
  detectedIssues:
      (json['detectedIssues'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  suggestedCategory: json['suggestedCategory'] as String?,
  conditionLabel: json['conditionLabel'] as String?,
  modelName: json['modelName'] as String? ?? 'gemini-3-flash-preview',
  promptVersion: json['promptVersion'] as String? ?? 'marketplace_ai_v1',
  rawResponseSummary: json['rawResponseSummary'] as String? ?? '',
  createdAt: DateTime.parse(json['createdAt'] as String),
  source: json['source'] as String? ?? 'create_product',
);

Map<String, dynamic> _$AiVerificationReportModelToJson(
  _AiVerificationReportModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'sellerId': instance.sellerId,
  'status': instance.status,
  'score': instance.score,
  'summary': instance.summary,
  'detectedIssues': instance.detectedIssues,
  'suggestedCategory': instance.suggestedCategory,
  'conditionLabel': instance.conditionLabel,
  'modelName': instance.modelName,
  'promptVersion': instance.promptVersion,
  'rawResponseSummary': instance.rawResponseSummary,
  'createdAt': instance.createdAt.toIso8601String(),
  'source': instance.source,
};
