import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/gaestebuch/crud.dart';

void main() {
  group("Gaestebuch API test", () {
    test("Should be able to write to database", () async {
      final FirebaseFirestore instance = FakeFirebaseFirestore();
      final CrudMethoden crud = CrudMethoden(firestore: instance);
      await crud.addData({"hello": "world"});
      expect(
          (await instance.collection("path").snapshots().first)
              .docs
              .first
              .data(),
          {"hello": "world"});
    });
    test("Should be able to read from database", () async {
      final FirebaseFirestore instance = FakeFirebaseFirestore();
      final CrudMethoden crud = CrudMethoden(firestore: instance);
      instance.collection("path").add({"hello": "world"});
      Map<String, dynamic> data = (await ((await crud.getData())
                  as Stream<QuerySnapshot<Map<String, dynamic>>>)
              .first)
          .docs
          .first
          .data();
      expect(data, {"hello": "world"});
    });
  });
}
