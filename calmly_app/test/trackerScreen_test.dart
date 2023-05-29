import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/trackerScreen/trackerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Render trackerScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: trackerScreen(),
        ),
      ),
    );

    // Verify that the trackerScreen widget is rendered
    expect(find.byType(trackerScreen), findsOneWidget);

    // Verify the presence of key UI elements
    expect(find.byType(navBar), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(14));
    expect(find.byType(Wrap), findsOneWidget);
    expect(find.byType(InkWell), findsNWidgets(6));
    expect(find.byType(Container), findsNWidgets(8));
    expect(find.byType(Padding), findsNWidgets(17));
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(mainButton), findsOneWidget);
  });

  testWidgets('Select mood and submit reason', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: trackerScreen(),
        ),
      ),
    );

    // Select a mood by tapping on it
    await tester.tap(find.text('awesome'));
    await tester.pumpAndSettle();

    // Verify that the selected mood is updated
    expect(find.text('awesome'), findsOneWidget);

    // Enter a reason in the text field
    await tester.enterText(find.byType(TextField), 'Feeling great!');
    await tester.pumpAndSettle();

    // Verify that the entered reason is updated
    expect(find.text('Feeling great!'), findsOneWidget);
  });
}
