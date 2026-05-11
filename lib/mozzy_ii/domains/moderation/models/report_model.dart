import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

enum ReportTargetType {
  @JsonValue('news')
  news,
  @JsonValue('marketplace')
  marketplace,
  @JsonValue('jobs')
  jobs,
  @JsonValue('chat')
  chat,
  @JsonValue('user')
  user,
}

enum ReportReason {
  @JsonValue('spam')
  spam,
  @JsonValue('scam')
  scam,
  @JsonValue('offensive')
  offensive,
  @JsonValue('illegal')
  illegal,
  @JsonValue('harassment')
  harassment,
  @JsonValue('fake')
  fake,
  @JsonValue('other')
  other,
}

enum ReportStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('reviewed')
  reviewed,
  @JsonValue('dismissed')
  dismissed,
  @JsonValue('actionTaken')
  actionTaken,
}

enum ModerationStatus {
  @JsonValue('visible')
  visible,
  @JsonValue('underReview')
  underReview,
  @JsonValue('hidden')
  hidden,
  @JsonValue('removed')
  removed,
}

class SafeDateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const SafeDateTimeConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime date) => Timestamp.fromDate(date);
}

class OptionalSafeDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const OptionalSafeDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    return null;
  }

  @override
  dynamic toJson(DateTime? date) => date != null ? Timestamp.fromDate(date) : null;
}

@freezed
abstract class ReportModel with _$ReportModel {
  const factory ReportModel({
    required String id,
    required ReportTargetType targetType,
    required String targetId,
    String? targetOwnerId,
    required String reporterId,
    required ReportReason reason,
    String? description,
    @Default(ReportStatus.pending) ReportStatus status,
    @Default('medium') String severity,
    @SafeDateTimeConverter() required DateTime createdAt,
    @OptionalSafeDateTimeConverter() DateTime? reviewedAt,
    String? reviewedBy,
    String? adminNote,
    @Default('ID') String countryCode,
    String? sourceRoute,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);
}
