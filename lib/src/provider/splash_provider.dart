import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../base/utils/shared_preference_manager.dart';
import '../di/get_it.dart';

enum UserState { initial, checking, loggedIn, notLoggedIn, notificationClick }

class SplashProvider extends ChangeNotifier {
  SplashProvider({this.state = UserState.initial});

  UserState state;

  void checkUserAlreadyLoggedIn() async {
    state = UserState.checking;
    notifyListeners();
    if (FirebaseAuth.instance.currentUser != null) {
      state = UserState.loggedIn;
    } else {
      state = UserState.notLoggedIn;
    }
    await SharedPreferenceManager.init();
    await getInstance.allReady();
    await SharedPreferenceManager.reloadPrefrence();
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
  }
}
