// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_engagement_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedEngagementSummary {

 String get id; String get sourceType; String get sourceId; String? get feedItemId; int get impressionCount; int get cardTapCount; int get detailOpenCount; int get ctaTapCount; int get semanticIntentCount; int get totalInteractions; int get uniqueSessionCount; double get engagementScore;@OptionalSafeDateTimeConverter() DateTime? get lastInteractionAt;@OptionalSafeDateTimeConverter() DateTime? get lastAggregatedAt; String get window;
/// Create a copy of FeedEngagementSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEngagementSummaryCopyWith<FeedEngagementSummary> get copyWith => _$FeedEngagementSummaryCopyWithImpl<FeedEngagementSummary>(this as FeedEngagementSummary, _$identity);

  /// Serializes this FeedEngagementSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEngagementSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.feedItemId, feedItemId) || other.feedItemId == feedItemId)&&(identical(other.impressionCount, impressionCount) || other.impressionCount == impressionCount)&&(identical(other.cardTapCount, cardTapCount) || other.cardTapCount == cardTapCount)&&(identical(other.detailOpenCount, detailOpenCount) || other.detailOpenCount == detailOpenCount)&&(identical(other.ctaTapCount, ctaTapCount) || other.ctaTapCount == ctaTapCount)&&(identical(other.semanticIntentCount, semanticIntentCount) || other.semanticIntentCount == semanticIntentCount)&&(identical(other.totalInteractions, totalInteractions) || other.totalInteractions == totalInteractions)&&(identical(other.uniqueSessionCount, uniqueSessionCount) || other.uniqueSessionCount == uniqueSessionCount)&&(identical(other.engagementScore, engagementScore) || other.engagementScore == engagementScore)&&(identical(other.lastInteractionAt, lastInteractionAt) || other.lastInteractionAt == lastInteractionAt)&&(identical(other.lastAggregatedAt, lastAggregatedAt) || other.lastAggregatedAt == lastAggregatedAt)&&(identical(other.window, window) || other.window == window));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sourceType,sourceId,feedItemId,impressionCount,cardTapCount,detailOpenCount,ctaTapCount,semanticIntentCount,totalInteractions,uniqueSessionCount,engagementScore,lastInteractionAt,lastAggregatedAt,window);

@override
String toString() {
  return 'FeedEngagementSummary(id: $id, sourceType: $sourceType, sourceId: $sourceId, feedItemId: $feedItemId, impressionCount: $impressionCount, cardTapCount: $cardTapCount, detailOpenCount: $detailOpenCount, ctaTapCount: $ctaTapCount, semanticIntentCount: $semanticIntentCount, totalInteractions: $totalInteractions, uniqueSessionCount: $uniqueSessionCount, engagementScore: $engagementScore, lastInteractionAt: $lastInteractionAt, lastAggregatedAt: $lastAggregatedAt, window: $window)';
}


}

/// @nodoc
abstract mixin class $FeedEngagementSummaryCopyWith<$Res>  {
  factory $FeedEngagementSummaryCopyWith(FeedEngagementSummary value, $Res Function(FeedEngagementSummary) _then) = _$FeedEngagementSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String sourceType, String sourceId, String? feedItemId, int impressionCount, int cardTapCount, int detailOpenCount, int ctaTapCount, int semanticIntentCount, int totalInteractions, int uniqueSessionCount, double engagementScore,@OptionalSafeDateTimeConverter() DateTime? lastInteractionAt,@OptionalSafeDateTimeConverter() DateTime? lastAggregatedAt, String window
});




}
/// @nodoc
class _$FeedEngagementSummaryCopyWithImpl<$Res>
    implements $FeedEngagementSummaryCopyWith<$Res> {
  _$FeedEngagementSummaryCopyWithImpl(this._self, this._then);

  final FeedEngagementSummary _self;
  final $Res Function(FeedEngagementSummary) _then;

/// Create a copy of FeedEngagementSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sourceType = null,Object? sourceId = null,Object? feedItemId = freezed,Object? impressionCount = null,Object? cardTapCount = null,Object? detailOpenCount = null,Object? ctaTapCount = null,Object? semanticIntentCount = null,Object? totalInteractions = null,Object? uniqueSessionCount = null,Object? engagementScore = null,Object? lastInteractionAt = freezed,Object? lastAggregatedAt = freezed,Object? window = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,feedItemId: freezed == feedItemId ? _self.feedItemId : feedItemId // ignore: cast_nullable_to_non_nullable
as String?,impressionCount: null == impressionCount ? _self.impressionCount : impressionCount // ignore: cast_nullable_to_non_nullable
as int,cardTapCount: null == cardTapCount ? _self.cardTapCount : cardTapCount // ignore: cast_nullable_to_non_nullable
as int,detailOpenCount: null == detailOpenCount ? _self.detailOpenCount : detailOpenCount // ignore: cast_nullable_to_non_nullable
as int,ctaTapCount: null == ctaTapCount ? _self.ctaTapCount : ctaTapCount // ignore: cast_nullable_to_non_nullable
as int,semanticIntentCount: null == semanticIntentCount ? _self.semanticIntentCount : semanticIntentCount // ignore: cast_nullable_to_non_nullable
as int,totalInteractions: null == totalInteractions ? _self.totalInteractions : totalInteractions // ignore: cast_nullable_to_non_nullable
as int,uniqueSessionCount: null == uniqueSessionCount ? _self.uniqueSessionCount : uniqueSessionCount // ignore: cast_nullable_to_non_nullable
as int,engagementScore: null == engagementScore ? _self.engagementScore : engagementScore // ignore: cast_nullable_to_non_nullable
as double,lastInteractionAt: freezed == lastInteractionAt ? _self.lastInteractionAt : lastInteractionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastAggregatedAt: freezed == lastAggregatedAt ? _self.lastAggregatedAt : lastAggregatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,window: null == window ? _self.window : window // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedEngagementSummary].
extension FeedEngagementSummaryPatterns on FeedEngagementSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEngagementSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEngagementSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEngagementSummary value)  $default,){
final _that = this;
switch (_that) {
case _FeedEngagementSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEngagementSummary value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEngagementSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sourceType,  String sourceId,  String? feedItemId,  int impressionCount,  int cardTapCount,  int detailOpenCount,  int ctaTapCount,  int semanticIntentCount,  int totalInteractions,  int uniqueSessionCount,  double engagementScore, @OptionalSafeDateTimeConverter()  DateTime? lastInteractionAt, @OptionalSafeDateTimeConverter()  DateTime? lastAggregatedAt,  String window)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEngagementSummary() when $default != null:
return $default(_that.id,_that.sourceType,_that.sourceId,_that.feedItemId,_that.impressionCount,_that.cardTapCount,_that.detailOpenCount,_that.ctaTapCount,_that.semanticIntentCount,_that.totalInteractions,_that.uniqueSessionCount,_that.engagementScore,_that.lastInteractionAt,_that.lastAggregatedAt,_that.window);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sourceType,  String sourceId,  String? feedItemId,  int impressionCount,  int cardTapCount,  int detailOpenCount,  int ctaTapCount,  int semanticIntentCount,  int totalInteractions,  int uniqueSessionCount,  double engagementScore, @OptionalSafeDateTimeConverter()  DateTime? lastInteractionAt, @OptionalSafeDateTimeConverter()  DateTime? lastAggregatedAt,  String window)  $default,) {final _that = this;
switch (_that) {
case _FeedEngagementSummary():
return $default(_that.id,_that.sourceType,_that.sourceId,_that.feedItemId,_that.impressionCount,_that.cardTapCount,_that.detailOpenCount,_that.ctaTapCount,_that.semanticIntentCount,_that.totalInteractions,_that.uniqueSessionCount,_that.engagementScore,_that.lastInteractionAt,_that.lastAggregatedAt,_that.window);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sourceType,  String sourceId,  String? feedItemId,  int impressionCount,  int cardTapCount,  int detailOpenCount,  int ctaTapCount,  int semanticIntentCount,  int totalInteractions,  int uniqueSessionCount,  double engagementScore, @OptionalSafeDateTimeConverter()  DateTime? lastInteractionAt, @OptionalSafeDateTimeConverter()  DateTime? lastAggregatedAt,  String window)?  $default,) {final _that = this;
switch (_that) {
case _FeedEngagementSummary() when $default != null:
return $default(_that.id,_that.sourceType,_that.sourceId,_that.feedItemId,_that.impressionCount,_that.cardTapCount,_that.detailOpenCount,_that.ctaTapCount,_that.semanticIntentCount,_that.totalInteractions,_that.uniqueSessionCount,_that.engagementScore,_that.lastInteractionAt,_that.lastAggregatedAt,_that.window);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedEngagementSummary implements FeedEngagementSummary {
  const _FeedEngagementSummary({required this.id, required this.sourceType, required this.sourceId, this.feedItemId, this.impressionCount = 0, this.cardTapCount = 0, this.detailOpenCount = 0, this.ctaTapCount = 0, this.semanticIntentCount = 0, this.totalInteractions = 0, this.uniqueSessionCount = 0, this.engagementScore = 0.0, @OptionalSafeDateTimeConverter() this.lastInteractionAt, @OptionalSafeDateTimeConverter() this.lastAggregatedAt, this.window = 'all_time'});
  factory _FeedEngagementSummary.fromJson(Map<String, dynamic> json) => _$FeedEngagementSummaryFromJson(json);

@override final  String id;
@override final  String sourceType;
@override final  String sourceId;
@override final  String? feedItemId;
@override@JsonKey() final  int impressionCount;
@override@JsonKey() final  int cardTapCount;
@override@JsonKey() final  int detailOpenCount;
@override@JsonKey() final  int ctaTapCount;
@override@JsonKey() final  int semanticIntentCount;
@override@JsonKey() final  int totalInteractions;
@override@JsonKey() final  int uniqueSessionCount;
@override@JsonKey() final  double engagementScore;
@override@OptionalSafeDateTimeConverter() final  DateTime? lastInteractionAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? lastAggregatedAt;
@override@JsonKey() final  String window;

/// Create a copy of FeedEngagementSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEngagementSummaryCopyWith<_FeedEngagementSummary> get copyWith => __$FeedEngagementSummaryCopyWithImpl<_FeedEngagementSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedEngagementSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEngagementSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.feedItemId, feedItemId) || other.feedItemId == feedItemId)&&(identical(other.impressionCount, impressionCount) || other.impressionCount == impressionCount)&&(identical(other.cardTapCount, cardTapCount) || other.cardTapCount == cardTapCount)&&(identical(other.detailOpenCount, detailOpenCount) || other.detailOpenCount == detailOpenCount)&&(identical(other.ctaTapCount, ctaTapCount) || other.ctaTapCount == ctaTapCount)&&(identical(other.semanticIntentCount, semanticIntentCount) || other.semanticIntentCount == semanticIntentCount)&&(identical(other.totalInteractions, totalInteractions) || other.totalInteractions == totalInteractions)&&(identical(other.uniqueSessionCount, uniqueSessionCount) || other.uniqueSessionCount == uniqueSessionCount)&&(identical(other.engagementScore, engagementScore) || other.engagementScore == engagementScore)&&(identical(other.lastInteractionAt, lastInteractionAt) || other.lastInteractionAt == lastInteractionAt)&&(identical(other.lastAggregatedAt, lastAggregatedAt) || other.lastAggregatedAt == lastAggregatedAt)&&(identical(other.window, window) || other.window == window));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sourceType,sourceId,feedItemId,impressionCount,cardTapCount,detailOpenCount,ctaTapCount,semanticIntentCount,totalInteractions,uniqueSessionCount,engagementScore,lastInteractionAt,lastAggregatedAt,window);

@override
String toString() {
  return 'FeedEngagementSummary(id: $id, sourceType: $sourceType, sourceId: $sourceId, feedItemId: $feedItemId, impressionCount: $impressionCount, cardTapCount: $cardTapCount, detailOpenCount: $detailOpenCount, ctaTapCount: $ctaTapCount, semanticIntentCount: $semanticIntentCount, totalInteractions: $totalInteractions, uniqueSessionCount: $uniqueSessionCount, engagementScore: $engagementScore, lastInteractionAt: $lastInteractionAt, lastAggregatedAt: $lastAggregatedAt, window: $window)';
}


}

/// @nodoc
abstract mixin class _$FeedEngagementSummaryCopyWith<$Res> implements $FeedEngagementSummaryCopyWith<$Res> {
  factory _$FeedEngagementSummaryCopyWith(_FeedEngagementSummary value, $Res Function(_FeedEngagementSummary) _then) = __$FeedEngagementSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String sourceType, String sourceId, String? feedItemId, int impressionCount, int cardTapCount, int detailOpenCount, int ctaTapCount, int semanticIntentCount, int totalInteractions, int uniqueSessionCount, double engagementScore,@OptionalSafeDateTimeConverter() DateTime? lastInteractionAt,@OptionalSafeDateTimeConverter() DateTime? lastAggregatedAt, String window
});




}
/// @nodoc
class __$FeedEngagementSummaryCopyWithImpl<$Res>
    implements _$FeedEngagementSummaryCopyWith<$Res> {
  __$FeedEngagementSummaryCopyWithImpl(this._self, this._then);

  final _FeedEngagementSummary _self;
  final $Res Function(_FeedEngagementSummary) _then;

/// Create a copy of FeedEngagementSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sourceType = null,Object? sourceId = null,Object? feedItemId = freezed,Object? impressionCount = null,Object? cardTapCount = null,Object? detailOpenCount = null,Object? ctaTapCount = null,Object? semanticIntentCount = null,Object? totalInteractions = null,Object? uniqueSessionCount = null,Object? engagementScore = null,Object? lastInteractionAt = freezed,Object? lastAggregatedAt = freezed,Object? window = null,}) {
  return _then(_FeedEngagementSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,feedItemId: freezed == feedItemId ? _self.feedItemId : feedItemId // ignore: cast_nullable_to_non_nullable
as String?,impressionCount: null == impressionCount ? _self.impressionCount : impressionCount // ignore: cast_nullable_to_non_nullable
as int,cardTapCount: null == cardTapCount ? _self.cardTapCount : cardTapCount // ignore: cast_nullable_to_non_nullable
as int,detailOpenCount: null == detailOpenCount ? _self.detailOpenCount : detailOpenCount // ignore: cast_nullable_to_non_nullable
as int,ctaTapCount: null == ctaTapCount ? _self.ctaTapCount : ctaTapCount // ignore: cast_nullable_to_non_nullable
as int,semanticIntentCount: null == semanticIntentCount ? _self.semanticIntentCount : semanticIntentCount // ignore: cast_nullable_to_non_nullable
as int,totalInteractions: null == totalInteractions ? _self.totalInteractions : totalInteractions // ignore: cast_nullable_to_non_nullable
as int,uniqueSessionCount: null == uniqueSessionCount ? _self.uniqueSessionCount : uniqueSessionCount // ignore: cast_nullable_to_non_nullable
as int,engagementScore: null == engagementScore ? _self.engagementScore : engagementScore // ignore: cast_nullable_to_non_nullable
as double,lastInteractionAt: freezed == lastInteractionAt ? _self.lastInteractionAt : lastInteractionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastAggregatedAt: freezed == lastAggregatedAt ? _self.lastAggregatedAt : lastAggregatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,window: null == window ? _self.window : window // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
