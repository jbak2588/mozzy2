// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(smartFeedRepository)
final smartFeedRepositoryProvider = SmartFeedRepositoryProvider._();

final class SmartFeedRepositoryProvider
    extends
        $FunctionalProvider<
          SmartFeedRepository,
          SmartFeedRepository,
          SmartFeedRepository
        >
    with $Provider<SmartFeedRepository> {
  SmartFeedRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smartFeedRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smartFeedRepositoryHash();

  @$internal
  @override
  $ProviderElement<SmartFeedRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SmartFeedRepository create(Ref ref) {
    return smartFeedRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmartFeedRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmartFeedRepository>(value),
    );
  }
}

String _$smartFeedRepositoryHash() =>
    r'280b92cc15ff73ea1710c2f23d7773c2f363a02b';

@ProviderFor(smartFeed)
final smartFeedProvider = SmartFeedProvider._();

final class SmartFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FeedItemModel>>,
          List<FeedItemModel>,
          Stream<List<FeedItemModel>>
        >
    with
        $FutureModifier<List<FeedItemModel>>,
        $StreamProvider<List<FeedItemModel>> {
  SmartFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smartFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smartFeedHash();

  @$internal
  @override
  $StreamProviderElement<List<FeedItemModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FeedItemModel>> create(Ref ref) {
    return smartFeed(ref);
  }
}

String _$smartFeedHash() => r'1c93cb7055eaa84bc43af881b8cb8c4edf05e00c';

@ProviderFor(FeedFilter)
final feedFilterProvider = FeedFilterProvider._();

final class FeedFilterProvider extends $NotifierProvider<FeedFilter, String?> {
  FeedFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedFilterHash();

  @$internal
  @override
  FeedFilter create() => FeedFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$feedFilterHash() => r'4519f646d55859a40f56e843bbe818ba271ad38c';

abstract class _$FeedFilter extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredSmartFeed)
final filteredSmartFeedProvider = FilteredSmartFeedProvider._();

final class FilteredSmartFeedProvider
    extends
        $FunctionalProvider<
          List<FeedItemModel>,
          List<FeedItemModel>,
          List<FeedItemModel>
        >
    with $Provider<List<FeedItemModel>> {
  FilteredSmartFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredSmartFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredSmartFeedHash();

  @$internal
  @override
  $ProviderElement<List<FeedItemModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<FeedItemModel> create(Ref ref) {
    return filteredSmartFeed(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FeedItemModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FeedItemModel>>(value),
    );
  }
}

String _$filteredSmartFeedHash() => r'73509137274b3a991d1b38cff94ab36f9009db8e';
