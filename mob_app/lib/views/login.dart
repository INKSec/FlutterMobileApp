import 'package:flutter/material.dart';
import 'package:mob_app/auth/auth_provider.dart';
import 'package:mob_app/auth/providers/dummy_provider.dart';
import 'package:mob_app/views/home_view.dart';

class LoginView extends StatelessWidget {
  final AuthProvider _authProvider = DummyAuthProvider() as AuthProvider;
  final GlobalKey<FormFieldState> _loginFormUserKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _loginFormPasswordKey =
      GlobalKey<FormFieldState>();

  LoginView({Key? key}) : super(key: key);

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
                    TextFormField(
                      key: _loginFormUserKey,
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                    TextFormField(
                      key: _loginFormPasswordKey,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                      obscuringCharacter: "*",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                          onPressed: () {
                            do_login(context).then((success) {
                              if (success) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeView()));
                              }
                            });
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

  Future<bool> do_login(context) async {
    //get the username and password from our form
    final username = _loginFormUserKey.currentState!.value;
    final password = _loginFormPasswordKey.currentState!.value;

    //try to log in
    try {
      final user = await _authProvider.login(username, password);
    } catch (e) {
      //if login fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    }
    //TODO: save user
    return true;
  }
}
