// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/gemini_marketplace_ai_verification_service.dart
// Purpose       : Gemini API를 이용한 Marketplace AI 검수 서비스 구현.
// ============================================================================

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../ai/marketplace_ai_config.dart';
import '../models/ai_verification_result.dart';
import 'marketplace_ai_verification_service.dart';

class GeminiMarketplaceAiVerificationService
    implements MarketplaceAiVerificationService {
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
    List<XFile> imageFiles = const [],
  }) async {
    final apiKey = MarketplaceAiConfig.geminiApiKey;
    if (apiKey.isEmpty) {
      return _errorResult(productId, 'API Key is missing', 'not_requested');
    }

    final model = MarketplaceAiConfig.geminiModel;
    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey';

    final prompt =
        '''
You are a strict marketplace AI verification agent for Mozzy, a hyperlocal Indonesian marketplace.
You must verify whether the listing text and the uploaded product images match exactly.

Product Title: $title
Description: $description
Category: $category

Critical Rules:
1. Inspect the provided images directly and compare them with the title and description.
2. If the title claims a specific model, generation, or version (e.g., "AirPods Pro 3", "iPhone 15 Pro"), verify if the images actually show that exact model.
3. If the model/generation cannot be confidently verified from the images, you MUST return "needs_review".
4. If the images appear to show a different product, a different version, or a knock-off of what is claimed in the title, return "needs_review" or "failed".
5. If images are missing, blurry, or insufficient to prove the claim, return "needs_review".
6. Be extremely conservative for electronics and branded goods. Do not mark "passed" unless the image-text-category consistency is 100% clear.

Return ONLY a JSON object:
{
  "status": "passed" | "failed" | "needs_review",
  "score": 0.0 to 1.0,
  "summary": "Brief explanation",
  "detectedIssues": ["issue1", "issue2"],
  "suggestedCategory": "category name",
  "conditionLabel": "new" | "good" | "used" | "damaged" | "unknown",
  "imageTextMatch": "matched" | "mismatch" | "uncertain",
  "modelClaimVerified": true | false
}
''';

    try {
      final List<Map<String, dynamic>> parts = [
        {'text': prompt},
      ];

      // Add image data if available (max 4 images to keep request size reasonable)
      final imagesToProcess = imageFiles.take(4).toList();
      for (final file in imagesToProcess) {
        final bytes = await file.readAsBytes();
        parts.add({
          'inlineData': {
            'mimeType': 'image/webp',
            'data': base64Encode(bytes),
          },
        });
      }

      final response = await _client
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'contents': [
                {
                  'parts': parts,
                },
              ],
              'generationConfig': {'responseMimeType': 'application/json'},
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        return _errorResult(
          productId,
          'API Error: ${response.statusCode}',
          'error',
        );
      }

      final data = jsonDecode(response.body);
      final String? textResponse =
          data['candidates']?[0]?['content']?['parts']?[0]?['text'];

      if (textResponse == null) {
        return _errorResult(productId, 'Empty response from AI', 'error');
      }

      // Robust JSON parsing: strip markdown fences if present
      String cleanedJson = textResponse.trim();
      if (cleanedJson.startsWith('```')) {
        final lines = cleanedJson.split('\n');
        if (lines.length >= 2) {
          cleanedJson = lines.sublist(1, lines.length - 1).join('\n').trim();
        }
      }

      final Map<String, dynamic> aiJson = jsonDecode(cleanedJson);

      String finalStatus = _normalizeStatus(aiJson['status']);
      String finalSummary = aiJson['summary'] ?? '';

      // Post-processing logic for strictness
      final imageTextMatch = aiJson['imageTextMatch']?.toString();
      final modelClaimVerified = aiJson['modelClaimVerified'];
      
      if (imageTextMatch == 'mismatch' || imageTextMatch == 'uncertain') {
        finalStatus = 'needs_review';
      }
      
      if (_containsSpecificModelClaim(title) && modelClaimVerified != true) {
        if (finalStatus == 'passed') {
          finalStatus = 'needs_review';
          finalSummary = '[Strict Check] Model claim not verified. $finalSummary';
        }
      }

      // Override for staging verification if forceAiReview is enabled
      if (MarketplaceAiConfig.forceAiReview) {
        debugPrint('[GeminiAiService] MOZZY_FORCE_AI_REVIEW is true. Overriding status "$finalStatus" to "needs_review"');
        finalStatus = 'needs_review';
        finalSummary = '[FORCED REVIEW] $finalSummary';
      }

      return AiVerificationResult(
        id: const Uuid().v4(),
        productId: productId,
        status: finalStatus,
        score: (aiJson['score'] as num?)?.toDouble() ?? 0.0,
        summary: finalSummary,
        detectedIssues: List<String>.from(aiJson['detectedIssues'] ?? []),
        suggestedCategory: aiJson['suggestedCategory'],
        conditionLabel: aiJson['conditionLabel'],
        rawResponse: cleanedJson,
        createdAt: DateTime.now().toUtc(),
      );
    } catch (e) {
      debugPrint('Gemini verification error: $e');
      return _errorResult(
        productId,
        'Verification failed: parsing error or timeout',
        'error',
      );
    }
  }

  bool _containsSpecificModelClaim(String title) {
    final t = title.toLowerCase();
    final patterns = [
      'pro', 'gen', 'iphone', 'samsung', 'original', 'authentic', 
      'series', 'ultra', 'ipad', 'macbook', 'sony', 'canon', 'nikon'
    ];
    return patterns.any((p) => t.contains(p));
  }

  String _normalizeStatus(dynamic status) {
    final s = status?.toString().toLowerCase();
    if (s == 'passed') return 'passed';
    if (s == 'failed') return 'failed';
    return 'needs_review';
  }

  AiVerificationResult _errorResult(
    String productId,
    String summary,
    String status,
  ) {
    return AiVerificationResult(
      id: const Uuid().v4(),
      productId: productId,
      status: status,
      summary: summary,
      createdAt: DateTime.now().toUtc(),
    );
  }
}
