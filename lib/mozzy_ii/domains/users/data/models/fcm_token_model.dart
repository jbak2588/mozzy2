class FcmTokenModel {
  final String token;
  final String platform;
  final String? deviceId;
  final String? appVersion;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastSeenAt;
  final bool isActive;

  FcmTokenModel({
    required this.token,
    required this.platform,
    this.deviceId,
    this.appVersion,
    required this.createdAt,
    required this.updatedAt,
    required this.lastSeenAt,
    this.isActive = true,
  });

  factory FcmTokenModel.fromJson(Map<String, dynamic> json) {
    return FcmTokenModel(
      token: json['token'] as String,
      platform: json['platform'] as String,
      deviceId: json['deviceId'] as String?,
      appVersion: json['appVersion'] as String?,
      createdAt: (json['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
      updatedAt: (json['updatedAt'] as dynamic)?.toDate() ?? DateTime.now(),
      lastSeenAt: (json['lastSeenAt'] as dynamic)?.toDate() ?? DateTime.now(),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'platform': platform,
      'deviceId': deviceId,
      'appVersion': appVersion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lastSeenAt': lastSeenAt,
      'isActive': isActive,
    };
  }
}
