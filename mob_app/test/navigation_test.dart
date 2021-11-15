import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/navigation_drawer.dart';

Widget createNavigationDrawer() => MaterialApp(
      home: NavigationDrawerWidget(),
    );

void main() {
  group("Navigation Drawer Widget Tests", () {
    testWidgets('Navigation Drawer Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createNavigationDrawer());
    });
  });
}
