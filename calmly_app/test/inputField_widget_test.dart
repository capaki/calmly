import 'package:calmly_app/components/inputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Input Field Widget Test', (WidgetTester tester) async {
    // Define the test variables
    String hintText = 'Enter your name';
    String enteredText = '';

    // Create a TextEditingController for the input field
    TextEditingController controller = TextEditingController();

    // Build the inputField widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: inputField(
            hintText: hintText,
            icon: Icons.person,
            controller: controller,
            onChanged: (value) {
              enteredText = value;
            },
          ),
        ),
      ),
    );

    // Enter text into the input field
    await tester.enterText(find.byType(TextField), 'John Doe');
    await tester.pump();

    // Verify that the entered text is correctly assigned to the controller and onChanged callback
    expect(controller.text, 'John Doe');
    expect(enteredText, 'John Doe');
  });
}
