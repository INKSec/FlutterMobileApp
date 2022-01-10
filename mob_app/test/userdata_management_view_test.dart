import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/userdata_manage.dart';

Widget createUserDataView() => MaterialApp(
      home: UserDataManageView(),
    );

void main() {
  group("UserData View Widget Tests", () {
    testWidgets('UserData Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createUserDataView());
    });
  });
}
