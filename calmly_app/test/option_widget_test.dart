import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/option.dart';

void main() {
  testWidgets('Option Widget Test', (WidgetTester tester) async {
    // Define the test data for the option widget
    final svgSource = 'assets/icons/Meditation.svg';
    final optionTitle = 'Example Option';

    // Build the Option widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: option(
            svgSource: svgSource,
            optionTitle: optionTitle,
            press: () {},
          ),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.text(optionTitle), findsOneWidget);
  });
}
