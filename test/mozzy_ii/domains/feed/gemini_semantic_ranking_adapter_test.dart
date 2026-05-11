import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/gemini_semantic_ranking_adapter.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/semantic_ranking_payload.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFunctions>(),
  MockSpec<HttpsCallable>(),
])
import 'gemini_semantic_ranking_adapter_test.mocks.dart';

void main() {
  late MockFirebaseFunctions mockFunctions;
  late MockHttpsCallable mockCallable;
  late GeminiSemanticRankingAdapter adapter;

  setUp(() {
    mockFunctions = MockFirebaseFunctions();
    mockCallable = MockHttpsCallable();
    adapter = GeminiSemanticRankingAdapter(functions: mockFunctions);
  });

  group('GeminiSemanticRankingAdapter Tests', () {
    test('should call rankSmartFeedWithGemini with safe payload', () async {
      final payloads = [
        const SemanticRankingPayload(
          feedItemId: '1',
          sourceId: 'src1',
          type: 'job',
          title: 'Job 1',
        ),
      ];

      when(mockFunctions.httpsCallable('rankSmartFeedWithGemini')).thenReturn(mockCallable);
      when(mockCallable.call(any)).thenAnswer((_) async {
        return FakeHttpsCallableResult({
          'results': [
            {'feedItemId': '1', 'score': 25.0, 'reason': 'Relevant'}
          ],
          'provider': 'gemini',
          'mode': 'live'
        });
      });

      final results = await adapter.rank(
        payloads: payloads,
        userIntent: 'looking for work',
        languageCode: 'en',
      );

      expect(results.length, 1);
      expect(results[0].feedItemId, '1');
      expect(results[0].score, 25.0);
      expect(results[0].reason, 'Relevant');

      verify(mockCallable.call({
        'intent': 'looking for work',
        'languageCode': 'en',
        'items': [payloads[0].toSafeJson()],
      })).called(1);
    });

    test('should return empty list on failure', () async {
      when(mockFunctions.httpsCallable(any)).thenReturn(mockCallable);
      when(mockCallable.call(any)).thenThrow(
        FirebaseFunctionsException(message: 'Internal Error', code: 'internal'),
      );

      final results = await adapter.rank(
        payloads: [
          const SemanticRankingPayload(
            feedItemId: '1',
            sourceId: 'src1',
            type: 'job',
            title: 'Job 1',
          ),
        ],
        userIntent: 'intent',
      );

      expect(results, isEmpty);
    });

    test('should not call callable if payloads is empty', () async {
      await adapter.rank(payloads: [], userIntent: 'test');
      verifyNever(mockFunctions.httpsCallable(any));
    });

    test('should not call callable if intent is empty', () async {
      await adapter.rank(
        payloads: [const SemanticRankingPayload(feedItemId: '1', sourceId: 's', type: 't', title: 't')],
        userIntent: '   ',
      );
      verifyNever(mockFunctions.httpsCallable(any));
    });

    test('should truncate to 30 items before calling', () async {
      final manyPayloads = List.generate(
        40,
        (i) => SemanticRankingPayload(
          feedItemId: '$i',
          sourceId: 's',
          type: 't',
          title: 't',
        ),
      );

      when(mockFunctions.httpsCallable(any)).thenReturn(mockCallable);
      when(mockCallable.call(any)).thenAnswer((_) async => FakeHttpsCallableResult({'results': []}));

      await adapter.rank(payloads: manyPayloads, userIntent: 'test');

      final captured = verify(mockCallable.call(captureAny)).captured.single as Map<String, dynamic>;
      final items = captured['items'] as List;
      expect(items.length, 30);
    });

    test('should handle malformed response safely', () async {
      when(mockFunctions.httpsCallable(any)).thenReturn(mockCallable);
      when(mockCallable.call(any)).thenAnswer((_) async => FakeHttpsCallableResult('not a map'));

      final results = await adapter.rank(
        payloads: [const SemanticRankingPayload(feedItemId: '1', sourceId: 's', type: 't', title: 't')],
        userIntent: 'test',
      );
      expect(results, isEmpty);
    });

    test('should clamp scores from response', () async {
      when(mockFunctions.httpsCallable(any)).thenReturn(mockCallable);
      when(mockCallable.call(any)).thenAnswer((_) async => FakeHttpsCallableResult({
            'results': [
              {'feedItemId': '1', 'score': 50.0},
              {'feedItemId': '2', 'score': -10.0}
            ]
          }));

      final results = await adapter.rank(payloads: [
        const SemanticRankingPayload(feedItemId: '1', sourceId: 's', type: 't', title: 't'),
        const SemanticRankingPayload(feedItemId: '2', sourceId: 's', type: 't', title: 't'),
      ], userIntent: 'test');

      expect(results[0].score, 30.0);
      expect(results[1].score, 0.0);
    });
  });
}

class FakeHttpsCallableResult<T> implements HttpsCallableResult<T> {
  @override
  final T data;
  FakeHttpsCallableResult(this.data);
}
