class Utils {
  String convertFromDate(DateTime date) {
    int year = date.year;
    int month = date.month;
    int day = date.day;
    String? monthString;
    String? dayString;
    if (month < 10) {
      monthString = '0$month';
    }
    if (day < 10) {
      dayString = '0$day';
    }
    if (monthString != null && dayString != null) {
      return '$dayString-$monthString-$year';
    }
    return '$day/$month/$year';
  }
}
