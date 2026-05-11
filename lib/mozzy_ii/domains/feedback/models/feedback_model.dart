import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

enum FeedbackType {
  @JsonValue('bug')
  bug,
  @JsonValue('suggestion')
  suggestion,
  @JsonValue('usability')
  usability,
  @JsonValue('payment')
  payment,
  @JsonValue('account')
  account,
  @JsonValue('safety')
  safety,
  @JsonValue('other')
  other,
}

enum FeedbackStatus {
  @JsonValue('open')
  open,
  @JsonValue('inReview')
  inReview,
  @JsonValue('resolved')
  resolved,
  @JsonValue('dismissed')
  dismissed,
}

enum FeedbackPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
}

enum FeedbackContactPreference {
  @JsonValue('none')
  none,
  @JsonValue('whatsapp')
  whatsapp,
  @JsonValue('email')
  email,
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
abstract class FeedbackModel with _$FeedbackModel {
  const factory FeedbackModel({
    required String id,
    required String userId,
    required FeedbackType type,
    required String message,
    @Default(FeedbackContactPreference.none) FeedbackContactPreference contactPreference,
    String? contactValue,
    required String appVersion,
    required String platform,
    required String appEnv,
    @Default(FeedbackStatus.open) FeedbackStatus status,
    @Default(FeedbackPriority.low) FeedbackPriority priority,
    @SafeDateTimeConverter() required DateTime createdAt,
    @SafeDateTimeConverter() required DateTime updatedAt,
    String? adminNote,
    String? resolvedBy,
    @OptionalSafeDateTimeConverter() DateTime? resolvedAt,
  }) = _FeedbackModel;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => _$FeedbackModelFromJson(json);
}
