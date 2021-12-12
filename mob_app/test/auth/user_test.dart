import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/auth/auth_user.dart';

void main() {
  group("User model test", () {
    test("Should be able to create a user instance", () {
      final user = User(id: "1", name: "John Doe", email: "");
      expect(user.id, "1");
      expect(user.name, "John Doe");
      expect(user.email, "");
    });
    test("Should be able to create a user instance without an email", () {
      final user = User(id: "1", name: "John Doe", email: null);
      expect(user.id, "1");
      expect(user.name, "John Doe");
      expect(user.email, null);
    });
    test("toString should return the user's name", () {
      final user = User(id: "1", name: "John Doe", email: "");
      expect(user.toString(), "John Doe");
    });
  });
}
