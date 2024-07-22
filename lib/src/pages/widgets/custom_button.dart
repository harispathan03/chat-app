import 'package:chat_application/src/base/constant/colors.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final bool isActive;
  final Function function;
  final Color? buttonColor;
  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.isActive,
      required this.function,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        function();
      },
      child: Container(
        height: 40.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: buttonColor ??
                (isActive ? greenColor : greenColor.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 18.sp, color: isActive ? Colors.white : greyColor),
          ),
        ),
      ),
    );
  }
}
