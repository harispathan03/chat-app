import 'package:chat_application/src/base/constant/colors.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:flutter/material.dart';

class CustomAlertDialogue extends StatelessWidget {
  final String message;
  final String? declineText;
  final String? acceptText;
  final Function function;
  const CustomAlertDialogue(
      {super.key,
      required this.message,
      required this.function,
      this.declineText,
      this.acceptText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: Colors.white,
      title: Text(
        "Chit-Chat",
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
      ),
      content: Text(
        message,
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 14.sp, color: Colors.black),
      ),
      actions: [
        TextButton(
          child: Text(
            declineText ?? "No",
            style: TextStyle(color: greenColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            acceptText ?? "Yes",
            style: TextStyle(color: greenColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            function();
          },
        ),
      ],
    );
  }
}
