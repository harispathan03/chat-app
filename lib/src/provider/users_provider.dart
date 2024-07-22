import 'package:chat_application/src/base/helper/user_helper.dart';
import 'package:chat_application/src/di/get_it.dart';
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  List<FirebaseUserModel> users = [];
  FirebaseUserModel selfUser = getInstance<UserHelper>().user!;

  Future<void> fetchAllUsers() async {
    var querySnapshots =
        await FirebaseFirestore.instance.collection("users").get();
    for (var element in querySnapshots.docs) {
      if (element.id != selfUser.email) {
        users.add(FirebaseUserModel.fromJson(element.
        data()));
      }
    }
    notifyListeners();
  }
}
