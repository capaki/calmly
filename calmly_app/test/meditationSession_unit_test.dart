import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/meditationScreen/components/meditationSession.dart';

void main() {
  testWidgets('MeditationSession Test', (WidgetTester tester) async {
    const sessionNum = 1;
    const sessionTitle = 'Session Title';
    const audioURL = 'audio_url';
    bool isPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: meditationSession(
            sessionNum: sessionNum,
            sessionTitle: sessionTitle,
            audioURL: audioURL,
            press: () {
              isPressed = true;
            },
            sessionClicked: (int sessionNum) {},
            isPlaying: false,
          ),
        ),
      ),
    );

    final sessionFinder = find.text('session $sessionNum - $sessionTitle');
    expect(sessionFinder, findsOneWidget);

    final playIconFinder = find.byIcon(Icons.play_arrow);
    expect(playIconFinder, findsOneWidget);

    await tester.tap(find.byType(InkWell));
    expect(isPressed, isTrue);
  });
}
