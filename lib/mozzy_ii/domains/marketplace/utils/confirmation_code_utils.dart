import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

String generateConfirmationCode({int length = 6}) {
  final random = Random.secure();
  final chars = List.generate(
      length, (index) => _alphabet[random.nextInt(_alphabet.length)]);
  return chars.join();
}

String normalizeConfirmationCode(String input) {
  return input.replaceAll(' ', '').toUpperCase();
}

String hashConfirmationCode({
  required String dealId,
  required String code,
}) {
  final normalizedCode = normalizeConfirmationCode(code);
  final input = '$dealId:$normalizedCode';
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

String maskConfirmationCode(String code) {
  if (code.length < 2) return code;
  final first = code[0];
  final last = code[code.length - 1];
  final maskLength = code.length - 2;
  return '$first${'*' * maskLength}$last';
}

bool isCodeExpired(DateTime codeExpiresAt) {
  return DateTime.now().toUtc().isAfter(codeExpiresAt.toUtc());
}
