import 'dart:async';

import 'package:chat_application/src/base/helper/string_helper.dart';
import 'package:chat_application/src/base/helper/user_helper.dart';
import 'package:chat_application/src/di/get_it.dart';
import 'package:chat_application/src/models/chatboard_user/chatboard_user.dart';
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/last_message/last_message.dart';

class ChatboardProvider extends ChangeNotifier {
  List<String> chatDocs = [];
  List<ChatboardUserModel> chatUsersList = [];
  FirebaseUserModel selfUser = getInstance<UserHelper>().user!;
  final Completer<void> _usersLoaded = Completer<void>();

  Future<void> getChatDocumentIds() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("chats").get();
    for (var element in querySnapshot.docs) {
      if (element.id.contains(selfUser.email)) {
        chatDocs.add(element.id);
      }
    }
  }

  Future<void> getUsers() async {
    await getChatDocumentIds();
    for (var doc in chatDocs) {
      String email = StringHelper.getChatId(selfUser.email, doc);
      var map =
          await FirebaseFirestore.instance.collection("users").doc(email).get();
      FirebaseUserModel user = FirebaseUserModel.fromJson(map.data()!);
      chatUsersList.add(ChatboardUserModel(user: user));
    }
    _usersLoaded.complete();
    notifyListeners();
  }

  Stream<List<DocumentSnapshot>> getFilteredChatsStream() async* {
    await _usersLoaded.future;
    Stream<QuerySnapshot> snapshotStream =
        FirebaseFirestore.instance.collection("chats").snapshots();
    await for (QuerySnapshot snapshot in snapshotStream) {
      List<DocumentSnapshot> filteredDocs = snapshot.docs.where((doc) {
        return doc.id.contains(selfUser.email);
      }).toList();
      for (var doc in filteredDocs) {
        String otherUserEmail = StringHelper.getChatId(selfUser.email, doc.id);
        ChatboardUserModel? chatUser = chatUsersList.firstWhere((user) {
          return user.user.email == otherUserEmail;
        },
            orElse: () => ChatboardUserModel(
                user: FirebaseUserModel(
                    email: otherUserEmail, userName: 'Unknown')));
        if (doc.data() != null) {
          chatUser = setLastMessageOfUser(
              chatUser, doc.data() as Map<String, dynamic>);
        }
        chatUsersList.removeWhere((user) => user.user.email == otherUserEmail);
        chatUsersList.add(chatUser);
      }

      // Sort the chatUsersList by the last message datetime in descending order
      chatUsersList.sort((a, b) {
        var aTime = a.lastMessage?.dateTime;
        var bTime = b.lastMessage?.dateTime;
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        return bTime.compareTo(aTime);
      });

      yield filteredDocs;
    }
  }

  ChatboardUserModel setLastMessageOfUser(
      ChatboardUserModel model, Map<String, dynamic> lastMessage) {
    LastMessageModel lastMessageModel = LastMessageModel.fromJson(lastMessage);
    model = model.copyWith(lastMessage: lastMessageModel);
    return model;
  }

  void markLastMessageAsRead(String docId, String lastMessageEmailId) {
    if (lastMessageEmailId != selfUser.email) {
      FirebaseFirestore.instance
          .collection("chats")
          .doc(docId)
          .update({"isRead": true});
    }
  }
}
