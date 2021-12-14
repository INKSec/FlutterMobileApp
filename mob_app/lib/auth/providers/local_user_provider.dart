import 'package:mob_app/auth/auth_provider.dart';
import 'package:mob_app/auth/auth_user.dart';

class LocalUserProvider extends AuthProvider {
  LocalUserProvider();

  @override
  Future<AuthenticatedUser> login(String name, String password) async {
    return AuthenticatedUser(name: name, id: name, token: name);
  }

  @override
  Future<void> logout(AuthenticatedUser user) async {
    return;
  }
}
