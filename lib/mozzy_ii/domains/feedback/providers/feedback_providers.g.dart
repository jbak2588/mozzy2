// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedbackRepository)
final feedbackRepositoryProvider = FeedbackRepositoryProvider._();

final class FeedbackRepositoryProvider
    extends
        $FunctionalProvider<
          FeedbackRepository,
          FeedbackRepository,
          FeedbackRepository
        >
    with $Provider<FeedbackRepository> {
  FeedbackRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedbackRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedbackRepositoryHash();

  @$internal
  @override
  $ProviderElement<FeedbackRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FeedbackRepository create(Ref ref) {
    return feedbackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedbackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedbackRepository>(value),
    );
  }
}

String _$feedbackRepositoryHash() =>
    r'afe3e84c0527b495d4d793a0da7b59ccaeacc699';

@ProviderFor(feedbackService)
final feedbackServiceProvider = FeedbackServiceProvider._();

final class FeedbackServiceProvider
    extends
        $FunctionalProvider<FeedbackService, FeedbackService, FeedbackService>
    with $Provider<FeedbackService> {
  FeedbackServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedbackServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedbackServiceHash();

  @$internal
  @override
  $ProviderElement<FeedbackService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeedbackService create(Ref ref) {
    return feedbackService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedbackService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedbackService>(value),
    );
  }
}

String _$feedbackServiceHash() => r'4e124924e3e878e1fb27ff65211ae571a79a1572';

@ProviderFor(openFeedback)
final openFeedbackProvider = OpenFeedbackProvider._();

final class OpenFeedbackProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FeedbackModel>>,
          List<FeedbackModel>,
          Stream<List<FeedbackModel>>
        >
    with
        $FutureModifier<List<FeedbackModel>>,
        $StreamProvider<List<FeedbackModel>> {
  OpenFeedbackProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openFeedbackProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openFeedbackHash();

  @$internal
  @override
  $StreamProviderElement<List<FeedbackModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<FeedbackModel>> create(Ref ref) {
    return openFeedback(ref);
  }
}

String _$openFeedbackHash() => r'6f092793750ff92fbdf025d69ba488945263af4c';
