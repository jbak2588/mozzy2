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
    r'3bc5ab4c59429be2eccdf4f7bc0ab918b4f67a80';

@ProviderFor(semanticRankingAdapter)
final semanticRankingAdapterProvider = SemanticRankingAdapterProvider._();

final class SemanticRankingAdapterProvider
    extends
        $FunctionalProvider<
          SemanticRankingAdapter,
          SemanticRankingAdapter,
          SemanticRankingAdapter
        >
    with $Provider<SemanticRankingAdapter> {
  SemanticRankingAdapterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'semanticRankingAdapterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$semanticRankingAdapterHash();

  @$internal
  @override
  $ProviderElement<SemanticRankingAdapter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SemanticRankingAdapter create(Ref ref) {
    return semanticRankingAdapter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SemanticRankingAdapter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SemanticRankingAdapter>(value),
    );
  }
}

String _$semanticRankingAdapterHash() =>
    r'e90f3d121606310bf6359c1c4dc41996209fcddd';

@ProviderFor(feedSemanticSanitizer)
final feedSemanticSanitizerProvider = FeedSemanticSanitizerProvider._();

final class FeedSemanticSanitizerProvider
    extends
        $FunctionalProvider<
          FeedSemanticSanitizer,
          FeedSemanticSanitizer,
          FeedSemanticSanitizer
        >
    with $Provider<FeedSemanticSanitizer> {
  FeedSemanticSanitizerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedSemanticSanitizerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedSemanticSanitizerHash();

  @$internal
  @override
  $ProviderElement<FeedSemanticSanitizer> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FeedSemanticSanitizer create(Ref ref) {
    return feedSemanticSanitizer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedSemanticSanitizer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedSemanticSanitizer>(value),
    );
  }
}

String _$feedSemanticSanitizerHash() =>
    r'df1b2b8292d79ebf37eb32dce797311c234b4779';

@ProviderFor(semanticRankingService)
final semanticRankingServiceProvider = SemanticRankingServiceProvider._();

final class SemanticRankingServiceProvider
    extends
        $FunctionalProvider<
          SemanticRankingService,
          SemanticRankingService,
          SemanticRankingService
        >
    with $Provider<SemanticRankingService> {
  SemanticRankingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'semanticRankingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$semanticRankingServiceHash();

  @$internal
  @override
  $ProviderElement<SemanticRankingService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SemanticRankingService create(Ref ref) {
    return semanticRankingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SemanticRankingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SemanticRankingService>(value),
    );
  }
}

String _$semanticRankingServiceHash() =>
    r'dad8ed79fdc79c28c4e70c26077c283622e2ad70';

@ProviderFor(SmartFeedSearchIntent)
final smartFeedSearchIntentProvider = SmartFeedSearchIntentProvider._();

final class SmartFeedSearchIntentProvider
    extends $NotifierProvider<SmartFeedSearchIntent, String> {
  SmartFeedSearchIntentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smartFeedSearchIntentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smartFeedSearchIntentHash();

  @$internal
  @override
  SmartFeedSearchIntent create() => SmartFeedSearchIntent();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$smartFeedSearchIntentHash() =>
    r'6673f62cb6adccda14bb1c667ae6222971dacee6';

abstract class _$SmartFeedSearchIntent extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

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

String _$smartFeedHash() => r'3c3fd31a119e50a30902164cce0c18ad4f31654b';

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

String _$filteredSmartFeedHash() => r'926b774a1bd3d8cb371075d2339e444f349131e4';
