import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/mappers/job_feed_mapper.dart';
import 'package:mozzy/mozzy_ii/domains/feed/mappers/product_feed_mapper.dart';
import 'package:mozzy/mozzy_ii/domains/feed/mappers/news_feed_mapper.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  final now = DateTime.now();

  group('Mappers', () {
    test('JobFeedMapper maps JobPostModel to FeedItemModel', () {
      final job = JobPostModel(
        id: 'job123',
        title: 'Flutter Dev',
        description: 'Work with us',
        companyName: 'Tech Co',
        ownerId: 'user1',
        ownerName: 'Owner',
        category: 'IT',
        jobType: JobType.fullTime,
        workType: WorkType.remote,
        salaryType: SalaryType.monthly,
        salaryMin: 5000000,
        salaryMax: 10000000,
        locationParts: const LocationParts(
          countryCode: 'ID',
          latitude: 0,
          longitude: 0,
          geoHash: 'abc',
        ),
        createdAt: now,
        updatedAt: now,
        expiresAt: now.add(const Duration(days: 30)),
      );

      final item = JobFeedMapper.map(job);

      expect(item.sourceId, 'job123');
      expect(item.type, FeedItemType.job);
      expect(item.title, 'Flutter Dev');
      expect(item.subtitle, 'Tech Co');
      expect(item.route, '/jobs/job123');
    });

    test('ProductFeedMapper maps ProductModel to FeedItemModel', () {
      final product = ProductModel(
        id: 'prod123',
        userId: 'user2',
        title: 'Used iPhone',
        description: 'Good condition',
        category: 'Electronics',
        price: 3000000,
        imageUrls: ['https://example.com/img.jpg'],
        geoPath: 'some/path',
        createdAt: now,
      );

      final item = ProductFeedMapper.map(product);

      expect(item.sourceId, 'prod123');
      expect(item.type, FeedItemType.marketplaceProduct);
      expect(item.title, 'Used iPhone');
      expect(item.imageUrl, 'https://example.com/img.jpg');
      expect(item.route, '/marketplace/prod123');
    });

    test('NewsFeedMapper maps PostModel to FeedItemModel', () {
      final post = PostModel(
        id: 'news123',
        userId: 'user3',
        title: 'Breaking News',
        content: 'Something happened',
        category: 'umum',
        geoPath: 'some/path',
        location: const LocationParts(
          countryCode: 'ID',
          latitude: 0,
          longitude: 0,
          geoHash: 'abc',
        ),
        createdAt: now,
      );

      final item = NewsFeedMapper.map(post);

      expect(item.sourceId, 'news123');
      expect(item.type, FeedItemType.localNews);
      expect(item.title, 'Breaking News');
      expect(item.description, 'Something happened');
      expect(item.route, '/news/news123');
      expect(item.imageUrl, isNull);
    });
  });
}
