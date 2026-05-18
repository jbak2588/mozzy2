// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentResult {

 String get paymentId; String get externalId; MozzyPaymentStatus get status; int get amountIdr; String? get invoiceUrl; String? get qrString; DateTime? get expiresAt; Map<String, dynamic> get raw;
/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentResultCopyWith<PaymentResult> get copyWith => _$PaymentResultCopyWithImpl<PaymentResult>(this as PaymentResult, _$identity);

  /// Serializes this PaymentResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentResult&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amountIdr, amountIdr) || other.amountIdr == amountIdr)&&(identical(other.invoiceUrl, invoiceUrl) || other.invoiceUrl == invoiceUrl)&&(identical(other.qrString, qrString) || other.qrString == qrString)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other.raw, raw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,externalId,status,amountIdr,invoiceUrl,qrString,expiresAt,const DeepCollectionEquality().hash(raw));

@override
String toString() {
  return 'PaymentResult(paymentId: $paymentId, externalId: $externalId, status: $status, amountIdr: $amountIdr, invoiceUrl: $invoiceUrl, qrString: $qrString, expiresAt: $expiresAt, raw: $raw)';
}


}

/// @nodoc
abstract mixin class $PaymentResultCopyWith<$Res>  {
  factory $PaymentResultCopyWith(PaymentResult value, $Res Function(PaymentResult) _then) = _$PaymentResultCopyWithImpl;
@useResult
$Res call({
 String paymentId, String externalId, MozzyPaymentStatus status, int amountIdr, String? invoiceUrl, String? qrString, DateTime? expiresAt, Map<String, dynamic> raw
});




}
/// @nodoc
class _$PaymentResultCopyWithImpl<$Res>
    implements $PaymentResultCopyWith<$Res> {
  _$PaymentResultCopyWithImpl(this._self, this._then);

  final PaymentResult _self;
  final $Res Function(PaymentResult) _then;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? externalId = null,Object? status = null,Object? amountIdr = null,Object? invoiceUrl = freezed,Object? qrString = freezed,Object? expiresAt = freezed,Object? raw = null,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,externalId: null == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MozzyPaymentStatus,amountIdr: null == amountIdr ? _self.amountIdr : amountIdr // ignore: cast_nullable_to_non_nullable
as int,invoiceUrl: freezed == invoiceUrl ? _self.invoiceUrl : invoiceUrl // ignore: cast_nullable_to_non_nullable
as String?,qrString: freezed == qrString ? _self.qrString : qrString // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentResult].
extension PaymentResultPatterns on PaymentResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentResult value)  $default,){
final _that = this;
switch (_that) {
case _PaymentResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentResult value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  String externalId,  MozzyPaymentStatus status,  int amountIdr,  String? invoiceUrl,  String? qrString,  DateTime? expiresAt,  Map<String, dynamic> raw)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
return $default(_that.paymentId,_that.externalId,_that.status,_that.amountIdr,_that.invoiceUrl,_that.qrString,_that.expiresAt,_that.raw);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  String externalId,  MozzyPaymentStatus status,  int amountIdr,  String? invoiceUrl,  String? qrString,  DateTime? expiresAt,  Map<String, dynamic> raw)  $default,) {final _that = this;
switch (_that) {
case _PaymentResult():
return $default(_that.paymentId,_that.externalId,_that.status,_that.amountIdr,_that.invoiceUrl,_that.qrString,_that.expiresAt,_that.raw);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  String externalId,  MozzyPaymentStatus status,  int amountIdr,  String? invoiceUrl,  String? qrString,  DateTime? expiresAt,  Map<String, dynamic> raw)?  $default,) {final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
return $default(_that.paymentId,_that.externalId,_that.status,_that.amountIdr,_that.invoiceUrl,_that.qrString,_that.expiresAt,_that.raw);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentResult implements PaymentResult {
  const _PaymentResult({required this.paymentId, required this.externalId, this.status = MozzyPaymentStatus.pending, required this.amountIdr, this.invoiceUrl, this.qrString, this.expiresAt, final  Map<String, dynamic> raw = const <String, dynamic>{}}): _raw = raw;
  factory _PaymentResult.fromJson(Map<String, dynamic> json) => _$PaymentResultFromJson(json);

@override final  String paymentId;
@override final  String externalId;
@override@JsonKey() final  MozzyPaymentStatus status;
@override final  int amountIdr;
@override final  String? invoiceUrl;
@override final  String? qrString;
@override final  DateTime? expiresAt;
 final  Map<String, dynamic> _raw;
@override@JsonKey() Map<String, dynamic> get raw {
  if (_raw is EqualUnmodifiableMapView) return _raw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_raw);
}


/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentResultCopyWith<_PaymentResult> get copyWith => __$PaymentResultCopyWithImpl<_PaymentResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentResult&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amountIdr, amountIdr) || other.amountIdr == amountIdr)&&(identical(other.invoiceUrl, invoiceUrl) || other.invoiceUrl == invoiceUrl)&&(identical(other.qrString, qrString) || other.qrString == qrString)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other._raw, _raw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,externalId,status,amountIdr,invoiceUrl,qrString,expiresAt,const DeepCollectionEquality().hash(_raw));

@override
String toString() {
  return 'PaymentResult(paymentId: $paymentId, externalId: $externalId, status: $status, amountIdr: $amountIdr, invoiceUrl: $invoiceUrl, qrString: $qrString, expiresAt: $expiresAt, raw: $raw)';
}


}

/// @nodoc
abstract mixin class _$PaymentResultCopyWith<$Res> implements $PaymentResultCopyWith<$Res> {
  factory _$PaymentResultCopyWith(_PaymentResult value, $Res Function(_PaymentResult) _then) = __$PaymentResultCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, String externalId, MozzyPaymentStatus status, int amountIdr, String? invoiceUrl, String? qrString, DateTime? expiresAt, Map<String, dynamic> raw
});




}
/// @nodoc
class __$PaymentResultCopyWithImpl<$Res>
    implements _$PaymentResultCopyWith<$Res> {
  __$PaymentResultCopyWithImpl(this._self, this._then);

  final _PaymentResult _self;
  final $Res Function(_PaymentResult) _then;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? externalId = null,Object? status = null,Object? amountIdr = null,Object? invoiceUrl = freezed,Object? qrString = freezed,Object? expiresAt = freezed,Object? raw = null,}) {
  return _then(_PaymentResult(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,externalId: null == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MozzyPaymentStatus,amountIdr: null == amountIdr ? _self.amountIdr : amountIdr // ignore: cast_nullable_to_non_nullable
as int,invoiceUrl: freezed == invoiceUrl ? _self.invoiceUrl : invoiceUrl // ignore: cast_nullable_to_non_nullable
as String?,qrString: freezed == qrString ? _self.qrString : qrString // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,raw: null == raw ? _self._raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
