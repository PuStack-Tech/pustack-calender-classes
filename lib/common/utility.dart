class Utility {
  static int findDifferenceInMinutes(DateTime date1, DateTime date2) {
    return date2.difference(date1).inMinutes;
  }
}
