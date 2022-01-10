import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/login/login_dummy.dart';

Widget createDummyLoginView() => MaterialApp(
      home: DummyLoginView(createNextWidget: () => {}),
    );

void main() {
  group("Dummy Login View Widget Tests", () {
    testWidgets('Dummy Login View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createDummyLoginView());
    });
  });
}
