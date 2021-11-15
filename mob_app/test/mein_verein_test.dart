import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/mein_verein.dart';

Widget createMeinVereinView() => MaterialApp(
      home: MeinVerein(),
    );

void main() {
  group("Mein Verein View Widget Tests", () {
    testWidgets('Mein Verein View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createMeinVereinView());
    });
  });
}
