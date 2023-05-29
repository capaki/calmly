import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/option.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  testWidgets('Option Widget Test', (WidgetTester tester) async {
    final svgSource = 'assets/icons/Meditation.svg';
    final optionTitle = 'Example Option';

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

    // Verify the initial state of the Option widget
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.text(optionTitle), findsOneWidget);
  });
}
