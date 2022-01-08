import 'package:mob_app/storage/storage_provider.dart';

class UserData implements Storable {
  @override
  var serial;

  String displayName;
  String avatar;

  UserData(this.displayName, this.avatar, this.serial);

  @override
  Map<String, dynamic> serialize() {
    return {
      'displayName': displayName,
      'avatar': avatar,
    };
  }

  static UserData deserialize(Map<String, dynamic> data, dynamic serial) {
    return UserData(
        data['displayName'] as String, data['avatar'] as String, serial);
  }
}
