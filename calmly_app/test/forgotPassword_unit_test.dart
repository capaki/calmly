import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/loginScreen/components/forgotPassword.dart';

void main() {
  testWidgets('forgotPassword Test', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForgotPassword(
            press: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    // Verify the initial state of the forgotPassword
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.text("forgot password?"), findsOneWidget);

    // Tap on the "forgot password?" text
    await tester.tap(find.text("forgot password?"));
    await tester.pump();

    // Verify that the press callback is called
    expect(pressed, true);
  });
}
