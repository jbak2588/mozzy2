import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/news/screens/local_news_detail_screen.dart';
import 'package:mozzy/mozzy_ii/domains/news/providers/posts_provider.dart';
import 'package:mozzy/mozzy_ii/domains/news/providers/comments_provider.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/domains/news/widgets/cross_link_section.dart';

void main() {
  final testPost = PostModel(
    id: 'post-1',
    userId: 'user-1',
    title: 'Test Title',
    content: 'Test Content',
    category: 'Umum',
    geoPath: 'ID/JB/Bandung',
    createdAt: DateTime(2026, 4, 28, 12, 0),
    location: const LocationParts(
      countryCode: 'ID',
      latitude: 0.0,
      longitude: 0.0,
      geoHash: 'abc',
      idAddress: IndonesiaGeoAddress(
        provinsi: 'Jawa Barat',
        kabupaten: 'Bandung',
        kecamatan: 'Coblong',
        kelurahan: 'Dago',
      ),
    ),
  );

  testWidgets('LocalNewsDetailScreen shows post details', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postByIdProvider('post-1').overrideWith((ref) => testPost),
          currentCommentUserIdProvider.overrideWith((ref) => 'u1'),
          visibleTopLevelCommentsProvider(const VisibleCommentsQuery(postId: 'post-1', currentUserId: 'u1')).overrideWith((ref) => []),
        ],
        child: const MaterialApp(
          home: LocalNewsDetailScreen(postId: 'post-1'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
    expect(find.text('Umum'), findsOneWidget);
    expect(find.textContaining('Coblong'), findsOneWidget);
    expect(find.byType(CrossLinkSection), findsOneWidget);
  });

  testWidgets('LocalNewsDetailScreen shows not found when post is null', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postByIdProvider('post-1').overrideWith((ref) => null),
        ],
        child: const MaterialApp(
          home: LocalNewsDetailScreen(postId: 'post-1'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('news.notFound'), findsOneWidget);
  });
}
