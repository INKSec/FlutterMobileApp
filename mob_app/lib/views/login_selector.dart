import 'package:flutter/material.dart';
import 'package:mob_app/views/login/login_dummy.dart';
import 'package:mob_app/views/login/login_oidc_generic.dart';

class LoginSelectorView extends StatelessWidget {
  final void Function(BuildContext) createNextWidget;
  LoginSelectorView({Key? key, required this.createNextWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navWidgets = _buildNavigatorWidgets(context);
    if (navWidgets.length == 1) {
      // if there is only one widget, don't show the selector
      // and instead move on to the LoginView directly.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => navWidgets.entries.first.value(context),
        ),
      );
    }
    return Scaffold(
        body: Center(
            child: Column(children: [
      Text("Login with:", style: Theme.of(context).textTheme.headline6),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: navWidgets.entries
              // this is a bit messy but it works.
              // In essence we are iterating over the map of authentication
              // provider widgets and turn it into a list where each entry
              // is a widget containing a button that navigates to the
              // corresponding LoginView.
              .map<Widget>((MapEntry<String, Widget Function(dynamic)> entry) =>
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          child: Text(entry.key),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (context) =>
                                      entry.value(context))))))
              .toList())
    ])));
  }

  Map<String, Widget Function(dynamic)> _buildNavigatorWidgets(
      BuildContext context) {
    return {
      'OIDC': (context) => GenericOpenIDLoginView(
          issuerUri: Uri.parse("http://192.168.1.232:8001/issuer"),
          clientId: "81RRjLMem3ASRqzNI1xrnUkPELofcIAusPkjyk4Q",
          createNextWidget: createNextWidget),
      'Anonymous': (context) =>
          DummyLoginView(createNextWidget: createNextWidget),
    };
  }
}