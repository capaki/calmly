import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:flutter/material.dart';


void main() {
  testWidgets('TextField Test', (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    String textFieldValue = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: textField(
            controller: controller,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                textFieldValue = value;
              },
              decoration: InputDecoration(
                hintText: 'Test Hint',
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the initial state of the TextField
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Test Hint'), findsOneWidget);

    // Enter text into the TextField
    await tester.enterText(find.byType(TextField), 'Test Text');
    expect(textFieldValue, 'Test Text');
    expect(controller.text, 'Test Text');
  });
}
