import 'package:calmly_app/screens/meditationScreen/meditationScreen.dart';
import 'package:calmly_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/option.dart';

void main() {
  testWidgets('Render HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Verify that the openingScreen widget is rendered
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Navigate to meditationScreen on "meditate" option tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Tap on the "meditate" option
    await tester.tap(find.ancestor(
        of: find.text('meditate'), matching: find.byType(option)));
    await tester.pumpAndSettle();

    // Verify redirection to the meditationScreen
    expect(find.byType(meditationScreen), findsOneWidget);
  });
}
