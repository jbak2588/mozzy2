// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobPostModel {

 String get id; String get title; String get description; String get companyName; String get ownerId; String get ownerName; String? get ownerPhotoUrl; String? get shopId; String get category; JobType get jobType; WorkType get workType; SalaryType get salaryType; int get salaryMin; int get salaryMax; String get currency; LocationParts get locationParts; GeoScope get geoScope; ReachMode get reachMode; double get trustScore; double get signalScore; List<String> get discoveryChannels; bool get mapVisibility; Map<String, String> get translationState; String get status;// JobPostStatus as string for Firestore
 int get applicantCount; int get chatCount; int get viewCount; bool get isDeleted; bool get isClosed; bool get isPromoted; String get boostStatus; String? get boostPaymentId; String? get boostPackageId;@OptionalSafeDateTimeConverter() DateTime? get boostStartedAt;@OptionalSafeDateTimeConverter() DateTime? get boostActiveUntil; int get boostDurationDays; double get boostSignalScore;@OptionalSafeDateTimeConverter() DateTime? get lastBoostedAt;@SafeDateTimeConverter() DateTime get createdAt;@SafeDateTimeConverter() DateTime get updatedAt;@SafeDateTimeConverter() DateTime get expiresAt;
/// Create a copy of JobPostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobPostModelCopyWith<JobPostModel> get copyWith => _$JobPostModelCopyWithImpl<JobPostModel>(this as JobPostModel, _$identity);

  /// Serializes this JobPostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.ownerPhotoUrl, ownerPhotoUrl) || other.ownerPhotoUrl == ownerPhotoUrl)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.category, category) || other.category == category)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.workType, workType) || other.workType == workType)&&(identical(other.salaryType, salaryType) || other.salaryType == salaryType)&&(identical(other.salaryMin, salaryMin) || other.salaryMin == salaryMin)&&(identical(other.salaryMax, salaryMax) || other.salaryMax == salaryMax)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.locationParts, locationParts) || other.locationParts == locationParts)&&(identical(other.geoScope, geoScope) || other.geoScope == geoScope)&&(identical(other.reachMode, reachMode) || other.reachMode == reachMode)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.signalScore, signalScore) || other.signalScore == signalScore)&&const DeepCollectionEquality().equals(other.discoveryChannels, discoveryChannels)&&(identical(other.mapVisibility, mapVisibility) || other.mapVisibility == mapVisibility)&&const DeepCollectionEquality().equals(other.translationState, translationState)&&(identical(other.status, status) || other.status == status)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.chatCount, chatCount) || other.chatCount == chatCount)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.boostStatus, boostStatus) || other.boostStatus == boostStatus)&&(identical(other.boostPaymentId, boostPaymentId) || other.boostPaymentId == boostPaymentId)&&(identical(other.boostPackageId, boostPackageId) || other.boostPackageId == boostPackageId)&&(identical(other.boostStartedAt, boostStartedAt) || other.boostStartedAt == boostStartedAt)&&(identical(other.boostActiveUntil, boostActiveUntil) || other.boostActiveUntil == boostActiveUntil)&&(identical(other.boostDurationDays, boostDurationDays) || other.boostDurationDays == boostDurationDays)&&(identical(other.boostSignalScore, boostSignalScore) || other.boostSignalScore == boostSignalScore)&&(identical(other.lastBoostedAt, lastBoostedAt) || other.lastBoostedAt == lastBoostedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,companyName,ownerId,ownerName,ownerPhotoUrl,shopId,category,jobType,workType,salaryType,salaryMin,salaryMax,currency,locationParts,geoScope,reachMode,trustScore,signalScore,const DeepCollectionEquality().hash(discoveryChannels),mapVisibility,const DeepCollectionEquality().hash(translationState),status,applicantCount,chatCount,viewCount,isDeleted,isClosed,isPromoted,boostStatus,boostPaymentId,boostPackageId,boostStartedAt,boostActiveUntil,boostDurationDays,boostSignalScore,lastBoostedAt,createdAt,updatedAt,expiresAt]);

@override
String toString() {
  return 'JobPostModel(id: $id, title: $title, description: $description, companyName: $companyName, ownerId: $ownerId, ownerName: $ownerName, ownerPhotoUrl: $ownerPhotoUrl, shopId: $shopId, category: $category, jobType: $jobType, workType: $workType, salaryType: $salaryType, salaryMin: $salaryMin, salaryMax: $salaryMax, currency: $currency, locationParts: $locationParts, geoScope: $geoScope, reachMode: $reachMode, trustScore: $trustScore, signalScore: $signalScore, discoveryChannels: $discoveryChannels, mapVisibility: $mapVisibility, translationState: $translationState, status: $status, applicantCount: $applicantCount, chatCount: $chatCount, viewCount: $viewCount, isDeleted: $isDeleted, isClosed: $isClosed, isPromoted: $isPromoted, boostStatus: $boostStatus, boostPaymentId: $boostPaymentId, boostPackageId: $boostPackageId, boostStartedAt: $boostStartedAt, boostActiveUntil: $boostActiveUntil, boostDurationDays: $boostDurationDays, boostSignalScore: $boostSignalScore, lastBoostedAt: $lastBoostedAt, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $JobPostModelCopyWith<$Res>  {
  factory $JobPostModelCopyWith(JobPostModel value, $Res Function(JobPostModel) _then) = _$JobPostModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String companyName, String ownerId, String ownerName, String? ownerPhotoUrl, String? shopId, String category, JobType jobType, WorkType workType, SalaryType salaryType, int salaryMin, int salaryMax, String currency, LocationParts locationParts, GeoScope geoScope, ReachMode reachMode, double trustScore, double signalScore, List<String> discoveryChannels, bool mapVisibility, Map<String, String> translationState, String status, int applicantCount, int chatCount, int viewCount, bool isDeleted, bool isClosed, bool isPromoted, String boostStatus, String? boostPaymentId, String? boostPackageId,@OptionalSafeDateTimeConverter() DateTime? boostStartedAt,@OptionalSafeDateTimeConverter() DateTime? boostActiveUntil, int boostDurationDays, double boostSignalScore,@OptionalSafeDateTimeConverter() DateTime? lastBoostedAt,@SafeDateTimeConverter() DateTime createdAt,@SafeDateTimeConverter() DateTime updatedAt,@SafeDateTimeConverter() DateTime expiresAt
});




}
/// @nodoc
class _$JobPostModelCopyWithImpl<$Res>
    implements $JobPostModelCopyWith<$Res> {
  _$JobPostModelCopyWithImpl(this._self, this._then);

  final JobPostModel _self;
  final $Res Function(JobPostModel) _then;

/// Create a copy of JobPostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? companyName = null,Object? ownerId = null,Object? ownerName = null,Object? ownerPhotoUrl = freezed,Object? shopId = freezed,Object? category = null,Object? jobType = null,Object? workType = null,Object? salaryType = null,Object? salaryMin = null,Object? salaryMax = null,Object? currency = null,Object? locationParts = null,Object? geoScope = null,Object? reachMode = null,Object? trustScore = null,Object? signalScore = null,Object? discoveryChannels = null,Object? mapVisibility = null,Object? translationState = null,Object? status = null,Object? applicantCount = null,Object? chatCount = null,Object? viewCount = null,Object? isDeleted = null,Object? isClosed = null,Object? isPromoted = null,Object? boostStatus = null,Object? boostPaymentId = freezed,Object? boostPackageId = freezed,Object? boostStartedAt = freezed,Object? boostActiveUntil = freezed,Object? boostDurationDays = null,Object? boostSignalScore = null,Object? lastBoostedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,ownerName: null == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String,ownerPhotoUrl: freezed == ownerPhotoUrl ? _self.ownerPhotoUrl : ownerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,jobType: null == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as JobType,workType: null == workType ? _self.workType : workType // ignore: cast_nullable_to_non_nullable
as WorkType,salaryType: null == salaryType ? _self.salaryType : salaryType // ignore: cast_nullable_to_non_nullable
as SalaryType,salaryMin: null == salaryMin ? _self.salaryMin : salaryMin // ignore: cast_nullable_to_non_nullable
as int,salaryMax: null == salaryMax ? _self.salaryMax : salaryMax // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,locationParts: null == locationParts ? _self.locationParts : locationParts // ignore: cast_nullable_to_non_nullable
as LocationParts,geoScope: null == geoScope ? _self.geoScope : geoScope // ignore: cast_nullable_to_non_nullable
as GeoScope,reachMode: null == reachMode ? _self.reachMode : reachMode // ignore: cast_nullable_to_non_nullable
as ReachMode,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,signalScore: null == signalScore ? _self.signalScore : signalScore // ignore: cast_nullable_to_non_nullable
as double,discoveryChannels: null == discoveryChannels ? _self.discoveryChannels : discoveryChannels // ignore: cast_nullable_to_non_nullable
as List<String>,mapVisibility: null == mapVisibility ? _self.mapVisibility : mapVisibility // ignore: cast_nullable_to_non_nullable
as bool,translationState: null == translationState ? _self.translationState : translationState // ignore: cast_nullable_to_non_nullable
as Map<String, String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,applicantCount: null == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int,chatCount: null == chatCount ? _self.chatCount : chatCount // ignore: cast_nullable_to_non_nullable
as int,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,boostStatus: null == boostStatus ? _self.boostStatus : boostStatus // ignore: cast_nullable_to_non_nullable
as String,boostPaymentId: freezed == boostPaymentId ? _self.boostPaymentId : boostPaymentId // ignore: cast_nullable_to_non_nullable
as String?,boostPackageId: freezed == boostPackageId ? _self.boostPackageId : boostPackageId // ignore: cast_nullable_to_non_nullable
as String?,boostStartedAt: freezed == boostStartedAt ? _self.boostStartedAt : boostStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,boostActiveUntil: freezed == boostActiveUntil ? _self.boostActiveUntil : boostActiveUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,boostDurationDays: null == boostDurationDays ? _self.boostDurationDays : boostDurationDays // ignore: cast_nullable_to_non_nullable
as int,boostSignalScore: null == boostSignalScore ? _self.boostSignalScore : boostSignalScore // ignore: cast_nullable_to_non_nullable
as double,lastBoostedAt: freezed == lastBoostedAt ? _self.lastBoostedAt : lastBoostedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [JobPostModel].
extension JobPostModelPatterns on JobPostModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobPostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobPostModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobPostModel value)  $default,){
final _that = this;
switch (_that) {
case _JobPostModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobPostModel value)?  $default,){
final _that = this;
switch (_that) {
case _JobPostModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String companyName,  String ownerId,  String ownerName,  String? ownerPhotoUrl,  String? shopId,  String category,  JobType jobType,  WorkType workType,  SalaryType salaryType,  int salaryMin,  int salaryMax,  String currency,  LocationParts locationParts,  GeoScope geoScope,  ReachMode reachMode,  double trustScore,  double signalScore,  List<String> discoveryChannels,  bool mapVisibility,  Map<String, String> translationState,  String status,  int applicantCount,  int chatCount,  int viewCount,  bool isDeleted,  bool isClosed,  bool isPromoted,  String boostStatus,  String? boostPaymentId,  String? boostPackageId, @OptionalSafeDateTimeConverter()  DateTime? boostStartedAt, @OptionalSafeDateTimeConverter()  DateTime? boostActiveUntil,  int boostDurationDays,  double boostSignalScore, @OptionalSafeDateTimeConverter()  DateTime? lastBoostedAt, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt, @SafeDateTimeConverter()  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobPostModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.companyName,_that.ownerId,_that.ownerName,_that.ownerPhotoUrl,_that.shopId,_that.category,_that.jobType,_that.workType,_that.salaryType,_that.salaryMin,_that.salaryMax,_that.currency,_that.locationParts,_that.geoScope,_that.reachMode,_that.trustScore,_that.signalScore,_that.discoveryChannels,_that.mapVisibility,_that.translationState,_that.status,_that.applicantCount,_that.chatCount,_that.viewCount,_that.isDeleted,_that.isClosed,_that.isPromoted,_that.boostStatus,_that.boostPaymentId,_that.boostPackageId,_that.boostStartedAt,_that.boostActiveUntil,_that.boostDurationDays,_that.boostSignalScore,_that.lastBoostedAt,_that.createdAt,_that.updatedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String companyName,  String ownerId,  String ownerName,  String? ownerPhotoUrl,  String? shopId,  String category,  JobType jobType,  WorkType workType,  SalaryType salaryType,  int salaryMin,  int salaryMax,  String currency,  LocationParts locationParts,  GeoScope geoScope,  ReachMode reachMode,  double trustScore,  double signalScore,  List<String> discoveryChannels,  bool mapVisibility,  Map<String, String> translationState,  String status,  int applicantCount,  int chatCount,  int viewCount,  bool isDeleted,  bool isClosed,  bool isPromoted,  String boostStatus,  String? boostPaymentId,  String? boostPackageId, @OptionalSafeDateTimeConverter()  DateTime? boostStartedAt, @OptionalSafeDateTimeConverter()  DateTime? boostActiveUntil,  int boostDurationDays,  double boostSignalScore, @OptionalSafeDateTimeConverter()  DateTime? lastBoostedAt, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt, @SafeDateTimeConverter()  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _JobPostModel():
return $default(_that.id,_that.title,_that.description,_that.companyName,_that.ownerId,_that.ownerName,_that.ownerPhotoUrl,_that.shopId,_that.category,_that.jobType,_that.workType,_that.salaryType,_that.salaryMin,_that.salaryMax,_that.currency,_that.locationParts,_that.geoScope,_that.reachMode,_that.trustScore,_that.signalScore,_that.discoveryChannels,_that.mapVisibility,_that.translationState,_that.status,_that.applicantCount,_that.chatCount,_that.viewCount,_that.isDeleted,_that.isClosed,_that.isPromoted,_that.boostStatus,_that.boostPaymentId,_that.boostPackageId,_that.boostStartedAt,_that.boostActiveUntil,_that.boostDurationDays,_that.boostSignalScore,_that.lastBoostedAt,_that.createdAt,_that.updatedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String companyName,  String ownerId,  String ownerName,  String? ownerPhotoUrl,  String? shopId,  String category,  JobType jobType,  WorkType workType,  SalaryType salaryType,  int salaryMin,  int salaryMax,  String currency,  LocationParts locationParts,  GeoScope geoScope,  ReachMode reachMode,  double trustScore,  double signalScore,  List<String> discoveryChannels,  bool mapVisibility,  Map<String, String> translationState,  String status,  int applicantCount,  int chatCount,  int viewCount,  bool isDeleted,  bool isClosed,  bool isPromoted,  String boostStatus,  String? boostPaymentId,  String? boostPackageId, @OptionalSafeDateTimeConverter()  DateTime? boostStartedAt, @OptionalSafeDateTimeConverter()  DateTime? boostActiveUntil,  int boostDurationDays,  double boostSignalScore, @OptionalSafeDateTimeConverter()  DateTime? lastBoostedAt, @SafeDateTimeConverter()  DateTime createdAt, @SafeDateTimeConverter()  DateTime updatedAt, @SafeDateTimeConverter()  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _JobPostModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.companyName,_that.ownerId,_that.ownerName,_that.ownerPhotoUrl,_that.shopId,_that.category,_that.jobType,_that.workType,_that.salaryType,_that.salaryMin,_that.salaryMax,_that.currency,_that.locationParts,_that.geoScope,_that.reachMode,_that.trustScore,_that.signalScore,_that.discoveryChannels,_that.mapVisibility,_that.translationState,_that.status,_that.applicantCount,_that.chatCount,_that.viewCount,_that.isDeleted,_that.isClosed,_that.isPromoted,_that.boostStatus,_that.boostPaymentId,_that.boostPackageId,_that.boostStartedAt,_that.boostActiveUntil,_that.boostDurationDays,_that.boostSignalScore,_that.lastBoostedAt,_that.createdAt,_that.updatedAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobPostModel extends JobPostModel {
  const _JobPostModel({required this.id, required this.title, required this.description, required this.companyName, required this.ownerId, required this.ownerName, this.ownerPhotoUrl, this.shopId, required this.category, required this.jobType, required this.workType, required this.salaryType, required this.salaryMin, required this.salaryMax, this.currency = 'IDR', required this.locationParts, this.geoScope = GeoScope.neighborhood, this.reachMode = ReachMode.localOnly, this.trustScore = 0.5, this.signalScore = 0.0, final  List<String> discoveryChannels = const ['feed', 'map', 'search'], this.mapVisibility = true, final  Map<String, String> translationState = const {}, this.status = 'open', this.applicantCount = 0, this.chatCount = 0, this.viewCount = 0, this.isDeleted = false, this.isClosed = false, this.isPromoted = false, this.boostStatus = 'none', this.boostPaymentId, this.boostPackageId, @OptionalSafeDateTimeConverter() this.boostStartedAt, @OptionalSafeDateTimeConverter() this.boostActiveUntil, this.boostDurationDays = 0, this.boostSignalScore = 0.0, @OptionalSafeDateTimeConverter() this.lastBoostedAt, @SafeDateTimeConverter() required this.createdAt, @SafeDateTimeConverter() required this.updatedAt, @SafeDateTimeConverter() required this.expiresAt}): _discoveryChannels = discoveryChannels,_translationState = translationState,super._();
  factory _JobPostModel.fromJson(Map<String, dynamic> json) => _$JobPostModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String companyName;
@override final  String ownerId;
@override final  String ownerName;
@override final  String? ownerPhotoUrl;
@override final  String? shopId;
@override final  String category;
@override final  JobType jobType;
@override final  WorkType workType;
@override final  SalaryType salaryType;
@override final  int salaryMin;
@override final  int salaryMax;
@override@JsonKey() final  String currency;
@override final  LocationParts locationParts;
@override@JsonKey() final  GeoScope geoScope;
@override@JsonKey() final  ReachMode reachMode;
@override@JsonKey() final  double trustScore;
@override@JsonKey() final  double signalScore;
 final  List<String> _discoveryChannels;
@override@JsonKey() List<String> get discoveryChannels {
  if (_discoveryChannels is EqualUnmodifiableListView) return _discoveryChannels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discoveryChannels);
}

@override@JsonKey() final  bool mapVisibility;
 final  Map<String, String> _translationState;
@override@JsonKey() Map<String, String> get translationState {
  if (_translationState is EqualUnmodifiableMapView) return _translationState;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_translationState);
}

@override@JsonKey() final  String status;
// JobPostStatus as string for Firestore
@override@JsonKey() final  int applicantCount;
@override@JsonKey() final  int chatCount;
@override@JsonKey() final  int viewCount;
@override@JsonKey() final  bool isDeleted;
@override@JsonKey() final  bool isClosed;
@override@JsonKey() final  bool isPromoted;
@override@JsonKey() final  String boostStatus;
@override final  String? boostPaymentId;
@override final  String? boostPackageId;
@override@OptionalSafeDateTimeConverter() final  DateTime? boostStartedAt;
@override@OptionalSafeDateTimeConverter() final  DateTime? boostActiveUntil;
@override@JsonKey() final  int boostDurationDays;
@override@JsonKey() final  double boostSignalScore;
@override@OptionalSafeDateTimeConverter() final  DateTime? lastBoostedAt;
@override@SafeDateTimeConverter() final  DateTime createdAt;
@override@SafeDateTimeConverter() final  DateTime updatedAt;
@override@SafeDateTimeConverter() final  DateTime expiresAt;

/// Create a copy of JobPostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobPostModelCopyWith<_JobPostModel> get copyWith => __$JobPostModelCopyWithImpl<_JobPostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobPostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.ownerName, ownerName) || other.ownerName == ownerName)&&(identical(other.ownerPhotoUrl, ownerPhotoUrl) || other.ownerPhotoUrl == ownerPhotoUrl)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.category, category) || other.category == category)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.workType, workType) || other.workType == workType)&&(identical(other.salaryType, salaryType) || other.salaryType == salaryType)&&(identical(other.salaryMin, salaryMin) || other.salaryMin == salaryMin)&&(identical(other.salaryMax, salaryMax) || other.salaryMax == salaryMax)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.locationParts, locationParts) || other.locationParts == locationParts)&&(identical(other.geoScope, geoScope) || other.geoScope == geoScope)&&(identical(other.reachMode, reachMode) || other.reachMode == reachMode)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.signalScore, signalScore) || other.signalScore == signalScore)&&const DeepCollectionEquality().equals(other._discoveryChannels, _discoveryChannels)&&(identical(other.mapVisibility, mapVisibility) || other.mapVisibility == mapVisibility)&&const DeepCollectionEquality().equals(other._translationState, _translationState)&&(identical(other.status, status) || other.status == status)&&(identical(other.applicantCount, applicantCount) || other.applicantCount == applicantCount)&&(identical(other.chatCount, chatCount) || other.chatCount == chatCount)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.boostStatus, boostStatus) || other.boostStatus == boostStatus)&&(identical(other.boostPaymentId, boostPaymentId) || other.boostPaymentId == boostPaymentId)&&(identical(other.boostPackageId, boostPackageId) || other.boostPackageId == boostPackageId)&&(identical(other.boostStartedAt, boostStartedAt) || other.boostStartedAt == boostStartedAt)&&(identical(other.boostActiveUntil, boostActiveUntil) || other.boostActiveUntil == boostActiveUntil)&&(identical(other.boostDurationDays, boostDurationDays) || other.boostDurationDays == boostDurationDays)&&(identical(other.boostSignalScore, boostSignalScore) || other.boostSignalScore == boostSignalScore)&&(identical(other.lastBoostedAt, lastBoostedAt) || other.lastBoostedAt == lastBoostedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,companyName,ownerId,ownerName,ownerPhotoUrl,shopId,category,jobType,workType,salaryType,salaryMin,salaryMax,currency,locationParts,geoScope,reachMode,trustScore,signalScore,const DeepCollectionEquality().hash(_discoveryChannels),mapVisibility,const DeepCollectionEquality().hash(_translationState),status,applicantCount,chatCount,viewCount,isDeleted,isClosed,isPromoted,boostStatus,boostPaymentId,boostPackageId,boostStartedAt,boostActiveUntil,boostDurationDays,boostSignalScore,lastBoostedAt,createdAt,updatedAt,expiresAt]);

@override
String toString() {
  return 'JobPostModel(id: $id, title: $title, description: $description, companyName: $companyName, ownerId: $ownerId, ownerName: $ownerName, ownerPhotoUrl: $ownerPhotoUrl, shopId: $shopId, category: $category, jobType: $jobType, workType: $workType, salaryType: $salaryType, salaryMin: $salaryMin, salaryMax: $salaryMax, currency: $currency, locationParts: $locationParts, geoScope: $geoScope, reachMode: $reachMode, trustScore: $trustScore, signalScore: $signalScore, discoveryChannels: $discoveryChannels, mapVisibility: $mapVisibility, translationState: $translationState, status: $status, applicantCount: $applicantCount, chatCount: $chatCount, viewCount: $viewCount, isDeleted: $isDeleted, isClosed: $isClosed, isPromoted: $isPromoted, boostStatus: $boostStatus, boostPaymentId: $boostPaymentId, boostPackageId: $boostPackageId, boostStartedAt: $boostStartedAt, boostActiveUntil: $boostActiveUntil, boostDurationDays: $boostDurationDays, boostSignalScore: $boostSignalScore, lastBoostedAt: $lastBoostedAt, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$JobPostModelCopyWith<$Res> implements $JobPostModelCopyWith<$Res> {
  factory _$JobPostModelCopyWith(_JobPostModel value, $Res Function(_JobPostModel) _then) = __$JobPostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String companyName, String ownerId, String ownerName, String? ownerPhotoUrl, String? shopId, String category, JobType jobType, WorkType workType, SalaryType salaryType, int salaryMin, int salaryMax, String currency, LocationParts locationParts, GeoScope geoScope, ReachMode reachMode, double trustScore, double signalScore, List<String> discoveryChannels, bool mapVisibility, Map<String, String> translationState, String status, int applicantCount, int chatCount, int viewCount, bool isDeleted, bool isClosed, bool isPromoted, String boostStatus, String? boostPaymentId, String? boostPackageId,@OptionalSafeDateTimeConverter() DateTime? boostStartedAt,@OptionalSafeDateTimeConverter() DateTime? boostActiveUntil, int boostDurationDays, double boostSignalScore,@OptionalSafeDateTimeConverter() DateTime? lastBoostedAt,@SafeDateTimeConverter() DateTime createdAt,@SafeDateTimeConverter() DateTime updatedAt,@SafeDateTimeConverter() DateTime expiresAt
});




}
/// @nodoc
class __$JobPostModelCopyWithImpl<$Res>
    implements _$JobPostModelCopyWith<$Res> {
  __$JobPostModelCopyWithImpl(this._self, this._then);

  final _JobPostModel _self;
  final $Res Function(_JobPostModel) _then;

/// Create a copy of JobPostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? companyName = null,Object? ownerId = null,Object? ownerName = null,Object? ownerPhotoUrl = freezed,Object? shopId = freezed,Object? category = null,Object? jobType = null,Object? workType = null,Object? salaryType = null,Object? salaryMin = null,Object? salaryMax = null,Object? currency = null,Object? locationParts = null,Object? geoScope = null,Object? reachMode = null,Object? trustScore = null,Object? signalScore = null,Object? discoveryChannels = null,Object? mapVisibility = null,Object? translationState = null,Object? status = null,Object? applicantCount = null,Object? chatCount = null,Object? viewCount = null,Object? isDeleted = null,Object? isClosed = null,Object? isPromoted = null,Object? boostStatus = null,Object? boostPaymentId = freezed,Object? boostPackageId = freezed,Object? boostStartedAt = freezed,Object? boostActiveUntil = freezed,Object? boostDurationDays = null,Object? boostSignalScore = null,Object? lastBoostedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? expiresAt = null,}) {
  return _then(_JobPostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,ownerName: null == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String,ownerPhotoUrl: freezed == ownerPhotoUrl ? _self.ownerPhotoUrl : ownerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,jobType: null == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as JobType,workType: null == workType ? _self.workType : workType // ignore: cast_nullable_to_non_nullable
as WorkType,salaryType: null == salaryType ? _self.salaryType : salaryType // ignore: cast_nullable_to_non_nullable
as SalaryType,salaryMin: null == salaryMin ? _self.salaryMin : salaryMin // ignore: cast_nullable_to_non_nullable
as int,salaryMax: null == salaryMax ? _self.salaryMax : salaryMax // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,locationParts: null == locationParts ? _self.locationParts : locationParts // ignore: cast_nullable_to_non_nullable
as LocationParts,geoScope: null == geoScope ? _self.geoScope : geoScope // ignore: cast_nullable_to_non_nullable
as GeoScope,reachMode: null == reachMode ? _self.reachMode : reachMode // ignore: cast_nullable_to_non_nullable
as ReachMode,trustScore: null == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double,signalScore: null == signalScore ? _self.signalScore : signalScore // ignore: cast_nullable_to_non_nullable
as double,discoveryChannels: null == discoveryChannels ? _self._discoveryChannels : discoveryChannels // ignore: cast_nullable_to_non_nullable
as List<String>,mapVisibility: null == mapVisibility ? _self.mapVisibility : mapVisibility // ignore: cast_nullable_to_non_nullable
as bool,translationState: null == translationState ? _self._translationState : translationState // ignore: cast_nullable_to_non_nullable
as Map<String, String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,applicantCount: null == applicantCount ? _self.applicantCount : applicantCount // ignore: cast_nullable_to_non_nullable
as int,chatCount: null == chatCount ? _self.chatCount : chatCount // ignore: cast_nullable_to_non_nullable
as int,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,boostStatus: null == boostStatus ? _self.boostStatus : boostStatus // ignore: cast_nullable_to_non_nullable
as String,boostPaymentId: freezed == boostPaymentId ? _self.boostPaymentId : boostPaymentId // ignore: cast_nullable_to_non_nullable
as String?,boostPackageId: freezed == boostPackageId ? _self.boostPackageId : boostPackageId // ignore: cast_nullable_to_non_nullable
as String?,boostStartedAt: freezed == boostStartedAt ? _self.boostStartedAt : boostStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,boostActiveUntil: freezed == boostActiveUntil ? _self.boostActiveUntil : boostActiveUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,boostDurationDays: null == boostDurationDays ? _self.boostDurationDays : boostDurationDays // ignore: cast_nullable_to_non_nullable
as int,boostSignalScore: null == boostSignalScore ? _self.boostSignalScore : boostSignalScore // ignore: cast_nullable_to_non_nullable
as double,lastBoostedAt: freezed == lastBoostedAt ? _self.lastBoostedAt : lastBoostedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
