import 'package:calmly_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Main Button Widget Test', (WidgetTester tester) async {
    // Define the test variables
    String buttonTitle = 'Submit';
    bool isPressed = false;

    // Build the mainButton widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: mainButton(
            buttonTitle: buttonTitle,
            press: () {
              isPressed = true;
            },
          ),
        ),
      ),
    );

    // Verify that the button title is displayed correctly
    expect(find.text(buttonTitle), findsOneWidget);

    // Tap on the button
    await tester.tap(find.text(buttonTitle));
    await tester.pump();

    // Verify that the onPressed callback is triggered and the button is pressed
    expect(isPressed, true);
  });
}
