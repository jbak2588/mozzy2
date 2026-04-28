import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/trust/trust_score_service.dart';

void main() {
  test('initialForGoogle is 0.3 and initialLevel is anggota_baru', () {
    expect(TrustScoreService.initialForGoogle(), 0.3);
    expect(TrustScoreService.initialLevel(), 'anggota_baru');
  });

  test('withPhoneVerification increments and caps at 1.0', () {
    expect(TrustScoreService.withPhoneVerification(0.3), 0.5);
    expect(TrustScoreService.withPhoneVerification(0.9) <= 1.0, true);
  });
}
