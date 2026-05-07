import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/datetime_converter.dart';

part 'job_applicant_model.freezed.dart';
part 'job_applicant_model.g.dart';

enum JobApplicantStatus {
  @JsonValue('new')
  newApplicant,
  @JsonValue('contacted')
  contacted,
  @JsonValue('shortlisted')
  shortlisted,
  @JsonValue('rejected')
  rejected,
  @JsonValue('hired')
  hired,
}

@freezed
abstract class JobApplicantModel with _$JobApplicantModel {
  const factory JobApplicantModel({
    required String id,
    required String jobId,
    required String applicantId,
    required String applicantName,
    String? applicantPhotoUrl,
    String? applicantPhoneMasked,
    String? chatRoomId,
    @Default(JobApplicantStatus.newApplicant) JobApplicantStatus status,
    String? messagePreview,
    @SafeDateTimeConverter() required DateTime appliedAt,
    @SafeDateTimeConverter() required DateTime updatedAt,
    @SafeDateTimeConverter() DateTime? lastInteractionAt,
    @Default('job_detail') String source,
    @Default('ID') String countryCode,
  }) = _JobApplicantModel;

  const JobApplicantModel._();

  factory JobApplicantModel.fromJson(Map<String, dynamic> json) => _$JobApplicantModelFromJson(json);
}
