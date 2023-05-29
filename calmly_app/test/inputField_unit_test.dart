import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/inputField.dart';

void main() {
  testWidgets('InputField Test', (WidgetTester tester) async {
    String inputValue = '';

    TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: inputField(
            hintText: 'Hint',
            icon: Icons.search,
            controller: controller,
            onChanged: (value) {
              inputValue = value;
            },
          ),
        ),
      ),
    );

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'Test Input');
    expect(inputValue, 'Test Input');
  });
}
