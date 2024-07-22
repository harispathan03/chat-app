import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/helper/user_helper.dart';
import '../base/utils/shared_preference_manager.dart';

final getInstance = GetIt.instance;

Future init() async {
  getInstance.registerSingleton<SharedPreferences>(
      await SharedPreferenceManager.init());
  getInstance.registerSingleton<UserHelper>(UserHelper());
}
