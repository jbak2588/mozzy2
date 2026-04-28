// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostModel {

 String get id; String get userId; String get title; String get content; List<String> get imageUrls; String get category;// Umum, Info, Event, Darurat, Kuliner, Tips Hidup
// MozzyPostContract 구현 필드
 GeoScope get geoScope; ReachMode get reachMode; Map<String, String> get translationState; double get trustScore; double get signalScore; String get geoPath;// 위치 상세 (Track 1)
 LocationParts get location;// Country code redundancy for queries (ISO alpha-2)
 String get countryCode;// Soft-delete flag and moderation counters
 bool get isDeleted; int get reportCount;// Visibility and discovery
 bool get mapVisibility; List<String> get discoveryChannels; List<String> get relayTargets; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostModelCopyWith<PostModel> get copyWith => _$PostModelCopyWithImpl<PostModel>(this as PostModel, _$identity);

  /// Serializes this PostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.category, category) || other.category == category)&&(identical(other.geoScope, geoScope) || other.geoScope == geoScope)&&(identical(other.reachMode, reachMode) || other.reachMode == reachMode)&&const DeepCollectionEquality().equals(other.translationState, translationState)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.signalScore, signalScore) || other.signalScore == signalScore)&&(identical(other.geoPath, geoPath) || other.geoPath == geoPath)&&(identical(other.location, location) || other.location == location)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.mapVisibility, mapVisibility) || other.mapVisibility == mapVisibility)&&const DeepCollectionEquality().equals(other.discoveryChannels, discoveryChannels)&&const DeepCollectionEquality().equals(other.relayTargets, relayTargets)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,title,content,const DeepCollectionEquality().hash(imageUrls),category,geoScope,reachMode,const DeepCollectionEquality().hash(translationState),trustScore,signalScore,geoPath,location,countryCode,isDeleted,reportCount,mapVisibility,const DeepCollectionEquality().hash(discoveryChannels),const DeepCollectionEquality().hash(relayTargets),createdAt,updatedAt]);

@override
String toString() {
  return 'PostModel(id: $id, userId: $userId, title: $title, content: $content, imageUrls: $imageUrls, category: $category, geoScope: $geoScope, reachMode: $reachMode, translationState: $translationState, trustScore: $trustScore, signalScore: $signalScore, geoPath: $geoPath, location: $location, countryCode: $countryCode, isDeleted: $isDeleted, reportCount: $reportCount, mapVisibility: $mapVisibility, discoveryChannels: $discoveryChannels, relayTargets: $relayTargets, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PostModelCopyWith<$Res>  {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) _then) = _$PostModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String title, String content, List<String> imageUrls, String category, GeoScope geoScope, ReachMode reachMode, Map<String, String> translationState, double trustScore, double signalScore, String geoPath, LocationParts location, String countryCode, bool isDeleted, int reportCount, bool mapVisibility, List<String> discoveryChannels, List<String> relayTargets, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$PostModelCopyWithImpl<$Res>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._self, this._then);

  final PostModel _self;
  final $Res Function(PostModel) _then;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? content = null,Object? imageUrls = null,Object? category = null,Object? geoScope = null,Object? reachMode = null,Object? translationState = null,Object? trustScore = null,Object? signalScore = null,Object? geoPath = null,Object? location = null,Object? countryCode = null,Object? isDeleted = null,Object? reportCount = null,Object? mapVisibility = null,Object? discoveryChannels = null,Object? relayTargets = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,geoScope: null == geoScope ? _self.geoScope : geoScope // ignore: cast_nullable_to_non_nullable
as GeoScope,reachMode: null == reachMode ? _self.reachMode : reachMode // ignore: cast_nullable_to_non_nullable
as ReachMode,translationState: null == translationState ? _self.translationState : translationState // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,signalScore: null == signalScore ? _self.signalScore : signalScore // ignore: cast_nullable_to_non_nullable
as double,geoPath: null == geoPath ? _self.geoPath : geoPath // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationParts,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,mapVisibility: null == mapVisibility ? _self.mapVisibility : mapVisibility // ignore: cast_nullable_to_non_nullable
as bool,discoveryChannels: null == discoveryChannels ? _self.discoveryChannels : discoveryChannels // ignore: cast_nullable_to_non_nullable
as List<String>,relayTargets: null == relayTargets ? _self.relayTargets : relayTargets // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostModel].
extension PostModelPatterns on PostModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostModel value)  $default,){
final _that = this;
switch (_that) {
case _PostModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String content,  List<String> imageUrls,  String category,  GeoScope geoScope,  ReachMode reachMode,  Map<String, String> translationState,  double trustScore,  double signalScore,  String geoPath,  LocationParts location,  String countryCode,  bool isDeleted,  int reportCount,  bool mapVisibility,  List<String> discoveryChannels,  List<String> relayTargets,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostModel() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.content,_that.imageUrls,_that.category,_that.geoScope,_that.reachMode,_that.translationState,_that.trustScore,_that.signalScore,_that.geoPath,_that.location,_that.countryCode,_that.isDeleted,_that.reportCount,_that.mapVisibility,_that.discoveryChannels,_that.relayTargets,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String content,  List<String> imageUrls,  String category,  GeoScope geoScope,  ReachMode reachMode,  Map<String, String> translationState,  double trustScore,  double signalScore,  String geoPath,  LocationParts location,  String countryCode,  bool isDeleted,  int reportCount,  bool mapVisibility,  List<String> discoveryChannels,  List<String> relayTargets,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PostModel():
return $default(_that.id,_that.userId,_that.title,_that.content,_that.imageUrls,_that.category,_that.geoScope,_that.reachMode,_that.translationState,_that.trustScore,_that.signalScore,_that.geoPath,_that.location,_that.countryCode,_that.isDeleted,_that.reportCount,_that.mapVisibility,_that.discoveryChannels,_that.relayTargets,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String title,  String content,  List<String> imageUrls,  String category,  GeoScope geoScope,  ReachMode reachMode,  Map<String, String> translationState,  double trustScore,  double signalScore,  String geoPath,  LocationParts location,  String countryCode,  bool isDeleted,  int reportCount,  bool mapVisibility,  List<String> discoveryChannels,  List<String> relayTargets,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PostModel() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.content,_that.imageUrls,_that.category,_that.geoScope,_that.reachMode,_that.translationState,_that.trustScore,_that.signalScore,_that.geoPath,_that.location,_that.countryCode,_that.isDeleted,_that.reportCount,_that.mapVisibility,_that.discoveryChannels,_that.relayTargets,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PostModel extends PostModel implements MozzyPostContract {
  const _PostModel({required this.id, required this.userId, required this.title, required this.content, final  List<String> imageUrls = const [], required this.category, this.geoScope = GeoScope.neighborhood, this.reachMode = ReachMode.localOnly, final  Map<String, String> translationState = const {}, this.trustScore = 0.0, this.signalScore = 0.0, required this.geoPath, required this.location, this.countryCode = 'ID', this.isDeleted = false, this.reportCount = 0, this.mapVisibility = true, final  List<String> discoveryChannels = const <String>[], final  List<String> relayTargets = const <String>[], required this.createdAt, this.updatedAt}): _imageUrls = imageUrls,_translationState = translationState,_discoveryChannels = discoveryChannels,_relayTargets = relayTargets,super._();
  factory _PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String title;
@override final  String content;
 final  List<String> _imageUrls;
@override@JsonKey() List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override final  String category;
// Umum, Info, Event, Darurat, Kuliner, Tips Hidup
// MozzyPostContract 구현 필드
@override@JsonKey() final  GeoScope geoScope;
@override@JsonKey() final  ReachMode reachMode;
 final  Map<String, String> _translationState;
@override@JsonKey() Map<String, String> get translationState {
  if (_translationState is EqualUnmodifiableMapView) return _translationState;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_translationState);
}

@override@JsonKey() final  double trustScore;
@override@JsonKey() final  double signalScore;
@override final  String geoPath;
// 위치 상세 (Track 1)
@override final  LocationParts location;
// Country code redundancy for queries (ISO alpha-2)
@override@JsonKey() final  String countryCode;
// Soft-delete flag and moderation counters
@override@JsonKey() final  bool isDeleted;
@override@JsonKey() final  int reportCount;
// Visibility and discovery
@override@JsonKey() final  bool mapVisibility;
 final  List<String> _discoveryChannels;
@override@JsonKey() List<String> get discoveryChannels {
  if (_discoveryChannels is EqualUnmodifiableListView) return _discoveryChannels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discoveryChannels);
}

 final  List<String> _relayTargets;
@override@JsonKey() List<String> get relayTargets {
  if (_relayTargets is EqualUnmodifiableListView) return _relayTargets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relayTargets);
}

@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostModelCopyWith<_PostModel> get copyWith => __$PostModelCopyWithImpl<_PostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.category, category) || other.category == category)&&(identical(other.geoScope, geoScope) || other.geoScope == geoScope)&&(identical(other.reachMode, reachMode) || other.reachMode == reachMode)&&const DeepCollectionEquality().equals(other._translationState, _translationState)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.signalScore, signalScore) || other.signalScore == signalScore)&&(identical(other.geoPath, geoPath) || other.geoPath == geoPath)&&(identical(other.location, location) || other.location == location)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.mapVisibility, mapVisibility) || other.mapVisibility == mapVisibility)&&const DeepCollectionEquality().equals(other._discoveryChannels, _discoveryChannels)&&const DeepCollectionEquality().equals(other._relayTargets, _relayTargets)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,title,content,const DeepCollectionEquality().hash(_imageUrls),category,geoScope,reachMode,const DeepCollectionEquality().hash(_translationState),trustScore,signalScore,geoPath,location,countryCode,isDeleted,reportCount,mapVisibility,const DeepCollectionEquality().hash(_discoveryChannels),const DeepCollectionEquality().hash(_relayTargets),createdAt,updatedAt]);

@override
String toString() {
  return 'PostModel(id: $id, userId: $userId, title: $title, content: $content, imageUrls: $imageUrls, category: $category, geoScope: $geoScope, reachMode: $reachMode, translationState: $translationState, trustScore: $trustScore, signalScore: $signalScore, geoPath: $geoPath, location: $location, countryCode: $countryCode, isDeleted: $isDeleted, reportCount: $reportCount, mapVisibility: $mapVisibility, discoveryChannels: $discoveryChannels, relayTargets: $relayTargets, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PostModelCopyWith<$Res> implements $PostModelCopyWith<$Res> {
  factory _$PostModelCopyWith(_PostModel value, $Res Function(_PostModel) _then) = __$PostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String title, String content, List<String> imageUrls, String category, GeoScope geoScope, ReachMode reachMode, Map<String, String> translationState, double trustScore, double signalScore, String geoPath, LocationParts location, String countryCode, bool isDeleted, int reportCount, bool mapVisibility, List<String> discoveryChannels, List<String> relayTargets, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$PostModelCopyWithImpl<$Res>
    implements _$PostModelCopyWith<$Res> {
  __$PostModelCopyWithImpl(this._self, this._then);

  final _PostModel _self;
  final $Res Function(_PostModel) _then;

/// Create a copy of PostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? content = null,Object? imageUrls = null,Object? category = null,Object? geoScope = null,Object? reachMode = null,Object? translationState = null,Object? trustScore = null,Object? signalScore = null,Object? geoPath = null,Object? location = null,Object? countryCode = null,Object? isDeleted = null,Object? reportCount = null,Object? mapVisibility = null,Object? discoveryChannels = null,Object? relayTargets = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_PostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,geoScope: null == geoScope ? _self.geoScope : geoScope // ignore: cast_nullable_to_non_nullable
as GeoScope,reachMode: null == reachMode ? _self.reachMode : reachMode // ignore: cast_nullable_to_non_nullable
as ReachMode,translationState: null == translationState ? _self._translationState : translationState // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,signalScore: null == signalScore ? _self.signalScore : signalScore // ignore: cast_nullable_to_non_nullable
as double,geoPath: null == geoPath ? _self.geoPath : geoPath // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationParts,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,mapVisibility: null == mapVisibility ? _self.mapVisibility : mapVisibility // ignore: cast_nullable_to_non_nullable
as bool,discoveryChannels: null == discoveryChannels ? _self._discoveryChannels : discoveryChannels // ignore: cast_nullable_to_non_nullable
as List<String>,relayTargets: null == relayTargets ? _self._relayTargets : relayTargets // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
