import 'package:chat_application/src/models/message/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../base/helper/string_helper.dart';

class ChatProvider extends ChangeNotifier {
  int pageSize = 15;
  bool isLoading = false;

  Future<void> sendMessage(String selfUserEmail, String intendedUserEmail,
      MessageModel messageModel) async {
    String chatId =
        StringHelper.generateChatId(selfUserEmail, intendedUserEmail);
    CollectionReference messagesReference = FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("messages");
    await messagesReference
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(messageModel.toJson());
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .set(messageModel.getLastMessage());
  }

  Future<void> getMoreChats() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2), () {});
    pageSize += 15;
    notifyListeners();
    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
