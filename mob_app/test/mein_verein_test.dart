import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/mein_verein.dart';

Future<Widget> createMeinVereinView() async {
  final firestore =
      FakeFirebaseFirestore(); //substitute with fake firestore for testing.
  await firestore.collection('testliste').add({'name': 'test'});
  return MaterialApp(home: MeinVerein(firestore: firestore));
}

void main() {
  group("Mein Verein View Widget Tests", () {
    testWidgets('Mein Verein View Smoke Test', (WidgetTester tester) async {
      //await Firebase.initializeApp();
      await tester.pumpWidget(await createMeinVereinView());
    });
  });
}
