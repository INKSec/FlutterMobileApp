import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/login/login_oidc_generic.dart';

Widget createOIDCLoginView() => MaterialApp(
      home: GenericOpenIDLoginView(
          createNextWidget: () => {},
          issuerUri: Uri.parse("example.org"),
          clientId: "clientId"),
    );

void main() {
  group("OIDC Login View Widget Tests", () {
    testWidgets('OIDC Login View Smoke Test', (WidgetTester tester) async {
      await tester.pumpWidget(createOIDCLoginView());
    });
  });
}
