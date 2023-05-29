import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/smallButton.dart';

void main() {
  testWidgets('smallButton Widget Test', (WidgetTester tester) async {
    // Build the smallButton widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: smallButton(
            buttonTitle: 'Press Me',
            press: () {},
          ),
        ),
      ),
    );

    // Verify that the button with the expected text is present
    expect(find.text('Press Me'), findsOneWidget);
  });
}
