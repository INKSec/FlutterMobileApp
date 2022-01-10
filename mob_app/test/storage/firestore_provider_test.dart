import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/storage/exceptions.dart';
import 'package:mob_app/storage/providers/firestore_provider.dart';
import 'package:mob_app/storage/storage_provider.dart';

/// Create a FirestoreProvider with a fake Firestore instance
/// for testing purposes.
FirestoreProvider createProvider(String for_collection,
    {Map<String, dynamic> data = const {}}) {
  dynamic instance = FakeFirebaseFirestore();
  data.map(
      (key, value) => instance.collection(for_collection).doc(key).set(value));
  return FirestoreProvider(instance, for_collection);
}

class FakeStorable implements Storable {
  @override
  var serial;

  late String myString;
  late int myInt;

  @override
  Map<String, dynamic> serialize() {
    return {
      'myString': myString,
      'myInt': myInt,
    };
  }

  static FakeStorable deserialize(Map<String, dynamic> data, dynamic serial) {
    final obj = FakeStorable();
    obj.serial = serial;
    obj.myString = data['myString'];
    obj.myInt = data['myInt'];
    return obj;
  }
}

void main() {
  group("FirestoreProvider test", () {
    test("Firestore create object", () async {
      final provider = createProvider('test');
      final obj = FakeStorable();
      obj.myString = 'test';
      obj.myInt = 1;
      obj.serial = 'someKey';
      await provider.create(obj);
      dynamic newobj = await provider.read(
          'someKey', (data) => FakeStorable.deserialize(data, 'someKey'));
      expect(newobj.myString, 'test');
      expect(newobj.myInt, 1);
    });

    test("Firestore update object", () async {
      final provider = createProvider('test');
      final obj = FakeStorable();
      obj.myString = 'test';
      obj.myInt = 1;
      obj.serial = 'someKey';
      await provider.create(obj);
      obj.myInt = 2;
      await provider.update(obj);
      dynamic newobj = await provider.read(
          'someKey', (data) => FakeStorable.deserialize(data, 'someKey'));
      expect(newobj.myString, 'test'); // assume myString was not altered
      expect(newobj.myInt, 2);
    });

    test("Firestore delete object", () async {
      final provider = createProvider('test');
      final obj = FakeStorable();
      obj.myString = 'test';
      obj.myInt = 1;
      obj.serial = 'someKey';
      await provider.create(obj);
      await provider.delete(obj);
      expect(
          () => provider.read(
              'someKey', (data) => FakeStorable.deserialize(data, 'someKey')),
          throwsA(predicate((e) =>
              e is StorageReadException &&
              e.message == 'Document does not exist.')));
    });
  });
}
