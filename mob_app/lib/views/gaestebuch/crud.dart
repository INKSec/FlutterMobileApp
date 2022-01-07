import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethoden {
  Future<void> addData(daten) async {
    FirebaseFirestore.instance.collection("path").add(daten).catchError((e) {});
    print(e);
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("path").snapshots();
  }
}
