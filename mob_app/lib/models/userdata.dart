import 'package:mob_app/storage/storage_provider.dart';

/// This is a lot of boilerplate for something that
/// would have been a lot easier with annotations and
/// runtime reflection. But no.
///
/// Storage model for application user data.
/// This is kept separately from the user authentication
/// data as we may need to support multiple authentication
/// providers.
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
