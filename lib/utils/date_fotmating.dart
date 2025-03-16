import 'package:intl/intl.dart';

class DateFormating {
  static String formattedDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat("dd MMM yyyy").format(parsedDate);
  }
}
