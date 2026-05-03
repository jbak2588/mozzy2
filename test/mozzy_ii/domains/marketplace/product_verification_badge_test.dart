import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/widgets/product_verification_badge.dart';

void main() {
  Widget buildTestWidget(ProductModel product) {
    return MaterialApp(
      home: Scaffold(body: ProductVerificationBadge(product: product)),
    );
  }

  testWidgets('renders Terverifikasi AI when passed and isAiVerified true', (tester) async {
    final product = ProductModel(
      id: '1',
      userId: 'u1',
      title: 'T',
      description: 'D',
      category: 'C',
      price: 100,
      geoPath: 'G',
      createdAt: DateTime.now(),
      isAiVerified: true,
      aiVerificationStatus: 'passed',
    );

    await tester.pumpWidget(buildTestWidget(product));
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
  });

  testWidgets('renders Perlu ditinjau when needs_review', (tester) async {
    final product = ProductModel(
      id: '2',
      userId: 'u1',
      title: 'T',
      description: 'D',
      category: 'C',
      price: 100,
      geoPath: 'G',
      createdAt: DateTime.now(),
      isAiVerified: false,
      aiVerificationStatus: 'needs_review',
    );

    await tester.pumpWidget(buildTestWidget(product));
    expect(find.byIcon(Icons.rate_review_outlined), findsOneWidget);
  });

  testWidgets('renders Tidak lolos AI when failed', (tester) async {
    final product = ProductModel(
      id: '3',
      userId: 'u1',
      title: 'T',
      description: 'D',
      category: 'C',
      price: 100,
      geoPath: 'G',
      createdAt: DateTime.now(),
      isAiVerified: false,
      aiVerificationStatus: 'failed',
    );

    await tester.pumpWidget(buildTestWidget(product));
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('renders nothing when not_requested', (tester) async {
    final product = ProductModel(
      id: '4',
      userId: 'u1',
      title: 'T',
      description: 'D',
      category: 'C',
      price: 100,
      geoPath: 'G',
      createdAt: DateTime.now(),
      isAiVerified: false,
      aiVerificationStatus: 'not_requested',
    );

    await tester.pumpWidget(buildTestWidget(product));
    expect(find.byType(SizedBox), findsOneWidget);
  });
}
