import 'dart:developer';

import 'package:flutter/material.dart';

import 'navigation_drawer.dart';
import 'package:mob_app/globals.dart' as globals;

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  String? yeah;

  Future<String> _getYeah() {
    return Future<String>(() => "test");
  }

  void _doUpdateYeah() {
    setState(() {
      _getYeah().then((String value) {
        yeah = value;
      }).catchError((error) {
        log(error);
      });
    });
  }

  Widget create_list_entry(String label) {
    return Padding(padding: EdgeInsets.all(10), child: Text(label));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
            leading: (ModalRoute.of(context)?.canPop ?? false)
                ? const BackButton()
                : null, // Backbutton
            title: const Text("Startseite")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(120.0),
            child: ListView(
              children: [
                create_list_entry("Welcome ${globals.user}"),
                create_list_entry("Home page"),
                create_list_entry("Add more meaningful content here later.")
              ],
            ),
          ),
        ));
  }
}
