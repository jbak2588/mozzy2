class MozzyNotificationModel {
  final String id;
  final String recipientId;
  final String? senderId;
  final String notificationType;
  final String titleKey;
  final String bodyKey;
  final Map<String, String> titleParams;
  final Map<String, String> bodyParams;
  final String? chatRoomId;
  final String? productId;
  final String? dealId;
  final String? route;
  final String? jobId;
  final String? applicantId;
  final bool isRead;
  final DateTime createdAt;

  MozzyNotificationModel({
    required this.id,
    required this.recipientId,
    this.senderId,
    required this.notificationType,
    required this.titleKey,
    required this.bodyKey,
    this.titleParams = const {},
    this.bodyParams = const {},
    this.chatRoomId,
    this.productId,
    this.dealId,
    this.route,
    this.jobId,
    this.applicantId,
    this.isRead = false,
    required this.createdAt,
  });

  factory MozzyNotificationModel.fromJson(Map<String, dynamic> json) {
    return MozzyNotificationModel(
      id: json['id'] as String,
      recipientId: json['recipientId'] as String,
      senderId: json['senderId'] as String?,
      notificationType: json['type'] as String,
      titleKey: json['titleKey'] as String,
      bodyKey: json['bodyKey'] as String,
      titleParams: Map<String, String>.from(json['titleParams'] ?? {}),
      bodyParams: Map<String, String>.from(json['bodyParams'] ?? {}),
      chatRoomId: json['chatRoomId'] as String?,
      productId: json['productId'] as String?,
      dealId: json['dealId'] as String?,
      route: json['route'] as String?,
      jobId: json['jobId'] as String?,
      applicantId: json['applicantId'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      createdAt: (json['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipientId': recipientId,
      'senderId': senderId,
      'type': notificationType,
      'titleKey': titleKey,
      'bodyKey': bodyKey,
      'titleParams': titleParams,
      'bodyParams': bodyParams,
      'chatRoomId': chatRoomId,
      'productId': productId,
      'dealId': dealId,
      'route': route,
      'jobId': jobId,
      'applicantId': applicantId,
      'isRead': isRead,
      'createdAt': createdAt,
    };
  }
}
