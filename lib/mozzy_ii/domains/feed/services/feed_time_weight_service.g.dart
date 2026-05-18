// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_time_weight_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeedTimeWeightService)
final feedTimeWeightServiceProvider = FeedTimeWeightServiceProvider._();

final class FeedTimeWeightServiceProvider
    extends $NotifierProvider<FeedTimeWeightService, void> {
  FeedTimeWeightServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedTimeWeightServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedTimeWeightServiceHash();

  @$internal
  @override
  FeedTimeWeightService create() => FeedTimeWeightService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$feedTimeWeightServiceHash() =>
    r'4dfa035792f2f014b2d84edc36e0b769aacb864e';

abstract class _$FeedTimeWeightService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
