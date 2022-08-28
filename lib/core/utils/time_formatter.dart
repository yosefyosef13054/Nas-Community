class TimeFormatter {
  TimeFormatter._();

  static String timeInTwelveSys(DateTime time) {
    if (time.hour > 12) {
      return "${(time.hour - 12).toString().padLeft(2, "0")}:${(time.minute).toString().padLeft(2, "0")} pm";
    } else {
      if (time.hour == 0) {
        return "12:${(time.minute).toString().padLeft(2, "0")} am";
      } else {
        return "${(time.hour).toString().padLeft(2, "0")}:${(time.minute).toString().padLeft(2, "0")} am";
      }
    }
  }

  static String durationInMSToTime(int duration) {
    final Duration _duration = Duration(milliseconds: duration);
    int sec = _duration.inSeconds - (_duration.inMinutes * 60);
    return "${(_duration.inMinutes).toString().padLeft(2, "0")}:${sec.toString().padLeft(2, "0")}";
  }

  static String dateOrToday(DateTime time) {
    if (time.day == DateTime.now().day &&
        time.month == DateTime.now().month &&
        time.year == DateTime.now().year) {
      return "Today";
    }else if (
    time.day == DateTime.now().day - 1  &&
        time.month == DateTime.now().month &&
        time.year == DateTime.now().year
    ){
      return "Yesterday";
    }else {
      return time.toString().substring(0, 10);
    }
  }
}
