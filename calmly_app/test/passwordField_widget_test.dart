import 'package:calmly_app/components/passwordField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Password Field Widget Test', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: passwordField(
            onChanged: (value) {},
            controller: controller,
          ),
        ),
      ),
    );

    expect(tester.widget<TextField>(find.byType(TextField)).obscureText, true);

    await tester.enterText(find.byType(TextField), 'password123');

    expect(controller.text, 'password123');

    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pumpAndSettle();

    expect(tester.widget<TextField>(find.byType(TextField)).obscureText, false);

    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pumpAndSettle();

    expect(tester.widget<TextField>(find.byType(TextField)).obscureText, true);
  });
}
