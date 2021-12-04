import 'package:mob_app/auth/auth_user.dart';

/// Interface for Authetication Providers
abstract class AuthProvider {
  Future<AuthenticatedUser> login(String name, String password);
  Future<void> logout();
}

/// A naive implementation of [AuthProvider] that always returns the same
/// [AuthenticatedUser].
/// This is used for testing purposes.
/// It is not recommended to use this in production.
class DummyAuthProvider extends AuthProvider {
  final AuthenticatedUser user = AuthenticatedUser(
      name: 'Mock User', email: 'mock@example.org', token: "test", id: 42);

  DummyAuthProvider();

  Future<AuthenticatedUser> login(String name, String password) async {
    return user;
  }

  Future<void> logout() async {
    return;
  }
}
