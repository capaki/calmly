import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/accountCheck.dart';

void main() {
  testWidgets('accountCheck Test', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: accountCheck(
            login: true,
            press: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    // Verify the initial state of the accountCheck
    expect(find.byType(Row), findsOneWidget);
    expect(find.text("don't have an account yet? "), findsOneWidget);
    expect(find.text("SIGN UP"), findsOneWidget);

    // Tap on the "SIGN UP" text
    await tester.tap(find.text("SIGN UP"));
    await tester.pump();

    // Verify that the press callback is called
    expect(pressed, true);
  });
}
