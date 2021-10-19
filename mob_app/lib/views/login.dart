import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mob_app/views/test_view.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 150, right: 150),
                child: Form(
                  child: Column(children: [
                    const TextField(
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                    const TextField(
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                      obscuringCharacter: "*",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TestView()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    )
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
