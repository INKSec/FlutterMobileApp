import 'dart:developer';

import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestViewState();
  }
}

class TestViewState extends State<TestView> {
  String? yeah;

  Future<String> _getYeah() {
    return HttpRequest.getString("https://google.com");
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
        appBar: AppBar(title: Text("Test View")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(120.0),
            child: ListView(
              children: [
                create_list_entry("This"),
                create_list_entry("is"),
                create_list_entry("a"),
                create_list_entry("test"),
                create_list_entry(yeah ?? "null"),
                ElevatedButton(
                  child: const Text("yeah"),
                  onPressed: () {
                    _doUpdateYeah();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
