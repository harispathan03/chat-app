import 'dart:math';

import 'package:chat_application/src/base/constant/colors.dart';
import 'package:chat_application/src/base/helper/date_helper.dart';
import 'package:chat_application/src/base/helper/user_helper.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:chat_application/src/di/get_it.dart';
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:chat_application/src/models/last_message/last_message.dart';
import 'package:flutter/material.dart';

import '../../base/helper/string_helper.dart';

class ChatRow extends StatelessWidget {
  final FirebaseUserModel user;
  final LastMessageModel? message;
  final Function function;
  const ChatRow(
      {super.key, required this.user, this.message, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        onTap: () {
          function();
        },
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              decoration: BoxDecoration(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  shape: BoxShape.circle),
              child: Text(
                StringHelper.getTwoChars(user.userName),
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          user.userName,
                          style: TextStyle(fontSize: 18.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(getDate(message?.dateTime ?? DateTime.now()))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          message?.message ?? "",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: (message?.isRead == false &&
                                      message?.senderEmail !=
                                          getInstance<UserHelper>().user!.email)
                                  ? FontWeight.w500
                                  : FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      (message?.isRead == false &&
                              message?.senderEmail !=
                                  getInstance<UserHelper>().user!.email)
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Container(
                                height: 12.h,
                                width: 12.w,
                                decoration: BoxDecoration(
                                    color: greenColor, shape: BoxShape.circle),
                              ),
                            )
                          : const SizedBox()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    if (dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year) {
      return DateHelper.getFormattedDate(dateTime, DateHelper.timeFormat);
    }
    if (dateTime.day == (now.day - 1) &&
        dateTime.month == now.month &&
        dateTime.year == now.year) {
      return "Yesterday";
    }
    return DateHelper.getFormattedDate(dateTime, DateHelper.dateFormat);
  }
}
