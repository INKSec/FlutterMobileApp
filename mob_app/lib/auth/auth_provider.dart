import 'package:mob_app/auth/auth_user.dart';

/// Interface for Authetication Providers
abstract class AuthProvider {
  Future<AuthenticatedUser> login(String name, String password);
  Future<void> logout(AuthenticatedUser user);
}
