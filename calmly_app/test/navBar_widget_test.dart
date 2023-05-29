import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:calmly_app/main.dart';
import 'package:calmly_app/components/navBar.dart';

void main() {
  testWidgets('Navigate to Home on "Home" tab tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: navBar(),
        ),
      ),
    );

    // Verify that the initial page is not the home page
    expect(find.byType(HomePage), findsNothing);

    // Tap on the "home" tab
    await tester.tap(find.text('home'));
    await tester.pumpAndSettle();

    // Verify redirection to the home page
    expect(find.byType(HomePage), findsOneWidget);
  });
}
