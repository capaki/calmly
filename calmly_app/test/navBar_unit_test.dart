import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:calmly_app/components/navBar.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  testWidgets('Nav Bar Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: navBar(),
    ));

    expect(find.byType(navBarItem), findsNWidgets(3));
  });

  testWidgets('Nav Bar Item Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: navBarItem(
            svgSource: "assets/icons/home.svg",
            navTitle: "home",
            press: () {},
            isActive: true,
          ),
        ),
      ),
    );

    expect(find.text('home'), findsOneWidget);

    expect(find.byType(SvgPicture), findsOneWidget);
  });
}
