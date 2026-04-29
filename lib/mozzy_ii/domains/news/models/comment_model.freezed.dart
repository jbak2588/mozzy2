// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentModel {

 String get id; String get postId; String get userId; String get content;@SafeDateTimeConverter() DateTime get createdAt;@OptionalSafeDateTimeConverter() DateTime? get updatedAt; bool get isDeleted; int get reportCount; double get trustScore; String? get parentCommentId;
/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentModelCopyWith<CommentModel> get copyWith => _$CommentModelCopyWithImpl<CommentModel>(this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,userId,content,createdAt,updatedAt,isDeleted,reportCount,trustScore,parentCommentId);

@override
String toString() {
  return 'CommentModel(id: $id, postId: $postId, userId: $userId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, reportCount: $reportCount, trustScore: $trustScore, parentCommentId: $parentCommentId)';
}


}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res>  {
  factory $CommentModelCopyWith(CommentModel value, $Res Function(CommentModel) _then) = _$CommentModelCopyWithImpl;
@useResult
$Res call({
 String id, String postId, String userId, String content,@SafeDateTimeConverter() DateTime createdAt,@OptionalSafeDateTimeConverter() DateTime? updatedAt, bool isDeleted, int reportCount, double trustScore, String? parentCommentId
});




}
/// @nodoc
class _$CommentModelCopyWithImpl<$Res>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? postId = null,Object? userId = null,Object? content = null,Object? createdAt = null,Object? updatedAt = freezed,Object? isDeleted = null,Object? reportCount = null,Object? trustScore = null,Object? parentCommentId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentModel].
extension CommentModelPatterns on CommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String postId,  String userId,  String content, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isDeleted,  int reportCount,  double trustScore,  String? parentCommentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.postId,_that.userId,_that.content,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.reportCount,_that.trustScore,_that.parentCommentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String postId,  String userId,  String content, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isDeleted,  int reportCount,  double trustScore,  String? parentCommentId)  $default,) {final _that = this;
switch (_that) {
case _CommentModel():
return $default(_that.id,_that.postId,_that.userId,_that.content,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.reportCount,_that.trustScore,_that.parentCommentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String postId,  String userId,  String content, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? updatedAt,  bool isDeleted,  int reportCount,  double trustScore,  String? parentCommentId)?  $default,) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.postId,_that.userId,_that.content,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.reportCount,_that.trustScore,_that.parentCommentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentModel extends CommentModel {
  const _CommentModel({required this.id, required this.postId, required this.userId, required this.content, @SafeDateTimeConverter() required this.createdAt, @OptionalSafeDateTimeConverter() this.updatedAt, this.isDeleted = false, this.reportCount = 0, this.trustScore = 0.3, this.parentCommentId}): super._();
  factory _CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

@override final  String id;
@override final  String postId;
@override final  String userId;
@override final  String content;
@override@SafeDateTimeConverter() final  DateTime createdAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? updatedAt;
@override@JsonKey() final  bool isDeleted;
@override@JsonKey() final  int reportCount;
@override@JsonKey() final  double trustScore;
@override final  String? parentCommentId;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentModelCopyWith<_CommentModel> get copyWith => __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,userId,content,createdAt,updatedAt,isDeleted,reportCount,trustScore,parentCommentId);

@override
String toString() {
  return 'CommentModel(id: $id, postId: $postId, userId: $userId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, reportCount: $reportCount, trustScore: $trustScore, parentCommentId: $parentCommentId)';
}


}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res> implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(_CommentModel value, $Res Function(_CommentModel) _then) = __$CommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String postId, String userId, String content,@SafeDateTimeConverter() DateTime createdAt,@OptionalSafeDateTimeConverter() DateTime? updatedAt, bool isDeleted, int reportCount, double trustScore, String? parentCommentId
});




}
/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? postId = null,Object? userId = null,Object? content = null,Object? createdAt = null,Object? updatedAt = freezed,Object? isDeleted = null,Object? reportCount = null,Object? trustScore = null,Object? parentCommentId = freezed,}) {
  return _then(_CommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
