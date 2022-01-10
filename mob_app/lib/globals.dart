// Hours spent researching global state in Dart and this was the best result I could find...

import 'package:mob_app/auth/auth_user.dart';
import 'package:mob_app/models/userdata.dart';
import 'package:mob_app/storage/providers/firestore_provider.dart';
import 'package:mob_app/storage/storage_provider.dart';

AbstractStorageProvider userDataStorageProvider =
    FirestoreProvider(null, "UserData");

AuthenticatedUser? user;
UserData? userdata;
