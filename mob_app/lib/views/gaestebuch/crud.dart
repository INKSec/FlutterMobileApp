import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethoden {
  final FirebaseFirestore _firestore;

  CrudMethoden({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addData(daten) async {
    _firestore.collection("path").add(daten).catchError((e) {});
    print(e);
  }

  getData() async {
    return await _firestore.collection("path").snapshots();
  }
}
