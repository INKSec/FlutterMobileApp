import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_app/views/gaestebuch/crud.dart';
import 'package:mob_app/views/navigation_drawer.dart';
import 'package:random_string/random_string.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  late String beschreibung;
  File? bild;

  CrudMethoden crudMethoden = CrudMethoden();

// laesst den Nutzer ein Bild aus der Galerie auswaehlen
  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        bild = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  uploadEintrag() async {
    if (bild != null) {
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("bild")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(bild!);

      var imageUrl;
      await task.whenComplete(() async {
        try {
          imageUrl = await firebaseStorageRef.getDownloadURL();
        } catch (onError) {
          print("Error");
        }

        Map<String, dynamic> myMap = {
          "imgUrl": imageUrl,
          "Beschreibung": beschreibung
        };
        crudMethoden.addData(myMap).then((value) {});
      });
    } else {
      print("Kein Bild");
    }
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
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  getImage(); // oeffnet die Gallerie - Kamera oeffnen einbauen?
                },
                child: bild != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              bild!,
                              fit: BoxFit.cover,
                            )),
                      )
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
                      )),
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
            ),
            Container(
                //padding: const EdgeInsets.symmetric(horizontal: 15),

                height: 80,
                margin: const EdgeInsets.fromLTRB(220, 350, 20, 20),
                child: Column(children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      uploadEintrag();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100)
                          //more than 50% of width makes circle
                          ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: const Icon(Icons.file_upload),
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
