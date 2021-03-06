import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mob_app/auth/auth_provider.dart';
import 'package:mob_app/auth/auth_user.dart';
import 'package:mob_app/globals.dart' as globals;
import 'package:mob_app/models/userdata.dart';
import 'package:mob_app/storage/storage_provider.dart';

/// Abstract Login View class.
///
/// This class is used to create a generic login view.
/// Implementation specific logic must be implemented for [buildLoginView] and
/// [loginProvider].
abstract class AbstractLoginView extends StatelessWidget {
  late final AuthProvider authProvider;
  late final Function nextWidget;

  AbstractLoginView({
    Key? key,
    required AuthProvider provider,
    required Function createNextWidget,
  }) : super(key: key) {
    authProvider = provider;
    nextWidget = createNextWidget;
  }

  /// Embedded login view builder.
  /// Use this to implement the login provider specific logic.
  Widget buildLoginView(BuildContext context);

  /// Provider login hook.
  /// Login the user using the provider and return an [AuthenticatedUser] instance.
  /// Use this to implement the login provider specific logic.
  Future<AuthenticatedUser> loginProvider(AuthProvider provider);

  /// Login callback.
  Future<bool> doLogin(context) async {
    //try to log in
    try {
      final user = await loginProvider(authProvider);
      globals.user = user; //save user
      // try to fetch userdata from database
      try {
        globals.userdata = await globals.userDataStorageProvider.read(
            user.id, (data) => UserData.deserialize(data, user.id)) as UserData;
        log("Userdata loaded from database");
      } catch (e) {
        log("No userdata found for user ${user.id}, creating new document");
        // if no userdata found, create new one
        globals.userdata = UserData(user.name, "", user.id);
        log("Writing to database");
        await globals.userDataStorageProvider.create(globals.userdata!);
      }
    } catch (e) {
      //if login fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLoginView(context),
          ],
        ),
      ),
    );
  }

  void routePostLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextWidget(context)),
    );
  }
}
