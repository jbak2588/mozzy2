import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final feedSessionIdProvider = Provider<String>((ref) {
  // Simple UUID for the session, regenerated on app restart/provider refresh
  return const Uuid().v4();
});
