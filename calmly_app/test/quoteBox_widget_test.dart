import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/quoteBox.dart';

void main() {
  testWidgets('QuoteBox Widget Test', (WidgetTester tester) async {
    // Build the QuoteBox widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuoteBox(),
        ),
      ),
    );

    // Verify that the text widgets with the expected text are present
    expect(find.text('take a deep breath,'), findsOneWidget);
    expect(find.text('god knows you need it.'), findsOneWidget);
  });
}
