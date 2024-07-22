import 'package:flutter/material.dart';

void customSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    ));
}
