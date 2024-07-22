import 'dart:async';

import 'package:chat_application/src/base/constant/colors.dart';
import 'package:chat_application/src/base/constant/text.dart';
import 'package:chat_application/src/base/extension/scaffold_extension.dart';
import 'package:chat_application/src/base/helper/date_helper.dart';
import 'package:chat_application/src/base/helper/string_helper.dart';
import 'package:chat_application/src/base/helper/user_helper.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:chat_application/src/di/get_it.dart';
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:chat_application/src/models/message/message.dart';
import 'package:chat_application/src/pages/widgets/custom_app_bar.dart';
import 'package:chat_application/src/pages/widgets/custom_textfield.dart';
import 'package:chat_application/src/provider/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final FirebaseUserModel firebaseUserModel;
  const ChatPage({super.key, required this.firebaseUserModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatProvider provider;
  TextEditingController messageController = TextEditingController();
  FirebaseUserModel user = getInstance<UserHelper>().user!;
  late String chatId;
  late StreamSubscription<DocumentSnapshot> chatSubscription;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    provider = context.read<ChatProvider>();
    chatId =
        StringHelper.generateChatId(user.email, widget.firebaseUserModel.email);
    _scrollController.addListener(getMoreChatListener);
    super.initState();
    markMessagesAsReadContinuously();
  }

  @override
  void dispose() {
    chatSubscription.cancel();
    _scrollController.removeListener(getMoreChatListener);
    _scrollController.dispose();
    super.dispose();
  }

  void markMessagesAsReadContinuously() {
    chatSubscription = FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .snapshots()
        .listen((querySnapshot) {
      if (querySnapshot.data()?['senderEmail'] != null &&
          querySnapshot.data()?['senderEmail'] != user.email) {
        querySnapshot.reference.update({"isRead": true});
      }
    });
  }

  Future<void> getMoreChatListener() async {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      await provider.getMoreChats();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent / 2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (provider.isLoading)
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: CircularProgressIndicator(color: greenColor),
              )),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chats")
                    .doc(chatId)
                    .collection("messages")
                    .orderBy(
                        'dateTime') // Ensure messages are ordered by dateTime
                    .limitToLast(provider.pageSize)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }
                  _scrollDown();
                  DateTime? lastDateTime;
                  return ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      MessageModel message = MessageModel.fromJson(
                          document.data() as Map<String, dynamic>);
                      bool showDate = false;
                      if (lastDateTime == null ||
                          !isSameDay(lastDateTime!, message.dateTime)) {
                        lastDateTime = message.dateTime;
                        showDate = true;
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Column(
                          children: [
                            if (showDate)
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: greyColor.withAlpha(130),
                                    ),
                                    child: Text(
                                      DateHelper.chatDateLabel(
                                          message.dateTime),
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ),
                            Align(
                              alignment: message.senderEmail == user.email
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.8),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: message.senderEmail == user.email
                                      ? greenColor
                                      : greyColor.withAlpha(100),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      message.message,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      DateHelper.getFormattedDate(
                                          message.dateTime,
                                          DateHelper.timeFormat),
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: MediaQuery.of(context).viewPadding,
              child: CustomTextField(
                controller: messageController,
                fillColor: textfieldBackgroundColor,
                hinttext: yourMessage,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                fontSize: 14.sp,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: InkWell(
                    onTap: () {
                      if (messageController.text.isNotEmpty) {
                        provider.sendMessage(
                          user.email,
                          widget.firebaseUserModel.email,
                          MessageModel(
                            message: messageController.text,
                            dateTime: DateTime.now(),
                            senderEmail: user.email,
                          ),
                        );
                        messageController.clear();
                        _scrollDown(); // Ensure the scroll happens after sending a message
                      }
                    },
                    child: const Icon(Icons.send),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    ).scaffoldWithAppBar(
      context: context,
      appBar: customAppBar(context,
          title: widget.firebaseUserModel.userName, centerTitle: false),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
