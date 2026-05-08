// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminAuth)
final adminAuthProvider = AdminAuthProvider._();

final class AdminAuthProvider
    extends $StreamNotifierProvider<AdminAuth, AdminClaimsModel> {
  AdminAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAuthHash();

  @$internal
  @override
  AdminAuth create() => AdminAuth();
}

String _$adminAuthHash() => r'032908a864f5eebf414cde6f9cad9edf5d63496e';

abstract class _$AdminAuth extends $StreamNotifier<AdminClaimsModel> {
  Stream<AdminClaimsModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AdminClaimsModel>, AdminClaimsModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AdminClaimsModel>, AdminClaimsModel>,
              AsyncValue<AdminClaimsModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(isAdmin)
final isAdminProvider = IsAdminProvider._();

final class IsAdminProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsAdminProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAdminProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAdminHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAdmin(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAdminHash() => r'26fe3481a6b9816a60c51afe903e295c773727f1';

@ProviderFor(adminRole)
final adminRoleProvider = AdminRoleProvider._();

final class AdminRoleProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  AdminRoleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminRoleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminRoleHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return adminRole(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$adminRoleHash() => r'173cf9aa622bcf8467e66a70ed087169cf565d7e';
