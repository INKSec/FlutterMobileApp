// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/home_view.dart';
import 'package:mob_app/views/login_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var primaryColor = const Color.fromRGBO(80, 100, 160, 1);
// Bei Appstart wird jetzt Firebase gestartet
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: MaterialColor(primary_color.value, {1: primary_color}),
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          surface: primaryColor,
        ),
        // backgroundColor: primary_color
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginSelectorView(
          createNextWidget: (BuildContext context) => const HomeView()),
    );
  }
}
