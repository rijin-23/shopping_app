class HttpExceptions implements Exception {
  final String message;

  HttpExceptions(this.message);

  @override
  String toString() {
    // TODO: implement toString
    print('$message httpexception');
    return message;
  }
}
