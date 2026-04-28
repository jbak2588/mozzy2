import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mozzy/mozzy_ii/domains/news/widgets/local_news_card.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/shared/contracts/mozzy_post_contract.dart';

void main() {
  testWidgets('LocalNewsCard renders fields without crashing', (tester) async {
    final post = PostModel(
      id: 'p1',
      userId: 'u1',
      title: 'Judul',
      content: 'Isi berita panjang lebih dari satu baris',
      imageUrls: [],
      category: 'umum',
      geoScope: GeoScope.neighborhood,
      reachMode: ReachMode.localOnly,
      translationState: {},
      trustScore: 0.5,
      signalScore: 0.1,
      geoPath: 'ID#JB#BANDUNG#COBLONG',
      location: LocationParts(
        countryCode: 'ID',
        idAddress: null,
        globalAddress: null,
        latitude: -6.9,
        longitude: 107.6,
        geoHash: 'x',
      ),
      createdAt: DateTime.now().toUtc(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: LocalNewsCard(post: post)),
      ),
    );
    expect(find.text('Judul'), findsOneWidget);
    expect(find.text('umum'), findsOneWidget);
  });
}
