import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'navigation_drawer.dart';
import 'package:mob_app/globals.dart' as globals;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          leading: (ModalRoute.of(context)?.canPop ?? false)
              ? const BackButton()
              : null, // Backbutton
          title: Text(
            'Startseite',
            style: TextStyle(color: HexColor("#d3d3d3")),
          ),
          centerTitle: true,
          backgroundColor: HexColor('#808080'),
        ),
        body: const StartBildschirm(),
        backgroundColor: HexColor('#ffffff'),
      );
}

class StartBildschirm extends StatelessWidget {
  const StartBildschirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 400,
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          // Artikelbox Hintergrund
          color: HexColor("#d3d3d3"),
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: HexColor("d3d3d3"),
            ),
            child: Text(
              "Willkommen ${globals.user?.name}",
              style: TextStyle(
                  // Farbe Überschrift
                  color: HexColor('#000000'),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
            ),
          ),
          Container(
            child: Text(
              "Mit einem überragenden Sieg hat der TSV Kleinmühlen den Gegner in die Knie gezwungen. Hoch lebe der TSV. Während andere nur auf der Bank saßen, haben wir angefeuert",
              style: TextStyle(color: HexColor('#000000')),
            ),
          )
        ],
      ),
    );
  }
}
