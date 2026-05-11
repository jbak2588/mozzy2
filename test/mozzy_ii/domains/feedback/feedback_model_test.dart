import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feedback/models/feedback_model.dart';

void main() {
  group('FeedbackModel', () {
    test('should serialize and deserialize successfully', () {
      final now = DateTime.now();
      
      final feedback = FeedbackModel(
        id: 'f123',
        userId: 'u456',
        type: FeedbackType.bug,
        message: 'Test bug report',
        contactPreference: FeedbackContactPreference.whatsapp,
        contactValue: '628123456789',
        appVersion: '1.0.0+1',
        platform: 'android',
        appEnv: 'staging',
        status: FeedbackStatus.open,
        priority: FeedbackPriority.medium,
        createdAt: now,
        updatedAt: now,
      );

      final json = feedback.toJson();
      
      expect(json['id'], 'f123');
      expect(json['userId'], 'u456');
      expect(json['type'], 'bug');
      expect(json['status'], 'open');
      expect(json['priority'], 'medium');
      
      final restored = FeedbackModel.fromJson(json);
      
      expect(restored.id, feedback.id);
      expect(restored.userId, feedback.userId);
      expect(restored.type, feedback.type);
      expect(restored.message, feedback.message);
      expect(restored.contactPreference, feedback.contactPreference);
      expect(restored.contactValue, feedback.contactValue);
      expect(restored.appVersion, feedback.appVersion);
      expect(restored.platform, feedback.platform);
      expect(restored.appEnv, feedback.appEnv);
      expect(restored.status, feedback.status);
      expect(restored.priority, feedback.priority);
    });

    test('should map enums correctly', () {
      expect(FeedbackType.bug.name, 'bug');
      expect(FeedbackStatus.resolved.name, 'resolved');
      expect(FeedbackPriority.high.name, 'high');
      expect(FeedbackContactPreference.email.name, 'email');
    });
  });
}
