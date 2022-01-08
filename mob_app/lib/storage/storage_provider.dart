abstract class Storable {
  late final dynamic serial;
  Map<String, dynamic> serialize();
  // can't make static methods abstract so this is what you get
  static Storable deserialize(Map<String, dynamic> map) =>
      throw NoSuchMethodError;
}

abstract class AbstractStorageProvider {
  Future<void> create(Storable storable);
  // this is weird but without reflection this is the best we can do
  // for runtime typing.
  Future<Storable> read(
      dynamic serial, Storable Function(Map<String, dynamic>) create_instance);
  Future<void> update(Storable storable);
  Future<void> delete(Storable storable);
}
