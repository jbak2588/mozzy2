// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportModel {

 String get id; ReportTargetType get targetType; String get targetId; String? get targetOwnerId; String get reporterId; ReportReason get reason; String? get description; ReportStatus get status; String get severity;@SafeDateTimeConverter() DateTime get createdAt;@OptionalSafeDateTimeConverter() DateTime? get reviewedAt; String? get reviewedBy; String? get adminNote; String get countryCode; String? get sourceRoute;
/// Create a copy of ReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportModelCopyWith<ReportModel> get copyWith => _$ReportModelCopyWithImpl<ReportModel>(this as ReportModel, _$identity);

  /// Serializes this ReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.targetOwnerId, targetOwnerId) || other.targetOwnerId == targetOwnerId)&&(identical(other.reporterId, reporterId) || other.reporterId == reporterId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.adminNote, adminNote) || other.adminNote == adminNote)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.sourceRoute, sourceRoute) || other.sourceRoute == sourceRoute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,targetType,targetId,targetOwnerId,reporterId,reason,description,status,severity,createdAt,reviewedAt,reviewedBy,adminNote,countryCode,sourceRoute);

@override
String toString() {
  return 'ReportModel(id: $id, targetType: $targetType, targetId: $targetId, targetOwnerId: $targetOwnerId, reporterId: $reporterId, reason: $reason, description: $description, status: $status, severity: $severity, createdAt: $createdAt, reviewedAt: $reviewedAt, reviewedBy: $reviewedBy, adminNote: $adminNote, countryCode: $countryCode, sourceRoute: $sourceRoute)';
}


}

/// @nodoc
abstract mixin class $ReportModelCopyWith<$Res>  {
  factory $ReportModelCopyWith(ReportModel value, $Res Function(ReportModel) _then) = _$ReportModelCopyWithImpl;
@useResult
$Res call({
 String id, ReportTargetType targetType, String targetId, String? targetOwnerId, String reporterId, ReportReason reason, String? description, ReportStatus status, String severity,@SafeDateTimeConverter() DateTime createdAt,@OptionalSafeDateTimeConverter() DateTime? reviewedAt, String? reviewedBy, String? adminNote, String countryCode, String? sourceRoute
});




}
/// @nodoc
class _$ReportModelCopyWithImpl<$Res>
    implements $ReportModelCopyWith<$Res> {
  _$ReportModelCopyWithImpl(this._self, this._then);

  final ReportModel _self;
  final $Res Function(ReportModel) _then;

/// Create a copy of ReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? targetType = null,Object? targetId = null,Object? targetOwnerId = freezed,Object? reporterId = null,Object? reason = null,Object? description = freezed,Object? status = null,Object? severity = null,Object? createdAt = null,Object? reviewedAt = freezed,Object? reviewedBy = freezed,Object? adminNote = freezed,Object? countryCode = null,Object? sourceRoute = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as ReportTargetType,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,targetOwnerId: freezed == targetOwnerId ? _self.targetOwnerId : targetOwnerId // ignore: cast_nullable_to_non_nullable
as String?,reporterId: null == reporterId ? _self.reporterId : reporterId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReportReason,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportStatus,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,adminNote: freezed == adminNote ? _self.adminNote : adminNote // ignore: cast_nullable_to_non_nullable
as String?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,sourceRoute: freezed == sourceRoute ? _self.sourceRoute : sourceRoute // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportModel].
extension ReportModelPatterns on ReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportModel value)  $default,){
final _that = this;
switch (_that) {
case _ReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ReportTargetType targetType,  String targetId,  String? targetOwnerId,  String reporterId,  ReportReason reason,  String? description,  ReportStatus status,  String severity, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? reviewedAt,  String? reviewedBy,  String? adminNote,  String countryCode,  String? sourceRoute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportModel() when $default != null:
return $default(_that.id,_that.targetType,_that.targetId,_that.targetOwnerId,_that.reporterId,_that.reason,_that.description,_that.status,_that.severity,_that.createdAt,_that.reviewedAt,_that.reviewedBy,_that.adminNote,_that.countryCode,_that.sourceRoute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ReportTargetType targetType,  String targetId,  String? targetOwnerId,  String reporterId,  ReportReason reason,  String? description,  ReportStatus status,  String severity, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? reviewedAt,  String? reviewedBy,  String? adminNote,  String countryCode,  String? sourceRoute)  $default,) {final _that = this;
switch (_that) {
case _ReportModel():
return $default(_that.id,_that.targetType,_that.targetId,_that.targetOwnerId,_that.reporterId,_that.reason,_that.description,_that.status,_that.severity,_that.createdAt,_that.reviewedAt,_that.reviewedBy,_that.adminNote,_that.countryCode,_that.sourceRoute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ReportTargetType targetType,  String targetId,  String? targetOwnerId,  String reporterId,  ReportReason reason,  String? description,  ReportStatus status,  String severity, @SafeDateTimeConverter()  DateTime createdAt, @OptionalSafeDateTimeConverter()  DateTime? reviewedAt,  String? reviewedBy,  String? adminNote,  String countryCode,  String? sourceRoute)?  $default,) {final _that = this;
switch (_that) {
case _ReportModel() when $default != null:
return $default(_that.id,_that.targetType,_that.targetId,_that.targetOwnerId,_that.reporterId,_that.reason,_that.description,_that.status,_that.severity,_that.createdAt,_that.reviewedAt,_that.reviewedBy,_that.adminNote,_that.countryCode,_that.sourceRoute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportModel implements ReportModel {
  const _ReportModel({required this.id, required this.targetType, required this.targetId, this.targetOwnerId, required this.reporterId, required this.reason, this.description, this.status = ReportStatus.pending, this.severity = 'medium', @SafeDateTimeConverter() required this.createdAt, @OptionalSafeDateTimeConverter() this.reviewedAt, this.reviewedBy, this.adminNote, this.countryCode = 'ID', this.sourceRoute});
  factory _ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);

@override final  String id;
@override final  ReportTargetType targetType;
@override final  String targetId;
@override final  String? targetOwnerId;
@override final  String reporterId;
@override final  ReportReason reason;
@override final  String? description;
@override@JsonKey() final  ReportStatus status;
@override@JsonKey() final  String severity;
@override@SafeDateTimeConverter() final  DateTime createdAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? reviewedAt;
@override final  String? reviewedBy;
@override final  String? adminNote;
@override@JsonKey() final  String countryCode;
@override final  String? sourceRoute;

/// Create a copy of ReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportModelCopyWith<_ReportModel> get copyWith => __$ReportModelCopyWithImpl<_ReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.targetOwnerId, targetOwnerId) || other.targetOwnerId == targetOwnerId)&&(identical(other.reporterId, reporterId) || other.reporterId == reporterId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.adminNote, adminNote) || other.adminNote == adminNote)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.sourceRoute, sourceRoute) || other.sourceRoute == sourceRoute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,targetType,targetId,targetOwnerId,reporterId,reason,description,status,severity,createdAt,reviewedAt,reviewedBy,adminNote,countryCode,sourceRoute);

@override
String toString() {
  return 'ReportModel(id: $id, targetType: $targetType, targetId: $targetId, targetOwnerId: $targetOwnerId, reporterId: $reporterId, reason: $reason, description: $description, status: $status, severity: $severity, createdAt: $createdAt, reviewedAt: $reviewedAt, reviewedBy: $reviewedBy, adminNote: $adminNote, countryCode: $countryCode, sourceRoute: $sourceRoute)';
}


}

/// @nodoc
abstract mixin class _$ReportModelCopyWith<$Res> implements $ReportModelCopyWith<$Res> {
  factory _$ReportModelCopyWith(_ReportModel value, $Res Function(_ReportModel) _then) = __$ReportModelCopyWithImpl;
@override @useResult
$Res call({
 String id, ReportTargetType targetType, String targetId, String? targetOwnerId, String reporterId, ReportReason reason, String? description, ReportStatus status, String severity,@SafeDateTimeConverter() DateTime createdAt,@OptionalSafeDateTimeConverter() DateTime? reviewedAt, String? reviewedBy, String? adminNote, String countryCode, String? sourceRoute
});




}
/// @nodoc
class __$ReportModelCopyWithImpl<$Res>
    implements _$ReportModelCopyWith<$Res> {
  __$ReportModelCopyWithImpl(this._self, this._then);

  final _ReportModel _self;
  final $Res Function(_ReportModel) _then;

/// Create a copy of ReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? targetType = null,Object? targetId = null,Object? targetOwnerId = freezed,Object? reporterId = null,Object? reason = null,Object? description = freezed,Object? status = null,Object? severity = null,Object? createdAt = null,Object? reviewedAt = freezed,Object? reviewedBy = freezed,Object? adminNote = freezed,Object? countryCode = null,Object? sourceRoute = freezed,}) {
  return _then(_ReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as ReportTargetType,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,targetOwnerId: freezed == targetOwnerId ? _self.targetOwnerId : targetOwnerId // ignore: cast_nullable_to_non_nullable
as String?,reporterId: null == reporterId ? _self.reporterId : reporterId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReportReason,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportStatus,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,adminNote: freezed == adminNote ? _self.adminNote : adminNote // ignore: cast_nullable_to_non_nullable
as String?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,sourceRoute: freezed == sourceRoute ? _self.sourceRoute : sourceRoute // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
