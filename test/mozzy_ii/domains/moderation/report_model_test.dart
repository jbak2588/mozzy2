import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/moderation/models/report_model.dart';

void main() {
  group('ReportModel', () {
    test('should serialize and deserialize successfully', () {
      final now = DateTime.now();
      
      final report = ReportModel(
        id: '123',
        targetType: ReportTargetType.marketplace,
        targetId: 'prod_123',
        targetOwnerId: 'seller_123',
        reporterId: 'reporter_456',
        reason: ReportReason.scam,
        description: 'Scam product',
        status: ReportStatus.pending,
        createdAt: now,
      );

      final json = report.toJson();
      
      expect(json['id'], '123');
      expect(json['targetType'], 'marketplace');
      expect(json['reason'], 'scam');
      expect(json['status'], 'pending');
      
      final restored = ReportModel.fromJson(json);
      
      expect(restored.id, report.id);
      expect(restored.targetType, report.targetType);
      expect(restored.targetId, report.targetId);
      expect(restored.targetOwnerId, report.targetOwnerId);
      expect(restored.reporterId, report.reporterId);
      expect(restored.reason, report.reason);
      expect(restored.description, report.description);
      expect(restored.status, report.status);
    });

    test('should map enums correctly', () {
      expect(ReportTargetType.news.name, 'news');
      expect(ReportTargetType.jobs.name, 'jobs');
      expect(ReportReason.spam.name, 'spam');
      expect(ReportReason.other.name, 'other');
      expect(ModerationStatus.hidden.name, 'hidden');
    });
  });
}
