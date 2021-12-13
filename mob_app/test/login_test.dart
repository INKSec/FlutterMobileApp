import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/login_selector.dart';

Widget createLoginView() => MaterialApp(
      home: LoginSelectorView(createNextWidget: (BuildContext context) => null),
    );

void main() {
  group("Login View Widget Tests", () {
    testWidgets('Login View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginView());
    });
  });
}
