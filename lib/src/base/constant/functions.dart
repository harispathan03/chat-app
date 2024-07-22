import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'text.dart';

//Scheduled card time display formatter
String convertToScheduledCardFormat(DateTime dateTime) {
  String formattedDate = DateFormat('dd LLL yyyy, HH:mm a').format(dateTime);
  return formattedDate;
}

//05 Jan 2024 date formatter
String convertToDOBFormat(DateTime dateTime) {
  String formattedDate = DateFormat('dd LLL yyyy').format(dateTime);
  return formattedDate;
}

//function for notification time display
String getNotificationTime(String dateTimeString) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateFormat("dd-MM-yyyy HH:mm").parse(dateTimeString);
  if (now.difference(dateTime).inDays == 0) {
    if (now.difference(dateTime).inMinutes < 60) {
      if (now.difference(dateTime).inMinutes < 2) {
        return justNow;
      } else {
        return "${now.difference(dateTime).inMinutes} $minsAgo";
      }
    } else {
      return "${now.difference(dateTime).inHours} $hoursAgo";
    }
  } else if (now.difference(dateTime).inDays == 1) {
    return yesterday;
  } else {
    return DateFormat("dd MMM yyyy").format(dateTime);
  }
}

//function for search page date
String getSearchDateTimeString(DateTime dateTime) {
  String formattedDate = DateFormat('E, dd LLL yyyy').format(dateTime);
  return formattedDate;
}

//to select birth date
Future<DateTime> selectBirthDate(
    BuildContext context, DateTime selectedDate) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(
          DateTime.now().year - 100, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(
          DateTime.now().year - 18, DateTime.now().month, DateTime.now().day));
  if (picked != null && picked != selectedDate) {
    return picked;
  }
  return selectedDate;
}

//to select search date
Future<DateTime?> selectSearchDate(
    BuildContext context, DateTime selectedDate) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)));
  if (picked != null && picked != selectedDate) {
    return picked;
  }
  return null;
}

//to select time
Future<TimeOfDay?> selectTime(
    BuildContext context, TimeOfDay initialTime) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
  return picked;
}

//function for phone number display in booking page
String getBookingPhone(String number) {
  String s1 = number.substring(0, 4);
  String s2 = number.substring(4, 7);
  String s3 = number.substring(7);
  return "$s1 $s2 $s3";
}

//return string for motorcycles req params
String getMotorcycleTypes(bool sport, bool cruiser, bool motard) {
  List<int> list = [];
  if (sport) {
    list.add(1);
  }
  if (cruiser) {
    list.add(2);
  }
  if (motard) {
    list.add(3);
  }
  return list.join(",");
}

String getMotorcycleNamesFromTypes(String motorcycleTypes) {
  List<String> list = [];
  if (motorcycleTypes.contains("1")) {
    list.add("Sport");
  }
  if (motorcycleTypes.contains("2")) {
    list.add("Cruiser");
  }
  if (motorcycleTypes.contains("3")) {
    list.add("Motard");
  }
  return list.join(",");
}

//return string for availability days
String getAvailabilityDays(bool monday, bool tuesday, bool wednesday,
    bool thursday, bool friday, bool saturday, bool sunday) {
  List<int> list = [];
  if (monday) {
    list.add(1);
  }
  if (tuesday) {
    list.add(2);
  }
  if (wednesday) {
    list.add(3);
  }
  if (thursday) {
    list.add(4);
  }
  if (friday) {
    list.add(5);
  }
  if (saturday) {
    list.add(6);
  }
  if (sunday) {
    list.add(7);
  }
  return list.join(",");
}

String getMobileNumberWithSpacing(String mobile) {
  return "${mobile.substring(0, 4)} ${mobile.substring(4, 7)} ${mobile.substring(7)}";
}

String getDateTimeInFormat(DateTime dateTime) {
  // DateTime dateTime = DateFormat("dd-MM-yyyy HH:mm").parse(dateTimeString);
  return "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
}
