import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/gaestebuch/gaestebuch.dart';
import 'package:mob_app/views/gaestebuch/view.dart';

Widget createGaestebuchView() => const MaterialApp(
      home: GaesteView(),
    );

Widget createUploadForm() => const MaterialApp(
      home: Upload(),
    );

void main() {
  group("Gaestebuch View Widget Tests", () {
    testWidgets('Gaestebuch View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createGaestebuchView());
    });
    testWidgets('Gaestebuch Upload Form Smoke Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(createUploadForm());
    });
  });
}
