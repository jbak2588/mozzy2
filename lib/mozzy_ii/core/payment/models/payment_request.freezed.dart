// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentRequest {

 PaymentPurpose get purpose; String get userId; int get amountIdr; String get description; String? get sourceType; String? get sourceId; MozzyPaymentMethod get method; Map<String, dynamic> get metadata;
/// Create a copy of PaymentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentRequestCopyWith<PaymentRequest> get copyWith => _$PaymentRequestCopyWithImpl<PaymentRequest>(this as PaymentRequest, _$identity);

  /// Serializes this PaymentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentRequest&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amountIdr, amountIdr) || other.amountIdr == amountIdr)&&(identical(other.description, description) || other.description == description)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purpose,userId,amountIdr,description,sourceType,sourceId,method,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PaymentRequest(purpose: $purpose, userId: $userId, amountIdr: $amountIdr, description: $description, sourceType: $sourceType, sourceId: $sourceId, method: $method, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PaymentRequestCopyWith<$Res>  {
  factory $PaymentRequestCopyWith(PaymentRequest value, $Res Function(PaymentRequest) _then) = _$PaymentRequestCopyWithImpl;
@useResult
$Res call({
 PaymentPurpose purpose, String userId, int amountIdr, String description, String? sourceType, String? sourceId, MozzyPaymentMethod method, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$PaymentRequestCopyWithImpl<$Res>
    implements $PaymentRequestCopyWith<$Res> {
  _$PaymentRequestCopyWithImpl(this._self, this._then);

  final PaymentRequest _self;
  final $Res Function(PaymentRequest) _then;

/// Create a copy of PaymentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? purpose = null,Object? userId = null,Object? amountIdr = null,Object? description = null,Object? sourceType = freezed,Object? sourceId = freezed,Object? method = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as PaymentPurpose,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amountIdr: null == amountIdr ? _self.amountIdr : amountIdr // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sourceType: freezed == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String?,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as MozzyPaymentMethod,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentRequest].
extension PaymentRequestPatterns on PaymentRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentRequest value)  $default,){
final _that = this;
switch (_that) {
case _PaymentRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentPurpose purpose,  String userId,  int amountIdr,  String description,  String? sourceType,  String? sourceId,  MozzyPaymentMethod method,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentRequest() when $default != null:
return $default(_that.purpose,_that.userId,_that.amountIdr,_that.description,_that.sourceType,_that.sourceId,_that.method,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentPurpose purpose,  String userId,  int amountIdr,  String description,  String? sourceType,  String? sourceId,  MozzyPaymentMethod method,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _PaymentRequest():
return $default(_that.purpose,_that.userId,_that.amountIdr,_that.description,_that.sourceType,_that.sourceId,_that.method,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentPurpose purpose,  String userId,  int amountIdr,  String description,  String? sourceType,  String? sourceId,  MozzyPaymentMethod method,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _PaymentRequest() when $default != null:
return $default(_that.purpose,_that.userId,_that.amountIdr,_that.description,_that.sourceType,_that.sourceId,_that.method,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentRequest implements PaymentRequest {
  const _PaymentRequest({required this.purpose, required this.userId, required this.amountIdr, required this.description, this.sourceType, this.sourceId, this.method = MozzyPaymentMethod.qris, final  Map<String, dynamic> metadata = const <String, dynamic>{}}): _metadata = metadata;
  factory _PaymentRequest.fromJson(Map<String, dynamic> json) => _$PaymentRequestFromJson(json);

@override final  PaymentPurpose purpose;
@override final  String userId;
@override final  int amountIdr;
@override final  String description;
@override final  String? sourceType;
@override final  String? sourceId;
@override@JsonKey() final  MozzyPaymentMethod method;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of PaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentRequestCopyWith<_PaymentRequest> get copyWith => __$PaymentRequestCopyWithImpl<_PaymentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentRequest&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amountIdr, amountIdr) || other.amountIdr == amountIdr)&&(identical(other.description, description) || other.description == description)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,purpose,userId,amountIdr,description,sourceType,sourceId,method,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'PaymentRequest(purpose: $purpose, userId: $userId, amountIdr: $amountIdr, description: $description, sourceType: $sourceType, sourceId: $sourceId, method: $method, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PaymentRequestCopyWith<$Res> implements $PaymentRequestCopyWith<$Res> {
  factory _$PaymentRequestCopyWith(_PaymentRequest value, $Res Function(_PaymentRequest) _then) = __$PaymentRequestCopyWithImpl;
@override @useResult
$Res call({
 PaymentPurpose purpose, String userId, int amountIdr, String description, String? sourceType, String? sourceId, MozzyPaymentMethod method, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$PaymentRequestCopyWithImpl<$Res>
    implements _$PaymentRequestCopyWith<$Res> {
  __$PaymentRequestCopyWithImpl(this._self, this._then);

  final _PaymentRequest _self;
  final $Res Function(_PaymentRequest) _then;

/// Create a copy of PaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? purpose = null,Object? userId = null,Object? amountIdr = null,Object? description = null,Object? sourceType = freezed,Object? sourceId = freezed,Object? method = null,Object? metadata = null,}) {
  return _then(_PaymentRequest(
purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as PaymentPurpose,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amountIdr: null == amountIdr ? _self.amountIdr : amountIdr // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sourceType: freezed == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String?,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as MozzyPaymentMethod,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
