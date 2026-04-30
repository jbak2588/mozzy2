// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/gemini_marketplace_ai_verification_service.dart
// Purpose       : Gemini API를 이용한 Marketplace AI 검수 서비스 구현.
// ============================================================================

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../ai/marketplace_ai_config.dart';
import '../models/ai_verification_result.dart';
import 'marketplace_ai_verification_service.dart';

class GeminiMarketplaceAiVerificationService implements MarketplaceAiVerificationService {
  final http.Client _client;

  GeminiMarketplaceAiVerificationService([http.Client? client])
      : _client = client ?? http.Client();

  @override
  Future<AiVerificationResult> verifyProductImages({
    required String productId,
    required String title,
    required String description,
    required String category,
    required List<String> imageUrls,
  }) async {
    final apiKey = MarketplaceAiConfig.geminiApiKey;
    if (apiKey.isEmpty) {
      return _errorResult(productId, 'API Key is missing', 'not_requested');
    }

    final model = MarketplaceAiConfig.geminiModel;
    final url = 'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey';

    final prompt = '''
You are verifying a marketplace listing for a hyperlocal Indonesian app (Mozzy).
Check whether the product evidence (title, description, category) appears consistent and safe.
Note: Images are provided as URLs. If you cannot access them, rely on the text metadata.

Product Title: $title
Description: $description
Category: $category
Images: ${imageUrls.join(', ')}

Rules:
1. Detect unsafe, prohibited (drugs, weapons, adult), or clearly fraudulent red flags.
2. Check if the category is appropriate.
3. Suggest a condition label (new, good, used, damaged, unknown).
4. Return ONLY a JSON object with this structure:
{
  "status": "passed" | "failed" | "needs_review",
  "score": 0.0 to 1.0,
  "summary": "Brief explanation",
  "detectedIssues": ["issue1", "issue2"],
  "suggestedCategory": "category name",
  "conditionLabel": "new" | "good" | "used" | "damaged" | "unknown"
}
''';

    try {
      final response = await _client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'responseMimeType': 'application/json',
          }
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        return _errorResult(productId, 'API Error: ${response.statusCode}', 'error');
      }

      final data = jsonDecode(response.body);
      final String? textResponse = data['candidates']?[0]?['content']?[0]?['parts']?[0]?['text'];

      if (textResponse == null) {
        return _errorResult(productId, 'Empty response from AI', 'error');
      }

      final Map<String, dynamic> aiJson = jsonDecode(textResponse);

      return AiVerificationResult(
        id: const Uuid().v4(),
        productId: productId,
        status: aiJson['status'] ?? 'needs_review',
        score: (aiJson['score'] as num?)?.toDouble() ?? 0.0,
        summary: aiJson['summary'] ?? '',
        detectedIssues: List<String>.from(aiJson['detectedIssues'] ?? []),
        suggestedCategory: aiJson['suggestedCategory'],
        conditionLabel: aiJson['conditionLabel'],
        rawResponse: textResponse,
        createdAt: DateTime.now().toUtc(),
      );
    } catch (e) {
      return _errorResult(productId, 'Exception: $e', 'error');
    }
  }

  AiVerificationResult _errorResult(String productId, String summary, String status) {
    return AiVerificationResult(
      id: const Uuid().v4(),
      productId: productId,
      status: status,
      summary: summary,
      createdAt: DateTime.now().toUtc(),
    );
  }
}
