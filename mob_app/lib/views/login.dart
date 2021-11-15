import 'package:flutter/material.dart';
import 'package:mob_app/views/home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 100, right: 100),
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
                                    builder: (context) => HomeView()));
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
