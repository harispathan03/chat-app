import 'package:chat_application/src/base/constant/colors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context,
    {String? title, bool centerTitle = true}) {
  return AppBar(
    elevation: 0,
    backgroundColor: lightBackgroundColor,
    title: Text(title ?? ""),
    centerTitle: centerTitle,
    leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back)),
  );
}
