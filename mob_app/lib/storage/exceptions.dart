class StorageReadException implements Exception {
  StorageReadException(this.message);

  final String message;

  @override
  String toString() => 'StorageReadException: $message';
}
