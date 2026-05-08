// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$paymentRepositoryHash() => r'9aff8465dd5adb012719f9908afe2a9bf9d0a894';

@ProviderFor(paymentDetail)
final paymentDetailProvider = PaymentDetailFamily._();

final class PaymentDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaymentModel?>,
          PaymentModel?,
          Stream<PaymentModel?>
        >
    with $FutureModifier<PaymentModel?>, $StreamProvider<PaymentModel?> {
  PaymentDetailProvider._({
    required PaymentDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'paymentDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paymentDetailHash();

  @override
  String toString() {
    return r'paymentDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<PaymentModel?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PaymentModel?> create(Ref ref) {
    final argument = this.argument as String;
    return paymentDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paymentDetailHash() => r'623aa7e9fba3cac5549b4234c8947b5f6eee54e3';

final class PaymentDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<PaymentModel?>, String> {
  PaymentDetailFamily._()
    : super(
        retry: null,
        name: r'paymentDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PaymentDetailProvider call(String paymentId) =>
      PaymentDetailProvider._(argument: paymentId, from: this);

  @override
  String toString() => r'paymentDetailProvider';
}
