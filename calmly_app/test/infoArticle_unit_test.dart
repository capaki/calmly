import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/infoScreen/components/infoArticle.dart';

void main() {
  testWidgets('InfoArticle Test', (WidgetTester tester) async {
    const articleTitle = 'Article Title';
    const articleDetail = 'Article Detail';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: infoArticle(
            articleTitle: articleTitle,
            articleDetail: articleDetail,
            articleKey: 'key',
            press: () {},
          ),
        ),
      ),
    );

    expect(find.text(articleTitle), findsOneWidget);
    expect(find.text(articleDetail), findsOneWidget);
  });
}
