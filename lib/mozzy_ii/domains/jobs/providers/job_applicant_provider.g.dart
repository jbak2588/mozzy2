// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_applicant_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jobApplicants)
final jobApplicantsProvider = JobApplicantsFamily._();

final class JobApplicantsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JobApplicantModel>>,
          List<JobApplicantModel>,
          Stream<List<JobApplicantModel>>
        >
    with
        $FutureModifier<List<JobApplicantModel>>,
        $StreamProvider<List<JobApplicantModel>> {
  JobApplicantsProvider._({
    required JobApplicantsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'jobApplicantsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$jobApplicantsHash();

  @override
  String toString() {
    return r'jobApplicantsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<JobApplicantModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<JobApplicantModel>> create(Ref ref) {
    final argument = this.argument as String;
    return jobApplicants(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is JobApplicantsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$jobApplicantsHash() => r'4baeb34bd1d5405e79176c51a9b4f84ed3679de2';

final class JobApplicantsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<JobApplicantModel>>, String> {
  JobApplicantsFamily._()
    : super(
        retry: null,
        name: r'jobApplicantsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JobApplicantsProvider call(String jobId) =>
      JobApplicantsProvider._(argument: jobId, from: this);

  @override
  String toString() => r'jobApplicantsProvider';
}

@ProviderFor(ApplicantStatusFilter)
final applicantStatusFilterProvider = ApplicantStatusFilterProvider._();

final class ApplicantStatusFilterProvider
    extends $NotifierProvider<ApplicantStatusFilter, JobApplicantStatus?> {
  ApplicantStatusFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicantStatusFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicantStatusFilterHash();

  @$internal
  @override
  ApplicantStatusFilter create() => ApplicantStatusFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JobApplicantStatus? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JobApplicantStatus?>(value),
    );
  }
}

String _$applicantStatusFilterHash() =>
    r'74964e603bf18af659ac71846193330fbd75228e';

abstract class _$ApplicantStatusFilter extends $Notifier<JobApplicantStatus?> {
  JobApplicantStatus? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<JobApplicantStatus?, JobApplicantStatus?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<JobApplicantStatus?, JobApplicantStatus?>,
              JobApplicantStatus?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredJobApplicants)
final filteredJobApplicantsProvider = FilteredJobApplicantsFamily._();

final class FilteredJobApplicantsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JobApplicantModel>>,
          AsyncValue<List<JobApplicantModel>>,
          AsyncValue<List<JobApplicantModel>>
        >
    with $Provider<AsyncValue<List<JobApplicantModel>>> {
  FilteredJobApplicantsProvider._({
    required FilteredJobApplicantsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'filteredJobApplicantsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredJobApplicantsHash();

  @override
  String toString() {
    return r'filteredJobApplicantsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<List<JobApplicantModel>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<JobApplicantModel>> create(Ref ref) {
    final argument = this.argument as String;
    return filteredJobApplicants(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<JobApplicantModel>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<JobApplicantModel>>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredJobApplicantsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredJobApplicantsHash() =>
    r'f5be6027d04945b19dd05e8e4d569d58ca7eb93f';

final class FilteredJobApplicantsFamily extends $Family
    with
        $FunctionalFamilyOverride<AsyncValue<List<JobApplicantModel>>, String> {
  FilteredJobApplicantsFamily._()
    : super(
        retry: null,
        name: r'filteredJobApplicantsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredJobApplicantsProvider call(String jobId) =>
      FilteredJobApplicantsProvider._(argument: jobId, from: this);

  @override
  String toString() => r'filteredJobApplicantsProvider';
}

@ProviderFor(myApplicantRecord)
final myApplicantRecordProvider = MyApplicantRecordFamily._();

final class MyApplicantRecordProvider
    extends
        $FunctionalProvider<
          AsyncValue<JobApplicantModel?>,
          JobApplicantModel?,
          FutureOr<JobApplicantModel?>
        >
    with
        $FutureModifier<JobApplicantModel?>,
        $FutureProvider<JobApplicantModel?> {
  MyApplicantRecordProvider._({
    required MyApplicantRecordFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'myApplicantRecordProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$myApplicantRecordHash();

  @override
  String toString() {
    return r'myApplicantRecordProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<JobApplicantModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JobApplicantModel?> create(Ref ref) {
    final argument = this.argument as String;
    return myApplicantRecord(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MyApplicantRecordProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$myApplicantRecordHash() => r'd1f4a8ded1d1bae5a51a6230eaddd52ddc4cbfc0';

final class MyApplicantRecordFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<JobApplicantModel?>, String> {
  MyApplicantRecordFamily._()
    : super(
        retry: null,
        name: r'myApplicantRecordProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MyApplicantRecordProvider call(String jobId) =>
      MyApplicantRecordProvider._(argument: jobId, from: this);

  @override
  String toString() => r'myApplicantRecordProvider';
}

@ProviderFor(JobApplicantActionController)
final jobApplicantActionControllerProvider =
    JobApplicantActionControllerProvider._();

final class JobApplicantActionControllerProvider
    extends $NotifierProvider<JobApplicantActionController, AsyncValue<void>> {
  JobApplicantActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jobApplicantActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jobApplicantActionControllerHash();

  @$internal
  @override
  JobApplicantActionController create() => JobApplicantActionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$jobApplicantActionControllerHash() =>
    r'b228eb822e85d31cd4d993ff1a1c998b65874074';

abstract class _$JobApplicantActionController
    extends $Notifier<AsyncValue<void>> {
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
