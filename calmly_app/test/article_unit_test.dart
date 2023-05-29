import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/infoScreen/components/articleScreen.dart';

void main() {
  testWidgets('Article Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: articleScreen(
        articleKey: 'key',
        articleTitle: 'Article Title',
        articleContent: 'Article Content',
      ),
    ));

    // Verify that the article title and content are rendered
    expect(find.text('Article Title'), findsOneWidget);
    expect(find.text('Article Content'), findsOneWidget);
  });
}
