
class ServerError<T> implements Exception{
  String? title;
  String? body;
  StackTrace? stackTrace;

  ServerError({
    this.title,
    this.body = "Try again later",
    this.stackTrace});

  @override
  String toString() {
    return body ?? "Exception ...";
  }
}