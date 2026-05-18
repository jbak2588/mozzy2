// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(xenditService)
final xenditServiceProvider = XenditServiceProvider._();

final class XenditServiceProvider
    extends $FunctionalProvider<XenditService, XenditService, XenditService>
    with $Provider<XenditService> {
  XenditServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'xenditServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$xenditServiceHash();

  @$internal
  @override
  $ProviderElement<XenditService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  XenditService create(Ref ref) {
    return xenditService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(XenditService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<XenditService>(value),
    );
  }
}

String _$xenditServiceHash() => r'1fe32bc5441e3b9c5ae394291ad32a753bcc93bd';

@ProviderFor(paymentRepository)
final paymentRepositoryProvider = PaymentRepositoryProvider._();

final class PaymentRepositoryProvider
    extends
        $FunctionalProvider<
          PaymentRepository,
          PaymentRepository,
          PaymentRepository
        >
    with $Provider<PaymentRepository> {
  PaymentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentRepositoryHash();

  @$internal
  @override
  $ProviderElement<PaymentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PaymentRepository create(Ref ref) {
    return paymentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentRepository>(value),
    );
  }
}

String _$paymentRepositoryHash() => r'48957ded3ac2127f2aa73702f8b3d1fe7bb453f0';
