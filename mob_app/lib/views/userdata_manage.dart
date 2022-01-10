import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mob_app/models/userdata.dart';
import 'package:mob_app/storage/providers/firestore_provider.dart';
import 'package:mob_app/views/navigation_drawer.dart';
import 'package:mob_app/globals.dart' as globals;

class UserDataManageView extends StatelessWidget {
  final GlobalKey<FormFieldState> _nameKey = GlobalKey<FormFieldState>();

  UserDataManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          leading: (ModalRoute.of(context)?.canPop ?? false)
              ? const BackButton()
              : null, // Backbutton
          title: Text(
            'Meine Daten',
            style: TextStyle(color: HexColor("#d3d3d3")),
          ),
          centerTitle: true,
          backgroundColor: HexColor('#808080'),
        ),
        body: Center(
          child: Form(
            child: Column(
              children: [
                (globals.userdata?.avatar != null &&
                        globals.userdata?.avatar != "")
                    ? Image.network(globals.userdata?.avatar ?? "")
                    : Text("no image"),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: TextFormField(
                    key: _nameKey,
                    style: TextStyle(color: HexColor("#101010")),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: HexColor("#101010")),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#d3d3d3")),
                      ),
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Speichern'),
                      onPressed: () {
                        // Save values to userdata model
                        globals.userdata!.displayName =
                            _nameKey.currentState!.value ??
                                globals.userdata!.displayName;

                        // unsafe type cast to UserData but tbh if this *was*
                        // null then we would have had problems earlier
                        globals.userDataStorageProvider
                            .update(globals.userdata as UserData)
                            .then((_) => Navigator.of(context).pop());
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Abbrechen'))
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: HexColor('#ffffff'),
      );
}
