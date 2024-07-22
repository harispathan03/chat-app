class NoInternetException implements Exception {
  final String message;

  const NoInternetException({this.message = ""});

  @override
  String toString() => message;
}
