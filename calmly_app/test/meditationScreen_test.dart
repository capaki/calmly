import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/searchBar.dart';
import 'package:calmly_app/screens/meditationScreen/components/meditationSession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/meditationScreen/meditationScreen.dart';
import 'package:calmly_app/main.dart';

void main() {
  testWidgets('Navigate to HomePage on navBar tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: meditationScreen()));

    // Verify that the meditationScreen widget is rendered
    expect(find.byType(meditationScreen), findsOneWidget);

    // Tap on the "home" tab in the navBar
    await tester.tap(find.text('home'));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Render meditationScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: meditationScreen()));

    expect(find.byType(meditationScreen), findsOneWidget);

    expect(find.text('meditation'), findsOneWidget);
    expect(find.text('take a moment to breathe'), findsOneWidget);

    expect(find.byType(searchBar), findsOneWidget);

    final meditationSessions = tester.widgetList<GestureDetector>(
      find.byType(GestureDetector),
    );
    expect(meditationSessions, isNotEmpty);
  });
}
