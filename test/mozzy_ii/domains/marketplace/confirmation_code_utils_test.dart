import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/utils/confirmation_code_utils.dart';

void main() {
  group('Confirmation Code Utils Tests', () {
    test('generateConfirmationCode generates 6 chars using allowed alphabet', () {
      final code = generateConfirmationCode();
      expect(code.length, 6);
      
      final allowedRegex = RegExp(r'^[ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{6}$');
      expect(allowedRegex.hasMatch(code), true);
    });

    test('normalizeConfirmationCode removes spaces and uppercases', () {
      expect(normalizeConfirmationCode('a b c 1 2 3'), 'ABC123');
      expect(normalizeConfirmationCode(' aBc '), 'ABC');
    });

    test('hashConfirmationCode generates same hash for same inputs', () {
      final dealId = 'test-deal-123';
      final code = 'ABC123';
      final hash1 = hashConfirmationCode(dealId: dealId, code: code);
      final hash2 = hashConfirmationCode(dealId: dealId, code: code);
      final hash3 = hashConfirmationCode(dealId: dealId, code: 'a b c 1 2 3');
      
      expect(hash1, hash2);
      expect(hash1, hash3); // Since normalized
    });

    test('hashConfirmationCode generates different hashes for different inputs', () {
      final hash1 = hashConfirmationCode(dealId: 'deal1', code: 'CODE12');
      final hash2 = hashConfirmationCode(dealId: 'deal1', code: 'CODE34');
      final hash3 = hashConfirmationCode(dealId: 'deal2', code: 'CODE12');
      
      expect(hash1, isNot(equals(hash2)));
      expect(hash1, isNot(equals(hash3)));
    });

    test('maskConfirmationCode correctly masks internal characters', () {
      expect(maskConfirmationCode('A1B2C3'), 'A****3');
      expect(maskConfirmationCode('AB'), 'AB');
    });

    test('isCodeExpired returns true if expired', () {
      final now = DateTime.now();
      final expired = now.subtract(const Duration(minutes: 1));
      final notExpired = now.add(const Duration(minutes: 1));
      
      expect(isCodeExpired(expired), true);
      expect(isCodeExpired(notExpired), false);
    });
  });
}
