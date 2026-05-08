// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PaymentAction)
final paymentActionProvider = PaymentActionProvider._();

final class PaymentActionProvider
    extends $NotifierProvider<PaymentAction, AsyncValue<void>> {
  PaymentActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentActionHash();

  @$internal
  @override
  PaymentAction create() => PaymentAction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$paymentActionHash() => r'b639b12ba2084a818320679bfdcfc6e1b28fcec2';

abstract class _$PaymentAction extends $Notifier<AsyncValue<void>> {
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
