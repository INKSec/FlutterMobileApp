class User {
  final String _name;
  final dynamic _id;
  final String? _email;

  get name => _name;
  get id => _id;
  get email => _email;

  User({required name, required id, email})
      : _name = name,
        _id = id,
        _email = email;
}

class AuthenticatedUser extends User {
  final String _token;
  get token => _token;

  AuthenticatedUser({required name, required id, required token, email})
      : _token = token,
        super(name: name, id: id, email: email);
}
