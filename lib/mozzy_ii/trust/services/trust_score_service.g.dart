// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_score_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrustScoreService)
final trustScoreServiceProvider = TrustScoreServiceFamily._();

final class TrustScoreServiceProvider
    extends $AsyncNotifierProvider<TrustScoreService, double> {
  TrustScoreServiceProvider._({
    required TrustScoreServiceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'trustScoreServiceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trustScoreServiceHash();

  @override
  String toString() {
    return r'trustScoreServiceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TrustScoreService create() => TrustScoreService();

  @override
  bool operator ==(Object other) {
    return other is TrustScoreServiceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trustScoreServiceHash() => r'9e5c0f5719a1af9b71ff56387682be27741bd546';

final class TrustScoreServiceFamily extends $Family
    with
        $ClassFamilyOverride<
          TrustScoreService,
          AsyncValue<double>,
          double,
          FutureOr<double>,
          String
        > {
  TrustScoreServiceFamily._()
    : super(
        retry: null,
        name: r'trustScoreServiceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TrustScoreServiceProvider call(String userId) =>
      TrustScoreServiceProvider._(argument: userId, from: this);

  @override
  String toString() => r'trustScoreServiceProvider';
}

abstract class _$TrustScoreService extends $AsyncNotifier<double> {
  late final _$args = ref.$arg as String;
  String get userId => _$args;

  FutureOr<double> build(String userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<double>, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<double>, double>,
              AsyncValue<double>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
