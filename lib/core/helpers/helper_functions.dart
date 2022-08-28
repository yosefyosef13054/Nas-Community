import 'package:intl/intl.dart';
// Convert minutes to hour minutes

String getTimeString(int value) {
  final int hour = value ~/ 60;
  final int minutes = value % 60;
  return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
}

/// Find the first date of the week which contains the provided date.
DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

/// Find last date of the week which contains provided date.
DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
}

String getDatesForCurrentWeek() {
  DateTime today = DateTime.now();
  final startDate = (DateFormat.MMMd().format(findFirstDateOfTheWeek(today)));
  final endDate = (DateFormat.MMMd().format(findLastDateOfTheWeek(today)));
  return '$startDate - $endDate';
}

String getHostFromUrl(String urlSource) {
  final uri = Uri.parse(urlSource);
  String host = uri.host.split('.')[uri.host.split('.').length - 2];
  if (host == "youtu" || host == "youtube") {
    host = "YouTube";
  }
  return host;
}
