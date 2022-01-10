import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/login/login_local_user.dart';

Widget createLocalLoginView() => MaterialApp(
      home: LocalUserLoginView(createNextWidget: () => {}),
    );

void main() {
  group("Local Login View Widget Tests", () {
    testWidgets('Local Login View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createLocalLoginView());
    });
  });
}
