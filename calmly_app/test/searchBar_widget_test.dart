import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/searchBar.dart';

void main() {
  testWidgets('searchBar Widget Test', (WidgetTester tester) async {
    // Build the searchBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: searchBar(
            onChanged: (value) {},
          ),
        ),
      ),
    );

    // Verify that the TextField widget is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the hintText is correct
    expect(find.text('search'), findsOneWidget);

    // Verify that the SvgPicture.asset widget is present
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byIcon(Icons.search),
        findsNothing); // Assumes search.svg is not using the default search icon
  });
}
