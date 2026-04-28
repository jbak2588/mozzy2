import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mozzy/mozzy_ii/domains/news/widgets/cross_link_section.dart';

void main() {
  testWidgets('CrossLinkSection shows title, description and icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CrossLinkSection(),
        ),
      ),
    );

    expect(find.text('news.relatedLocalItems'), findsOneWidget);
    expect(find.text('news.crossLinkDescription'), findsOneWidget);
    expect(find.byIcon(Icons.link), findsOneWidget);
  });
}
