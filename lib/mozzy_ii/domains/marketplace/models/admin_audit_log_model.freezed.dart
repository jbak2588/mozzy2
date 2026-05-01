// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_audit_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminAuditLogModel {

 String get id; String get action;// approve | reject | dismiss
 String get queueItemId; String get productId; String? get reportId; String get reviewerId; String get reviewerRole; String get previousReviewStatus; String get newReviewStatus; String get decision; String? get noteSummary; DateTime get createdAt; String get source;
/// Create a copy of AdminAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminAuditLogModelCopyWith<AdminAuditLogModel> get copyWith => _$AdminAuditLogModelCopyWithImpl<AdminAuditLogModel>(this as AdminAuditLogModel, _$identity);

  /// Serializes this AdminAuditLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminAuditLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.queueItemId, queueItemId) || other.queueItemId == queueItemId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.reviewerRole, reviewerRole) || other.reviewerRole == reviewerRole)&&(identical(other.previousReviewStatus, previousReviewStatus) || other.previousReviewStatus == previousReviewStatus)&&(identical(other.newReviewStatus, newReviewStatus) || other.newReviewStatus == newReviewStatus)&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.noteSummary, noteSummary) || other.noteSummary == noteSummary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,action,queueItemId,productId,reportId,reviewerId,reviewerRole,previousReviewStatus,newReviewStatus,decision,noteSummary,createdAt,source);

@override
String toString() {
  return 'AdminAuditLogModel(id: $id, action: $action, queueItemId: $queueItemId, productId: $productId, reportId: $reportId, reviewerId: $reviewerId, reviewerRole: $reviewerRole, previousReviewStatus: $previousReviewStatus, newReviewStatus: $newReviewStatus, decision: $decision, noteSummary: $noteSummary, createdAt: $createdAt, source: $source)';
}


}

/// @nodoc
abstract mixin class $AdminAuditLogModelCopyWith<$Res>  {
  factory $AdminAuditLogModelCopyWith(AdminAuditLogModel value, $Res Function(AdminAuditLogModel) _then) = _$AdminAuditLogModelCopyWithImpl;
@useResult
$Res call({
 String id, String action, String queueItemId, String productId, String? reportId, String reviewerId, String reviewerRole, String previousReviewStatus, String newReviewStatus, String decision, String? noteSummary, DateTime createdAt, String source
});




}
/// @nodoc
class _$AdminAuditLogModelCopyWithImpl<$Res>
    implements $AdminAuditLogModelCopyWith<$Res> {
  _$AdminAuditLogModelCopyWithImpl(this._self, this._then);

  final AdminAuditLogModel _self;
  final $Res Function(AdminAuditLogModel) _then;

/// Create a copy of AdminAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? action = null,Object? queueItemId = null,Object? productId = null,Object? reportId = freezed,Object? reviewerId = null,Object? reviewerRole = null,Object? previousReviewStatus = null,Object? newReviewStatus = null,Object? decision = null,Object? noteSummary = freezed,Object? createdAt = null,Object? source = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,queueItemId: null == queueItemId ? _self.queueItemId : queueItemId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,reportId: freezed == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String?,reviewerId: null == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String,reviewerRole: null == reviewerRole ? _self.reviewerRole : reviewerRole // ignore: cast_nullable_to_non_nullable
as String,previousReviewStatus: null == previousReviewStatus ? _self.previousReviewStatus : previousReviewStatus // ignore: cast_nullable_to_non_nullable
as String,newReviewStatus: null == newReviewStatus ? _self.newReviewStatus : newReviewStatus // ignore: cast_nullable_to_non_nullable
as String,decision: null == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as String,noteSummary: freezed == noteSummary ? _self.noteSummary : noteSummary // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminAuditLogModel].
extension AdminAuditLogModelPatterns on AdminAuditLogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminAuditLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminAuditLogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminAuditLogModel value)  $default,){
final _that = this;
switch (_that) {
case _AdminAuditLogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminAuditLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _AdminAuditLogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String action,  String queueItemId,  String productId,  String? reportId,  String reviewerId,  String reviewerRole,  String previousReviewStatus,  String newReviewStatus,  String decision,  String? noteSummary,  DateTime createdAt,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminAuditLogModel() when $default != null:
return $default(_that.id,_that.action,_that.queueItemId,_that.productId,_that.reportId,_that.reviewerId,_that.reviewerRole,_that.previousReviewStatus,_that.newReviewStatus,_that.decision,_that.noteSummary,_that.createdAt,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String action,  String queueItemId,  String productId,  String? reportId,  String reviewerId,  String reviewerRole,  String previousReviewStatus,  String newReviewStatus,  String decision,  String? noteSummary,  DateTime createdAt,  String source)  $default,) {final _that = this;
switch (_that) {
case _AdminAuditLogModel():
return $default(_that.id,_that.action,_that.queueItemId,_that.productId,_that.reportId,_that.reviewerId,_that.reviewerRole,_that.previousReviewStatus,_that.newReviewStatus,_that.decision,_that.noteSummary,_that.createdAt,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String action,  String queueItemId,  String productId,  String? reportId,  String reviewerId,  String reviewerRole,  String previousReviewStatus,  String newReviewStatus,  String decision,  String? noteSummary,  DateTime createdAt,  String source)?  $default,) {final _that = this;
switch (_that) {
case _AdminAuditLogModel() when $default != null:
return $default(_that.id,_that.action,_that.queueItemId,_that.productId,_that.reportId,_that.reviewerId,_that.reviewerRole,_that.previousReviewStatus,_that.newReviewStatus,_that.decision,_that.noteSummary,_that.createdAt,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminAuditLogModel extends AdminAuditLogModel {
  const _AdminAuditLogModel({required this.id, required this.action, required this.queueItemId, required this.productId, this.reportId, required this.reviewerId, required this.reviewerRole, required this.previousReviewStatus, required this.newReviewStatus, required this.decision, this.noteSummary, required this.createdAt, this.source = 'admin_review_screen'}): super._();
  factory _AdminAuditLogModel.fromJson(Map<String, dynamic> json) => _$AdminAuditLogModelFromJson(json);

@override final  String id;
@override final  String action;
// approve | reject | dismiss
@override final  String queueItemId;
@override final  String productId;
@override final  String? reportId;
@override final  String reviewerId;
@override final  String reviewerRole;
@override final  String previousReviewStatus;
@override final  String newReviewStatus;
@override final  String decision;
@override final  String? noteSummary;
@override final  DateTime createdAt;
@override@JsonKey() final  String source;

/// Create a copy of AdminAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminAuditLogModelCopyWith<_AdminAuditLogModel> get copyWith => __$AdminAuditLogModelCopyWithImpl<_AdminAuditLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminAuditLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminAuditLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.queueItemId, queueItemId) || other.queueItemId == queueItemId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.reviewerRole, reviewerRole) || other.reviewerRole == reviewerRole)&&(identical(other.previousReviewStatus, previousReviewStatus) || other.previousReviewStatus == previousReviewStatus)&&(identical(other.newReviewStatus, newReviewStatus) || other.newReviewStatus == newReviewStatus)&&(identical(other.decision, decision) || other.decision == decision)&&(identical(other.noteSummary, noteSummary) || other.noteSummary == noteSummary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,action,queueItemId,productId,reportId,reviewerId,reviewerRole,previousReviewStatus,newReviewStatus,decision,noteSummary,createdAt,source);

@override
String toString() {
  return 'AdminAuditLogModel(id: $id, action: $action, queueItemId: $queueItemId, productId: $productId, reportId: $reportId, reviewerId: $reviewerId, reviewerRole: $reviewerRole, previousReviewStatus: $previousReviewStatus, newReviewStatus: $newReviewStatus, decision: $decision, noteSummary: $noteSummary, createdAt: $createdAt, source: $source)';
}


}

/// @nodoc
abstract mixin class _$AdminAuditLogModelCopyWith<$Res> implements $AdminAuditLogModelCopyWith<$Res> {
  factory _$AdminAuditLogModelCopyWith(_AdminAuditLogModel value, $Res Function(_AdminAuditLogModel) _then) = __$AdminAuditLogModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String action, String queueItemId, String productId, String? reportId, String reviewerId, String reviewerRole, String previousReviewStatus, String newReviewStatus, String decision, String? noteSummary, DateTime createdAt, String source
});




}
/// @nodoc
class __$AdminAuditLogModelCopyWithImpl<$Res>
    implements _$AdminAuditLogModelCopyWith<$Res> {
  __$AdminAuditLogModelCopyWithImpl(this._self, this._then);

  final _AdminAuditLogModel _self;
  final $Res Function(_AdminAuditLogModel) _then;

/// Create a copy of AdminAuditLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? action = null,Object? queueItemId = null,Object? productId = null,Object? reportId = freezed,Object? reviewerId = null,Object? reviewerRole = null,Object? previousReviewStatus = null,Object? newReviewStatus = null,Object? decision = null,Object? noteSummary = freezed,Object? createdAt = null,Object? source = null,}) {
  return _then(_AdminAuditLogModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,queueItemId: null == queueItemId ? _self.queueItemId : queueItemId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,reportId: freezed == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String?,reviewerId: null == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String,reviewerRole: null == reviewerRole ? _self.reviewerRole : reviewerRole // ignore: cast_nullable_to_non_nullable
as String,previousReviewStatus: null == previousReviewStatus ? _self.previousReviewStatus : previousReviewStatus // ignore: cast_nullable_to_non_nullable
as String,newReviewStatus: null == newReviewStatus ? _self.newReviewStatus : newReviewStatus // ignore: cast_nullable_to_non_nullable
as String,decision: null == decision ? _self.decision : decision // ignore: cast_nullable_to_non_nullable
as String,noteSummary: freezed == noteSummary ? _self.noteSummary : noteSummary // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
