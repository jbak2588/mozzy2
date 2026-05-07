class ChatMessageModel {
  final String id;
  final String roomId;
  final String senderId;
  final String text;
  final String type;
  final String? imageUrl;
  final DateTime createdAt;
  final List<String> readBy;
  final String status;
  final String? localTempId;

  ChatMessageModel({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.text,
    this.type = 'text',
    this.imageUrl,
    required this.createdAt,
    this.readBy = const [],
    this.status = 'sent',
    this.localTempId,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      type: json['type'] as String? ?? 'text',
      imageUrl: json['imageUrl'] as String?,
      createdAt: (json['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
      readBy: List<String>.from(json['readBy'] ?? []),
      status: json['status'] as String? ?? 'sent',
      localTempId: json['localTempId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'senderId': senderId,
      'text': text,
      'type': type,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'readBy': readBy,
      'status': status,
      'localTempId': localTempId,
    };
  }
}
