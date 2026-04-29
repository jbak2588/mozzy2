import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

class SafeDateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const SafeDateTimeConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    } else if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }
    return DateTime.now(); // Fallback
  }

  @override
  dynamic toJson(DateTime object) => object.toUtc().toIso8601String();
}

class OptionalSafeDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const OptionalSafeDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    } else if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? object) => object?.toUtc().toIso8601String();
}

@freezed
abstract class CommentModel with _$CommentModel {
  const CommentModel._();

  const factory CommentModel({
    required String id,
    required String postId,
    required String userId,
    required String content,
    @SafeDateTimeConverter() required DateTime createdAt,
    @OptionalSafeDateTimeConverter() DateTime? updatedAt,
    @Default(false) bool isDeleted,
    @Default(0) int reportCount,
    @Default(0.3) double trustScore,
    String? parentCommentId,
    @Default(false) bool isSecret,
    @Default('') String postOwnerId,
    String? parentCommentOwnerId,
    @Default([]) List<String> visibleToUserIds,
  }) = _CommentModel;

  bool get isReply => parentCommentId != null && parentCommentId!.isNotEmpty;

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
}
