import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/navigation_drawer.dart';

class MeinVerein extends StatelessWidget {
  const MeinVerein({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text('Mein Verein'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
      );
}
