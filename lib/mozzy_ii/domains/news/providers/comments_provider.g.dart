// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commentRepository)
final commentRepositoryProvider = CommentRepositoryProvider._();

final class CommentRepositoryProvider
    extends
        $FunctionalProvider<
          CommentRepository,
          CommentRepository,
          CommentRepository
        >
    with $Provider<CommentRepository> {
  CommentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentRepositoryHash();

  @$internal
  @override
  $ProviderElement<CommentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommentRepository create(Ref ref) {
    return commentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentRepository>(value),
    );
  }
}

String _$commentRepositoryHash() => r'863c9103e6e03daf3bd858335f2a8ed4e168a9af';

@ProviderFor(currentCommentUserId)
final currentCommentUserIdProvider = CurrentCommentUserIdProvider._();

final class CurrentCommentUserIdProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  CurrentCommentUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentCommentUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentCommentUserIdHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return currentCommentUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentCommentUserIdHash() =>
    r'8db72c941e66e5b502722669b4e1dc3f805a4a0c';

@ProviderFor(visibleTopLevelComments)
final visibleTopLevelCommentsProvider = VisibleTopLevelCommentsFamily._();

final class VisibleTopLevelCommentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommentModel>>,
          List<CommentModel>,
          FutureOr<List<CommentModel>>
        >
    with
        $FutureModifier<List<CommentModel>>,
        $FutureProvider<List<CommentModel>> {
  VisibleTopLevelCommentsProvider._({
    required VisibleTopLevelCommentsFamily super.from,
    required VisibleCommentsQuery super.argument,
  }) : super(
         retry: null,
         name: r'visibleTopLevelCommentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$visibleTopLevelCommentsHash();

  @override
  String toString() {
    return r'visibleTopLevelCommentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CommentModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommentModel>> create(Ref ref) {
    final argument = this.argument as VisibleCommentsQuery;
    return visibleTopLevelComments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VisibleTopLevelCommentsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$visibleTopLevelCommentsHash() =>
    r'5399c9b9ca066edaaf5d2c9046e6fd6c193819eb';

final class VisibleTopLevelCommentsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<CommentModel>>,
          VisibleCommentsQuery
        > {
  VisibleTopLevelCommentsFamily._()
    : super(
        retry: null,
        name: r'visibleTopLevelCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VisibleTopLevelCommentsProvider call(VisibleCommentsQuery query) =>
      VisibleTopLevelCommentsProvider._(argument: query, from: this);

  @override
  String toString() => r'visibleTopLevelCommentsProvider';
}

@ProviderFor(visibleRepliesByComment)
final visibleRepliesByCommentProvider = VisibleRepliesByCommentFamily._();

final class VisibleRepliesByCommentProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommentModel>>,
          List<CommentModel>,
          FutureOr<List<CommentModel>>
        >
    with
        $FutureModifier<List<CommentModel>>,
        $FutureProvider<List<CommentModel>> {
  VisibleRepliesByCommentProvider._({
    required VisibleRepliesByCommentFamily super.from,
    required VisibleRepliesQuery super.argument,
  }) : super(
         retry: null,
         name: r'visibleRepliesByCommentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$visibleRepliesByCommentHash();

  @override
  String toString() {
    return r'visibleRepliesByCommentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CommentModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommentModel>> create(Ref ref) {
    final argument = this.argument as VisibleRepliesQuery;
    return visibleRepliesByComment(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VisibleRepliesByCommentProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$visibleRepliesByCommentHash() =>
    r'e6325b8f753ffa5559f1deff3b6e8f0f9f0686b3';

final class VisibleRepliesByCommentFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<CommentModel>>,
          VisibleRepliesQuery
        > {
  VisibleRepliesByCommentFamily._()
    : super(
        retry: null,
        name: r'visibleRepliesByCommentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VisibleRepliesByCommentProvider call(VisibleRepliesQuery query) =>
      VisibleRepliesByCommentProvider._(argument: query, from: this);

  @override
  String toString() => r'visibleRepliesByCommentProvider';
}

@ProviderFor(createComment)
final createCommentProvider = CreateCommentProvider._();

final class CreateCommentProvider
    extends
        $FunctionalProvider<
          CreateCommentAction,
          CreateCommentAction,
          CreateCommentAction
        >
    with $Provider<CreateCommentAction> {
  CreateCommentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createCommentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createCommentHash();

  @$internal
  @override
  $ProviderElement<CreateCommentAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateCommentAction create(Ref ref) {
    return createComment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateCommentAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateCommentAction>(value),
    );
  }
}

String _$createCommentHash() => r'ad53ebb54eccc511cd1a069d6d54d470ddd95f98';
