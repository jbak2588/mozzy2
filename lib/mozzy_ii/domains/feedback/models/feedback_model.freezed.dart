// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedbackModel {

 String get id; String get userId; FeedbackType get type; String get message; FeedbackContactPreference get contactPreference; String? get contactValue; String get appVersion; String get platform; String get appEnv; FeedbackStatus get status; FeedbackPriority get priority;@SafeDateTimeConverter() DateTime get createdAt;@SafeDateTimeConverter() DateTime get updatedAt; String? get adminNote; String? get resolvedBy;@OptionalSafeDateTimeConverter() DateTime? get resolvedAt;
/// Create a copy of FeedbackModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackModelCopyWith<FeedbackModel> get copyWith => _$FeedbackModelCopyWithImpl<FeedbackModel>(this as FeedbackModel, _$identity);

  /// Serializes this FeedbackModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.contactPreference, contactPreference) || other.contactPreference == contactPreference)&&(identical(other.contactValue, contactValue) || other.contactValue == contactValue)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.appEnv, appEnv) || other.appEnv == appEnv)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.adminNote, adminNote) || other.adminNote == adminNote)&&(identical(other.resolvedBy, resolvedBy) || other.resolvedBy == resolvedBy)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,message,contactPreference,contactValue,appVersion,platform,appEnv,status,priority,createdAt,updatedAt,adminNote,resolvedBy,resolvedAt);

@override
String toString() {
  return 'FeedbackModel(id: $id, userId: $userId, type: $type, message: $message, contactPreference: $contactPreference, contactValue: $contactValue, appVersion: $appVersion, platform: $platform, appEnv: $appEnv, status: $status, priority: $priority, createdAt: $createdAt, updatedAt: $updatedAt, adminNote: $adminNote, resolvedBy: $resolvedBy, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $FeedbackModelCopyWith<$Res>  {
  factory $FeedbackModelCopyWith(FeedbackModel value, $Res Function(FeedbackModel) _then) = _$FeedbackModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, FeedbackType type, String message, FeedbackContactPreference contactPreference, String? contactValue, String appVersion, String platform, String appEnv, FeedbackStatus status, FeedbackPriority priority,@SafeDateTimeConverter() DateTime createdAt,@SafeDateTimeConverter() DateTime updatedAt, String? adminNote, String? resolvedBy,@OptionalSafeDateTimeConverter() DateTime? resolvedAt
});




}
/// @nodoc
class _$FeedbackModelCopyWithImpl<$Res>
    implements $FeedbackModelCopyWith<$Res> {
  _$FeedbackModelCopyWithImpl(this._self, this._then);

  final FeedbackModel _self;
  final $Res Function(FeedbackModel) _then;

/// Create a copy of FeedbackModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? message = null,Object? contactPreference = null,Object? contactValue = freezed,Object? appVersion = null,Object? platform = null,Object? appEnv = null,Object? status = null,Object? priority = null,Object? createdAt = null,Object? updatedAt = null,Object? adminNote = freezed,Object? resolvedBy = freezed,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FeedbackType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,contactPreference: null == contactPreference ? _self.contactPreference : contactPreference // ignore: cast_nullable_to_non_nullable
as FeedbackContactPreference,contactValue: freezed == contactValue ? _self.contactValue : contactValue // ignore: cast_nullable_to_non_nullable
as String?,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,appEnv: null == appEnv ? _self.appEnv : appEnv // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FeedbackStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as FeedbackPriority,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,adminNote: freezed == adminNote ? _self.adminNote : adminNote // ignore: cast_nullable_to_non_nullable
as String?,resolvedBy: freezed == resolvedBy ? _self.resolvedBy : resolvedBy // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackModel].
extension FeedbackModelPatterns on FeedbackModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackModel value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackModel value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  FeedbackType type,  String message,  FeedbackContactPreference contactPreference,  String? contactValue,  String appVersion,  String platform,  String appEnv,  FeedbackStatus status,  FeedbackPriority priority, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt,  String? adminNote,  String? resolvedBy, @OptionalSafeDateTimeConverter()  DateTime? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackModel() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.message,_that.contactPreference,_that.contactValue,_that.appVersion,_that.platform,_that.appEnv,_that.status,_that.priority,_that.createdAt,_that.updatedAt,_that.adminNote,_that.resolvedBy,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  FeedbackType type,  String message,  FeedbackContactPreference contactPreference,  String? contactValue,  String appVersion,  String platform,  String appEnv,  FeedbackStatus status,  FeedbackPriority priority, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt,  String? adminNote,  String? resolvedBy, @OptionalSafeDateTimeConverter()  DateTime? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _FeedbackModel():
return $default(_that.id,_that.userId,_that.type,_that.message,_that.contactPreference,_that.contactValue,_that.appVersion,_that.platform,_that.appEnv,_that.status,_that.priority,_that.createdAt,_that.updatedAt,_that.adminNote,_that.resolvedBy,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  FeedbackType type,  String message,  FeedbackContactPreference contactPreference,  String? contactValue,  String appVersion,  String platform,  String appEnv,  FeedbackStatus status,  FeedbackPriority priority, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt,  String? adminNote,  String? resolvedBy, @OptionalSafeDateTimeConverter()  DateTime? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackModel() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.message,_that.contactPreference,_that.contactValue,_that.appVersion,_that.platform,_that.appEnv,_that.status,_that.priority,_that.createdAt,_that.updatedAt,_that.adminNote,_that.resolvedBy,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedbackModel implements FeedbackModel {
  const _FeedbackModel({required this.id, required this.userId, required this.type, required this.message, this.contactPreference = FeedbackContactPreference.none, this.contactValue, required this.appVersion, required this.platform, required this.appEnv, this.status = FeedbackStatus.open, this.priority = FeedbackPriority.low, @SafeDateTimeConverter() required this.createdAt, @SafeDateTimeConverter() required this.updatedAt, this.adminNote, this.resolvedBy, @OptionalSafeDateTimeConverter() this.resolvedAt});
  factory _FeedbackModel.fromJson(Map<String, dynamic> json) => _$FeedbackModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  FeedbackType type;
@override final  String message;
@override@JsonKey() final  FeedbackContactPreference contactPreference;
@override final  String? contactValue;
@override final  String appVersion;
@override final  String platform;
@override final  String appEnv;
@override@JsonKey() final  FeedbackStatus status;
@override@JsonKey() final  FeedbackPriority priority;
@override@SafeDateTimeConverter() final  DateTime createdAt;
@override@SafeDateTimeConverter() final  DateTime updatedAt;
@override final  String? adminNote;
@override final  String? resolvedBy;
@override@OptionalSafeDateTimeConverter() final  DateTime? resolvedAt;

/// Create a copy of FeedbackModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackModelCopyWith<_FeedbackModel> get copyWith => __$FeedbackModelCopyWithImpl<_FeedbackModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedbackModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.contactPreference, contactPreference) || other.contactPreference == contactPreference)&&(identical(other.contactValue, contactValue) || other.contactValue == contactValue)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.appEnv, appEnv) || other.appEnv == appEnv)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.adminNote, adminNote) || other.adminNote == adminNote)&&(identical(other.resolvedBy, resolvedBy) || other.resolvedBy == resolvedBy)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,message,contactPreference,contactValue,appVersion,platform,appEnv,status,priority,createdAt,updatedAt,adminNote,resolvedBy,resolvedAt);

@override
String toString() {
  return 'FeedbackModel(id: $id, userId: $userId, type: $type, message: $message, contactPreference: $contactPreference, contactValue: $contactValue, appVersion: $appVersion, platform: $platform, appEnv: $appEnv, status: $status, priority: $priority, createdAt: $createdAt, updatedAt: $updatedAt, adminNote: $adminNote, resolvedBy: $resolvedBy, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$FeedbackModelCopyWith<$Res> implements $FeedbackModelCopyWith<$Res> {
  factory _$FeedbackModelCopyWith(_FeedbackModel value, $Res Function(_FeedbackModel) _then) = __$FeedbackModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, FeedbackType type, String message, FeedbackContactPreference contactPreference, String? contactValue, String appVersion, String platform, String appEnv, FeedbackStatus status, FeedbackPriority priority,@SafeDateTimeConverter() DateTime createdAt,@SafeDateTimeConverter() DateTime updatedAt, String? adminNote, String? resolvedBy,@OptionalSafeDateTimeConverter() DateTime? resolvedAt
});




}
/// @nodoc
class __$FeedbackModelCopyWithImpl<$Res>
    implements _$FeedbackModelCopyWith<$Res> {
  __$FeedbackModelCopyWithImpl(this._self, this._then);

  final _FeedbackModel _self;
  final $Res Function(_FeedbackModel) _then;

/// Create a copy of FeedbackModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? message = null,Object? contactPreference = null,Object? contactValue = freezed,Object? appVersion = null,Object? platform = null,Object? appEnv = null,Object? status = null,Object? priority = null,Object? createdAt = null,Object? updatedAt = null,Object? adminNote = freezed,Object? resolvedBy = freezed,Object? resolvedAt = freezed,}) {
  return _then(_FeedbackModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FeedbackType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,contactPreference: null == contactPreference ? _self.contactPreference : contactPreference // ignore: cast_nullable_to_non_nullable
as FeedbackContactPreference,contactValue: freezed == contactValue ? _self.contactValue : contactValue // ignore: cast_nullable_to_non_nullable
as String?,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,appEnv: null == appEnv ? _self.appEnv : appEnv // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FeedbackStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as FeedbackPriority,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,adminNote: freezed == adminNote ? _self.adminNote : adminNote // ignore: cast_nullable_to_non_nullable
as String?,resolvedBy: freezed == resolvedBy ? _self.resolvedBy : resolvedBy // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
