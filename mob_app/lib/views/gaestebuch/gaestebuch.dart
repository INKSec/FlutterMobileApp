// zwischenspeicher
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_app/views/gaestebuch/crud.dart';
import 'package:mob_app/views/navigation_drawer.dart';

class Upload extends StatefulWidget {
  late FirebaseFirestore firestore;

  Upload({
    Key? key,
    FirebaseFirestore? firestore,
  }) : super(key: key) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }

  @override
  _UploadState createState() => _UploadState(firestore);
}

class _UploadState extends State<Upload> {
  late String beschreibung;
  late File bild;
  final FirebaseFirestore firestore;

  _UploadState(this.firestore);

  CrudMethoden crudMethoden = CrudMethoden();

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      bild = image as File;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        leading: (ModalRoute.of(context)?.canPop ?? false)
            ? const BackButton()
            : null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Hochladen",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                getImage(); // oeffnet die Gallerie - Kamera oeffnen einbauen?
              },
              child: bild == null
                  ? Container()
                  : Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      width: MediaQuery.of(context).size.width,
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                      ),
                    ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(hintText: "Beschreibung"),
                    onChanged: (value) {
                      beschreibung = value;
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
