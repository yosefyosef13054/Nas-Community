class LocalDBError<T> implements Exception{
  String? title;
  String? body;
  StackTrace? stackTrace;

  LocalDBError({
    this.title,
    this.body = "Try again later",
    this.stackTrace});

  @override
  String toString() {
    return body ?? "Local Data Base Exception ...";
  }
}