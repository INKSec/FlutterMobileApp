// @dart=2.9
import 'package:flutter/material.dart';
import 'package:mob_app/views/home_view.dart';
import 'package:mob_app/views/login_selector.dart';

var primary_color = Color.fromRGBO(80, 100, 160, 1);

void main() {
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
          primary: primary_color,
          surface: primary_color,
        ),
        // backgroundColor: primary_color
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginSelectorView(
          createNextWidget: (BuildContext context) => HomeView()),
    );
  }
}
