import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/screens/infoScreen/components/articleScreen.dart';

void main() {
  testWidgets('articleScreen Widget Test', (WidgetTester tester) async {
    // Define the test data for the article
    final articleKey = 'Article Key';
    final articleTitle = 'Article Title';
    final articleContent = 'Article Content';

    // Build the articleScreen widget
    await tester.pumpWidget(
      MaterialApp(
        home: articleScreen(
          articleKey: articleKey,
          articleTitle: articleTitle,
          articleContent: articleContent,
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(navBar), findsOneWidget);
    expect(find.text(articleTitle), findsOneWidget);
    expect(find.text(articleContent), findsOneWidget);
  });
}
