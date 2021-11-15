import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/news.dart';

Widget createNewsView() => MaterialApp(
      home: NewsPage(),
    );

void main() {
  group("News View Widget Tests", () {
    testWidgets('News View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createNewsView());
    });
  });
}
