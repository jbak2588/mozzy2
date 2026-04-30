// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_verification_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiVerificationResult {

 String get id; String get productId; String get status;// passed | failed | needs_review | pending | not_requested | error
 double get score; String get summary; List<String> get detectedIssues; String? get suggestedCategory; String? get conditionLabel; String? get rawResponse; DateTime get createdAt;
/// Create a copy of AiVerificationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiVerificationResultCopyWith<AiVerificationResult> get copyWith => _$AiVerificationResultCopyWithImpl<AiVerificationResult>(this as AiVerificationResult, _$identity);

  /// Serializes this AiVerificationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiVerificationResult&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.status, status) || other.status == status)&&(identical(other.score, score) || other.score == score)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.detectedIssues, detectedIssues)&&(identical(other.suggestedCategory, suggestedCategory) || other.suggestedCategory == suggestedCategory)&&(identical(other.conditionLabel, conditionLabel) || other.conditionLabel == conditionLabel)&&(identical(other.rawResponse, rawResponse) || other.rawResponse == rawResponse)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,status,score,summary,const DeepCollectionEquality().hash(detectedIssues),suggestedCategory,conditionLabel,rawResponse,createdAt);

@override
String toString() {
  return 'AiVerificationResult(id: $id, productId: $productId, status: $status, score: $score, summary: $summary, detectedIssues: $detectedIssues, suggestedCategory: $suggestedCategory, conditionLabel: $conditionLabel, rawResponse: $rawResponse, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AiVerificationResultCopyWith<$Res>  {
  factory $AiVerificationResultCopyWith(AiVerificationResult value, $Res Function(AiVerificationResult) _then) = _$AiVerificationResultCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String status, double score, String summary, List<String> detectedIssues, String? suggestedCategory, String? conditionLabel, String? rawResponse, DateTime createdAt
});




}
/// @nodoc
class _$AiVerificationResultCopyWithImpl<$Res>
    implements $AiVerificationResultCopyWith<$Res> {
  _$AiVerificationResultCopyWithImpl(this._self, this._then);

  final AiVerificationResult _self;
  final $Res Function(AiVerificationResult) _then;

/// Create a copy of AiVerificationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? status = null,Object? score = null,Object? summary = null,Object? detectedIssues = null,Object? suggestedCategory = freezed,Object? conditionLabel = freezed,Object? rawResponse = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,detectedIssues: null == detectedIssues ? _self.detectedIssues : detectedIssues // ignore: cast_nullable_to_non_nullable
as List<String>,suggestedCategory: freezed == suggestedCategory ? _self.suggestedCategory : suggestedCategory // ignore: cast_nullable_to_non_nullable
as String?,conditionLabel: freezed == conditionLabel ? _self.conditionLabel : conditionLabel // ignore: cast_nullable_to_non_nullable
as String?,rawResponse: freezed == rawResponse ? _self.rawResponse : rawResponse // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AiVerificationResult].
extension AiVerificationResultPatterns on AiVerificationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiVerificationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiVerificationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiVerificationResult value)  $default,){
final _that = this;
switch (_that) {
case _AiVerificationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiVerificationResult value)?  $default,){
final _that = this;
switch (_that) {
case _AiVerificationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String status,  double score,  String summary,  List<String> detectedIssues,  String? suggestedCategory,  String? conditionLabel,  String? rawResponse,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiVerificationResult() when $default != null:
return $default(_that.id,_that.productId,_that.status,_that.score,_that.summary,_that.detectedIssues,_that.suggestedCategory,_that.conditionLabel,_that.rawResponse,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String status,  double score,  String summary,  List<String> detectedIssues,  String? suggestedCategory,  String? conditionLabel,  String? rawResponse,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AiVerificationResult():
return $default(_that.id,_that.productId,_that.status,_that.score,_that.summary,_that.detectedIssues,_that.suggestedCategory,_that.conditionLabel,_that.rawResponse,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String status,  double score,  String summary,  List<String> detectedIssues,  String? suggestedCategory,  String? conditionLabel,  String? rawResponse,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AiVerificationResult() when $default != null:
return $default(_that.id,_that.productId,_that.status,_that.score,_that.summary,_that.detectedIssues,_that.suggestedCategory,_that.conditionLabel,_that.rawResponse,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiVerificationResult extends AiVerificationResult {
  const _AiVerificationResult({required this.id, required this.productId, required this.status, this.score = 0.0, this.summary = '', final  List<String> detectedIssues = const [], this.suggestedCategory, this.conditionLabel, this.rawResponse, required this.createdAt}): _detectedIssues = detectedIssues,super._();
  factory _AiVerificationResult.fromJson(Map<String, dynamic> json) => _$AiVerificationResultFromJson(json);

@override final  String id;
@override final  String productId;
@override final  String status;
// passed | failed | needs_review | pending | not_requested | error
@override@JsonKey() final  double score;
@override@JsonKey() final  String summary;
 final  List<String> _detectedIssues;
@override@JsonKey() List<String> get detectedIssues {
  if (_detectedIssues is EqualUnmodifiableListView) return _detectedIssues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_detectedIssues);
}

@override final  String? suggestedCategory;
@override final  String? conditionLabel;
@override final  String? rawResponse;
@override final  DateTime createdAt;

/// Create a copy of AiVerificationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiVerificationResultCopyWith<_AiVerificationResult> get copyWith => __$AiVerificationResultCopyWithImpl<_AiVerificationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiVerificationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiVerificationResult&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.status, status) || other.status == status)&&(identical(other.score, score) || other.score == score)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._detectedIssues, _detectedIssues)&&(identical(other.suggestedCategory, suggestedCategory) || other.suggestedCategory == suggestedCategory)&&(identical(other.conditionLabel, conditionLabel) || other.conditionLabel == conditionLabel)&&(identical(other.rawResponse, rawResponse) || other.rawResponse == rawResponse)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,status,score,summary,const DeepCollectionEquality().hash(_detectedIssues),suggestedCategory,conditionLabel,rawResponse,createdAt);

@override
String toString() {
  return 'AiVerificationResult(id: $id, productId: $productId, status: $status, score: $score, summary: $summary, detectedIssues: $detectedIssues, suggestedCategory: $suggestedCategory, conditionLabel: $conditionLabel, rawResponse: $rawResponse, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AiVerificationResultCopyWith<$Res> implements $AiVerificationResultCopyWith<$Res> {
  factory _$AiVerificationResultCopyWith(_AiVerificationResult value, $Res Function(_AiVerificationResult) _then) = __$AiVerificationResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String status, double score, String summary, List<String> detectedIssues, String? suggestedCategory, String? conditionLabel, String? rawResponse, DateTime createdAt
});




}
/// @nodoc
class __$AiVerificationResultCopyWithImpl<$Res>
    implements _$AiVerificationResultCopyWith<$Res> {
  __$AiVerificationResultCopyWithImpl(this._self, this._then);

  final _AiVerificationResult _self;
  final $Res Function(_AiVerificationResult) _then;

/// Create a copy of AiVerificationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? status = null,Object? score = null,Object? summary = null,Object? detectedIssues = null,Object? suggestedCategory = freezed,Object? conditionLabel = freezed,Object? rawResponse = freezed,Object? createdAt = null,}) {
  return _then(_AiVerificationResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,detectedIssues: null == detectedIssues ? _self._detectedIssues : detectedIssues // ignore: cast_nullable_to_non_nullable
as List<String>,suggestedCategory: freezed == suggestedCategory ? _self.suggestedCategory : suggestedCategory // ignore: cast_nullable_to_non_nullable
as String?,conditionLabel: freezed == conditionLabel ? _self.conditionLabel : conditionLabel // ignore: cast_nullable_to_non_nullable
as String?,rawResponse: freezed == rawResponse ? _self.rawResponse : rawResponse // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
