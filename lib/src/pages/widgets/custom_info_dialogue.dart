import 'package:chat_application/src/base/constant/colors.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:flutter/material.dart';

class CustomInfoDialogue extends StatelessWidget {
  final String message;
  final Function function;
  const CustomInfoDialogue(
      {super.key, required this.message, required this.function});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        "Chit-Chat",
        style: TextStyle(fontSize: 16.sp, color: Colors.black),
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
      ),
      actions: [
        TextButton(
          child: Text(
            "Ok",
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
