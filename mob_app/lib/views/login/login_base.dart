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
  late final AbstractStorageProvider userStorageProvider;

  AbstractLoginView(
      {Key? key,
      required AuthProvider provider,
      required Function createNextWidget,
      required AbstractStorageProvider storageProvider})
      : super(key: key) {
    authProvider = provider;
    nextWidget = createNextWidget;
    userStorageProvider = storageProvider;
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
      globals.userdata = await userStorageProvider.read(
          user.id, (data) => UserData.deserialize(data)) as UserData;
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
