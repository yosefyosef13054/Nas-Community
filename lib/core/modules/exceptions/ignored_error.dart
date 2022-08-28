class IgnoredError<T> implements Exception{

  @override
  String toString() {
    return "THIS IS AN INSIGNIFICANT ERROR AND SHOULD BE IGNORED";
  }
}