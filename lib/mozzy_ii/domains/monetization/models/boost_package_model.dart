import 'package:freezed_annotation/freezed_annotation.dart';

part 'boost_package_model.freezed.dart';
part 'boost_package_model.g.dart';

@freezed
abstract class BoostPackageModel with _$BoostPackageModel {
  const factory BoostPackageModel({
    required String id,
    required String productType, // jobBoost
    required String titleKey,
    required String descriptionKey,
    required int durationDays,
    required int amount,
    @Default('IDR') String currency,
    @Default(true) bool isActive,
  }) = _BoostPackageModel;

  factory BoostPackageModel.fromJson(Map<String, dynamic> json) => _$BoostPackageModelFromJson(json);
}
