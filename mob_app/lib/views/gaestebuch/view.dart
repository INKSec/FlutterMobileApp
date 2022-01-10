import 'dart:ffi';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/gaestebuch/crud.dart';
import 'package:mob_app/views/gaestebuch/view_upload.dart';
import 'package:mob_app/views/navigation_drawer.dart';
import 'package:mob_app/globals.dart' as globals;

class GaesteView extends StatefulWidget {
  late FirebaseFirestore firestore;

  GaesteView({Key? key, FirebaseFirestore? firestore}) : super(key: key) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }

  @override
  _GaesteViewState createState() => _GaesteViewState(firestore);
}

class _GaesteViewState extends State<GaesteView> {
  late CrudMethoden crudMethoden;

  _GaesteViewState(firestore) {
    this.crudMethoden = CrudMethoden(firestore: firestore);
  }

  Stream? myStream;
  Widget eintraege() {
    return Container(
      child: myStream != null
          ? StreamBuilder(
              stream: myStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                } // wegen nullfehler, position egal
                return ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Containerlein(
                          imgUrl: snapshot.data.docs[index]["imgUrl"] ?? "",
                          beschreibung:
                              snapshot.data.docs[index]["Beschreibung"] ?? "");
                    });
              },
            )
          : Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crudMethoden.getData().then((result) {
      setState(() {
        myStream = result;
      });
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
          children: const [
            Text(
              "Gaestebuch",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
      body: eintraege(),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Upload()));
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

// Die einzelnen Bloecke
class Containerlein extends StatelessWidget {
  late String imgUrl, beschreibung;
  Containerlein({Key? key, required this.imgUrl, required this.beschreibung})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
          height: 140,
          child: CachedNetworkImage(
            // Macht die Eintraege offline verfuegbar
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          )),
      SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              beschreibung,
              style: const TextStyle(
                color: Colors.amber,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        height: 20,
        width: 800,
      ),
    ]);
  }
}
