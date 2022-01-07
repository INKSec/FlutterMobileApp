import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/gaestebuch/crud.dart';
import 'package:mob_app/views/gaestebuch/view_upload.dart';
import 'package:mob_app/views/navigation_drawer.dart';

class GaesteView extends StatefulWidget {
  const GaesteView({Key? key}) : super(key: key);

  @override
  _GaesteViewState createState() => _GaesteViewState();
}

class _GaesteViewState extends State<GaesteView> {
  CrudMethoden crudMethoden = CrudMethoden();

  Stream? myStream;
// Wie wird das kack ding scrollbar???????????????????????????????????????????????????
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
                    // ohne funktioniert scrollen nicht
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Containerlein(
                          imgUrl: snapshot.data.docs[index]["imgUrl"],
                          beschreibung: snapshot.data.docs[index]
                              ["Beschreibung"]);
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
    return Container(
        height: 140,
        child: Stack(children: <Widget>[
          ClipRRect(
              child: CachedNetworkImage(
            // Macht die Eintraege offline verfuegbar
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          )),
          Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6),
              )),
          Container(
            child: Column(
              children: <Widget>[Text(beschreibung)],
            ),
          )
        ]));
  }
}
