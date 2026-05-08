// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boost_package_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jobBoostPackages)
final jobBoostPackagesProvider = JobBoostPackagesProvider._();

final class JobBoostPackagesProvider
    extends
        $FunctionalProvider<
          List<BoostPackageModel>,
          List<BoostPackageModel>,
          List<BoostPackageModel>
        >
    with $Provider<List<BoostPackageModel>> {
  JobBoostPackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jobBoostPackagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jobBoostPackagesHash();

  @$internal
  @override
  $ProviderElement<List<BoostPackageModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<BoostPackageModel> create(Ref ref) {
    return jobBoostPackages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<BoostPackageModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<BoostPackageModel>>(value),
    );
  }
}

String _$jobBoostPackagesHash() => r'56b4ad723af18631ac058ba654585596e59d297a';
