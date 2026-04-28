import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

/// Simple FutureProvider.family to fetch user model by uid
final userModelProvider = FutureProvider.family<UserModel?, String>((
  ref,
  uid,
) async {
  final repo = ref.read(userRepositoryProvider);
  return await repo.getUser(uid);
});
