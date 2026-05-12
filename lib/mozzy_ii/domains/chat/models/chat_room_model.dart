class ChatRoomModel {
  final String id;
  final String type;
  final List<String> participants;
  final String? buyerId; // Optional for non-marketplace
  final String? sellerId; // Optional for non-marketplace
  final String? productId; // Optional for non-marketplace
  final String? dealId; // Optional for non-marketplace
  final String? productTitle; // Optional for non-marketplace
  final String? productImageUrl;
  final String? jobId; // Added for Jobs
  final String? jobTitle; // Added for Jobs
  final String? lastMessage;
  final String lastMessageType;
  final DateTime? lastMessageAt;
  final String? lastSenderId;
  final Map<String, int> unreadCountByUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, bool> isArchivedByUser;

  ChatRoomModel({
    required this.id,
    this.type = 'marketplace_deal',
    required this.participants,
    this.buyerId,
    this.sellerId,
    this.productId,
    this.dealId,
    this.productTitle,
    this.productImageUrl,
    this.jobId,
    this.jobTitle,
    this.lastMessage,
    this.lastMessageType = 'text',
    this.lastMessageAt,
    this.lastSenderId,
    this.unreadCountByUser = const {},
    required this.createdAt,
    required this.updatedAt,
    this.isArchivedByUser = const {},
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'marketplace_deal',
      participants: List<String>.from(json['participants'] ?? []),
      buyerId: json['buyerId'] as String?,
      sellerId: json['sellerId'] as String?,
      productId: json['productId'] as String?,
      dealId: json['dealId'] as String?,
      productTitle: json['productTitle'] as String?,
      productImageUrl: json['productImageUrl'] as String?,
      jobId: json['jobId'] as String?,
      jobTitle: json['jobTitle'] as String?,
      lastMessage: json['lastMessage'] as String?,
      lastMessageType: json['lastMessageType'] as String? ?? 'text',
      lastMessageAt: json['lastMessageAt'] is DateTime 
          ? json['lastMessageAt'] as DateTime 
          : (json['lastMessageAt'] as dynamic)?.toDate(),
      lastSenderId: json['lastSenderId'] as String?,
      unreadCountByUser: Map<String, int>.from(json['unreadCountByUser'] ?? {}),
      createdAt: json['createdAt'] is DateTime 
          ? json['createdAt'] as DateTime 
          : (json['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
      updatedAt: json['updatedAt'] is DateTime 
          ? json['updatedAt'] as DateTime 
          : (json['updatedAt'] as dynamic)?.toDate() ?? DateTime.now(),
      isArchivedByUser: Map<String, bool>.from(json['isArchivedByUser'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'participants': participants,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'productId': productId,
      'dealId': dealId,
      'productTitle': productTitle,
      'productImageUrl': productImageUrl,
      'jobId': jobId,
      'jobTitle': jobTitle,
      'lastMessage': lastMessage,
      'lastMessageType': lastMessageType,
      'lastMessageAt': lastMessageAt,
      'lastSenderId': lastSenderId,
      'unreadCountByUser': unreadCountByUser,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isArchivedByUser': isArchivedByUser,
    };
  }
}
