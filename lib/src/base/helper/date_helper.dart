import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static const dateFormat = "dd/MM/yyyy";
  static const serverDateFormat = "dd-MM-yyyy";
  static const inviteFriendFormat = "dd MMM yyyy";
  static const notificationMessageFormat = "dd/MM/yyyy HH:mm";

  static const timeFormat = "hh:mm a";

  static String getFormattedDate(DateTime date, String format) {
    return DateFormat(format).format(date);
  }

  static DateTime getDate(String strDate, String format) {
    return DateFormat(format).parse(strDate);
  }

  static DateTime convertServerToLocal(String strDate, String format) {
    return DateFormat(format).parse(strDate, true).toLocal();
  }

  static String convertDateFormat(
    String date,
    String sourceFormat,
    String targetFormat,
  ) {
    return getFormattedDate(getDate(date, sourceFormat), targetFormat);
  }

  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static String timeAgoSinceDate(String dateString) {
    DateTime notificationDate =
        DateFormat(notificationMessageFormat).parse(dateString);
    final currentDate = DateTime.now();

    //Today's message
    if (notificationDate.day == currentDate.day &&
        notificationDate.month == currentDate.month &&
        notificationDate.year == currentDate.year) {
      return DateHelper.getFormattedDate(
          DateHelper.getDate(dateString, DateHelper.notificationMessageFormat),
          DateHelper.timeFormat);
    }

    // yesterday's message
    DateTime yesterday = currentDate.subtract(const Duration(days: 1));
    if (notificationDate.day == yesterday.day &&
        notificationDate.month == currentDate.month &&
        notificationDate.year == currentDate.year) {
      return "Yesterday";
    }

    //older than two days
    return getFormattedDate(notificationDate, inviteFriendFormat);
  }

  // chat date labels for previous days message in chat screen
  static String chatDateLabel(DateTime sourceTime) {
    final date2 = DateTime.now();
    // final difference = date2.difference(sourceTime);
    // if (difference.inDays >= 2) {
    //   return getFormattedDate(sourceTime, inviteFriendFormat);
    // } else if (difference.inDays >= 1) {
    //   return "Yesterday";
    // } else {
    //   return "Today";
    // }

    if (sourceTime.day == date2.day &&
        sourceTime.month == date2.month &&
        sourceTime.year == date2.year) {
      return "Today";
    }

    DateTime yesterday = date2.subtract(const Duration(days: 1));

    if (sourceTime.day == yesterday.day &&
        sourceTime.month == date2.month &&
        sourceTime.year == date2.year) {
      return "Yesterday";
    }
    DateTime before2Days = date2.subtract(const Duration(days: 2));
    if (sourceTime.day == before2Days.day &&
        sourceTime.month == before2Days.month &&
        sourceTime.year == before2Days.year) {
      return DateFormat('EEEE').format(before2Days);
    }
    DateTime before3Days = date2.subtract(const Duration(days: 3));
    if (sourceTime.day == before3Days.day &&
        sourceTime.month == before3Days.month &&
        sourceTime.year == before3Days.year) {
      return DateFormat('EEEE').format(before3Days);
    }
    DateTime before4Days = date2.subtract(const Duration(days: 4));
    if (sourceTime.day == before4Days.day &&
        sourceTime.month == before4Days.month &&
        sourceTime.year == before4Days.year) {
      return DateFormat('EEEE').format(before4Days);
    }
    DateTime before5Days = date2.subtract(const Duration(days: 5));
    if (sourceTime.day == before5Days.day &&
        sourceTime.month == before5Days.month &&
        sourceTime.year == before5Days.year) {
      return DateFormat('EEEE').format(before5Days);
    }
    DateTime before6Days = date2.subtract(const Duration(days: 6));
    if (sourceTime.day == before6Days.day &&
        sourceTime.month == before6Days.month &&
        sourceTime.year == before6Days.year) {
      return DateFormat('EEEE').format(before6Days);
    }

    return getFormattedDate(sourceTime, inviteFriendFormat);
  }

  // chat date labels for previous days message in chat screen
  static String messageTimeAgo(DateTime sourceTime) {
    final date2 = DateTime.now();
    // final difference = date2.difference(sourceTime);
    // if (difference.inDays >= 2) {
    //   return getFormattedDate(sourceTime, inviteFriendFormat);
    // } else if (difference.inDays >= 1) {
    //   return "Yesterday";
    // } else {
    //   return "Today";
    // }

    if (sourceTime.day == date2.day &&
        sourceTime.month == date2.month &&
        sourceTime.year == date2.year) {
      return getFormattedDate(sourceTime, timeFormat);
    }

    DateTime yesterday = date2.subtract(const Duration(days: 1));

    if (sourceTime.day == yesterday.day &&
        sourceTime.month == date2.month &&
        sourceTime.year == date2.year) {
      return "Yesterday";
    }

    return getFormattedDate(sourceTime, inviteFriendFormat);
  }

  static String timeAgo(DateTime sourceTime) {
    final date2 = DateTime.now();
    final difference = date2.difference(sourceTime);
    if (difference.inDays > 1) {
      return getFormattedDate(sourceTime, inviteFriendFormat);
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else {
      return getFormattedDate(sourceTime, timeFormat);
    }
  }

  static Duration? durationFromMilliseconds(int? milliseconds) =>
      milliseconds == null ? null : Duration(milliseconds: milliseconds);

  static int? durationToMilliseconds(Duration? duration) =>
      duration?.inMilliseconds;

  static DateTime dateTimeFromEpochUs(int us) =>
      DateTime.fromMicrosecondsSinceEpoch(us);

  static int? dateTimeToEpochUs(DateTime? dateTime) =>
      dateTime?.microsecondsSinceEpoch;
}
