import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/passwordField.dart';

void main() {
  testWidgets('Password Field Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: passwordField(
          onChanged: (value) {},
          controller: TextEditingController(),
        ),
      ),
    ));

    // Verify that the password field is rendered
    expect(find.byType(TextField), findsOneWidget);
  });
}
