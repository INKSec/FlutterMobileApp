import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/home_view.dart';

Widget createHomeView() => MaterialApp(
      home: HomeView(),
    );

void main() {
  group("Home View Widget Tests", () {
    testWidgets('Home View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeView());
    });
  });
}
