import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/repositories/user_safety_repository.dart';
import '../../../app/auth/auth_service.dart';

final userSafetyRepositoryProvider = Provider<UserSafetyRepository>((ref) {
  return UserSafetyRepository(FirebaseFirestore.instance);
});

final isUserBlockedProvider = FutureProvider.family<bool, String>((ref, targetUserId) async {
  final currentUserId = ref.watch(authStateProvider).value?.uid;
  if (currentUserId == null) return false;
  
  return ref.watch(userSafetyRepositoryProvider).isBlocked(currentUserId, targetUserId);
});
