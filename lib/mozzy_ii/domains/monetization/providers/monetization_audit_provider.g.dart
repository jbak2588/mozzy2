// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monetization_audit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(monetizationAuditRepository)
final monetizationAuditRepositoryProvider =
    MonetizationAuditRepositoryProvider._();

final class MonetizationAuditRepositoryProvider
    extends
        $FunctionalProvider<
          MonetizationAuditRepository,
          MonetizationAuditRepository,
          MonetizationAuditRepository
        >
    with $Provider<MonetizationAuditRepository> {
  MonetizationAuditRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monetizationAuditRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monetizationAuditRepositoryHash();

  @$internal
  @override
  $ProviderElement<MonetizationAuditRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MonetizationAuditRepository create(Ref ref) {
    return monetizationAuditRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MonetizationAuditRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MonetizationAuditRepository>(value),
    );
  }
}

String _$monetizationAuditRepositoryHash() =>
    r'9f7f437e1bee1c546c187af7f8e89bccd9af2123';

@ProviderFor(jobBoostAuditLogs)
final jobBoostAuditLogsProvider = JobBoostAuditLogsFamily._();

final class JobBoostAuditLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MonetizationAuditLogModel>>,
          List<MonetizationAuditLogModel>,
          Stream<List<MonetizationAuditLogModel>>
        >
    with
        $FutureModifier<List<MonetizationAuditLogModel>>,
        $StreamProvider<List<MonetizationAuditLogModel>> {
  JobBoostAuditLogsProvider._({
    required JobBoostAuditLogsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'jobBoostAuditLogsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$jobBoostAuditLogsHash();

  @override
  String toString() {
    return r'jobBoostAuditLogsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<MonetizationAuditLogModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MonetizationAuditLogModel>> create(Ref ref) {
    final argument = this.argument as String;
    return jobBoostAuditLogs(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is JobBoostAuditLogsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$jobBoostAuditLogsHash() => r'a4f869348ec1233015154b4b046900afc3067f90';

final class JobBoostAuditLogsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<MonetizationAuditLogModel>>,
          String
        > {
  JobBoostAuditLogsFamily._()
    : super(
        retry: null,
        name: r'jobBoostAuditLogsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JobBoostAuditLogsProvider call(String jobId) =>
      JobBoostAuditLogsProvider._(argument: jobId, from: this);

  @override
  String toString() => r'jobBoostAuditLogsProvider';
}

@ProviderFor(paymentAuditLogs)
final paymentAuditLogsProvider = PaymentAuditLogsFamily._();

final class PaymentAuditLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MonetizationAuditLogModel>>,
          List<MonetizationAuditLogModel>,
          Stream<List<MonetizationAuditLogModel>>
        >
    with
        $FutureModifier<List<MonetizationAuditLogModel>>,
        $StreamProvider<List<MonetizationAuditLogModel>> {
  PaymentAuditLogsProvider._({
    required PaymentAuditLogsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'paymentAuditLogsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paymentAuditLogsHash();

  @override
  String toString() {
    return r'paymentAuditLogsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<MonetizationAuditLogModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MonetizationAuditLogModel>> create(Ref ref) {
    final argument = this.argument as String;
    return paymentAuditLogs(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentAuditLogsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paymentAuditLogsHash() => r'9b49b9febcad3572abc4d931fab06af9e159ca89';

final class PaymentAuditLogsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<MonetizationAuditLogModel>>,
          String
        > {
  PaymentAuditLogsFamily._()
    : super(
        retry: null,
        name: r'paymentAuditLogsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PaymentAuditLogsProvider call(String paymentId) =>
      PaymentAuditLogsProvider._(argument: paymentId, from: this);

  @override
  String toString() => r'paymentAuditLogsProvider';
}
