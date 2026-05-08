// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentModel _$PaymentModelFromJson(
  Map<String, dynamic> json,
) => _PaymentModel(
  id: json['id'] as String,
  provider: $enumDecode(_$PaymentProviderTypeEnumMap, json['provider']),
  providerMode: $enumDecode(_$PaymentProviderModeEnumMap, json['providerMode']),
  productType: $enumDecode(_$PaymentProductTypeEnumMap, json['productType']),
  relatedDomain: $enumDecode(_$RelatedDomainEnumMap, json['relatedDomain']),
  relatedId: json['relatedId'] as String,
  buyerId: json['buyerId'] as String,
  sellerId: json['sellerId'] as String?,
  ownerId: json['ownerId'] as String?,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String? ?? 'IDR',
  status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
  providerInvoiceId: json['providerInvoiceId'] as String?,
  providerInvoiceUrl: json['providerInvoiceUrl'] as String?,
  externalId: json['externalId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const SafeDateTimeConverter().fromJson(json['updatedAt']),
  paidAt: const OptionalSafeDateTimeConverter().fromJson(json['paidAt']),
  expiredAt: const OptionalSafeDateTimeConverter().fromJson(json['expiredAt']),
  webhookLastReceivedAt: const OptionalSafeDateTimeConverter().fromJson(
    json['webhookLastReceivedAt'],
  ),
  rawProviderStatus: json['rawProviderStatus'] as String?,
);

Map<String, dynamic> _$PaymentModelToJson(
  _PaymentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'provider': _$PaymentProviderTypeEnumMap[instance.provider]!,
  'providerMode': _$PaymentProviderModeEnumMap[instance.providerMode]!,
  'productType': _$PaymentProductTypeEnumMap[instance.productType]!,
  'relatedDomain': _$RelatedDomainEnumMap[instance.relatedDomain]!,
  'relatedId': instance.relatedId,
  'buyerId': instance.buyerId,
  'sellerId': instance.sellerId,
  'ownerId': instance.ownerId,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': _$PaymentStatusEnumMap[instance.status]!,
  'providerInvoiceId': instance.providerInvoiceId,
  'providerInvoiceUrl': instance.providerInvoiceUrl,
  'externalId': instance.externalId,
  'metadata': instance.metadata,
  'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const SafeDateTimeConverter().toJson(instance.updatedAt),
  'paidAt': const OptionalSafeDateTimeConverter().toJson(instance.paidAt),
  'expiredAt': const OptionalSafeDateTimeConverter().toJson(instance.expiredAt),
  'webhookLastReceivedAt': const OptionalSafeDateTimeConverter().toJson(
    instance.webhookLastReceivedAt,
  ),
  'rawProviderStatus': instance.rawProviderStatus,
};

const _$PaymentProviderTypeEnumMap = {
  PaymentProviderType.xendit: 'xendit',
  PaymentProviderType.midtrans: 'midtrans',
  PaymentProviderType.manual: 'manual',
};

const _$PaymentProviderModeEnumMap = {
  PaymentProviderMode.sandbox: 'sandbox',
  PaymentProviderMode.production: 'production',
};

const _$PaymentProductTypeEnumMap = {
  PaymentProductType.marketplaceDeal: 'marketplaceDeal',
  PaymentProductType.jobBoost: 'jobBoost',
  PaymentProductType.storeSubscription: 'storeSubscription',
  PaymentProductType.adCampaign: 'adCampaign',
};

const _$RelatedDomainEnumMap = {
  RelatedDomain.marketplace: 'marketplace',
  RelatedDomain.jobs: 'jobs',
  RelatedDomain.stores: 'stores',
  RelatedDomain.ads: 'ads',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.created: 'created',
  PaymentStatus.pending: 'pending',
  PaymentStatus.paid: 'paid',
  PaymentStatus.failed: 'failed',
  PaymentStatus.expired: 'expired',
  PaymentStatus.cancelled: 'cancelled',
  PaymentStatus.refunded: 'refunded',
};
