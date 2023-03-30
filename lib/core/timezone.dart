class TimeZone {
  static DateTime upd(DateTime dateTime) {
    return dateTime.add(Duration(hours: dateTime.timeZoneOffset.inHours));
  }
}
