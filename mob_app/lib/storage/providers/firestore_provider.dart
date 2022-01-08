import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob_app/storage/storage_provider.dart';

class FirestoreProvider extends AbstractStorageProvider {
  late final FirebaseFirestore firestore_instance;
  late final CollectionReference firestore_collection;

  FirestoreProvider(FirebaseFirestore? firestore, String collection) {
    firestore_instance = firestore ?? FirebaseFirestore.instance;
    firestore_collection = firestore_instance.collection(collection);
  }

  @override
  Future<void> create(Storable storable) async {
    await firestore_collection.doc(storable.serial).set(storable.serialize());
  }

  @override
  Future<void> delete(Storable storable) async {
    await firestore_collection.doc(storable.serial as String).delete();
  }

  @override
  Future<Storable> read(dynamic serial,
      Storable Function(Map<String, dynamic>) create_instance) async {
    DocumentSnapshot doc =
        await firestore_collection.doc(serial as String).get();
    return create_instance(doc.data() as Map<String, dynamic>);
  }

  @override
  Future<void> update(Storable storable) async {
    await firestore_collection
        .doc(storable.serial as String)
        .update(storable.serialize());
  }
}
