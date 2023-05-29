import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/calendarScreen/components/EventsList.dart';

void main() {
  testWidgets('EventsList Test', (WidgetTester tester) async {
    final events = [
      {
        'mood': 'awesome',
        'reason': 'Feeling great today!',
      },
      {
        'entry': 'Lorem ipsum dolor sit amet.',
      },
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventsList(events: events),
        ),
      ),
    );

    // Verify the number of event cards displayed
    expect(find.byType(Card), findsNWidgets(events.length));

    // Verify the content of each event card
    for (int i = 0; i < events.length; i++) {
      final event = events[i];

      if (event.containsKey('mood')) {
        expect(find.text('Mood: ${event['mood'] ?? ''}'), findsOneWidget);
        expect(find.text(event['reason'] ?? ''), findsOneWidget);
        expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
      } else if (event.containsKey('entry')) {
        expect(find.text('Journal Entry:'), findsOneWidget);
        expect(find.text(event['entry'] ?? ''), findsOneWidget);
        expect(find.byIcon(Icons.book), findsOneWidget);
      }
    }
  });
}
