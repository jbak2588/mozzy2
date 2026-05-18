import '../../news/models/post_model.dart';
import '../models/feed_item_model.dart';
import '../models/feed_item_type.dart';

class NewsFeedMapper {
  static FeedItemModel map(PostModel post) {
    return FeedItemModel(
      id: 'news_${post.id}',
      sourceId: post.id,
      type: FeedItemType.localNews,
      title: post.title,
      subtitle: post.category, // e.g. Umum, Info, Event
      description: post.content,
      imageUrl: post.imageUrls.isNotEmpty ? post.imageUrls.first : null,
      ownerId: post.userId,
      createdAt: post.createdAt,
      updatedAt: post.updatedAt,
      trustScore: post.trustScore,
      locationParts: post.location,
      locationText: post.location.idAddress?.kecamatan,
      likesCount: post.likesCount,
      commentsCount: post.commentsCount,
      viewsCount: post.viewsCount,
      route: '/news/${post.id}',
    );
  }
}
