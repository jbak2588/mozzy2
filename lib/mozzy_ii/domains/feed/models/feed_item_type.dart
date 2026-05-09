import 'package:freezed_annotation/freezed_annotation.dart';

enum FeedItemType {
  @JsonValue('job')
  job,
  @JsonValue('marketplaceProduct')
  marketplaceProduct,
  @JsonValue('localNews')
  localNews,
  @JsonValue('store')
  store,
  @JsonValue('community')
  community,
}
