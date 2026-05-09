// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semantic_ranking_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SemanticRankingPayload {

 String get feedItemId; String get sourceId; String get type; String get title; String? get publicSummary; String? get category; String? get locationHint; bool get isPromoted; bool get isTrusted; String? get ageBucket; String? get languageCode;
/// Create a copy of SemanticRankingPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SemanticRankingPayloadCopyWith<SemanticRankingPayload> get copyWith => _$SemanticRankingPayloadCopyWithImpl<SemanticRankingPayload>(this as SemanticRankingPayload, _$identity);

  /// Serializes this SemanticRankingPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SemanticRankingPayload&&(identical(other.feedItemId, feedItemId) || other.feedItemId == feedItemId)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.publicSummary, publicSummary) || other.publicSummary == publicSummary)&&(identical(other.category, category) || other.category == category)&&(identical(other.locationHint, locationHint) || other.locationHint == locationHint)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.isTrusted, isTrusted) || other.isTrusted == isTrusted)&&(identical(other.ageBucket, ageBucket) || other.ageBucket == ageBucket)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,feedItemId,sourceId,type,title,publicSummary,category,locationHint,isPromoted,isTrusted,ageBucket,languageCode);

@override
String toString() {
  return 'SemanticRankingPayload(feedItemId: $feedItemId, sourceId: $sourceId, type: $type, title: $title, publicSummary: $publicSummary, category: $category, locationHint: $locationHint, isPromoted: $isPromoted, isTrusted: $isTrusted, ageBucket: $ageBucket, languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class $SemanticRankingPayloadCopyWith<$Res>  {
  factory $SemanticRankingPayloadCopyWith(SemanticRankingPayload value, $Res Function(SemanticRankingPayload) _then) = _$SemanticRankingPayloadCopyWithImpl;
@useResult
$Res call({
 String feedItemId, String sourceId, String type, String title, String? publicSummary, String? category, String? locationHint, bool isPromoted, bool isTrusted, String? ageBucket, String? languageCode
});




}
/// @nodoc
class _$SemanticRankingPayloadCopyWithImpl<$Res>
    implements $SemanticRankingPayloadCopyWith<$Res> {
  _$SemanticRankingPayloadCopyWithImpl(this._self, this._then);

  final SemanticRankingPayload _self;
  final $Res Function(SemanticRankingPayload) _then;

/// Create a copy of SemanticRankingPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feedItemId = null,Object? sourceId = null,Object? type = null,Object? title = null,Object? publicSummary = freezed,Object? category = freezed,Object? locationHint = freezed,Object? isPromoted = null,Object? isTrusted = null,Object? ageBucket = freezed,Object? languageCode = freezed,}) {
  return _then(_self.copyWith(
feedItemId: null == feedItemId ? _self.feedItemId : feedItemId // ignore: cast_nullable_to_non_nullable
as String,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publicSummary: freezed == publicSummary ? _self.publicSummary : publicSummary // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,locationHint: freezed == locationHint ? _self.locationHint : locationHint // ignore: cast_nullable_to_non_nullable
as String?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,isTrusted: null == isTrusted ? _self.isTrusted : isTrusted // ignore: cast_nullable_to_non_nullable
as bool,ageBucket: freezed == ageBucket ? _self.ageBucket : ageBucket // ignore: cast_nullable_to_non_nullable
as String?,languageCode: freezed == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SemanticRankingPayload].
extension SemanticRankingPayloadPatterns on SemanticRankingPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SemanticRankingPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SemanticRankingPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SemanticRankingPayload value)  $default,){
final _that = this;
switch (_that) {
case _SemanticRankingPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SemanticRankingPayload value)?  $default,){
final _that = this;
switch (_that) {
case _SemanticRankingPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String feedItemId,  String sourceId,  String type,  String title,  String? publicSummary,  String? category,  String? locationHint,  bool isPromoted,  bool isTrusted,  String? ageBucket,  String? languageCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SemanticRankingPayload() when $default != null:
return $default(_that.feedItemId,_that.sourceId,_that.type,_that.title,_that.publicSummary,_that.category,_that.locationHint,_that.isPromoted,_that.isTrusted,_that.ageBucket,_that.languageCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String feedItemId,  String sourceId,  String type,  String title,  String? publicSummary,  String? category,  String? locationHint,  bool isPromoted,  bool isTrusted,  String? ageBucket,  String? languageCode)  $default,) {final _that = this;
switch (_that) {
case _SemanticRankingPayload():
return $default(_that.feedItemId,_that.sourceId,_that.type,_that.title,_that.publicSummary,_that.category,_that.locationHint,_that.isPromoted,_that.isTrusted,_that.ageBucket,_that.languageCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String feedItemId,  String sourceId,  String type,  String title,  String? publicSummary,  String? category,  String? locationHint,  bool isPromoted,  bool isTrusted,  String? ageBucket,  String? languageCode)?  $default,) {final _that = this;
switch (_that) {
case _SemanticRankingPayload() when $default != null:
return $default(_that.feedItemId,_that.sourceId,_that.type,_that.title,_that.publicSummary,_that.category,_that.locationHint,_that.isPromoted,_that.isTrusted,_that.ageBucket,_that.languageCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SemanticRankingPayload extends SemanticRankingPayload {
  const _SemanticRankingPayload({required this.feedItemId, required this.sourceId, required this.type, required this.title, this.publicSummary, this.category, this.locationHint, this.isPromoted = false, this.isTrusted = false, this.ageBucket, this.languageCode}): super._();
  factory _SemanticRankingPayload.fromJson(Map<String, dynamic> json) => _$SemanticRankingPayloadFromJson(json);

@override final  String feedItemId;
@override final  String sourceId;
@override final  String type;
@override final  String title;
@override final  String? publicSummary;
@override final  String? category;
@override final  String? locationHint;
@override@JsonKey() final  bool isPromoted;
@override@JsonKey() final  bool isTrusted;
@override final  String? ageBucket;
@override final  String? languageCode;

/// Create a copy of SemanticRankingPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SemanticRankingPayloadCopyWith<_SemanticRankingPayload> get copyWith => __$SemanticRankingPayloadCopyWithImpl<_SemanticRankingPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SemanticRankingPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SemanticRankingPayload&&(identical(other.feedItemId, feedItemId) || other.feedItemId == feedItemId)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.publicSummary, publicSummary) || other.publicSummary == publicSummary)&&(identical(other.category, category) || other.category == category)&&(identical(other.locationHint, locationHint) || other.locationHint == locationHint)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.isTrusted, isTrusted) || other.isTrusted == isTrusted)&&(identical(other.ageBucket, ageBucket) || other.ageBucket == ageBucket)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,feedItemId,sourceId,type,title,publicSummary,category,locationHint,isPromoted,isTrusted,ageBucket,languageCode);

@override
String toString() {
  return 'SemanticRankingPayload(feedItemId: $feedItemId, sourceId: $sourceId, type: $type, title: $title, publicSummary: $publicSummary, category: $category, locationHint: $locationHint, isPromoted: $isPromoted, isTrusted: $isTrusted, ageBucket: $ageBucket, languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class _$SemanticRankingPayloadCopyWith<$Res> implements $SemanticRankingPayloadCopyWith<$Res> {
  factory _$SemanticRankingPayloadCopyWith(_SemanticRankingPayload value, $Res Function(_SemanticRankingPayload) _then) = __$SemanticRankingPayloadCopyWithImpl;
@override @useResult
$Res call({
 String feedItemId, String sourceId, String type, String title, String? publicSummary, String? category, String? locationHint, bool isPromoted, bool isTrusted, String? ageBucket, String? languageCode
});




}
/// @nodoc
class __$SemanticRankingPayloadCopyWithImpl<$Res>
    implements _$SemanticRankingPayloadCopyWith<$Res> {
  __$SemanticRankingPayloadCopyWithImpl(this._self, this._then);

  final _SemanticRankingPayload _self;
  final $Res Function(_SemanticRankingPayload) _then;

/// Create a copy of SemanticRankingPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feedItemId = null,Object? sourceId = null,Object? type = null,Object? title = null,Object? publicSummary = freezed,Object? category = freezed,Object? locationHint = freezed,Object? isPromoted = null,Object? isTrusted = null,Object? ageBucket = freezed,Object? languageCode = freezed,}) {
  return _then(_SemanticRankingPayload(
feedItemId: null == feedItemId ? _self.feedItemId : feedItemId // ignore: cast_nullable_to_non_nullable
as String,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,publicSummary: freezed == publicSummary ? _self.publicSummary : publicSummary // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,locationHint: freezed == locationHint ? _self.locationHint : locationHint // ignore: cast_nullable_to_non_nullable
as String?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,isTrusted: null == isTrusted ? _self.isTrusted : isTrusted // ignore: cast_nullable_to_non_nullable
as bool,ageBucket: freezed == ageBucket ? _self.ageBucket : ageBucket // ignore: cast_nullable_to_non_nullable
as String?,languageCode: freezed == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
