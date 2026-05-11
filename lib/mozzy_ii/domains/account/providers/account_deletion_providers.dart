import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/account_deletion_service.dart';

part 'account_deletion_providers.g.dart';

@riverpod
AccountDeletionService accountDeletionService(Ref ref) {
  return AccountDeletionService(FirebaseFunctions.instance);
}
