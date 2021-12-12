import 'package:mob_app/auth/auth_provider.dart';
import 'package:mob_app/auth/auth_user.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenIDUser extends AuthenticatedUser {
  late Credential _credential;
  set credential(Credential value) {
    _credential = value;
  }

  OpenIDUser(String token, String id, String name)
      : super(token: token, id: id, name: name);

  factory OpenIDUser.fromCredentials(Credential credential) {
    OpenIDUser user = OpenIDUser(
        credential.toJson()['token']['accessToken'] as String,
        credential.idToken.claims.subject,
        credential.idToken.claims.nickname ??
            credential.idToken.claims.name ??
            credential.idToken.claims.email ??
            credential.idToken.claims.subject);

    //TODO: This is not ideal, might be a better way of doing this
    //by creating an abstract user class.
    user.credential = credential;

    return user;
  }
}

class OpenIDProvider extends AuthProvider {
  final String clientId;
  late List<String> _scopes;
  late Future<Issuer> issuer;

  OpenIDProvider(
      {required this.clientId,
      required Uri issuerUri,
      List<String> scopes = const []})
      : super() {
    issuer = Issuer.discover(issuerUri);
    _scopes = scopes;
  }

  @override
  Future<AuthenticatedUser> login(String name, String password) async {
    // TODO: OIDC does not require username and password.
    // Consider changing the interface to allow for this.

    final client = Client(await issuer, clientId, clientSecret: '');
    _launch(String uri) async {
      if (await canLaunch(uri)) {
        await launch(uri, forceWebView: true);
      } else {
        throw 'Failed to open WebView for URI $uri';
      }
    }

    Authenticator authenticator =
        Authenticator(client, scopes: _scopes, urlLancher: _launch);
    final result = await authenticator.authorize();

    try {
      await closeWebView();
    } catch (e) {
      //this can happen on certain platforms where
      //closing webviews is not supported.
      //We can safely ignore this error.
    }

    return OpenIDUser.fromCredentials(result);
  }

  @override
  Future<void> logout(AuthenticatedUser user) async {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
