// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monetization_audit_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MonetizationAuditLogModel {

 String get id; String get type;// payment_created, payment_status_changed, job_boost_activated, job_boost_expired
 String get relatedDomain;// payments, jobs
 String get relatedId; String? get paymentId; String? get jobId; String get actorType;// system, user, webhook, scheduler
 String? get actorId; String? get beforeStatus; String? get afterStatus; int? get amount; String? get currency; Map<String, dynamic> get metadata;@SafeDateTimeConverter() DateTime get createdAt;
/// Create a copy of MonetizationAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonetizationAuditLogModelCopyWith<MonetizationAuditLogModel> get copyWith => _$MonetizationAuditLogModelCopyWithImpl<MonetizationAuditLogModel>(this as MonetizationAuditLogModel, _$identity);

  /// Serializes this MonetizationAuditLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonetizationAuditLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.relatedDomain, relatedDomain) || other.relatedDomain == relatedDomain)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.actorType, actorType) || other.actorType == actorType)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.beforeStatus, beforeStatus) || other.beforeStatus == beforeStatus)&&(identical(other.afterStatus, afterStatus) || other.afterStatus == afterStatus)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,relatedDomain,relatedId,paymentId,jobId,actorType,actorId,beforeStatus,afterStatus,amount,currency,const DeepCollectionEquality().hash(metadata),createdAt);

@override
String toString() {
  return 'MonetizationAuditLogModel(id: $id, type: $type, relatedDomain: $relatedDomain, relatedId: $relatedId, paymentId: $paymentId, jobId: $jobId, actorType: $actorType, actorId: $actorId, beforeStatus: $beforeStatus, afterStatus: $afterStatus, amount: $amount, currency: $currency, metadata: $metadata, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MonetizationAuditLogModelCopyWith<$Res>  {
  factory $MonetizationAuditLogModelCopyWith(MonetizationAuditLogModel value, $Res Function(MonetizationAuditLogModel) _then) = _$MonetizationAuditLogModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String relatedDomain, String relatedId, String? paymentId, String? jobId, String actorType, String? actorId, String? beforeStatus, String? afterStatus, int? amount, String? currency, Map<String, dynamic> metadata,@SafeDateTimeConverter() DateTime createdAt
});




}
/// @nodoc
class _$MonetizationAuditLogModelCopyWithImpl<$Res>
    implements $MonetizationAuditLogModelCopyWith<$Res> {
  _$MonetizationAuditLogModelCopyWithImpl(this._self, this._then);

  final MonetizationAuditLogModel _self;
  final $Res Function(MonetizationAuditLogModel) _then;

/// Create a copy of MonetizationAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? relatedDomain = null,Object? relatedId = null,Object? paymentId = freezed,Object? jobId = freezed,Object? actorType = null,Object? actorId = freezed,Object? beforeStatus = freezed,Object? afterStatus = freezed,Object? amount = freezed,Object? currency = freezed,Object? metadata = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,relatedDomain: null == relatedDomain ? _self.relatedDomain : relatedDomain // ignore: cast_nullable_to_non_nullable
as String,relatedId: null == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,actorType: null == actorType ? _self.actorType : actorType // ignore: cast_nullable_to_non_nullable
as String,actorId: freezed == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String?,beforeStatus: freezed == beforeStatus ? _self.beforeStatus : beforeStatus // ignore: cast_nullable_to_non_nullable
as String?,afterStatus: freezed == afterStatus ? _self.afterStatus : afterStatus // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MonetizationAuditLogModel].
extension MonetizationAuditLogModelPatterns on MonetizationAuditLogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonetizationAuditLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonetizationAuditLogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonetizationAuditLogModel value)  $default,){
final _that = this;
switch (_that) {
case _MonetizationAuditLogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonetizationAuditLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _MonetizationAuditLogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String relatedDomain,  String relatedId,  String? paymentId,  String? jobId,  String actorType,  String? actorId,  String? beforeStatus,  String? afterStatus,  int? amount,  String? currency,  Map<String, dynamic> metadata, @SafeDateTimeConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonetizationAuditLogModel() when $default != null:
return $default(_that.id,_that.type,_that.relatedDomain,_that.relatedId,_that.paymentId,_that.jobId,_that.actorType,_that.actorId,_that.beforeStatus,_that.afterStatus,_that.amount,_that.currency,_that.metadata,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String relatedDomain,  String relatedId,  String? paymentId,  String? jobId,  String actorType,  String? actorId,  String? beforeStatus,  String? afterStatus,  int? amount,  String? currency,  Map<String, dynamic> metadata, @SafeDateTimeConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MonetizationAuditLogModel():
return $default(_that.id,_that.type,_that.relatedDomain,_that.relatedId,_that.paymentId,_that.jobId,_that.actorType,_that.actorId,_that.beforeStatus,_that.afterStatus,_that.amount,_that.currency,_that.metadata,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String relatedDomain,  String relatedId,  String? paymentId,  String? jobId,  String actorType,  String? actorId,  String? beforeStatus,  String? afterStatus,  int? amount,  String? currency,  Map<String, dynamic> metadata, @SafeDateTimeConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MonetizationAuditLogModel() when $default != null:
return $default(_that.id,_that.type,_that.relatedDomain,_that.relatedId,_that.paymentId,_that.jobId,_that.actorType,_that.actorId,_that.beforeStatus,_that.afterStatus,_that.amount,_that.currency,_that.metadata,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonetizationAuditLogModel implements MonetizationAuditLogModel {
  const _MonetizationAuditLogModel({required this.id, required this.type, required this.relatedDomain, required this.relatedId, this.paymentId, this.jobId, required this.actorType, this.actorId, this.beforeStatus, this.afterStatus, this.amount, this.currency, final  Map<String, dynamic> metadata = const {}, @SafeDateTimeConverter() required this.createdAt}): _metadata = metadata;
  factory _MonetizationAuditLogModel.fromJson(Map<String, dynamic> json) => _$MonetizationAuditLogModelFromJson(json);

@override final  String id;
@override final  String type;
// payment_created, payment_status_changed, job_boost_activated, job_boost_expired
@override final  String relatedDomain;
// payments, jobs
@override final  String relatedId;
@override final  String? paymentId;
@override final  String? jobId;
@override final  String actorType;
// system, user, webhook, scheduler
@override final  String? actorId;
@override final  String? beforeStatus;
@override final  String? afterStatus;
@override final  int? amount;
@override final  String? currency;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override@SafeDateTimeConverter() final  DateTime createdAt;

/// Create a copy of MonetizationAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonetizationAuditLogModelCopyWith<_MonetizationAuditLogModel> get copyWith => __$MonetizationAuditLogModelCopyWithImpl<_MonetizationAuditLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonetizationAuditLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonetizationAuditLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.relatedDomain, relatedDomain) || other.relatedDomain == relatedDomain)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.actorType, actorType) || other.actorType == actorType)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.beforeStatus, beforeStatus) || other.beforeStatus == beforeStatus)&&(identical(other.afterStatus, afterStatus) || other.afterStatus == afterStatus)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,relatedDomain,relatedId,paymentId,jobId,actorType,actorId,beforeStatus,afterStatus,amount,currency,const DeepCollectionEquality().hash(_metadata),createdAt);

@override
String toString() {
  return 'MonetizationAuditLogModel(id: $id, type: $type, relatedDomain: $relatedDomain, relatedId: $relatedId, paymentId: $paymentId, jobId: $jobId, actorType: $actorType, actorId: $actorId, beforeStatus: $beforeStatus, afterStatus: $afterStatus, amount: $amount, currency: $currency, metadata: $metadata, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MonetizationAuditLogModelCopyWith<$Res> implements $MonetizationAuditLogModelCopyWith<$Res> {
  factory _$MonetizationAuditLogModelCopyWith(_MonetizationAuditLogModel value, $Res Function(_MonetizationAuditLogModel) _then) = __$MonetizationAuditLogModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String relatedDomain, String relatedId, String? paymentId, String? jobId, String actorType, String? actorId, String? beforeStatus, String? afterStatus, int? amount, String? currency, Map<String, dynamic> metadata,@SafeDateTimeConverter() DateTime createdAt
});




}
/// @nodoc
class __$MonetizationAuditLogModelCopyWithImpl<$Res>
    implements _$MonetizationAuditLogModelCopyWith<$Res> {
  __$MonetizationAuditLogModelCopyWithImpl(this._self, this._then);

  final _MonetizationAuditLogModel _self;
  final $Res Function(_MonetizationAuditLogModel) _then;

/// Create a copy of MonetizationAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? relatedDomain = null,Object? relatedId = null,Object? paymentId = freezed,Object? jobId = freezed,Object? actorType = null,Object? actorId = freezed,Object? beforeStatus = freezed,Object? afterStatus = freezed,Object? amount = freezed,Object? currency = freezed,Object? metadata = null,Object? createdAt = null,}) {
  return _then(_MonetizationAuditLogModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,relatedDomain: null == relatedDomain ? _self.relatedDomain : relatedDomain // ignore: cast_nullable_to_non_nullable
as String,relatedId: null == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,actorType: null == actorType ? _self.actorType : actorType // ignore: cast_nullable_to_non_nullable
as String,actorId: freezed == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String?,beforeStatus: freezed == beforeStatus ? _self.beforeStatus : beforeStatus // ignore: cast_nullable_to_non_nullable
as String?,afterStatus: freezed == afterStatus ? _self.afterStatus : afterStatus // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
