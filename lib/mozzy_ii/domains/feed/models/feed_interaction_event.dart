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
    this.metadata,
  });

  Map<String, dynamic> toSafeJson() {
    return {
      'eventType': eventType.name,
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
      'metadata': metadata,
    };
  }
}
