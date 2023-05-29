import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/searchBar.dart';
import 'package:calmly_app/screens/infoScreen/components/articleScreen.dart';
import 'package:calmly_app/screens/infoScreen/components/infoArticle.dart';
import 'package:calmly_app/screens/infoScreen/infoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calmly_app/main.dart';

void main() {
  testWidgets('Navigate to HomePage on navBar tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: infoScreen()));

    // Verify that the InfoScreen widget is rendered
    expect(find.byType(infoScreen), findsOneWidget);

    // Tap on the "home" tab in the navBar
    await tester.tap(find.text('home'));
    await tester.pumpAndSettle();

    // Verify redirection to the HomePage
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Render InfoScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: infoScreen()));

    expect(find.byType(infoScreen), findsOneWidget);

    expect(find.text('get informed'), findsOneWidget);
    expect(find.text('get to know your mind better'), findsOneWidget);

    expect(find.byType(searchBar), findsOneWidget);

    final articles = tester.widgetList<GestureDetector>(
      find.byType(GestureDetector),
    );
    expect(articles, isNotEmpty);
  });
}
