// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentModel {

 String get id; PaymentProviderType get provider; PaymentProviderMode get providerMode; PaymentProductType get productType; RelatedDomain get relatedDomain; String get relatedId; String get buyerId; String? get sellerId; String? get ownerId; int get amount; String get currency; PaymentStatus get status; String? get providerInvoiceId; String? get providerInvoiceUrl; String? get externalId; Map<String, dynamic> get metadata;@SafeDateTimeConverter() DateTime get createdAt;@SafeDateTimeConverter() DateTime get updatedAt;@OptionalSafeDateTimeConverter() DateTime? get paidAt;@OptionalSafeDateTimeConverter() DateTime? get expiredAt;@OptionalSafeDateTimeConverter() DateTime? get webhookLastReceivedAt; String? get rawProviderStatus;
/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentModelCopyWith<PaymentModel> get copyWith => _$PaymentModelCopyWithImpl<PaymentModel>(this as PaymentModel, _$identity);

  /// Serializes this PaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.providerMode, providerMode) || other.providerMode == providerMode)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.relatedDomain, relatedDomain) || other.relatedDomain == relatedDomain)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.providerInvoiceId, providerInvoiceId) || other.providerInvoiceId == providerInvoiceId)&&(identical(other.providerInvoiceUrl, providerInvoiceUrl) || other.providerInvoiceUrl == providerInvoiceUrl)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.webhookLastReceivedAt, webhookLastReceivedAt) || other.webhookLastReceivedAt == webhookLastReceivedAt)&&(identical(other.rawProviderStatus, rawProviderStatus) || other.rawProviderStatus == rawProviderStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,provider,providerMode,productType,relatedDomain,relatedId,buyerId,sellerId,ownerId,amount,currency,status,providerInvoiceId,providerInvoiceUrl,externalId,const DeepCollectionEquality().hash(metadata),createdAt,updatedAt,paidAt,expiredAt,webhookLastReceivedAt,rawProviderStatus]);

@override
String toString() {
  return 'PaymentModel(id: $id, provider: $provider, providerMode: $providerMode, productType: $productType, relatedDomain: $relatedDomain, relatedId: $relatedId, buyerId: $buyerId, sellerId: $sellerId, ownerId: $ownerId, amount: $amount, currency: $currency, status: $status, providerInvoiceId: $providerInvoiceId, providerInvoiceUrl: $providerInvoiceUrl, externalId: $externalId, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, paidAt: $paidAt, expiredAt: $expiredAt, webhookLastReceivedAt: $webhookLastReceivedAt, rawProviderStatus: $rawProviderStatus)';
}


}

/// @nodoc
abstract mixin class $PaymentModelCopyWith<$Res>  {
  factory $PaymentModelCopyWith(PaymentModel value, $Res Function(PaymentModel) _then) = _$PaymentModelCopyWithImpl;
@useResult
$Res call({
 String id, PaymentProviderType provider, PaymentProviderMode providerMode, PaymentProductType productType, RelatedDomain relatedDomain, String relatedId, String buyerId, String? sellerId, String? ownerId, int amount, String currency, PaymentStatus status, String? providerInvoiceId, String? providerInvoiceUrl, String? externalId, Map<String, dynamic> metadata,@SafeDateTimeConverter() DateTime createdAt,@SafeDateTimeConverter() DateTime updatedAt,@OptionalSafeDateTimeConverter() DateTime? paidAt,@OptionalSafeDateTimeConverter() DateTime? expiredAt,@OptionalSafeDateTimeConverter() DateTime? webhookLastReceivedAt, String? rawProviderStatus
});




}
/// @nodoc
class _$PaymentModelCopyWithImpl<$Res>
    implements $PaymentModelCopyWith<$Res> {
  _$PaymentModelCopyWithImpl(this._self, this._then);

  final PaymentModel _self;
  final $Res Function(PaymentModel) _then;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? provider = null,Object? providerMode = null,Object? productType = null,Object? relatedDomain = null,Object? relatedId = null,Object? buyerId = null,Object? sellerId = freezed,Object? ownerId = freezed,Object? amount = null,Object? currency = null,Object? status = null,Object? providerInvoiceId = freezed,Object? providerInvoiceUrl = freezed,Object? externalId = freezed,Object? metadata = null,Object? createdAt = null,Object? updatedAt = null,Object? paidAt = freezed,Object? expiredAt = freezed,Object? webhookLastReceivedAt = freezed,Object? rawProviderStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as PaymentProviderType,providerMode: null == providerMode ? _self.providerMode : providerMode // ignore: cast_nullable_to_non_nullable
as PaymentProviderMode,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as PaymentProductType,relatedDomain: null == relatedDomain ? _self.relatedDomain : relatedDomain // ignore: cast_nullable_to_non_nullable
as RelatedDomain,relatedId: null == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: freezed == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,providerInvoiceId: freezed == providerInvoiceId ? _self.providerInvoiceId : providerInvoiceId // ignore: cast_nullable_to_non_nullable
as String?,providerInvoiceUrl: freezed == providerInvoiceUrl ? _self.providerInvoiceUrl : providerInvoiceUrl // ignore: cast_nullable_to_non_nullable
as String?,externalId: freezed == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,webhookLastReceivedAt: freezed == webhookLastReceivedAt ? _self.webhookLastReceivedAt : webhookLastReceivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rawProviderStatus: freezed == rawProviderStatus ? _self.rawProviderStatus : rawProviderStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentModel].
extension PaymentModelPatterns on PaymentModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PaymentProviderType provider,  PaymentProviderMode providerMode,  PaymentProductType productType,  RelatedDomain relatedDomain,  String relatedId,  String buyerId,  String? sellerId,  String? ownerId,  int amount,  String currency,  PaymentStatus status,  String? providerInvoiceId,  String? providerInvoiceUrl,  String? externalId,  Map<String, dynamic> metadata, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt, @OptionalSafeDateTimeConverter()  DateTime? paidAt, @OptionalSafeDateTimeConverter()  DateTime? expiredAt, @OptionalSafeDateTimeConverter()  DateTime? webhookLastReceivedAt,  String? rawProviderStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
return $default(_that.id,_that.provider,_that.providerMode,_that.productType,_that.relatedDomain,_that.relatedId,_that.buyerId,_that.sellerId,_that.ownerId,_that.amount,_that.currency,_that.status,_that.providerInvoiceId,_that.providerInvoiceUrl,_that.externalId,_that.metadata,_that.createdAt,_that.updatedAt,_that.paidAt,_that.expiredAt,_that.webhookLastReceivedAt,_that.rawProviderStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PaymentProviderType provider,  PaymentProviderMode providerMode,  PaymentProductType productType,  RelatedDomain relatedDomain,  String relatedId,  String buyerId,  String? sellerId,  String? ownerId,  int amount,  String currency,  PaymentStatus status,  String? providerInvoiceId,  String? providerInvoiceUrl,  String? externalId,  Map<String, dynamic> metadata, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt, @OptionalSafeDateTimeConverter()  DateTime? paidAt, @OptionalSafeDateTimeConverter()  DateTime? expiredAt, @OptionalSafeDateTimeConverter()  DateTime? webhookLastReceivedAt,  String? rawProviderStatus)  $default,) {final _that = this;
switch (_that) {
case _PaymentModel():
return $default(_that.id,_that.provider,_that.providerMode,_that.productType,_that.relatedDomain,_that.relatedId,_that.buyerId,_that.sellerId,_that.ownerId,_that.amount,_that.currency,_that.status,_that.providerInvoiceId,_that.providerInvoiceUrl,_that.externalId,_that.metadata,_that.createdAt,_that.updatedAt,_that.paidAt,_that.expiredAt,_that.webhookLastReceivedAt,_that.rawProviderStatus);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PaymentProviderType provider,  PaymentProviderMode providerMode,  PaymentProductType productType,  RelatedDomain relatedDomain,  String relatedId,  String buyerId,  String? sellerId,  String? ownerId,  int amount,  String currency,  PaymentStatus status,  String? providerInvoiceId,  String? providerInvoiceUrl,  String? externalId,  Map<String, dynamic> metadata, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt, @OptionalSafeDateTimeConverter()  DateTime? paidAt, @OptionalSafeDateTimeConverter()  DateTime? expiredAt, @OptionalSafeDateTimeConverter()  DateTime? webhookLastReceivedAt,  String? rawProviderStatus)?  $default,) {final _that = this;
switch (_that) {
case _PaymentModel() when $default != null:
return $default(_that.id,_that.provider,_that.providerMode,_that.productType,_that.relatedDomain,_that.relatedId,_that.buyerId,_that.sellerId,_that.ownerId,_that.amount,_that.currency,_that.status,_that.providerInvoiceId,_that.providerInvoiceUrl,_that.externalId,_that.metadata,_that.createdAt,_that.updatedAt,_that.paidAt,_that.expiredAt,_that.webhookLastReceivedAt,_that.rawProviderStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentModel extends PaymentModel {
  const _PaymentModel({required this.id, required this.provider, required this.providerMode, required this.productType, required this.relatedDomain, required this.relatedId, required this.buyerId, this.sellerId, this.ownerId, required this.amount, this.currency = 'IDR', required this.status, this.providerInvoiceId, this.providerInvoiceUrl, this.externalId, final  Map<String, dynamic> metadata = const {}, @SafeDateTimeConverter() required this.createdAt, @SafeDateTimeConverter() required this.updatedAt, @OptionalSafeDateTimeConverter() this.paidAt, @OptionalSafeDateTimeConverter() this.expiredAt, @OptionalSafeDateTimeConverter() this.webhookLastReceivedAt, this.rawProviderStatus}): _metadata = metadata,super._();
  factory _PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);

@override final  String id;
@override final  PaymentProviderType provider;
@override final  PaymentProviderMode providerMode;
@override final  PaymentProductType productType;
@override final  RelatedDomain relatedDomain;
@override final  String relatedId;
@override final  String buyerId;
@override final  String? sellerId;
@override final  String? ownerId;
@override final  int amount;
@override@JsonKey() final  String currency;
@override final  PaymentStatus status;
@override final  String? providerInvoiceId;
@override final  String? providerInvoiceUrl;
@override final  String? externalId;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override@SafeDateTimeConverter() final  DateTime createdAt;
@override@SafeDateTimeConverter() final  DateTime updatedAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? paidAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? expiredAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? webhookLastReceivedAt;
@override final  String? rawProviderStatus;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentModelCopyWith<_PaymentModel> get copyWith => __$PaymentModelCopyWithImpl<_PaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.providerMode, providerMode) || other.providerMode == providerMode)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.relatedDomain, relatedDomain) || other.relatedDomain == relatedDomain)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.providerInvoiceId, providerInvoiceId) || other.providerInvoiceId == providerInvoiceId)&&(identical(other.providerInvoiceUrl, providerInvoiceUrl) || other.providerInvoiceUrl == providerInvoiceUrl)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.webhookLastReceivedAt, webhookLastReceivedAt) || other.webhookLastReceivedAt == webhookLastReceivedAt)&&(identical(other.rawProviderStatus, rawProviderStatus) || other.rawProviderStatus == rawProviderStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,provider,providerMode,productType,relatedDomain,relatedId,buyerId,sellerId,ownerId,amount,currency,status,providerInvoiceId,providerInvoiceUrl,externalId,const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt,paidAt,expiredAt,webhookLastReceivedAt,rawProviderStatus]);

@override
String toString() {
  return 'PaymentModel(id: $id, provider: $provider, providerMode: $providerMode, productType: $productType, relatedDomain: $relatedDomain, relatedId: $relatedId, buyerId: $buyerId, sellerId: $sellerId, ownerId: $ownerId, amount: $amount, currency: $currency, status: $status, providerInvoiceId: $providerInvoiceId, providerInvoiceUrl: $providerInvoiceUrl, externalId: $externalId, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, paidAt: $paidAt, expiredAt: $expiredAt, webhookLastReceivedAt: $webhookLastReceivedAt, rawProviderStatus: $rawProviderStatus)';
}


}

/// @nodoc
abstract mixin class _$PaymentModelCopyWith<$Res> implements $PaymentModelCopyWith<$Res> {
  factory _$PaymentModelCopyWith(_PaymentModel value, $Res Function(_PaymentModel) _then) = __$PaymentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, PaymentProviderType provider, PaymentProviderMode providerMode, PaymentProductType productType, RelatedDomain relatedDomain, String relatedId, String buyerId, String? sellerId, String? ownerId, int amount, String currency, PaymentStatus status, String? providerInvoiceId, String? providerInvoiceUrl, String? externalId, Map<String, dynamic> metadata,@SafeDateTimeConverter() DateTime createdAt,@SafeDateTimeConverter() DateTime updatedAt,@OptionalSafeDateTimeConverter() DateTime? paidAt,@OptionalSafeDateTimeConverter() DateTime? expiredAt,@OptionalSafeDateTimeConverter() DateTime? webhookLastReceivedAt, String? rawProviderStatus
});




}
/// @nodoc
class __$PaymentModelCopyWithImpl<$Res>
    implements _$PaymentModelCopyWith<$Res> {
  __$PaymentModelCopyWithImpl(this._self, this._then);

  final _PaymentModel _self;
  final $Res Function(_PaymentModel) _then;

/// Create a copy of PaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? provider = null,Object? providerMode = null,Object? productType = null,Object? relatedDomain = null,Object? relatedId = null,Object? buyerId = null,Object? sellerId = freezed,Object? ownerId = freezed,Object? amount = null,Object? currency = null,Object? status = null,Object? providerInvoiceId = freezed,Object? providerInvoiceUrl = freezed,Object? externalId = freezed,Object? metadata = null,Object? createdAt = null,Object? updatedAt = null,Object? paidAt = freezed,Object? expiredAt = freezed,Object? webhookLastReceivedAt = freezed,Object? rawProviderStatus = freezed,}) {
  return _then(_PaymentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as PaymentProviderType,providerMode: null == providerMode ? _self.providerMode : providerMode // ignore: cast_nullable_to_non_nullable
as PaymentProviderMode,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as PaymentProductType,relatedDomain: null == relatedDomain ? _self.relatedDomain : relatedDomain // ignore: cast_nullable_to_non_nullable
as RelatedDomain,relatedId: null == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: freezed == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,providerInvoiceId: freezed == providerInvoiceId ? _self.providerInvoiceId : providerInvoiceId // ignore: cast_nullable_to_non_nullable
as String?,providerInvoiceUrl: freezed == providerInvoiceUrl ? _self.providerInvoiceUrl : providerInvoiceUrl // ignore: cast_nullable_to_non_nullable
as String?,externalId: freezed == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,webhookLastReceivedAt: freezed == webhookLastReceivedAt ? _self.webhookLastReceivedAt : webhookLastReceivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rawProviderStatus: freezed == rawProviderStatus ? _self.rawProviderStatus : rawProviderStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
