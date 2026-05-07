import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../geo/models/location_parts.dart';
import '../../../geo/providers/location_provider.dart';
import '../../../geo/utils/default_indonesia_location.dart';
import '../../users/data/repositories/user_repository.dart';
import 'job_provider.dart';

final effectiveJobsLocationProvider = FutureProvider.autoDispose<LocationParts>((ref) async {
  final uid = ref.watch(currentJobsUserIdProvider);

  // 1. User profile location
  if (uid != null) {
    try {
      final userRepo = ref.read(userRepositoryProvider);
      final user = await userRepo.getUser(uid).timeout(const Duration(seconds: 5));
      if (user?.locationParts != null) return user!.locationParts!;
    } catch (_) {}
  }

  // 2. Device location
  try {
    final deviceLocation = await ref.read(locationProvider.future).timeout(
      const Duration(seconds: 5),
      onTimeout: () => null,
    );
    if (deviceLocation != null) return deviceLocation;
  } catch (_) {}

  // 3. Fallback
  return defaultJakartaSenayanLocation();
});
