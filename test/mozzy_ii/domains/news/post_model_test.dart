import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/shared/contracts/mozzy_post_contract.dart';

void main() {
  test('PostModel toJson/fromJson and contract implementation', () {
    final location = LocationParts(
      countryCode: 'ID',
      idAddress: null,
      globalAddress: null,
      latitude: -6.9,
      longitude: 107.6,
      geoHash: 'w23e',
    );

    final post = PostModel(
      id: 'p1',
      userId: 'u1',
      title: 'Judul',
      content: 'Isi berita',
      imageUrls: ['https://example.com/img.jpg'],
      category: 'umum',
      geoScope: GeoScope.neighborhood,
      reachMode: ReachMode.localOnly,
      translationState: {},
      trustScore: 0.3,
      signalScore: 0.1,
      geoPath: 'ID#JB#BANDUNG#COBLONG#DAGO',
      location: location,
      countryCode: 'ID',
      isDeleted: false,
      reportCount: 0,
      mapVisibility: true,
      discoveryChannels: [],
      relayTargets: [],
      createdAt: DateTime.utc(2026, 4, 28),
    );

    final json = post.toJson();
    final restored = PostModel.fromJson(json);

    expect(restored.id, equals(post.id));
    expect(restored.userId, equals(post.userId));
    expect(restored.category, equals('umum'));
    // ignore: unnecessary_type_check
    expect(restored is MozzyPostContract, isTrue);
    expect(restored.location.countryCode, equals('ID'));
    expect(restored.trustScore, equals(0.3));
  });
}
