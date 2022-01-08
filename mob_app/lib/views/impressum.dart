import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'navigation_drawer.dart';
import 'package:mob_app/globals.dart' as globals;

class Impressum extends StatelessWidget {
  const Impressum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          leading: (ModalRoute.of(context)?.canPop ?? false)
              ? const BackButton()
              : null, // Backbutton
          title: Text(
            'Impressum',
            style: TextStyle(color: HexColor("#d3d3d3")),
          ),
          centerTitle: true,
          backgroundColor: HexColor('#808080'),
        ),
        body: impressumview(),
        backgroundColor: HexColor('#ffffff'),
      );
}

class impressumview extends StatelessWidget {
  const impressumview({Key? key}) : super(key: key);

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
              "Na ${globals.user?.name}",
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
              "Wusstest du eigentlich, dass diese App von Jascha Hirsekorn und Michael Burkhardt stammt? ",
              style: TextStyle(color: HexColor('#000000')),
            ),
          )
        ],
      ),
    );
  }
}
