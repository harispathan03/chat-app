import 'dart:convert';

import 'package:chat_application/src/models/firebase_user/firebase_user.dart';

import '../utils/shared_preference_manager.dart';

class UserHelper {
  FirebaseUserModel? _user;

  FirebaseUserModel? get user => _user ?? getUser();

  FirebaseUserModel? getUser() {
    var userJson =
        SharedPreferenceManager.getString(SharedPreferenceManager.prefUser);
    if (userJson.isNotEmpty && userJson != "null") {
      _user = FirebaseUserModel.fromJson(json.decode(userJson));
    } else {
      _user = null;
    }
    return _user;
  }

  Future<void> saveUser({FirebaseUserModel? user}) async {
    FirebaseUserModel? userInfo = user;
    String userPrefData = json.encode(userInfo?.toJson());
    await SharedPreferenceManager.setString(
        SharedPreferenceManager.prefUser, userPrefData);
    _user = userInfo;
  }
}
