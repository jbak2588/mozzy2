// ============================================================================
// Mozzy DocHeader
// Module        : Core Config
// File          : lib/mozzy_ii/core/config/firebase_constants.dart
// Purpose       : Firestore 컬렉션 이름 및 공통 경로를 상수로 관리합니다.
// ============================================================================

class FirebaseConstants {
  // [1] Root Collections
  static const String users = 'users';
  static const String countries = 'countries';

  // [2] Sub Collections (Path-Sharding)
  static const String domains = 'domains';
  static const String posts = 'posts';
  
  // [3] Chat
  static const String chatRooms = 'chat_rooms';
  static const String messages = 'messages';

  // [4] Field Names
  static const String fieldUserId = 'userId';
  static const String fieldGeoPath = 'geoPath';
  static const String fieldTrustScore = 'trustScore';
  static const String fieldSignalScore = 'signalScore';
  static const String fieldCreatedAt = 'createdAt';
}
