import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/navigation_drawer.dart';

class MeinVerein extends StatelessWidget {
  const MeinVerein({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          leading: (ModalRoute.of(context)?.canPop ?? false)
              ? const BackButton()
              : null, // Backbutton
          title: TextField(),
          centerTitle: true,

          backgroundColor: Colors.red,
        ),
        body: Center(
            child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('testliste').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Wer das liest ist schnell'));
            }
            return ListView(
              children: snapshot.data!.docs.map((testliste) {
                return Center(
                  child: ListTile(
                    title: Text(testliste['name']),
                  ),
                );
              }).toList(),
            );
          },
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {},
        ),
      );
}
