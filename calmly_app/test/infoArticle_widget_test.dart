import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/infoScreen/components/infoArticle.dart';

void main() {
  testWidgets('infoArticle Widget Test', (WidgetTester tester) async {
    // Define a flag to track whether the press callback is triggered
    bool pressCallbackTriggered = false;

    // Define the test data for the article
    final articleTitle = 'Article Title';
    final articleDetail = 'Article Detail';
    final articleKey = 'Article Key';

    // Build the infoArticle widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: infoArticle(
            articleTitle: articleTitle,
            articleDetail: articleDetail,
            articleKey: articleKey,
            press: () {
              pressCallbackTriggered = true;
            },
          ),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.text(articleTitle), findsOneWidget);
    expect(find.text(articleDetail), findsOneWidget);

    // Tap the widget to trigger the press callback
    await tester.tap(find.byType(InkWell));
    await tester.pump();

    // Verify that the press callback is triggered
    expect(pressCallbackTriggered, isTrue);
  });
}
