import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/smallButton.dart';

void main() {
  testWidgets('Small Button Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: smallButton(
          buttonTitle: 'Button',
          press: () {},
        ),
      ),
    ));

    // Verify that the small button is rendered
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
