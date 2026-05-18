import '../../jobs/models/job_post_model.dart';
import '../models/feed_item_model.dart';
import '../models/feed_item_type.dart';

class JobFeedMapper {
  static FeedItemModel map(JobPostModel job) {
    return FeedItemModel(
      id: 'jobs_${job.id}',
      sourceId: job.id,
      type: FeedItemType.job,
      title: job.title,
      subtitle: job.companyName,
      description: job.description,
      ownerId: job.ownerId,
      createdAt: job.createdAt,
      updatedAt: job.updatedAt,
      isPromoted: job.isBoostActive,
      boostActiveUntil: job.boostActiveUntil,
      trustScore: job.trustScore,
      locationParts: job.locationParts,
      locationText: job.locationParts.idAddress?.kecamatan,
      route: '/jobs/${job.id}',
    );
  }
}
