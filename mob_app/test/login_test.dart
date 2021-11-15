import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/login.dart';

Widget createLoginView() => MaterialApp(
      home: LoginView(),
    );

void main() {
  group("Login View Widget Tests", () {
    testWidgets('Login View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginView());
    });
  });
}
