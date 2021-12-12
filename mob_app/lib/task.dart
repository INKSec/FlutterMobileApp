/// Actual proper async task implementation because I have fucking had it with Darts nonsense.
/// This class wraps a Future and deferrs any exceptions until the result is accessed.
/// This is the same behavior as exhibited by Pythons asynchronous tasks and is
/// the proper way of doing it.
/// NOTE: If the result is never accessed, the exception is lost.
class Task<T> {
  Future<T> _future;
  late T? _result;
  late Exception? _exception;

  Task(this._future) {
    _future.then((result) {
      _result = result;
      _exception = null;
    }).catchError((exception) {
      _exception = exception;
      _result = null;
    });
  }

  Future<T> call() async {
    await _future;
    if (_exception != null) {
      throw _exception as Exception;
    }
    return _result as T;
  }
}
