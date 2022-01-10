import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/models/userdata.dart';

void main() {
  group("Userdata model test", () {
    test("Should be able to create a userdata instance", () {
      final userdata = UserData("displayName", "avatar", "serial");
    });
    test("Should be able to serialize a userdata instance", () {
      final userdata = UserData("displayName", "avatar", "serial");
      expect(userdata.serialize(),
          {"displayName": "displayName", "avatar": "avatar"});
    });
    test("Should be able to deserialize a userdata instance", () {
      final userdata = UserData.deserialize({
        "displayName": "displayName",
        "avatar": "avatar",
      }, "test");
      expect(userdata.displayName, "displayName");
      expect(userdata.avatar, "avatar");
      expect(userdata.serial, "test");
    });
  });
}
