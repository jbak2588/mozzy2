// ============================================================================
// Mozzy DocHeader
// Module        : Trust Layer
// File          : lib/mozzy_ii/trust/services/trust_score_service.dart
// Purpose       : Firestore의 사용자 신뢰 점수를 관리하고 업데이트합니다.
// ============================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozzy/mozzy_ii/core/config/firebase_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trust_score_service.g.dart';

@riverpod
class TrustScoreService extends _$TrustScoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  FutureOr<double> build(String userId) async {
    return _fetchTrustScore(userId);
  }

  /// Firestore에서 사용자의 현재 신뢰 점수를 가져옵니다.
  Future<double> _fetchTrustScore(String userId) async {
    try {
      final doc = await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .get();

      if (doc.exists) {
        return (doc.data()?[FirebaseConstants.fieldTrustScore] ?? 0.0) as double;
      }
      return 0.0;
    } catch (e) {
      // 에러 발생 시 기본값 반환
      return 0.0;
    }
  }

  /// 사용자의 신뢰 점수를 업데이트합니다. (예: 리뷰 완료, 본인 인증 등)
  Future<void> updateTrustScore(double newScore) async {
    final userId = this.userId;
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .set({
            FirebaseConstants.fieldTrustScore: newScore,
          }, SetOptions(merge: true));
      return newScore;
    });
  }

  /// 특정 행동에 따라 점수를 가감합니다. (단순 구현 예시)
  Future<void> adjustScore(double delta) async {
    final currentScore = state.value ?? 0.0;
    final newScore = (currentScore + delta).clamp(0.0, 1.0);
    await updateTrustScore(newScore);
  }
}
