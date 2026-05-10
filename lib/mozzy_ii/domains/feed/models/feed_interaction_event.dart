import 'feed_interaction_type.dart';

class FeedInteractionEvent {
  final String? id;
  final FeedInteractionType eventType;
  final String feedItemId;
  final String sourceId;
  final String sourceType;
  final String? route;
  final int position;
  final bool isPromoted;
  final bool hasSemanticIntent;
  final String? intentLengthBucket;
  final String countryCode;
  final Map<String, dynamic> locationParts;
  final DateTime? clientCreatedAt;
  final String? sessionId;
  final String? impressionMode;
  final double? visibleRatio;
  final int? dwellMs;
  final Map<String, dynamic>? metadata;

  FeedInteractionEvent({
    this.id,
    required this.eventType,
    required this.feedItemId,
    required this.sourceId,
    required this.sourceType,
    this.route,
    required this.position,
    this.isPromoted = false,
    this.hasSemanticIntent = false,
    this.intentLengthBucket,
    this.countryCode = 'ID',
    this.locationParts = const {},
    this.clientCreatedAt,
    this.sessionId,
    this.impressionMode,
    this.visibleRatio,
    this.dwellMs,
    this.metadata,
  });

  static const Set<String> forbiddenMetadataKeys = {
    'intent',
    'searchQuery',
    'query',
    'email',
    'phone',
    'exactAddress',
    'paymentId',
    'auditId',
    'fcmToken',
    'prompt',
    'userId',
    'ownerId',
  };

  Map<String, dynamic> _safeMetadata(Map<String, dynamic>? metadata) {
    if (metadata == null) return const {};
    final cleaned = <String, dynamic>{};
    for (final entry in metadata.entries) {
      if (!forbiddenMetadataKeys.contains(entry.key)) {
        cleaned[entry.key] = entry.value;
      }
    }
    return cleaned;
  }

  Map<String, dynamic> toSafeJson() {
    return {
      'eventType': eventType.wireValue,
      'feedItemId': feedItemId,
      'sourceId': sourceId,
      'sourceType': sourceType,
      'route': route,
      'position': position,
      'isPromoted': isPromoted,
      'hasSemanticIntent': hasSemanticIntent,
      'intentLengthBucket': intentLengthBucket,
      'countryCode': countryCode,
      'locationParts': locationParts,
      'clientCreatedAt': clientCreatedAt?.toIso8601String(),
      'sessionId': sessionId,
      if (impressionMode != null) 'impressionMode': impressionMode,
      if (visibleRatio != null) 'visibleRatio': visibleRatio,
      if (dwellMs != null) 'dwellMs': dwellMs,
      'metadata': _safeMetadata(metadata),
    };
  }
}
