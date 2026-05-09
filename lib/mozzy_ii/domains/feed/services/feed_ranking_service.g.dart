// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_ranking_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeedRankingService)
final feedRankingServiceProvider = FeedRankingServiceProvider._();

final class FeedRankingServiceProvider
    extends $NotifierProvider<FeedRankingService, void> {
  FeedRankingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedRankingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedRankingServiceHash();

  @$internal
  @override
  FeedRankingService create() => FeedRankingService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$feedRankingServiceHash() =>
    r'3b5460cf560d5417c95f320667ce3de4234b9993';

abstract class _$FeedRankingService extends $Notifier<void> {
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
