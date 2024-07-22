import 'package:flutter/material.dart';

double wp(BuildContext context, double percentage) {
  double result = (MediaQuery.of(context).size.width * percentage) / 100;
  return result;
}

double hp(BuildContext context, double percentage) {
  double result = (MediaQuery.of(context).size.height * percentage) / 100;
  return result;
}

double dp(BuildContext context, double size) {
  return MediaQuery.textScalerOf(context).scale(size);
}
