// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monetization_audit_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MonetizationAuditLogModel _$MonetizationAuditLogModelFromJson(
  Map<String, dynamic> json,
) => _MonetizationAuditLogModel(
  id: json['id'] as String,
  type: json['type'] as String,
  relatedDomain: json['relatedDomain'] as String,
  relatedId: json['relatedId'] as String,
  paymentId: json['paymentId'] as String?,
  jobId: json['jobId'] as String?,
  actorType: json['actorType'] as String,
  actorId: json['actorId'] as String?,
  beforeStatus: json['beforeStatus'] as String?,
  afterStatus: json['afterStatus'] as String?,
  amount: (json['amount'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$MonetizationAuditLogModelToJson(
  _MonetizationAuditLogModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'relatedDomain': instance.relatedDomain,
  'relatedId': instance.relatedId,
  'paymentId': instance.paymentId,
  'jobId': instance.jobId,
  'actorType': instance.actorType,
  'actorId': instance.actorId,
  'beforeStatus': instance.beforeStatus,
  'afterStatus': instance.afterStatus,
  'amount': instance.amount,
  'currency': instance.currency,
  'metadata': instance.metadata,
  'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
};
