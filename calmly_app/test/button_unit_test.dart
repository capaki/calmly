import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/button.dart';

void main() {
  testWidgets('mainButton Test', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: mainButton(
            buttonTitle: 'Button',
            press: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    // Verify the initial state of the mainButton
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Button'), findsOneWidget);

    // Tap on the mainButton
    await tester.tap(find.text('Button'));
    await tester.pump();

    // Verify that the press callback is called
    expect(pressed, true);
  });
}
