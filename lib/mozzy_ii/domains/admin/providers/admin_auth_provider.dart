import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/admin_claims_model.dart';

part 'admin_auth_provider.g.dart';

@riverpod
class AdminAuth extends _$AdminAuth {
  @override
  Stream<AdminClaimsModel> build() {
    return FirebaseAuth.instance.idTokenChanges().asyncMap((user) async {
      if (user == null) {
        return const AdminClaimsModel();
      }
      
      // Force refresh token to get latest custom claims
      final idTokenResult = await user.getIdTokenResult(true);
      return AdminClaimsModel.fromTokenClaims(idTokenResult.claims);
    });
  }

  Future<void> refreshClaims() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.getIdToken(true);
    }
  }
}

@riverpod
bool isAdmin(Ref ref) {
  final claimsAsync = ref.watch(adminAuthProvider);
  return claimsAsync.maybeWhen(
    data: (claims) => claims.isAdmin,
    orElse: () => false,
  );
}

@riverpod
String? adminRole(Ref ref) {
  final claimsAsync = ref.watch(adminAuthProvider);
  return claimsAsync.maybeWhen(
    data: (claims) => claims.adminRole,
    orElse: () => null,
  );
}

@riverpod
bool canReadMonetizationAudit(Ref ref) {
  final claimsAsync = ref.watch(adminAuthProvider);
  return claimsAsync.maybeWhen(
    data: (claims) => claims.canReadMonetizationAudit,
    orElse: () => false,
  );
}
