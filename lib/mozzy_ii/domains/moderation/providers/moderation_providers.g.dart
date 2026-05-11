// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moderation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportRepository)
final reportRepositoryProvider = ReportRepositoryProvider._();

final class ReportRepositoryProvider
    extends
        $FunctionalProvider<
          ReportRepository,
          ReportRepository,
          ReportRepository
        >
    with $Provider<ReportRepository> {
  ReportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReportRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReportRepository create(Ref ref) {
    return reportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportRepository>(value),
    );
  }
}

String _$reportRepositoryHash() => r'f75d5b0e192af0f9159d06fcdf2075efbb5eb1eb';

@ProviderFor(moderationService)
final moderationServiceProvider = ModerationServiceProvider._();

final class ModerationServiceProvider
    extends
        $FunctionalProvider<
          ModerationService,
          ModerationService,
          ModerationService
        >
    with $Provider<ModerationService> {
  ModerationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moderationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$moderationServiceHash();

  @$internal
  @override
  $ProviderElement<ModerationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ModerationService create(Ref ref) {
    return moderationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ModerationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ModerationService>(value),
    );
  }
}

String _$moderationServiceHash() => r'6071fe4e129babe4cd03fbd02215bd0d67561be1';

@ProviderFor(pendingReports)
final pendingReportsProvider = PendingReportsProvider._();

final class PendingReportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReportModel>>,
          List<ReportModel>,
          Stream<List<ReportModel>>
        >
    with
        $FutureModifier<List<ReportModel>>,
        $StreamProvider<List<ReportModel>> {
  PendingReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingReportsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingReportsHash();

  @$internal
  @override
  $StreamProviderElement<List<ReportModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ReportModel>> create(Ref ref) {
    return pendingReports(ref);
  }
}

String _$pendingReportsHash() => r'd6b8d195187fa7053b5b9c266434294eaf751a9a';
