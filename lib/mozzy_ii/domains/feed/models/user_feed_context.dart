import '../../../geo/models/location_parts.dart';

class UserFeedContext {
  final LocationParts? locationParts;
  final List<String> recentlyShownTypes;

  const UserFeedContext({
    this.locationParts,
    this.recentlyShownTypes = const [],
  });
}
