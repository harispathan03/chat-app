import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String getDateString(String dateTimeString) {
    DateTime dateTime = DateFormat("dd/MM/yyyy hh:mm").parse(dateTimeString);
    return DateFormat("dd MMM yyyy").format(dateTime);
  }

  static String getTimeString(String hourString, String minuteString) {
    int hour = int.parse(hourString);
    if (hour > 12) {
      return "${(hour - 12).toString()}:$minuteString pm";
    }
    return "$hourString:$minuteString am";
  }

  static String convertDateFormat(String? inputDate) {
    if (inputDate == null || inputDate.isEmpty) {
      return "";
    }
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(inputDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  static String convertDateFormatWithWeekday(String inputDate) {
    if (inputDate.isEmpty) {
      return "";
    }
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(inputDate);
    String formattedDate = DateFormat('E, dd MMM yyyy').format(dateTime);
    return formattedDate;
  }
}
