// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_applicant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobApplicantModel {

 String get id; String get jobId; String get applicantId; String get applicantName; String? get applicantPhotoUrl; String? get applicantPhoneMasked; String? get chatRoomId; JobApplicantStatus get status; String? get messagePreview;@SafeDateTimeConverter() DateTime get appliedAt;@SafeDateTimeConverter() DateTime get updatedAt;@SafeDateTimeConverter() DateTime? get lastInteractionAt; String get source; String get countryCode;
/// Create a copy of JobApplicantModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApplicantModelCopyWith<JobApplicantModel> get copyWith => _$JobApplicantModelCopyWithImpl<JobApplicantModel>(this as JobApplicantModel, _$identity);

  /// Serializes this JobApplicantModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApplicantModel&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.applicantId, applicantId) || other.applicantId == applicantId)&&(identical(other.applicantName, applicantName) || other.applicantName == applicantName)&&(identical(other.applicantPhotoUrl, applicantPhotoUrl) || other.applicantPhotoUrl == applicantPhotoUrl)&&(identical(other.applicantPhoneMasked, applicantPhoneMasked) || other.applicantPhoneMasked == applicantPhoneMasked)&&(identical(other.chatRoomId, chatRoomId) || other.chatRoomId == chatRoomId)&&(identical(other.status, status) || other.status == status)&&(identical(other.messagePreview, messagePreview) || other.messagePreview == messagePreview)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastInteractionAt, lastInteractionAt) || other.lastInteractionAt == lastInteractionAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,applicantId,applicantName,applicantPhotoUrl,applicantPhoneMasked,chatRoomId,status,messagePreview,appliedAt,updatedAt,lastInteractionAt,source,countryCode);

@override
String toString() {
  return 'JobApplicantModel(id: $id, jobId: $jobId, applicantId: $applicantId, applicantName: $applicantName, applicantPhotoUrl: $applicantPhotoUrl, applicantPhoneMasked: $applicantPhoneMasked, chatRoomId: $chatRoomId, status: $status, messagePreview: $messagePreview, appliedAt: $appliedAt, updatedAt: $updatedAt, lastInteractionAt: $lastInteractionAt, source: $source, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class $JobApplicantModelCopyWith<$Res>  {
  factory $JobApplicantModelCopyWith(JobApplicantModel value, $Res Function(JobApplicantModel) _then) = _$JobApplicantModelCopyWithImpl;
@useResult
$Res call({
 String id, String jobId, String applicantId, String applicantName, String? applicantPhotoUrl, String? applicantPhoneMasked, String? chatRoomId, JobApplicantStatus status, String? messagePreview,@SafeDateTimeConverter() DateTime appliedAt,@SafeDateTimeConverter() DateTime updatedAt,@SafeDateTimeConverter() DateTime? lastInteractionAt, String source, String countryCode
});




}
/// @nodoc
class _$JobApplicantModelCopyWithImpl<$Res>
    implements $JobApplicantModelCopyWith<$Res> {
  _$JobApplicantModelCopyWithImpl(this._self, this._then);

  final JobApplicantModel _self;
  final $Res Function(JobApplicantModel) _then;

/// Create a copy of JobApplicantModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobId = null,Object? applicantId = null,Object? applicantName = null,Object? applicantPhotoUrl = freezed,Object? applicantPhoneMasked = freezed,Object? chatRoomId = freezed,Object? status = null,Object? messagePreview = freezed,Object? appliedAt = null,Object? updatedAt = null,Object? lastInteractionAt = freezed,Object? source = null,Object? countryCode = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,applicantId: null == applicantId ? _self.applicantId : applicantId // ignore: cast_nullable_to_non_nullable
as String,applicantName: null == applicantName ? _self.applicantName : applicantName // ignore: cast_nullable_to_non_nullable
as String,applicantPhotoUrl: freezed == applicantPhotoUrl ? _self.applicantPhotoUrl : applicantPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,applicantPhoneMasked: freezed == applicantPhoneMasked ? _self.applicantPhoneMasked : applicantPhoneMasked // ignore: cast_nullable_to_non_nullable
as String?,chatRoomId: freezed == chatRoomId ? _self.chatRoomId : chatRoomId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobApplicantStatus,messagePreview: freezed == messagePreview ? _self.messagePreview : messagePreview // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: null == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastInteractionAt: freezed == lastInteractionAt ? _self.lastInteractionAt : lastInteractionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JobApplicantModel].
extension JobApplicantModelPatterns on JobApplicantModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApplicantModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApplicantModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApplicantModel value)  $default,){
final _that = this;
switch (_that) {
case _JobApplicantModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApplicantModel value)?  $default,){
final _that = this;
switch (_that) {
case _JobApplicantModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobId,  String applicantId,  String applicantName,  String? applicantPhotoUrl,  String? applicantPhoneMasked,  String? chatRoomId,  JobApplicantStatus status,  String? messagePreview, @SafeDateTimeConverter()  DateTime appliedAt, @SafeDateTimeConverter()  DateTime updatedAt, @SafeDateTimeConverter()  DateTime? lastInteractionAt,  String source,  String countryCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApplicantModel() when $default != null:
return $default(_that.id,_that.jobId,_that.applicantId,_that.applicantName,_that.applicantPhotoUrl,_that.applicantPhoneMasked,_that.chatRoomId,_that.status,_that.messagePreview,_that.appliedAt,_that.updatedAt,_that.lastInteractionAt,_that.source,_that.countryCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobId,  String applicantId,  String applicantName,  String? applicantPhotoUrl,  String? applicantPhoneMasked,  String? chatRoomId,  JobApplicantStatus status,  String? messagePreview, @SafeDateTimeConverter()  DateTime appliedAt, @SafeDateTimeConverter()  DateTime updatedAt, @SafeDateTimeConverter()  DateTime? lastInteractionAt,  String source,  String countryCode)  $default,) {final _that = this;
switch (_that) {
case _JobApplicantModel():
return $default(_that.id,_that.jobId,_that.applicantId,_that.applicantName,_that.applicantPhotoUrl,_that.applicantPhoneMasked,_that.chatRoomId,_that.status,_that.messagePreview,_that.appliedAt,_that.updatedAt,_that.lastInteractionAt,_that.source,_that.countryCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobId,  String applicantId,  String applicantName,  String? applicantPhotoUrl,  String? applicantPhoneMasked,  String? chatRoomId,  JobApplicantStatus status,  String? messagePreview, @SafeDateTimeConverter()  DateTime appliedAt, @SafeDateTimeConverter()  DateTime updatedAt, @SafeDateTimeConverter()  DateTime? lastInteractionAt,  String source,  String countryCode)?  $default,) {final _that = this;
switch (_that) {
case _JobApplicantModel() when $default != null:
return $default(_that.id,_that.jobId,_that.applicantId,_that.applicantName,_that.applicantPhotoUrl,_that.applicantPhoneMasked,_that.chatRoomId,_that.status,_that.messagePreview,_that.appliedAt,_that.updatedAt,_that.lastInteractionAt,_that.source,_that.countryCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobApplicantModel extends JobApplicantModel {
  const _JobApplicantModel({required this.id, required this.jobId, required this.applicantId, required this.applicantName, this.applicantPhotoUrl, this.applicantPhoneMasked, this.chatRoomId, this.status = JobApplicantStatus.newApplicant, this.messagePreview, @SafeDateTimeConverter() required this.appliedAt, @SafeDateTimeConverter() required this.updatedAt, @SafeDateTimeConverter() this.lastInteractionAt, this.source = 'job_detail', this.countryCode = 'ID'}): super._();
  factory _JobApplicantModel.fromJson(Map<String, dynamic> json) => _$JobApplicantModelFromJson(json);

@override final  String id;
@override final  String jobId;
@override final  String applicantId;
@override final  String applicantName;
@override final  String? applicantPhotoUrl;
@override final  String? applicantPhoneMasked;
@override final  String? chatRoomId;
@override@JsonKey() final  JobApplicantStatus status;
@override final  String? messagePreview;
@override@SafeDateTimeConverter() final  DateTime appliedAt;
@override@SafeDateTimeConverter() final  DateTime updatedAt;
@override@SafeDateTimeConverter() final  DateTime? lastInteractionAt;
@override@JsonKey() final  String source;
@override@JsonKey() final  String countryCode;

/// Create a copy of JobApplicantModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApplicantModelCopyWith<_JobApplicantModel> get copyWith => __$JobApplicantModelCopyWithImpl<_JobApplicantModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobApplicantModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApplicantModel&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.applicantId, applicantId) || other.applicantId == applicantId)&&(identical(other.applicantName, applicantName) || other.applicantName == applicantName)&&(identical(other.applicantPhotoUrl, applicantPhotoUrl) || other.applicantPhotoUrl == applicantPhotoUrl)&&(identical(other.applicantPhoneMasked, applicantPhoneMasked) || other.applicantPhoneMasked == applicantPhoneMasked)&&(identical(other.chatRoomId, chatRoomId) || other.chatRoomId == chatRoomId)&&(identical(other.status, status) || other.status == status)&&(identical(other.messagePreview, messagePreview) || other.messagePreview == messagePreview)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastInteractionAt, lastInteractionAt) || other.lastInteractionAt == lastInteractionAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,applicantId,applicantName,applicantPhotoUrl,applicantPhoneMasked,chatRoomId,status,messagePreview,appliedAt,updatedAt,lastInteractionAt,source,countryCode);

@override
String toString() {
  return 'JobApplicantModel(id: $id, jobId: $jobId, applicantId: $applicantId, applicantName: $applicantName, applicantPhotoUrl: $applicantPhotoUrl, applicantPhoneMasked: $applicantPhoneMasked, chatRoomId: $chatRoomId, status: $status, messagePreview: $messagePreview, appliedAt: $appliedAt, updatedAt: $updatedAt, lastInteractionAt: $lastInteractionAt, source: $source, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class _$JobApplicantModelCopyWith<$Res> implements $JobApplicantModelCopyWith<$Res> {
  factory _$JobApplicantModelCopyWith(_JobApplicantModel value, $Res Function(_JobApplicantModel) _then) = __$JobApplicantModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobId, String applicantId, String applicantName, String? applicantPhotoUrl, String? applicantPhoneMasked, String? chatRoomId, JobApplicantStatus status, String? messagePreview,@SafeDateTimeConverter() DateTime appliedAt,@SafeDateTimeConverter() DateTime updatedAt,@SafeDateTimeConverter() DateTime? lastInteractionAt, String source, String countryCode
});




}
/// @nodoc
class __$JobApplicantModelCopyWithImpl<$Res>
    implements _$JobApplicantModelCopyWith<$Res> {
  __$JobApplicantModelCopyWithImpl(this._self, this._then);

  final _JobApplicantModel _self;
  final $Res Function(_JobApplicantModel) _then;

/// Create a copy of JobApplicantModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobId = null,Object? applicantId = null,Object? applicantName = null,Object? applicantPhotoUrl = freezed,Object? applicantPhoneMasked = freezed,Object? chatRoomId = freezed,Object? status = null,Object? messagePreview = freezed,Object? appliedAt = null,Object? updatedAt = null,Object? lastInteractionAt = freezed,Object? source = null,Object? countryCode = null,}) {
  return _then(_JobApplicantModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,applicantId: null == applicantId ? _self.applicantId : applicantId // ignore: cast_nullable_to_non_nullable
as String,applicantName: null == applicantName ? _self.applicantName : applicantName // ignore: cast_nullable_to_non_nullable
as String,applicantPhotoUrl: freezed == applicantPhotoUrl ? _self.applicantPhotoUrl : applicantPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,applicantPhoneMasked: freezed == applicantPhoneMasked ? _self.applicantPhoneMasked : applicantPhoneMasked // ignore: cast_nullable_to_non_nullable
as String?,chatRoomId: freezed == chatRoomId ? _self.chatRoomId : chatRoomId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobApplicantStatus,messagePreview: freezed == messagePreview ? _self.messagePreview : messagePreview // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: null == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastInteractionAt: freezed == lastInteractionAt ? _self.lastInteractionAt : lastInteractionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
