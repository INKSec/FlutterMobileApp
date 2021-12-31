import 'package:mob_app/auth/auth_provider.dart';
import 'package:mob_app/auth/auth_user.dart';
import 'package:mob_app/task.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

/// A User authenticated with an OpenID Connect Provider.
/// User information is parsed from a Credentail object
/// instead of manually supplied (see [OpenIDUser.fromCredentials]).
/// The Credential instance is also available through [credential].
class OpenIDUser extends AuthenticatedUser {
  late final Credential _credential;
  late final UserInfo _userInfo;
  set credential(Credential value) {
    _credential = value;
  }

  set userInfo(UserInfo value) {
    _userInfo = value;
  }

  OpenIDUser(String token, String id, String name)
      : super(token: token, id: id, name: name);

  factory OpenIDUser.fromCredentials(Credential credential, UserInfo userInfo) {
    OpenIDUser user = OpenIDUser(
        credential.toJson()['token']['accessToken'] as String,
        credential.idToken.claims.subject,
        userInfo.nickname ??
            userInfo.preferredUsername ??
            userInfo.name ??
            userInfo.email ??
            userInfo.subject);

    //TODO: This is not ideal, might be a better way of doing this
    //by creating an abstract user class.
    user.credential = credential;
    user.userInfo = userInfo;

    return user;
  }
}

/// A class for authenticating with an OpenID Connect Provider.
class OpenIDProvider extends AuthProvider {
  final String clientId;
  final String clientSecret;
  late List<String> _scopes;
  late Task<Issuer> issuer;

  /// Constructor for OpenIDProvider.
  /// [clientId] is the client ID for the OpenID Connect Provider.
  /// [scopes] is a list of scopes to request from the provider.
  /// [issuer] is the URL of the OpenID Connect Provider.
  /// The [issuer] is resolved asynchronously using OIDC discovery.
  OpenIDProvider(
      {required this.clientId,
      this.clientSecret = "",
      required Uri issuerUri,
      List<String> scopes = const ["openid"]})
      : super() {
    // Rant time.
    // This is wrong. Dart is doing this wrong.
    // What is *supposed* to happen when an exception occurs inside an
    // asynchronous task is that the exception is thrown *after* the task
    // has completed.
    // This is not what is happening.
    // Instead the exception is thrown *instantly* the second it occurs.
    // This makes it very difficult to defer the exception handling to a
    // point in time that is more convenient, for example whenever we actually
    // need the result.
    // Further, it breaks the stack frame coherency making it more or less
    // impossible to actually debug the code. I am starting to understand why
    // Darts stack traces tend to be so utterly useless...
    // Look at lib/task.dart for a better solution.
    issuer = Task<Issuer>(Issuer.discover(issuerUri));

    _scopes = scopes;
  }

  @override
  Future<AuthenticatedUser> login(String name, String password) async {
    // TODO: OIDC does not require username and password.
    // Consider changing the interface to allow for this.

    final client = Client(await issuer(), clientId, clientSecret: clientSecret);
    _launch(String uri) async {
      if (await canLaunch(uri) || true) {
        await launch(uri, forceWebView: false);
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
    UserInfo userInfo = await result.getUserInfo();
    return OpenIDUser.fromCredentials(result, userInfo);
  }

  @override
  Future<void> logout(AuthenticatedUser user) async {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
