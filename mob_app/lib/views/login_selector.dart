import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mob_app/storage/storage_provider.dart';
import 'package:mob_app/views/login/login_local_user.dart';
import 'package:mob_app/views/login/login_oidc_generic.dart';

class LoginSelectorView extends StatelessWidget {
  final void Function(BuildContext) createNextWidget;
  final AbstractStorageProvider storageProvider;
  // ignore: prefer_const_constructors_in_immutables
  LoginSelectorView(
      {Key? key,
      required this.createNextWidget,
      required AbstractStorageProvider this.storageProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navWidgets = _buildNavigatorWidgets(context, storageProvider);
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
            child: Container(
      padding: const EdgeInsets.fromLTRB(10, 150, 10, 150),
      child: Column(children: [
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Text("Login with:",
                style: Theme.of(context).textTheme.headline6)),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: navWidgets.entries
                // this is a bit messy but it works.
                // In essence we are iterating over the map of authentication
                // provider widgets and turn it into a list where each entry
                // is a widget containing a button that navigates to the
                // corresponding LoginView.
                .map<Widget>(
                    (MapEntry<String, Widget Function(dynamic)> entry) =>
                        FractionallySizedBox(
                            widthFactor: 1,
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                    child: Text(
                                      entry.key,
                                    ),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                            builder: (context) =>
                                                entry.value(context)))))))
                .toList())
      ]),
    )));
  }

  Map<String, Widget Function(dynamic)> _buildNavigatorWidgets(
      BuildContext context, AbstractStorageProvider storageProvider) {
    return {
      'OIDC': (context) => GenericOpenIDLoginView(
            issuerUri: Uri.parse("http://192.168.1.232:8001/issuer"),
            clientId: "81RRjLMem3ASRqzNI1xrnUkPELofcIAusPkjyk4Q",
            createNextWidget: createNextWidget,
            useWebView: true,
          ),
      // 'OIDC Public Test Domain': (context) => GenericOpenIDLoginView(
      //     issuerUri: Uri.parse("http://136.243.14.112/issuer"),
      //     clientId: "oF8h8CtSrBOoSpKVTD83hcMtzgrZAGAmFmVtpoPA",
      //     createNextWidget: createNextWidget),
      'Google': (context) => GenericOpenIDLoginView(
          issuerUri: Uri.parse("https://accounts.google.com"),
          clientId:
              "661233299869-647c4hugbvell2osbksdsc8m8mim1kjr.apps.googleusercontent.com",
          // Note that putting this in the source code is not very secure.
          // However this is a public client and shouldn't even need an OAuth client secret.
          // Seems like someone forgot to tell Google about that though. Oh well.
          clientSecret: "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",
          createNextWidget: createNextWidget),

      'Local User': (context) =>
          LocalUserLoginView(createNextWidget: createNextWidget),
    };
  }
}
