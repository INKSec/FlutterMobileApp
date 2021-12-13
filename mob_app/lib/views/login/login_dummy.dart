import 'package:flutter/material.dart';
import 'package:mob_app/auth/auth_user.dart';
import 'package:mob_app/auth/auth_provider.dart';
import 'package:mob_app/auth/providers/dummy_provider.dart';
import 'package:mob_app/views/login/login_base.dart';

class DummyLoginView extends AbstractLoginView {
  final GlobalKey<FormFieldState> _loginFormUserKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _loginFormPasswordKey =
      GlobalKey<FormFieldState>();

  DummyLoginView({Key? key, required Function createNextWidget})
      : super(
            key: key,
            provider: DummyAuthProvider(),
            createNextWidget: createNextWidget);

  @override
  Widget buildLoginView(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 100, right: 100),
        child: Form(
          child: Column(children: [
            TextFormField(
              key: _loginFormUserKey,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextFormField(
              key: _loginFormPasswordKey,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
              obscuringCharacter: "*",
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: () {
                    doLogin(context).then((success) {
                      if (success) {
                        routePostLogin(context);
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
        ));
  }

  @override
  Future<AuthenticatedUser> loginProvider(AuthProvider provider) async {
    return await provider.login(_loginFormUserKey.currentState!.value,
        _loginFormPasswordKey.currentState!.value);
  }
}
