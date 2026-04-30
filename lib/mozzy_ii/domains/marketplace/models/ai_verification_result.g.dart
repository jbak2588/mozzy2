// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_verification_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiVerificationResult _$AiVerificationResultFromJson(
  Map<String, dynamic> json,
) => _AiVerificationResult(
  id: json['id'] as String,
  productId: json['productId'] as String,
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
  rawResponse: json['rawResponse'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AiVerificationResultToJson(
  _AiVerificationResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'status': instance.status,
  'score': instance.score,
  'summary': instance.summary,
  'detectedIssues': instance.detectedIssues,
  'suggestedCategory': instance.suggestedCategory,
  'conditionLabel': instance.conditionLabel,
  'rawResponse': instance.rawResponse,
  'createdAt': instance.createdAt.toIso8601String(),
};
