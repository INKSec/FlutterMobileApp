import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob_app/storage/exceptions.dart';
import 'package:mob_app/storage/storage_provider.dart';

class FirestoreProvider extends AbstractStorageProvider {
  late final FirebaseFirestore firestore_instance;
  late final CollectionReference firestore_collection;

  FirestoreProvider(FirebaseFirestore? firestore, String collection) {
    firestore_instance = firestore ??
        FirebaseFirestore
            .instance; // Use default instance if none was provided.
    firestore_collection = firestore_instance.collection(collection);
  }

  @override
  Future<void> create(Storable storable) async {
    // This looks weird but seems to be the correct way of doing it.
    // Document databases are strange and wonderous things.
    await firestore_collection.doc(storable.serial).set(storable.serialize());
  }

  @override
  Future<void> delete(Storable storable) async {
    await firestore_collection.doc(storable.serial as String).delete();
  }

  @override
  Future<Storable> read(dynamic serial,
      Storable Function(Map<String, dynamic>) create_instance) async {
    /// Proper explanation of what is going on to those whom it may concern.
    ///
    /// What you would normally do when implementing CRUD operations on
    /// object based models is create an instance on a read operation using
    /// a class derived from the storage object retrieved from the database.
    /// This is sort of impossible with Flutter because we have no access to
    /// reflection on types at runtime and therefore cannot create instances
    /// of classes the types of which are not known at compile time.
    /// The only workable solution I managed to come up with was to pass in a
    /// callback function that creates the instance for us by defering the
    /// object instatiation to a point in time where we know exactly what type
    /// the object needs to be. Which is somewhere up the call chain where we
    /// are actually interested in the resulting data. The storage provider
    /// should not have to care about *what* kind of data we are reading, nor
    /// its structure, apart from the information required to correctly parse it
    /// from the database. While this does provide us with proper separation of
    /// concerns, the solution is not at all obvious. I would have preferred to
    /// do this differently but unfortunately it was not possible.
    /// So there you are.
    DocumentSnapshot doc =
        await firestore_collection.doc(serial as String).get();
    if (doc.exists) {
      return create_instance(doc.data() as Map<String, dynamic>);
    } else {
      throw StorageReadException("Document does not exist.");
    }
  }

  @override
  Future<void> update(Storable storable) async {
    await firestore_collection
        .doc(storable.serial as String)
        .update(storable.serialize());
  }
}
