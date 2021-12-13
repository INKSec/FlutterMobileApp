import 'package:mob_app/auth/auth_provider.dart';
import 'package:mob_app/auth/auth_user.dart';

/// A naive implementation of [AuthProvider] that always returns the same
/// [AuthenticatedUser].
/// This is used for testing purposes.
/// It is not recommended to use this in production.
class DummyAuthProvider extends AuthProvider {
  final AuthenticatedUser user = AuthenticatedUser(
      name: 'Mock User', email: 'mock@example.org', token: "test", id: 42);

  DummyAuthProvider();

  @override
  Future<AuthenticatedUser> login(String name, String password) async {
    return user;
  }

  @override
  Future<void> logout(AuthenticatedUser user) async {
    return;
  }
}
