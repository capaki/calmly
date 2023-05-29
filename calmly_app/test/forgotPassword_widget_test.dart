import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/loginScreen/components/forgotPassword.dart';

void main() {
  testWidgets('ForgotPassword Widget Test', (WidgetTester tester) async {
    // Define a flag to track whether the press callback is triggered
    bool pressCallbackTriggered = false;

    // Build the ForgotPassword widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForgotPassword(
            press: () {
              pressCallbackTriggered = true;
            },
          ),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.text("forgot password?"), findsOneWidget);

    // Tap the widget to trigger the press callback
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Verify that the press callback is triggered
    expect(pressCallbackTriggered, isTrue);
  });
}
