import 'package:freezed_annotation/freezed_annotation.dart';

part 'semantic_ranking_payload.freezed.dart';
part 'semantic_ranking_payload.g.dart';

@freezed
abstract class SemanticRankingPayload with _$SemanticRankingPayload {
  const SemanticRankingPayload._();

  const factory SemanticRankingPayload({
    required String feedItemId,
    required String sourceId,
    required String type,
    required String title,
    String? publicSummary,
    String? category,
    String? locationHint,
    @Default(false) bool isPromoted,
    @Default(false) bool isTrusted,
    String? ageBucket,
    String? languageCode,
  }) = _SemanticRankingPayload;

  factory SemanticRankingPayload.fromJson(Map<String, dynamic> json) =>
      _$SemanticRankingPayloadFromJson(json);

  // Helper for safe JSON conversion (already handled by json_serializable, 
  // but we can add manual filtering if needed in the sanitizer)
  Map<String, dynamic> toSafeJson() => toJson();
}
