import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/newsApp/article_view.dart';

Widget createArticleView() => MaterialApp(
      home: Artikel(),
    );

void main() {
  group("Article View Widget Tests", () {
    testWidgets('Article View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createArticleView());
    });
  });
}
