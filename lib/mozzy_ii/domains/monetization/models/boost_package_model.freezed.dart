// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'boost_package_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BoostPackageModel {

 String get id; String get productType;// jobBoost
 String get titleKey; String get descriptionKey; int get durationDays; int get amount; String get currency; bool get isActive;
/// Create a copy of BoostPackageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoostPackageModelCopyWith<BoostPackageModel> get copyWith => _$BoostPackageModelCopyWithImpl<BoostPackageModel>(this as BoostPackageModel, _$identity);

  /// Serializes this BoostPackageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoostPackageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productType,titleKey,descriptionKey,durationDays,amount,currency,isActive);

@override
String toString() {
  return 'BoostPackageModel(id: $id, productType: $productType, titleKey: $titleKey, descriptionKey: $descriptionKey, durationDays: $durationDays, amount: $amount, currency: $currency, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $BoostPackageModelCopyWith<$Res>  {
  factory $BoostPackageModelCopyWith(BoostPackageModel value, $Res Function(BoostPackageModel) _then) = _$BoostPackageModelCopyWithImpl;
@useResult
$Res call({
 String id, String productType, String titleKey, String descriptionKey, int durationDays, int amount, String currency, bool isActive
});




}
/// @nodoc
class _$BoostPackageModelCopyWithImpl<$Res>
    implements $BoostPackageModelCopyWith<$Res> {
  _$BoostPackageModelCopyWithImpl(this._self, this._then);

  final BoostPackageModel _self;
  final $Res Function(BoostPackageModel) _then;

/// Create a copy of BoostPackageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productType = null,Object? titleKey = null,Object? descriptionKey = null,Object? durationDays = null,Object? amount = null,Object? currency = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,descriptionKey: null == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BoostPackageModel].
extension BoostPackageModelPatterns on BoostPackageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoostPackageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoostPackageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoostPackageModel value)  $default,){
final _that = this;
switch (_that) {
case _BoostPackageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoostPackageModel value)?  $default,){
final _that = this;
switch (_that) {
case _BoostPackageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productType,  String titleKey,  String descriptionKey,  int durationDays,  int amount,  String currency,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoostPackageModel() when $default != null:
return $default(_that.id,_that.productType,_that.titleKey,_that.descriptionKey,_that.durationDays,_that.amount,_that.currency,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productType,  String titleKey,  String descriptionKey,  int durationDays,  int amount,  String currency,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _BoostPackageModel():
return $default(_that.id,_that.productType,_that.titleKey,_that.descriptionKey,_that.durationDays,_that.amount,_that.currency,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productType,  String titleKey,  String descriptionKey,  int durationDays,  int amount,  String currency,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _BoostPackageModel() when $default != null:
return $default(_that.id,_that.productType,_that.titleKey,_that.descriptionKey,_that.durationDays,_that.amount,_that.currency,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoostPackageModel implements BoostPackageModel {
  const _BoostPackageModel({required this.id, required this.productType, required this.titleKey, required this.descriptionKey, required this.durationDays, required this.amount, this.currency = 'IDR', this.isActive = true});
  factory _BoostPackageModel.fromJson(Map<String, dynamic> json) => _$BoostPackageModelFromJson(json);

@override final  String id;
@override final  String productType;
// jobBoost
@override final  String titleKey;
@override final  String descriptionKey;
@override final  int durationDays;
@override final  int amount;
@override@JsonKey() final  String currency;
@override@JsonKey() final  bool isActive;

/// Create a copy of BoostPackageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoostPackageModelCopyWith<_BoostPackageModel> get copyWith => __$BoostPackageModelCopyWithImpl<_BoostPackageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoostPackageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoostPackageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productType,titleKey,descriptionKey,durationDays,amount,currency,isActive);

@override
String toString() {
  return 'BoostPackageModel(id: $id, productType: $productType, titleKey: $titleKey, descriptionKey: $descriptionKey, durationDays: $durationDays, amount: $amount, currency: $currency, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$BoostPackageModelCopyWith<$Res> implements $BoostPackageModelCopyWith<$Res> {
  factory _$BoostPackageModelCopyWith(_BoostPackageModel value, $Res Function(_BoostPackageModel) _then) = __$BoostPackageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String productType, String titleKey, String descriptionKey, int durationDays, int amount, String currency, bool isActive
});




}
/// @nodoc
class __$BoostPackageModelCopyWithImpl<$Res>
    implements _$BoostPackageModelCopyWith<$Res> {
  __$BoostPackageModelCopyWithImpl(this._self, this._then);

  final _BoostPackageModel _self;
  final $Res Function(_BoostPackageModel) _then;

/// Create a copy of BoostPackageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productType = null,Object? titleKey = null,Object? descriptionKey = null,Object? durationDays = null,Object? amount = null,Object? currency = null,Object? isActive = null,}) {
  return _then(_BoostPackageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,descriptionKey: null == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
