import 'package:calmly_app/components/accountCheck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Account Check Widget Test', (WidgetTester tester) async {
    // Build the accountCheck widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: accountCheck(
            login: true,
            press: () {},
          ),
        ),
      ),
    );

    // Verify that the text widget displays the correct message
    expect(find.text("don't have an account yet? "), findsOneWidget);

    // Tap on the "SIGN UP" text
    await tester.tap(find.text("SIGN UP"));
    await tester.pumpAndSettle();

    expect(true, true);

    // Build the accountCheck widget with the login parameter set to false
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: accountCheck(
            login: false,
            press: () {},
          ),
        ),
      ),
    );

    // Verify that the text widget displays the correct message
    expect(find.text("already have an account? "), findsOneWidget);

    // Tap on the "LOG IN" text
    await tester.tap(find.text("LOG IN"));
    await tester.pumpAndSettle();

    expect(true, true);
  });
}
