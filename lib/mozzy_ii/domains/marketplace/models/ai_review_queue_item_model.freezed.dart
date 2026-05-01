// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_review_queue_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiReviewQueueItemModel {

 String get id; String get productId; String get sellerId; String get reportId; String get status;// needs_review | failed | error
 String get reason; String get priority;// low | normal | high | urgent
 DateTime get createdAt; DateTime? get resolvedAt; String get reviewStatus;// open | resolved | dismissed
 String? get assignedTo; String? get reviewerId; String? get reviewerDecision;// approved | rejected | dismissed
 String? get reviewerNote;
/// Create a copy of AiReviewQueueItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiReviewQueueItemModelCopyWith<AiReviewQueueItemModel> get copyWith => _$AiReviewQueueItemModelCopyWithImpl<AiReviewQueueItemModel>(this as AiReviewQueueItemModel, _$identity);

  /// Serializes this AiReviewQueueItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiReviewQueueItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.reviewerDecision, reviewerDecision) || other.reviewerDecision == reviewerDecision)&&(identical(other.reviewerNote, reviewerNote) || other.reviewerNote == reviewerNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,sellerId,reportId,status,reason,priority,createdAt,resolvedAt,reviewStatus,assignedTo,reviewerId,reviewerDecision,reviewerNote);

@override
String toString() {
  return 'AiReviewQueueItemModel(id: $id, productId: $productId, sellerId: $sellerId, reportId: $reportId, status: $status, reason: $reason, priority: $priority, createdAt: $createdAt, resolvedAt: $resolvedAt, reviewStatus: $reviewStatus, assignedTo: $assignedTo, reviewerId: $reviewerId, reviewerDecision: $reviewerDecision, reviewerNote: $reviewerNote)';
}


}

/// @nodoc
abstract mixin class $AiReviewQueueItemModelCopyWith<$Res>  {
  factory $AiReviewQueueItemModelCopyWith(AiReviewQueueItemModel value, $Res Function(AiReviewQueueItemModel) _then) = _$AiReviewQueueItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String sellerId, String reportId, String status, String reason, String priority, DateTime createdAt, DateTime? resolvedAt, String reviewStatus, String? assignedTo, String? reviewerId, String? reviewerDecision, String? reviewerNote
});




}
/// @nodoc
class _$AiReviewQueueItemModelCopyWithImpl<$Res>
    implements $AiReviewQueueItemModelCopyWith<$Res> {
  _$AiReviewQueueItemModelCopyWithImpl(this._self, this._then);

  final AiReviewQueueItemModel _self;
  final $Res Function(AiReviewQueueItemModel) _then;

/// Create a copy of AiReviewQueueItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? sellerId = null,Object? reportId = null,Object? status = null,Object? reason = null,Object? priority = null,Object? createdAt = null,Object? resolvedAt = freezed,Object? reviewStatus = null,Object? assignedTo = freezed,Object? reviewerId = freezed,Object? reviewerDecision = freezed,Object? reviewerNote = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as String,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,reviewerId: freezed == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String?,reviewerDecision: freezed == reviewerDecision ? _self.reviewerDecision : reviewerDecision // ignore: cast_nullable_to_non_nullable
as String?,reviewerNote: freezed == reviewerNote ? _self.reviewerNote : reviewerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiReviewQueueItemModel].
extension AiReviewQueueItemModelPatterns on AiReviewQueueItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiReviewQueueItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiReviewQueueItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiReviewQueueItemModel value)  $default,){
final _that = this;
switch (_that) {
case _AiReviewQueueItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiReviewQueueItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _AiReviewQueueItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String sellerId,  String reportId,  String status,  String reason,  String priority,  DateTime createdAt,  DateTime? resolvedAt,  String reviewStatus,  String? assignedTo,  String? reviewerId,  String? reviewerDecision,  String? reviewerNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiReviewQueueItemModel() when $default != null:
return $default(_that.id,_that.productId,_that.sellerId,_that.reportId,_that.status,_that.reason,_that.priority,_that.createdAt,_that.resolvedAt,_that.reviewStatus,_that.assignedTo,_that.reviewerId,_that.reviewerDecision,_that.reviewerNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String sellerId,  String reportId,  String status,  String reason,  String priority,  DateTime createdAt,  DateTime? resolvedAt,  String reviewStatus,  String? assignedTo,  String? reviewerId,  String? reviewerDecision,  String? reviewerNote)  $default,) {final _that = this;
switch (_that) {
case _AiReviewQueueItemModel():
return $default(_that.id,_that.productId,_that.sellerId,_that.reportId,_that.status,_that.reason,_that.priority,_that.createdAt,_that.resolvedAt,_that.reviewStatus,_that.assignedTo,_that.reviewerId,_that.reviewerDecision,_that.reviewerNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String sellerId,  String reportId,  String status,  String reason,  String priority,  DateTime createdAt,  DateTime? resolvedAt,  String reviewStatus,  String? assignedTo,  String? reviewerId,  String? reviewerDecision,  String? reviewerNote)?  $default,) {final _that = this;
switch (_that) {
case _AiReviewQueueItemModel() when $default != null:
return $default(_that.id,_that.productId,_that.sellerId,_that.reportId,_that.status,_that.reason,_that.priority,_that.createdAt,_that.resolvedAt,_that.reviewStatus,_that.assignedTo,_that.reviewerId,_that.reviewerDecision,_that.reviewerNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiReviewQueueItemModel extends AiReviewQueueItemModel {
  const _AiReviewQueueItemModel({required this.id, required this.productId, required this.sellerId, required this.reportId, required this.status, this.reason = '', this.priority = 'normal', required this.createdAt, this.resolvedAt, this.reviewStatus = 'open', this.assignedTo, this.reviewerId, this.reviewerDecision, this.reviewerNote}): super._();
  factory _AiReviewQueueItemModel.fromJson(Map<String, dynamic> json) => _$AiReviewQueueItemModelFromJson(json);

@override final  String id;
@override final  String productId;
@override final  String sellerId;
@override final  String reportId;
@override final  String status;
// needs_review | failed | error
@override@JsonKey() final  String reason;
@override@JsonKey() final  String priority;
// low | normal | high | urgent
@override final  DateTime createdAt;
@override final  DateTime? resolvedAt;
@override@JsonKey() final  String reviewStatus;
// open | resolved | dismissed
@override final  String? assignedTo;
@override final  String? reviewerId;
@override final  String? reviewerDecision;
// approved | rejected | dismissed
@override final  String? reviewerNote;

/// Create a copy of AiReviewQueueItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiReviewQueueItemModelCopyWith<_AiReviewQueueItemModel> get copyWith => __$AiReviewQueueItemModelCopyWithImpl<_AiReviewQueueItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiReviewQueueItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiReviewQueueItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.reviewerDecision, reviewerDecision) || other.reviewerDecision == reviewerDecision)&&(identical(other.reviewerNote, reviewerNote) || other.reviewerNote == reviewerNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,sellerId,reportId,status,reason,priority,createdAt,resolvedAt,reviewStatus,assignedTo,reviewerId,reviewerDecision,reviewerNote);

@override
String toString() {
  return 'AiReviewQueueItemModel(id: $id, productId: $productId, sellerId: $sellerId, reportId: $reportId, status: $status, reason: $reason, priority: $priority, createdAt: $createdAt, resolvedAt: $resolvedAt, reviewStatus: $reviewStatus, assignedTo: $assignedTo, reviewerId: $reviewerId, reviewerDecision: $reviewerDecision, reviewerNote: $reviewerNote)';
}


}

/// @nodoc
abstract mixin class _$AiReviewQueueItemModelCopyWith<$Res> implements $AiReviewQueueItemModelCopyWith<$Res> {
  factory _$AiReviewQueueItemModelCopyWith(_AiReviewQueueItemModel value, $Res Function(_AiReviewQueueItemModel) _then) = __$AiReviewQueueItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String sellerId, String reportId, String status, String reason, String priority, DateTime createdAt, DateTime? resolvedAt, String reviewStatus, String? assignedTo, String? reviewerId, String? reviewerDecision, String? reviewerNote
});




}
/// @nodoc
class __$AiReviewQueueItemModelCopyWithImpl<$Res>
    implements _$AiReviewQueueItemModelCopyWith<$Res> {
  __$AiReviewQueueItemModelCopyWithImpl(this._self, this._then);

  final _AiReviewQueueItemModel _self;
  final $Res Function(_AiReviewQueueItemModel) _then;

/// Create a copy of AiReviewQueueItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? sellerId = null,Object? reportId = null,Object? status = null,Object? reason = null,Object? priority = null,Object? createdAt = null,Object? resolvedAt = freezed,Object? reviewStatus = null,Object? assignedTo = freezed,Object? reviewerId = freezed,Object? reviewerDecision = freezed,Object? reviewerNote = freezed,}) {
  return _then(_AiReviewQueueItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as String,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,reviewerId: freezed == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String?,reviewerDecision: freezed == reviewerDecision ? _self.reviewerDecision : reviewerDecision // ignore: cast_nullable_to_non_nullable
as String?,reviewerNote: freezed == reviewerNote ? _self.reviewerNote : reviewerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
