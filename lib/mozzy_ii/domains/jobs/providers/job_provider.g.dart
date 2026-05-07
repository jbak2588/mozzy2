// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JobFilters)
final jobFiltersProvider = JobFiltersProvider._();

final class JobFiltersProvider
    extends $NotifierProvider<JobFilters, JobFiltersState> {
  JobFiltersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jobFiltersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jobFiltersHash();

  @$internal
  @override
  JobFilters create() => JobFilters();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JobFiltersState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JobFiltersState>(value),
    );
  }
}

String _$jobFiltersHash() => r'4b238375a99c932f067181a5c65c917156108b3b';

abstract class _$JobFilters extends $Notifier<JobFiltersState> {
  JobFiltersState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<JobFiltersState, JobFiltersState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<JobFiltersState, JobFiltersState>,
              JobFiltersState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ownerJobs)
final ownerJobsProvider = OwnerJobsFamily._();

final class OwnerJobsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JobPostModel>>,
          List<JobPostModel>,
          Stream<List<JobPostModel>>
        >
    with
        $FutureModifier<List<JobPostModel>>,
        $StreamProvider<List<JobPostModel>> {
  OwnerJobsProvider._({
    required OwnerJobsFamily super.from,
    required ({String ownerId, JobPostStatus? status}) super.argument,
  }) : super(
         retry: null,
         name: r'ownerJobsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ownerJobsHash();

  @override
  String toString() {
    return r'ownerJobsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<JobPostModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<JobPostModel>> create(Ref ref) {
    final argument = this.argument as ({String ownerId, JobPostStatus? status});
    return ownerJobs(ref, ownerId: argument.ownerId, status: argument.status);
  }

  @override
  bool operator ==(Object other) {
    return other is OwnerJobsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ownerJobsHash() => r'991db5b0984f73031078f408027e3bef89380fc4';

final class OwnerJobsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<JobPostModel>>,
          ({String ownerId, JobPostStatus? status})
        > {
  OwnerJobsFamily._()
    : super(
        retry: null,
        name: r'ownerJobsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OwnerJobsProvider call({required String ownerId, JobPostStatus? status}) =>
      OwnerJobsProvider._(
        argument: (ownerId: ownerId, status: status),
        from: this,
      );

  @override
  String toString() => r'ownerJobsProvider';
}

@ProviderFor(MyJobsFilter)
final myJobsFilterProvider = MyJobsFilterProvider._();

final class MyJobsFilterProvider
    extends $NotifierProvider<MyJobsFilter, JobPostStatus?> {
  MyJobsFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myJobsFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myJobsFilterHash();

  @$internal
  @override
  MyJobsFilter create() => MyJobsFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JobPostStatus? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JobPostStatus?>(value),
    );
  }
}

String _$myJobsFilterHash() => r'5cdf9c89ca6fdffb0e63427dfffc57ae3c728913';

abstract class _$MyJobsFilter extends $Notifier<JobPostStatus?> {
  JobPostStatus? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<JobPostStatus?, JobPostStatus?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<JobPostStatus?, JobPostStatus?>,
              JobPostStatus?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(myJobs)
final myJobsProvider = MyJobsProvider._();

final class MyJobsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JobPostModel>>,
          List<JobPostModel>,
          Stream<List<JobPostModel>>
        >
    with
        $FutureModifier<List<JobPostModel>>,
        $StreamProvider<List<JobPostModel>> {
  MyJobsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myJobsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myJobsHash();

  @$internal
  @override
  $StreamProviderElement<List<JobPostModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<JobPostModel>> create(Ref ref) {
    return myJobs(ref);
  }
}

String _$myJobsHash() => r'd654f422af206b3693ccc96d17827e0ccf41d132';

@ProviderFor(JobActionController)
final jobActionControllerProvider = JobActionControllerProvider._();

final class JobActionControllerProvider
    extends $NotifierProvider<JobActionController, AsyncValue<void>> {
  JobActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jobActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jobActionControllerHash();

  @$internal
  @override
  JobActionController create() => JobActionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$jobActionControllerHash() =>
    r'87ab9189048d5d59766d55d7f50cfde175c69413';

abstract class _$JobActionController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
