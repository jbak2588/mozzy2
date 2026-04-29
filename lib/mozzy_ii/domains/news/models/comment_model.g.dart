// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
      updatedAt: const OptionalSafeDateTimeConverter().fromJson(
        json['updatedAt'],
      ),
      isDeleted: json['isDeleted'] as bool? ?? false,
      reportCount: (json['reportCount'] as num?)?.toInt() ?? 0,
      trustScore: (json['trustScore'] as num?)?.toDouble() ?? 0.3,
      parentCommentId: json['parentCommentId'] as String?,
      isSecret: json['isSecret'] as bool? ?? false,
      postOwnerId: json['postOwnerId'] as String? ?? '',
      parentCommentOwnerId: json['parentCommentOwnerId'] as String?,
      visibleToUserIds:
          (json['visibleToUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CommentModelToJson(
  _CommentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'postId': instance.postId,
  'userId': instance.userId,
  'content': instance.content,
  'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const OptionalSafeDateTimeConverter().toJson(instance.updatedAt),
  'isDeleted': instance.isDeleted,
  'reportCount': instance.reportCount,
  'trustScore': instance.trustScore,
  'parentCommentId': instance.parentCommentId,
  'isSecret': instance.isSecret,
  'postOwnerId': instance.postOwnerId,
  'parentCommentOwnerId': instance.parentCommentOwnerId,
  'visibleToUserIds': instance.visibleToUserIds,
};
