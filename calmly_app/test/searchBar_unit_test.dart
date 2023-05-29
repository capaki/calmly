import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/components/searchBar.dart';

void main() {
  testWidgets('Search Bar Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: searchBar(
          onChanged: (value) {},
        ),
      ),
    ));

    // Verify that the search bar is rendered
    expect(find.byType(TextField), findsOneWidget);
  });
}
