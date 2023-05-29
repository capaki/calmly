import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/textField.dart';

void main() {
  testWidgets('textField Widget Test', (WidgetTester tester) async {
    // Build the textField widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: textField(
            child: TextField(
              controller: TextEditingController(),
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Enter your text',
              ),
            ),
          ),
        ),
      ),
    );

    // Verify that the TextField widget is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the hintText is correct
    expect(find.text('Enter your text'), findsOneWidget);
  });
}
