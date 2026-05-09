// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_engagement_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedEngagementRepository)
final feedEngagementRepositoryProvider = FeedEngagementRepositoryProvider._();

final class FeedEngagementRepositoryProvider
    extends
        $FunctionalProvider<
          FeedEngagementRepository,
          FeedEngagementRepository,
          FeedEngagementRepository
        >
    with $Provider<FeedEngagementRepository> {
  FeedEngagementRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedEngagementRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedEngagementRepositoryHash();

  @$internal
  @override
  $ProviderElement<FeedEngagementRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FeedEngagementRepository create(Ref ref) {
    return feedEngagementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedEngagementRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedEngagementRepository>(value),
    );
  }
}

String _$feedEngagementRepositoryHash() =>
    r'de4ed11f3b1ef5f109f00dde8f563041a6686e8b';
