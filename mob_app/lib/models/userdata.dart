import 'package:mob_app/storage/storage_provider.dart';

class UserData implements Storable {
  @override
  var serial;

  String displayName;
  String avatar;

  UserData(this.displayName, this.avatar);

  @override
  Map<String, dynamic> serialize() {
    // TODO: implement serialize
    throw UnimplementedError();
  }

  static UserData deserialize(Map<String, dynamic> data) {
    return UserData(data['displayName'] as String, data['avatar'] as String);
  }
}
