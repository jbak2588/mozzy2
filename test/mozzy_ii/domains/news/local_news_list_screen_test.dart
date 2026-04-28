import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mozzy/mozzy_ii/domains/news/screens/local_news_list_screen.dart';
import 'package:mozzy/mozzy_ii/domains/news/providers/posts_provider.dart';
import 'package:mozzy/mozzy_ii/domains/news/repositories/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/geo/providers/location_provider.dart';

void main() {
  testWidgets('LocalNewsListScreen shows title and chips and empty state', (
    tester,
  ) async {
    await EasyLocalization.ensureInitialized();

    final testPosts = <PostModel>[];

    final fakeRepo = _FakePostRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [postRepositoryProvider.overrideWithValue(fakeRepo)],
        child: EasyLocalization(
          supportedLocales: const [Locale('id')],
          path: 'assets/translations',
          child: MaterialApp(home: LocalNewsListScreen()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('news.title'.tr()), findsOneWidget);
    expect(find.byType(ChoiceChip), findsWidgets);
    // empty state
    expect(find.text('news.emptyTitle'.tr()), findsOneWidget);
  });
}

class _FakePostRepository implements PostRepository {
  @override
  String postsCollectionPath([String? country]) {
    final c = country ?? 'ID';
    return 'countries/$c/domains/local_news/posts';
  }

  @override
  CollectionReference get postsCollection => throw UnimplementedError();
  @override
  Future<void> createPost(PostModel post) async {}

  @override
  Future<PostModel?> getPostById(String postId) async => null;

  @override
  Future<List<PostModel>> fetchByKecamatan({
    required String kecamatan,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async => [];

  @override
  Future<List<PostModel>> fetchByCategory({
    required String category,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async => [];

  @override
  Future<List<PostModel>> fetchByKecamatanAndCategory({
    required String kecamatan,
    required String category,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async => [];

  @override
  Future<void> updatePost(PostModel post) async {}

  @override
  Future<void> softDeletePost(String postId) async {}
}
