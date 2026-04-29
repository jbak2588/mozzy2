// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/models/product_model.dart
// Purpose       : 중고 거래 물품 데이터 모델. MozzyPostContract를 구현합니다.
// ============================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/shared/contracts/mozzy_post_contract.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

class SafeDateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const SafeDateTimeConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    } else if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }
    return DateTime.now(); // Fallback
  }

  @override
  dynamic toJson(DateTime object) => object.toUtc().toIso8601String();
}

class OptionalSafeDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const OptionalSafeDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    } else if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? object) => object?.toUtc().toIso8601String();
}

@freezed
abstract class ProductModel with _$ProductModel implements MozzyPostContract {
  const ProductModel._();

  const factory ProductModel({
    required String id,
    @JsonKey(name: 'sellerId') required String userId, // MozzyPostContract uses userId
    required String title,
    required String description,
    required String category,
    required int price,
    @Default('IDR') String currencyCode,
    @Default([]) List<String> imageUrls,
    
    // MozzyPostContract 구현 필드
    @Default(GeoScope.neighborhood) GeoScope geoScope,
    @Default(ReachMode.localOnly) ReachMode reachMode,
    @Default({}) Map<String, String> translationState,
    @Default(0.3) double trustScore,
    @Default(0.0) double signalScore,
    required String geoPath,

    // 위치 상세
    LocationParts? locationParts,

    @Default('ID') String countryCode,
    @Default(false) bool isAiVerified,
    @Default('not_requested') String aiVerificationStatus,

    @SafeDateTimeConverter() required DateTime createdAt,
    @OptionalSafeDateTimeConverter() DateTime? updatedAt,

    @Default(false) bool isDeleted,
    @Default(0) int viewsCount,
    @Default(0) int likesCount,
    @Default(0) int chatsCount,
  }) = _ProductModel;

  // Alias for MozzyPostContract compatibility if needed, 
  // but we already mapped sellerId to userId in the factory.
  String get sellerId => userId;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
