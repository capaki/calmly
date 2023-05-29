import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/openingScreen/openingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/main.dart';

void main() {
  testWidgets('Navigate to HomePage on tap', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: openingScreen()));

    // Tap on the screen
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // Verify redirection to the HomePage
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Render openingScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: openingScreen()));

    // Verify that the openingScreen widget is rendered
    expect(find.byType(openingScreen), findsOneWidget);

    // Verify the presence of the "calmly" text within the RichText widget
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText && widget.text.toPlainText().contains('calmly'),
      ),
      findsOneWidget,
    );
  });
}
