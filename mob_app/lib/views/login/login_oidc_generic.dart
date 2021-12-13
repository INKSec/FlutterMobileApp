import 'package:flutter/material.dart';
import 'package:mob_app/auth/auth_user.dart';
import 'package:mob_app/auth/auth_provider.dart';
import 'package:mob_app/auth/providers/openid_provider.dart';
import 'package:mob_app/views/login/login_base.dart';

class GenericOpenIDLoginView extends AbstractLoginView {
  GenericOpenIDLoginView(
      {Key? key,
      required Uri issuerUri,
      required String clientId,
      required Function createNextWidget})
      : super(
            key: key,
            createNextWidget: createNextWidget,
            provider: OpenIDProvider(clientId: clientId, issuerUri: issuerUri));

  @override
  Widget buildLoginView(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 100, right: 100),
        child: Form(
          child: Column(children: [
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
                      "Login with OpenID",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            )
          ]),
        ));
  }

  @override
  Future<AuthenticatedUser> loginProvider(AuthProvider provider) async {
    return await provider.login("", "");
  }
}
