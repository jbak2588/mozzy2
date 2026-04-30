// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_verification_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiVerificationReportModel {

 String get id; String get productId; String get sellerId; String get status;// passed | failed | needs_review | error
 double get score; String get summary; List<String> get detectedIssues; String? get suggestedCategory; String? get conditionLabel; String get modelName; String get promptVersion; String get rawResponseSummary; DateTime get createdAt; String get source;
/// Create a copy of AiVerificationReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiVerificationReportModelCopyWith<AiVerificationReportModel> get copyWith => _$AiVerificationReportModelCopyWithImpl<AiVerificationReportModel>(this as AiVerificationReportModel, _$identity);

  /// Serializes this AiVerificationReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiVerificationReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.score, score) || other.score == score)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.detectedIssues, detectedIssues)&&(identical(other.suggestedCategory, suggestedCategory) || other.suggestedCategory == suggestedCategory)&&(identical(other.conditionLabel, conditionLabel) || other.conditionLabel == conditionLabel)&&(identical(other.modelName, modelName) || other.modelName == modelName)&&(identical(other.promptVersion, promptVersion) || other.promptVersion == promptVersion)&&(identical(other.rawResponseSummary, rawResponseSummary) || other.rawResponseSummary == rawResponseSummary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,sellerId,status,score,summary,const DeepCollectionEquality().hash(detectedIssues),suggestedCategory,conditionLabel,modelName,promptVersion,rawResponseSummary,createdAt,source);

@override
String toString() {
  return 'AiVerificationReportModel(id: $id, productId: $productId, sellerId: $sellerId, status: $status, score: $score, summary: $summary, detectedIssues: $detectedIssues, suggestedCategory: $suggestedCategory, conditionLabel: $conditionLabel, modelName: $modelName, promptVersion: $promptVersion, rawResponseSummary: $rawResponseSummary, createdAt: $createdAt, source: $source)';
}


}

/// @nodoc
abstract mixin class $AiVerificationReportModelCopyWith<$Res>  {
  factory $AiVerificationReportModelCopyWith(AiVerificationReportModel value, $Res Function(AiVerificationReportModel) _then) = _$AiVerificationReportModelCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String sellerId, String status, double score, String summary, List<String> detectedIssues, String? suggestedCategory, String? conditionLabel, String modelName, String promptVersion, String rawResponseSummary, DateTime createdAt, String source
});




}
/// @nodoc
class _$AiVerificationReportModelCopyWithImpl<$Res>
    implements $AiVerificationReportModelCopyWith<$Res> {
  _$AiVerificationReportModelCopyWithImpl(this._self, this._then);

  final AiVerificationReportModel _self;
  final $Res Function(AiVerificationReportModel) _then;

/// Create a copy of AiVerificationReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? sellerId = null,Object? status = null,Object? score = null,Object? summary = null,Object? detectedIssues = null,Object? suggestedCategory = freezed,Object? conditionLabel = freezed,Object? modelName = null,Object? promptVersion = null,Object? rawResponseSummary = null,Object? createdAt = null,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,detectedIssues: null == detectedIssues ? _self.detectedIssues : detectedIssues // ignore: cast_nullable_to_non_nullable
as List<String>,suggestedCategory: freezed == suggestedCategory ? _self.suggestedCategory : suggestedCategory // ignore: cast_nullable_to_non_nullable
as String?,conditionLabel: freezed == conditionLabel ? _self.conditionLabel : conditionLabel // ignore: cast_nullable_to_non_nullable
as String?,modelName: null == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String,promptVersion: null == promptVersion ? _self.promptVersion : promptVersion // ignore: cast_nullable_to_non_nullable
as String,rawResponseSummary: null == rawResponseSummary ? _self.rawResponseSummary : rawResponseSummary // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiVerificationReportModel].
extension AiVerificationReportModelPatterns on AiVerificationReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiVerificationReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiVerificationReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiVerificationReportModel value)  $default,){
final _that = this;
switch (_that) {
case _AiVerificationReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiVerificationReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _AiVerificationReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String sellerId,  String status,  double score,  String summary,  List<String> detectedIssues,  String? suggestedCategory,  String? conditionLabel,  String modelName,  String promptVersion,  String rawResponseSummary,  DateTime createdAt,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiVerificationReportModel() when $default != null:
return $default(_that.id,_that.productId,_that.sellerId,_that.status,_that.score,_that.summary,_that.detectedIssues,_that.suggestedCategory,_that.conditionLabel,_that.modelName,_that.promptVersion,_that.rawResponseSummary,_that.createdAt,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String sellerId,  String status,  double score,  String summary,  List<String> detectedIssues,  String? suggestedCategory,  String? conditionLabel,  String modelName,  String promptVersion,  String rawResponseSummary,  DateTime createdAt,  String source)  $default,) {final _that = this;
switch (_that) {
case _AiVerificationReportModel():
return $default(_that.id,_that.productId,_that.sellerId,_that.status,_that.score,_that.summary,_that.detectedIssues,_that.suggestedCategory,_that.conditionLabel,_that.modelName,_that.promptVersion,_that.rawResponseSummary,_that.createdAt,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String sellerId,  String status,  double score,  String summary,  List<String> detectedIssues,  String? suggestedCategory,  String? conditionLabel,  String modelName,  String promptVersion,  String rawResponseSummary,  DateTime createdAt,  String source)?  $default,) {final _that = this;
switch (_that) {
case _AiVerificationReportModel() when $default != null:
return $default(_that.id,_that.productId,_that.sellerId,_that.status,_that.score,_that.summary,_that.detectedIssues,_that.suggestedCategory,_that.conditionLabel,_that.modelName,_that.promptVersion,_that.rawResponseSummary,_that.createdAt,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiVerificationReportModel extends AiVerificationReportModel {
  const _AiVerificationReportModel({required this.id, required this.productId, required this.sellerId, required this.status, this.score = 0.0, this.summary = '', final  List<String> detectedIssues = const [], this.suggestedCategory, this.conditionLabel, this.modelName = 'gemini-3-flash-preview', this.promptVersion = 'marketplace_ai_v1', this.rawResponseSummary = '', required this.createdAt, this.source = 'create_product'}): _detectedIssues = detectedIssues,super._();
  factory _AiVerificationReportModel.fromJson(Map<String, dynamic> json) => _$AiVerificationReportModelFromJson(json);

@override final  String id;
@override final  String productId;
@override final  String sellerId;
@override final  String status;
// passed | failed | needs_review | error
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
@override@JsonKey() final  String modelName;
@override@JsonKey() final  String promptVersion;
@override@JsonKey() final  String rawResponseSummary;
@override final  DateTime createdAt;
@override@JsonKey() final  String source;

/// Create a copy of AiVerificationReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiVerificationReportModelCopyWith<_AiVerificationReportModel> get copyWith => __$AiVerificationReportModelCopyWithImpl<_AiVerificationReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiVerificationReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiVerificationReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.score, score) || other.score == score)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._detectedIssues, _detectedIssues)&&(identical(other.suggestedCategory, suggestedCategory) || other.suggestedCategory == suggestedCategory)&&(identical(other.conditionLabel, conditionLabel) || other.conditionLabel == conditionLabel)&&(identical(other.modelName, modelName) || other.modelName == modelName)&&(identical(other.promptVersion, promptVersion) || other.promptVersion == promptVersion)&&(identical(other.rawResponseSummary, rawResponseSummary) || other.rawResponseSummary == rawResponseSummary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,sellerId,status,score,summary,const DeepCollectionEquality().hash(_detectedIssues),suggestedCategory,conditionLabel,modelName,promptVersion,rawResponseSummary,createdAt,source);

@override
String toString() {
  return 'AiVerificationReportModel(id: $id, productId: $productId, sellerId: $sellerId, status: $status, score: $score, summary: $summary, detectedIssues: $detectedIssues, suggestedCategory: $suggestedCategory, conditionLabel: $conditionLabel, modelName: $modelName, promptVersion: $promptVersion, rawResponseSummary: $rawResponseSummary, createdAt: $createdAt, source: $source)';
}


}

/// @nodoc
abstract mixin class _$AiVerificationReportModelCopyWith<$Res> implements $AiVerificationReportModelCopyWith<$Res> {
  factory _$AiVerificationReportModelCopyWith(_AiVerificationReportModel value, $Res Function(_AiVerificationReportModel) _then) = __$AiVerificationReportModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String sellerId, String status, double score, String summary, List<String> detectedIssues, String? suggestedCategory, String? conditionLabel, String modelName, String promptVersion, String rawResponseSummary, DateTime createdAt, String source
});




}
/// @nodoc
class __$AiVerificationReportModelCopyWithImpl<$Res>
    implements _$AiVerificationReportModelCopyWith<$Res> {
  __$AiVerificationReportModelCopyWithImpl(this._self, this._then);

  final _AiVerificationReportModel _self;
  final $Res Function(_AiVerificationReportModel) _then;

/// Create a copy of AiVerificationReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? sellerId = null,Object? status = null,Object? score = null,Object? summary = null,Object? detectedIssues = null,Object? suggestedCategory = freezed,Object? conditionLabel = freezed,Object? modelName = null,Object? promptVersion = null,Object? rawResponseSummary = null,Object? createdAt = null,Object? source = null,}) {
  return _then(_AiVerificationReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,detectedIssues: null == detectedIssues ? _self._detectedIssues : detectedIssues // ignore: cast_nullable_to_non_nullable
as List<String>,suggestedCategory: freezed == suggestedCategory ? _self.suggestedCategory : suggestedCategory // ignore: cast_nullable_to_non_nullable
as String?,conditionLabel: freezed == conditionLabel ? _self.conditionLabel : conditionLabel // ignore: cast_nullable_to_non_nullable
as String?,modelName: null == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String,promptVersion: null == promptVersion ? _self.promptVersion : promptVersion // ignore: cast_nullable_to_non_nullable
as String,rawResponseSummary: null == rawResponseSummary ? _self.rawResponseSummary : rawResponseSummary // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
