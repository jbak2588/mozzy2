// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

 String get id;@JsonKey(name: 'sellerId') String get userId;// MozzyPostContract uses userId
 String get title; String get description; String get category; int get price; String get currencyCode; List<String> get imageUrls;// MozzyPostContract 구현 필드
 GeoScope get geoScope; ReachMode get reachMode; Map<String, String> get translationState; double get trustScore; double get signalScore; String get geoPath;// 위치 상세
 LocationParts? get locationParts; String get countryCode; bool get isAiVerified; String get aiVerificationStatus;@SafeDateTimeConverter() DateTime get createdAt;@OptionalSafeDateTimeConverter() DateTime? get updatedAt; bool get isDeleted; int get viewsCount; int get likesCount; int get chatsCount;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.geoScope, geoScope) || other.geoScope == geoScope)&&(identical(other.reachMode, reachMode) || other.reachMode == reachMode)&&const DeepCollectionEquality().equals(other.translationState, translationState)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.signalScore, signalScore) || other.signalScore == signalScore)&&(identical(other.geoPath, geoPath) || other.geoPath == geoPath)&&(identical(other.locationParts, locationParts) || other.locationParts == locationParts)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.isAiVerified, isAiVerified) || other.isAiVerified == isAiVerified)&&(identical(other.aiVerificationStatus, aiVerificationStatus) || other.aiVerificationStatus == aiVerificationStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.viewsCount, viewsCount) || other.viewsCount == viewsCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.chatsCount, chatsCount) || other.chatsCount == chatsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,title,description,category,price,currencyCode,const DeepCollectionEquality().hash(imageUrls),geoScope,reachMode,const DeepCollectionEquality().hash(translationState),trustScore,signalScore,geoPath,locationParts,countryCode,isAiVerified,aiVerificationStatus,createdAt,updatedAt,isDeleted,viewsCount,likesCount,chatsCount]);

@override
String toString() {
  return 'ProductModel(id: $id, userId: $userId, title: $title, description: $description, category: $category, price: $price, currencyCode: $currencyCode, imageUrls: $imageUrls, geoScope: $geoScope, reachMode: $reachMode, translationState: $translationState, trustScore: $trustScore, signalScore: $signalScore, geoPath: $geoPath, locationParts: $locationParts, countryCode: $countryCode, isAiVerified: $isAiVerified, aiVerificationStatus: $aiVerificationStatus, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, viewsCount: $viewsCount, likesCount: $likesCount, chatsCount: $chatsCount)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'sellerId') String userId, String title, String description, String category, int price, String currencyCode, List<String> imageUrls, GeoScope geoScope, ReachMode reachMode, Map<String, String> translationState, double trustScore, double signalScore, String geoPath, LocationParts? locationParts, String countryCode, bool isAiVerified, String aiVerificationStatus,@SafeDateTimeConverter() DateTime createdAt,@OptionalSafeDateTimeConverter() DateTime? updatedAt, bool isDeleted, int viewsCount, int likesCount, int chatsCount
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? currencyCode = null,Object? imageUrls = null,Object? geoScope = null,Object? reachMode = null,Object? translationState = null,Object? trustScore = null,Object? signalScore = null,Object? geoPath = null,Object? locationParts = freezed,Object? countryCode = null,Object? isAiVerified = null,Object? aiVerificationStatus = null,Object? createdAt = null,Object? updatedAt = freezed,Object? isDeleted = null,Object? viewsCount = null,Object? likesCount = null,Object? chatsCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,geoScope: null == geoScope ? _self.geoScope : geoScope // ignore: cast_nullable_to_non_nullable
as GeoScope,reachMode: null == reachMode ? _self.reachMode : reachMode // ignore: cast_nullable_to_non_nullable
as ReachMode,translationState: null == translationState ? _self.translationState : translationState // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,signalScore: null == signalScore ? _self.signalScore : signalScore // ignore: cast_nullable_to_non_nullable
as double,geoPath: null == geoPath ? _self.geoPath : geoPath // ignore: cast_nullable_to_non_nullable
as String,locationParts: freezed == locationParts ? _self.locationParts : locationParts // ignore: cast_nullable_to_non_nullable
as LocationParts?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,isAiVerified: null == isAiVerified ? _self.isAiVerified : isAiVerified // ignore: cast_nullable_to_non_nullable
as bool,aiVerificationStatus: null == aiVerificationStatus ? _self.aiVerificationStatus : aiVerificationStatus // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,viewsCount: null == viewsCount ? _self.viewsCount : viewsCount // ignore: cast_nullable_to_non_nullable
as int,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,chatsCount: null == chatsCount ? _self.chatsCount : chatsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'sellerId')  String userId,  String title,  String description,  String category,  int price,  String currencyCode,  List<String> imageUrls,  GeoScope geoScope,  ReachMode reachMode,  Map<String, String> translationState,  double trustScore,  double signalScore,  String geoPath,  LocationParts? locationParts,  String countryCode,  bool isAiVerified,  String aiVerificationStatus, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isDeleted,  int viewsCount,  int likesCount,  int chatsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.description,_that.category,_that.price,_that.currencyCode,_that.imageUrls,_that.geoScope,_that.reachMode,_that.translationState,_that.trustScore,_that.signalScore,_that.geoPath,_that.locationParts,_that.countryCode,_that.isAiVerified,_that.aiVerificationStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.viewsCount,_that.likesCount,_that.chatsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'sellerId')  String userId,  String title,  String description,  String category,  int price,  String currencyCode,  List<String> imageUrls,  GeoScope geoScope,  ReachMode reachMode,  Map<String, String> translationState,  double trustScore,  double signalScore,  String geoPath,  LocationParts? locationParts,  String countryCode,  bool isAiVerified,  String aiVerificationStatus, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isDeleted,  int viewsCount,  int likesCount,  int chatsCount)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.id,_that.userId,_that.title,_that.description,_that.category,_that.price,_that.currencyCode,_that.imageUrls,_that.geoScope,_that.reachMode,_that.translationState,_that.trustScore,_that.signalScore,_that.geoPath,_that.locationParts,_that.countryCode,_that.isAiVerified,_that.aiVerificationStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.viewsCount,_that.likesCount,_that.chatsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'sellerId')  String userId,  String title,  String description,  String category,  int price,  String currencyCode,  List<String> imageUrls,  GeoScope geoScope,  ReachMode reachMode,  Map<String, String> translationState,  double trustScore,  double signalScore,  String geoPath,  LocationParts? locationParts,  String countryCode,  bool isAiVerified,  String aiVerificationStatus, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isDeleted,  int viewsCount,  int likesCount,  int chatsCount)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.description,_that.category,_that.price,_that.currencyCode,_that.imageUrls,_that.geoScope,_that.reachMode,_that.translationState,_that.trustScore,_that.signalScore,_that.geoPath,_that.locationParts,_that.countryCode,_that.isAiVerified,_that.aiVerificationStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.viewsCount,_that.likesCount,_that.chatsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({required this.id, @JsonKey(name: 'sellerId') required this.userId, required this.title, required this.description, required this.category, required this.price, this.currencyCode = 'IDR', final  List<String> imageUrls = const [], this.geoScope = GeoScope.neighborhood, this.reachMode = ReachMode.localOnly, final  Map<String, String> translationState = const {}, this.trustScore = 0.3, this.signalScore = 0.0, required this.geoPath, this.locationParts, this.countryCode = 'ID', this.isAiVerified = false, this.aiVerificationStatus = 'not_requested', @SafeDateTimeConverter() required this.createdAt, @OptionalSafeDateTimeConverter() this.updatedAt, this.isDeleted = false, this.viewsCount = 0, this.likesCount = 0, this.chatsCount = 0}): _imageUrls = imageUrls,_translationState = translationState,super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'sellerId') final  String userId;
// MozzyPostContract uses userId
@override final  String title;
@override final  String description;
@override final  String category;
@override final  int price;
@override@JsonKey() final  String currencyCode;
 final  List<String> _imageUrls;
@override@JsonKey() List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

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
// 위치 상세
@override final  LocationParts? locationParts;
@override@JsonKey() final  String countryCode;
@override@JsonKey() final  bool isAiVerified;
@override@JsonKey() final  String aiVerificationStatus;
@override@SafeDateTimeConverter() final  DateTime createdAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? updatedAt;
@override@JsonKey() final  bool isDeleted;
@override@JsonKey() final  int viewsCount;
@override@JsonKey() final  int likesCount;
@override@JsonKey() final  int chatsCount;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.geoScope, geoScope) || other.geoScope == geoScope)&&(identical(other.reachMode, reachMode) || other.reachMode == reachMode)&&const DeepCollectionEquality().equals(other._translationState, _translationState)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.signalScore, signalScore) || other.signalScore == signalScore)&&(identical(other.geoPath, geoPath) || other.geoPath == geoPath)&&(identical(other.locationParts, locationParts) || other.locationParts == locationParts)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.isAiVerified, isAiVerified) || other.isAiVerified == isAiVerified)&&(identical(other.aiVerificationStatus, aiVerificationStatus) || other.aiVerificationStatus == aiVerificationStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.viewsCount, viewsCount) || other.viewsCount == viewsCount)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.chatsCount, chatsCount) || other.chatsCount == chatsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,title,description,category,price,currencyCode,const DeepCollectionEquality().hash(_imageUrls),geoScope,reachMode,const DeepCollectionEquality().hash(_translationState),trustScore,signalScore,geoPath,locationParts,countryCode,isAiVerified,aiVerificationStatus,createdAt,updatedAt,isDeleted,viewsCount,likesCount,chatsCount]);

@override
String toString() {
  return 'ProductModel(id: $id, userId: $userId, title: $title, description: $description, category: $category, price: $price, currencyCode: $currencyCode, imageUrls: $imageUrls, geoScope: $geoScope, reachMode: $reachMode, translationState: $translationState, trustScore: $trustScore, signalScore: $signalScore, geoPath: $geoPath, locationParts: $locationParts, countryCode: $countryCode, isAiVerified: $isAiVerified, aiVerificationStatus: $aiVerificationStatus, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, viewsCount: $viewsCount, likesCount: $likesCount, chatsCount: $chatsCount)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'sellerId') String userId, String title, String description, String category, int price, String currencyCode, List<String> imageUrls, GeoScope geoScope, ReachMode reachMode, Map<String, String> translationState, double trustScore, double signalScore, String geoPath, LocationParts? locationParts, String countryCode, bool isAiVerified, String aiVerificationStatus,@SafeDateTimeConverter() DateTime createdAt,@OptionalSafeDateTimeConverter() DateTime? updatedAt, bool isDeleted, int viewsCount, int likesCount, int chatsCount
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? currencyCode = null,Object? imageUrls = null,Object? geoScope = null,Object? reachMode = null,Object? translationState = null,Object? trustScore = null,Object? signalScore = null,Object? geoPath = null,Object? locationParts = freezed,Object? countryCode = null,Object? isAiVerified = null,Object? aiVerificationStatus = null,Object? createdAt = null,Object? updatedAt = freezed,Object? isDeleted = null,Object? viewsCount = null,Object? likesCount = null,Object? chatsCount = null,}) {
  return _then(_ProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,geoScope: null == geoScope ? _self.geoScope : geoScope // ignore: cast_nullable_to_non_nullable
as GeoScope,reachMode: null == reachMode ? _self.reachMode : reachMode // ignore: cast_nullable_to_non_nullable
as ReachMode,translationState: null == translationState ? _self._translationState : translationState // ignore: cast_nullable_to_non_nullable
as Map<String, String>,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,signalScore: null == signalScore ? _self.signalScore : signalScore // ignore: cast_nullable_to_non_nullable
as double,geoPath: null == geoPath ? _self.geoPath : geoPath // ignore: cast_nullable_to_non_nullable
as String,locationParts: freezed == locationParts ? _self.locationParts : locationParts // ignore: cast_nullable_to_non_nullable
as LocationParts?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,isAiVerified: null == isAiVerified ? _self.isAiVerified : isAiVerified // ignore: cast_nullable_to_non_nullable
as bool,aiVerificationStatus: null == aiVerificationStatus ? _self.aiVerificationStatus : aiVerificationStatus // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,viewsCount: null == viewsCount ? _self.viewsCount : viewsCount // ignore: cast_nullable_to_non_nullable
as int,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,chatsCount: null == chatsCount ? _self.chatsCount : chatsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
