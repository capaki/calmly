import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/calendarScreen/components/EventsList.dart';

void main() {
  testWidgets('EventsList Widget Test', (WidgetTester tester) async {
    // Define the test data for the events list
    final events = [
      {
        'mood': 'awesome',
        'reason': 'Feeling great today!',
      },
      {
        'entry': 'Today was a productive day.',
      },
    ];

    // Build the EventsList widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventsList(events: events),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(2));
    expect(find.text('Mood: awesome'), findsOneWidget);
    expect(find.text('Feeling great today!'), findsOneWidget);
    expect(find.text('Journal Entry:'), findsOneWidget);
    expect(find.text('Today was a productive day.'), findsOneWidget);
  });
}
