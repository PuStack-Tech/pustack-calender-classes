class Utility {
  static int findDifferenceInMinutes(DateTime date1, DateTime date2) {
    return date2.difference(date1).inMinutes;
  }

  static bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
            .difference(DateTime(now.year, now.month, now.day))
            .inDays ==
        0;
  }
}
