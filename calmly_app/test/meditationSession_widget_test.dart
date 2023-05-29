import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/meditationScreen/components/meditationSession.dart';

void main() {
  testWidgets('meditationSession Widget Test', (WidgetTester tester) async {
    // Define the test variables
    const int sessionNum = 1;
    const String sessionTitle = 'Session Title';
    const String audioURL = 'audio.mp3';
    bool isPlaying = false;
    int clickedSessionNum = -1;

    // Build the meditationSession widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: meditationSession(
            sessionNum: sessionNum,
            sessionTitle: sessionTitle,
            audioURL: audioURL,
            press: () {
              isPlaying = !isPlaying;
            },
            sessionClicked: (num) {
              clickedSessionNum = num;
            },
            isPlaying: isPlaying,
          ),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsNothing);
    expect(find.text('session $sessionNum - $sessionTitle'), findsOneWidget);

    // Tap the widget to simulate playing the session
    await tester.tap(find.byType(meditationSession));
    await tester.pumpAndSettle();

    // Verify the updated state of the widget
    expect(find.byIcon(Icons.pause), findsNothing);
    expect(clickedSessionNum, sessionNum);
    expect(isPlaying, true);
  });
}
