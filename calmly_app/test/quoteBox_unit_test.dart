import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/quoteBox.dart';

void main() {
  testWidgets('Quote Box Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: QuoteBox(),
      ),
    ));

    // Verify that the quote text is rendered
    expect(find.text('take a deep breath,'), findsOneWidget);
    expect(find.text('god knows you need it.'), findsOneWidget);
  });
}
