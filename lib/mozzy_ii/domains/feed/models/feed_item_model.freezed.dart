// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedItemModel {

 String get id; String get sourceId; FeedItemType get type; String get title; String? get subtitle; String? get description; String? get imageUrl; String? get ownerId; String? get locationText; String get countryCode; LocationParts? get locationParts;@SafeDateTimeConverter() DateTime get createdAt;@OptionalSafeDateTimeConverter() DateTime? get updatedAt; bool get isPromoted;@OptionalSafeDateTimeConverter() DateTime? get boostActiveUntil;// Ranking Signals
 double get trustScore; double get freshnessScore; double get distanceScore; double get boostScore; double get engagementScore; double get semanticScore; String? get semanticReason;@OptionalSafeDateTimeConverter() DateTime? get semanticScoredAt; double get finalScore; String get route;
/// Create a copy of FeedItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemModelCopyWith<FeedItemModel> get copyWith => _$FeedItemModelCopyWithImpl<FeedItemModel>(this as FeedItemModel, _$identity);

  /// Serializes this FeedItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.locationText, locationText) || other.locationText == locationText)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.locationParts, locationParts) || other.locationParts == locationParts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.boostActiveUntil, boostActiveUntil) || other.boostActiveUntil == boostActiveUntil)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.freshnessScore, freshnessScore) || other.freshnessScore == freshnessScore)&&(identical(other.distanceScore, distanceScore) || other.distanceScore == distanceScore)&&(identical(other.boostScore, boostScore) || other.boostScore == boostScore)&&(identical(other.engagementScore, engagementScore) || other.engagementScore == engagementScore)&&(identical(other.semanticScore, semanticScore) || other.semanticScore == semanticScore)&&(identical(other.semanticReason, semanticReason) || other.semanticReason == semanticReason)&&(identical(other.semanticScoredAt, semanticScoredAt) || other.semanticScoredAt == semanticScoredAt)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.route, route) || other.route == route));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,sourceId,type,title,subtitle,description,imageUrl,ownerId,locationText,countryCode,locationParts,createdAt,updatedAt,isPromoted,boostActiveUntil,trustScore,freshnessScore,distanceScore,boostScore,engagementScore,semanticScore,semanticReason,semanticScoredAt,finalScore,route]);

@override
String toString() {
  return 'FeedItemModel(id: $id, sourceId: $sourceId, type: $type, title: $title, subtitle: $subtitle, description: $description, imageUrl: $imageUrl, ownerId: $ownerId, locationText: $locationText, countryCode: $countryCode, locationParts: $locationParts, createdAt: $createdAt, updatedAt: $updatedAt, isPromoted: $isPromoted, boostActiveUntil: $boostActiveUntil, trustScore: $trustScore, freshnessScore: $freshnessScore, distanceScore: $distanceScore, boostScore: $boostScore, engagementScore: $engagementScore, semanticScore: $semanticScore, semanticReason: $semanticReason, semanticScoredAt: $semanticScoredAt, finalScore: $finalScore, route: $route)';
}


}

/// @nodoc
abstract mixin class $FeedItemModelCopyWith<$Res>  {
  factory $FeedItemModelCopyWith(FeedItemModel value, $Res Function(FeedItemModel) _then) = _$FeedItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String sourceId, FeedItemType type, String title, String? subtitle, String? description, String? imageUrl, String? ownerId, String? locationText, String countryCode, LocationParts? locationParts,@SafeDateTimeConverter() DateTime createdAt,@OptionalSafeDateTimeConverter() DateTime? updatedAt, bool isPromoted,@OptionalSafeDateTimeConverter() DateTime? boostActiveUntil, double trustScore, double freshnessScore, double distanceScore, double boostScore, double engagementScore, double semanticScore, String? semanticReason,@OptionalSafeDateTimeConverter() DateTime? semanticScoredAt, double finalScore, String route
});




}
/// @nodoc
class _$FeedItemModelCopyWithImpl<$Res>
    implements $FeedItemModelCopyWith<$Res> {
  _$FeedItemModelCopyWithImpl(this._self, this._then);

  final FeedItemModel _self;
  final $Res Function(FeedItemModel) _then;

/// Create a copy of FeedItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sourceId = null,Object? type = null,Object? title = null,Object? subtitle = freezed,Object? description = freezed,Object? imageUrl = freezed,Object? ownerId = freezed,Object? locationText = freezed,Object? countryCode = null,Object? locationParts = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? isPromoted = null,Object? boostActiveUntil = freezed,Object? trustScore = null,Object? freshnessScore = null,Object? distanceScore = null,Object? boostScore = null,Object? engagementScore = null,Object? semanticScore = null,Object? semanticReason = freezed,Object? semanticScoredAt = freezed,Object? finalScore = null,Object? route = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FeedItemType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,locationText: freezed == locationText ? _self.locationText : locationText // ignore: cast_nullable_to_non_nullable
as String?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,locationParts: freezed == locationParts ? _self.locationParts : locationParts // ignore: cast_nullable_to_non_nullable
as LocationParts?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,boostActiveUntil: freezed == boostActiveUntil ? _self.boostActiveUntil : boostActiveUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,freshnessScore: null == freshnessScore ? _self.freshnessScore : freshnessScore // ignore: cast_nullable_to_non_nullable
as double,distanceScore: null == distanceScore ? _self.distanceScore : distanceScore // ignore: cast_nullable_to_non_nullable
as double,boostScore: null == boostScore ? _self.boostScore : boostScore // ignore: cast_nullable_to_non_nullable
as double,engagementScore: null == engagementScore ? _self.engagementScore : engagementScore // ignore: cast_nullable_to_non_nullable
as double,semanticScore: null == semanticScore ? _self.semanticScore : semanticScore // ignore: cast_nullable_to_non_nullable
as double,semanticReason: freezed == semanticReason ? _self.semanticReason : semanticReason // ignore: cast_nullable_to_non_nullable
as String?,semanticScoredAt: freezed == semanticScoredAt ? _self.semanticScoredAt : semanticScoredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as double,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedItemModel].
extension FeedItemModelPatterns on FeedItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedItemModel value)  $default,){
final _that = this;
switch (_that) {
case _FeedItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _FeedItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sourceId,  FeedItemType type,  String title,  String? subtitle,  String? description,  String? imageUrl,  String? ownerId,  String? locationText,  String countryCode,  LocationParts? locationParts, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isPromoted, @OptionalSafeDateTimeConverter()  DateTime? boostActiveUntil,  double trustScore,  double freshnessScore,  double distanceScore,  double boostScore,  double engagementScore,  double semanticScore,  String? semanticReason, @OptionalSafeDateTimeConverter()  DateTime? semanticScoredAt,  double finalScore,  String route)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedItemModel() when $default != null:
return $default(_that.id,_that.sourceId,_that.type,_that.title,_that.subtitle,_that.description,_that.imageUrl,_that.ownerId,_that.locationText,_that.countryCode,_that.locationParts,_that.createdAt,_that.updatedAt,_that.isPromoted,_that.boostActiveUntil,_that.trustScore,_that.freshnessScore,_that.distanceScore,_that.boostScore,_that.engagementScore,_that.semanticScore,_that.semanticReason,_that.semanticScoredAt,_that.finalScore,_that.route);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sourceId,  FeedItemType type,  String title,  String? subtitle,  String? description,  String? imageUrl,  String? ownerId,  String? locationText,  String countryCode,  LocationParts? locationParts, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isPromoted, @OptionalSafeDateTimeConverter()  DateTime? boostActiveUntil,  double trustScore,  double freshnessScore,  double distanceScore,  double boostScore,  double engagementScore,  double semanticScore,  String? semanticReason, @OptionalSafeDateTimeConverter()  DateTime? semanticScoredAt,  double finalScore,  String route)  $default,) {final _that = this;
switch (_that) {
case _FeedItemModel():
return $default(_that.id,_that.sourceId,_that.type,_that.title,_that.subtitle,_that.description,_that.imageUrl,_that.ownerId,_that.locationText,_that.countryCode,_that.locationParts,_that.createdAt,_that.updatedAt,_that.isPromoted,_that.boostActiveUntil,_that.trustScore,_that.freshnessScore,_that.distanceScore,_that.boostScore,_that.engagementScore,_that.semanticScore,_that.semanticReason,_that.semanticScoredAt,_that.finalScore,_that.route);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sourceId,  FeedItemType type,  String title,  String? subtitle,  String? description,  String? imageUrl,  String? ownerId,  String? locationText,  String countryCode,  LocationParts? locationParts, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isPromoted, @OptionalSafeDateTimeConverter()  DateTime? boostActiveUntil,  double trustScore,  double freshnessScore,  double distanceScore,  double boostScore,  double engagementScore,  double semanticScore,  String? semanticReason, @OptionalSafeDateTimeConverter()  DateTime? semanticScoredAt,  double finalScore,  String route)?  $default,) {final _that = this;
switch (_that) {
case _FeedItemModel() when $default != null:
return $default(_that.id,_that.sourceId,_that.type,_that.title,_that.subtitle,_that.description,_that.imageUrl,_that.ownerId,_that.locationText,_that.countryCode,_that.locationParts,_that.createdAt,_that.updatedAt,_that.isPromoted,_that.boostActiveUntil,_that.trustScore,_that.freshnessScore,_that.distanceScore,_that.boostScore,_that.engagementScore,_that.semanticScore,_that.semanticReason,_that.semanticScoredAt,_that.finalScore,_that.route);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedItemModel implements FeedItemModel {
  const _FeedItemModel({required this.id, required this.sourceId, required this.type, required this.title, this.subtitle, this.description, this.imageUrl, this.ownerId, this.locationText, this.countryCode = 'ID', this.locationParts, @SafeDateTimeConverter() required this.createdAt, @OptionalSafeDateTimeConverter() this.updatedAt, this.isPromoted = false, @OptionalSafeDateTimeConverter() this.boostActiveUntil, this.trustScore = 0.0, this.freshnessScore = 0.0, this.distanceScore = 0.0, this.boostScore = 0.0, this.engagementScore = 0.0, this.semanticScore = 0.0, this.semanticReason, @OptionalSafeDateTimeConverter() this.semanticScoredAt, this.finalScore = 0.0, required this.route});
  factory _FeedItemModel.fromJson(Map<String, dynamic> json) => _$FeedItemModelFromJson(json);

@override final  String id;
@override final  String sourceId;
@override final  FeedItemType type;
@override final  String title;
@override final  String? subtitle;
@override final  String? description;
@override final  String? imageUrl;
@override final  String? ownerId;
@override final  String? locationText;
@override@JsonKey() final  String countryCode;
@override final  LocationParts? locationParts;
@override@SafeDateTimeConverter() final  DateTime createdAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? updatedAt;
@override@JsonKey() final  bool isPromoted;
@override@OptionalSafeDateTimeConverter() final  DateTime? boostActiveUntil;
// Ranking Signals
@override@JsonKey() final  double trustScore;
@override@JsonKey() final  double freshnessScore;
@override@JsonKey() final  double distanceScore;
@override@JsonKey() final  double boostScore;
@override@JsonKey() final  double engagementScore;
@override@JsonKey() final  double semanticScore;
@override final  String? semanticReason;
@override@OptionalSafeDateTimeConverter() final  DateTime? semanticScoredAt;
@override@JsonKey() final  double finalScore;
@override final  String route;

/// Create a copy of FeedItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedItemModelCopyWith<_FeedItemModel> get copyWith => __$FeedItemModelCopyWithImpl<_FeedItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.locationText, locationText) || other.locationText == locationText)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.locationParts, locationParts) || other.locationParts == locationParts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.boostActiveUntil, boostActiveUntil) || other.boostActiveUntil == boostActiveUntil)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.freshnessScore, freshnessScore) || other.freshnessScore == freshnessScore)&&(identical(other.distanceScore, distanceScore) || other.distanceScore == distanceScore)&&(identical(other.boostScore, boostScore) || other.boostScore == boostScore)&&(identical(other.engagementScore, engagementScore) || other.engagementScore == engagementScore)&&(identical(other.semanticScore, semanticScore) || other.semanticScore == semanticScore)&&(identical(other.semanticReason, semanticReason) || other.semanticReason == semanticReason)&&(identical(other.semanticScoredAt, semanticScoredAt) || other.semanticScoredAt == semanticScoredAt)&&(identical(other.finalScore, finalScore) || other.finalScore == finalScore)&&(identical(other.route, route) || other.route == route));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,sourceId,type,title,subtitle,description,imageUrl,ownerId,locationText,countryCode,locationParts,createdAt,updatedAt,isPromoted,boostActiveUntil,trustScore,freshnessScore,distanceScore,boostScore,engagementScore,semanticScore,semanticReason,semanticScoredAt,finalScore,route]);

@override
String toString() {
  return 'FeedItemModel(id: $id, sourceId: $sourceId, type: $type, title: $title, subtitle: $subtitle, description: $description, imageUrl: $imageUrl, ownerId: $ownerId, locationText: $locationText, countryCode: $countryCode, locationParts: $locationParts, createdAt: $createdAt, updatedAt: $updatedAt, isPromoted: $isPromoted, boostActiveUntil: $boostActiveUntil, trustScore: $trustScore, freshnessScore: $freshnessScore, distanceScore: $distanceScore, boostScore: $boostScore, engagementScore: $engagementScore, semanticScore: $semanticScore, semanticReason: $semanticReason, semanticScoredAt: $semanticScoredAt, finalScore: $finalScore, route: $route)';
}


}

/// @nodoc
abstract mixin class _$FeedItemModelCopyWith<$Res> implements $FeedItemModelCopyWith<$Res> {
  factory _$FeedItemModelCopyWith(_FeedItemModel value, $Res Function(_FeedItemModel) _then) = __$FeedItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String sourceId, FeedItemType type, String title, String? subtitle, String? description, String? imageUrl, String? ownerId, String? locationText, String countryCode, LocationParts? locationParts,@SafeDateTimeConverter() DateTime createdAt,@OptionalSafeDateTimeConverter() DateTime? updatedAt, bool isPromoted,@OptionalSafeDateTimeConverter() DateTime? boostActiveUntil, double trustScore, double freshnessScore, double distanceScore, double boostScore, double engagementScore, double semanticScore, String? semanticReason,@OptionalSafeDateTimeConverter() DateTime? semanticScoredAt, double finalScore, String route
});




}
/// @nodoc
class __$FeedItemModelCopyWithImpl<$Res>
    implements _$FeedItemModelCopyWith<$Res> {
  __$FeedItemModelCopyWithImpl(this._self, this._then);

  final _FeedItemModel _self;
  final $Res Function(_FeedItemModel) _then;

/// Create a copy of FeedItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sourceId = null,Object? type = null,Object? title = null,Object? subtitle = freezed,Object? description = freezed,Object? imageUrl = freezed,Object? ownerId = freezed,Object? locationText = freezed,Object? countryCode = null,Object? locationParts = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? isPromoted = null,Object? boostActiveUntil = freezed,Object? trustScore = null,Object? freshnessScore = null,Object? distanceScore = null,Object? boostScore = null,Object? engagementScore = null,Object? semanticScore = null,Object? semanticReason = freezed,Object? semanticScoredAt = freezed,Object? finalScore = null,Object? route = null,}) {
  return _then(_FeedItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FeedItemType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,locationText: freezed == locationText ? _self.locationText : locationText // ignore: cast_nullable_to_non_nullable
as String?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,locationParts: freezed == locationParts ? _self.locationParts : locationParts // ignore: cast_nullable_to_non_nullable
as LocationParts?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,boostActiveUntil: freezed == boostActiveUntil ? _self.boostActiveUntil : boostActiveUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,freshnessScore: null == freshnessScore ? _self.freshnessScore : freshnessScore // ignore: cast_nullable_to_non_nullable
as double,distanceScore: null == distanceScore ? _self.distanceScore : distanceScore // ignore: cast_nullable_to_non_nullable
as double,boostScore: null == boostScore ? _self.boostScore : boostScore // ignore: cast_nullable_to_non_nullable
as double,engagementScore: null == engagementScore ? _self.engagementScore : engagementScore // ignore: cast_nullable_to_non_nullable
as double,semanticScore: null == semanticScore ? _self.semanticScore : semanticScore // ignore: cast_nullable_to_non_nullable
as double,semanticReason: freezed == semanticReason ? _self.semanticReason : semanticReason // ignore: cast_nullable_to_non_nullable
as String?,semanticScoredAt: freezed == semanticScoredAt ? _self.semanticScoredAt : semanticScoredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finalScore: null == finalScore ? _self.finalScore : finalScore // ignore: cast_nullable_to_non_nullable
as double,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
