//import 'dart:html';

//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/gaestebuch/view.dart';
import 'package:mob_app/views/impressum.dart';
import 'package:mob_app/views/mein_verein.dart';
import 'package:mob_app/views/news.dart';
import 'package:mob_app/views/home_view.dart';
import 'package:mob_app/views/gaestebuch/gaestebuch.dart';
import 'package:mob_app/views/newsApp/article_view.dart';
import 'package:mob_app/views/userdata_manage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'Startseite',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'News',
              icon: Icons.alarm,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'Mein Verein',
              icon: Icons.ballot,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'Gästebuch',
              icon: Icons.book,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white70),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'Optionen',
              icon: Icons.car_rental,
              onClicked: () => selectedItem(context, 6),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'Impressum',
              icon: Icons.text_fields,
              onClicked: () => selectedItem(context, 5),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

// Aussehen der Menüpunkte
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

// Switch für routing
  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop(); // Schließt den Navigator

    switch (index) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeView(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Artikel(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MeinVerein(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const GaesteView(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Impressum(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserDataManageView(),
        ));
        break;
    }
  }
}
