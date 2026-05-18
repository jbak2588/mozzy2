import '../../../geo/models/location_parts.dart';

class UserFeedContext {
  final LocationParts? locationParts;
  final String timezoneCode;
  final List<String> recentlyShownTypes;

  const UserFeedContext({
    this.locationParts,
    this.timezoneCode = 'WIB',
    this.recentlyShownTypes = const [],
  });

  UserFeedContext copyWith({
    LocationParts? locationParts,
    String? timezoneCode,
    List<String>? recentlyShownTypes,
  }) {
    return UserFeedContext(
      locationParts: locationParts ?? this.locationParts,
      timezoneCode: timezoneCode ?? this.timezoneCode,
      recentlyShownTypes: recentlyShownTypes ?? this.recentlyShownTypes,
    );
  }
}
