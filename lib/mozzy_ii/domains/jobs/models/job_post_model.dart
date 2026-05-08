import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../shared/contracts/mozzy_post_contract.dart';
import '../../../geo/models/location_parts.dart';
import '../../../core/utils/datetime_converter.dart';

part 'job_post_model.freezed.dart';
part 'job_post_model.g.dart';

enum JobPostStatus {
  open,
  closed,
  expired,
  archived,
}

enum JobType {
  fullTime,
  partTime,
  freelance,
  internship,
  daily,
}

enum WorkType {
  onsite,
  hybrid,
  remote,
}

enum SalaryType {
  monthly,
  daily,
  hourly,
  negotiable,
}

@freezed
abstract class JobPostModel with _$JobPostModel implements MozzyPostContract {
  const factory JobPostModel({
    required String id,
    required String title,
    required String description,
    required String companyName,
    required String ownerId,
    required String ownerName,
    String? ownerPhotoUrl,
    String? shopId,
    required String category,
    required JobType jobType,
    required WorkType workType,
    required SalaryType salaryType,
    required int salaryMin,
    required int salaryMax,
    @Default('IDR') String currency,
    required LocationParts locationParts,
    @Default(GeoScope.neighborhood) GeoScope geoScope,
    @Default(ReachMode.localOnly) ReachMode reachMode,
    @Default(0.5) double trustScore,
    @Default(0.0) double signalScore,
    @Default(['feed', 'map', 'search']) List<String> discoveryChannels,
    @Default(true) bool mapVisibility,
    @Default({}) Map<String, String> translationState,
    @Default('open') String status, // JobPostStatus as string for Firestore
    @Default(0) int applicantCount,
    @Default(0) int chatCount,
    @Default(0) int viewCount,
    @Default(false) bool isDeleted,
    @Default(false) bool isClosed,
    @Default('none') String boostStatus,
    String? boostPaymentId,
    String? boostPackageId,
    @OptionalSafeDateTimeConverter() DateTime? boostStartedAt,
    @OptionalSafeDateTimeConverter() DateTime? boostActiveUntil,
    @Default(0) int boostDurationDays,
    @Default(0.0) double boostSignalScore,
    @OptionalSafeDateTimeConverter() DateTime? lastBoostedAt,
    @SafeDateTimeConverter() required DateTime createdAt,
    @SafeDateTimeConverter() required DateTime updatedAt,
    @SafeDateTimeConverter() required DateTime expiresAt,
  }) = _JobPostModel;

  const JobPostModel._();

  @override
  String get userId => ownerId;

  bool get isBoostActive =>
      boostStatus == 'active' &&
      boostActiveUntil != null &&
      boostActiveUntil!.isAfter(DateTime.now());

  bool get hasBoostHistory => boostPaymentId != null || lastBoostedAt != null;

  bool get isBoostExpired =>
      boostStatus == 'active' &&
      boostActiveUntil != null &&
      boostActiveUntil!.isBefore(DateTime.now());

  factory JobPostModel.fromJson(Map<String, dynamic> json) => _$JobPostModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JobPostModelToJson(this as _JobPostModel);

  @override
  String get geoPath {
    final lp = locationParts;
    final l1 = lp.idAddress?.provinsi ?? 'UNKNOWN';
    final l2 = lp.idAddress?.kabupaten ?? 'UNKNOWN';
    final l3 = lp.idAddress?.kecamatan ?? 'UNKNOWN';
    final l4 = lp.idAddress?.kelurahan ?? 'UNKNOWN';
    return 'ID#$l1#$l2#$l3#$l4';
  }
}
