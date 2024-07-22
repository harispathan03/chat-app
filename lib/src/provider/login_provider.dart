import 'package:chat_application/src/base/helper/user_helper.dart';
import 'package:chat_application/src/base/routing/route_names.dart';
import 'package:chat_application/src/base/utils/validations.dart';
import 'package:chat_application/src/di/get_it.dart';
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:chat_application/src/models/login_user/login_user.dart';
import 'package:chat_application/src/pages/widgets/custom_snackbar.dart';
import 'package:chat_application/src/provider/loading_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  ValidationDetails emailValidationState = ValidationDetails(status: false);
  ValidationDetails passwordValidationState = ValidationDetails(status: false);

  void checkEmail({required String email}) {
    emailValidationState = Validation.emailValidator(email);
    notifyListeners();
  }

  void checkPassword({required String password}) {
    passwordValidationState = Validation.passwordValidator(password);
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context, LoginUser loginUser) async {
    try {
      getInstance<LoadingProvider>().startLoading();
      var snapshots = await FirebaseFirestore.instance
          .collection("users")
          .doc(loginUser.email)
          .get();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginUser.email, password: loginUser.password);
      FirebaseUserModel user = FirebaseUserModel.fromJson(snapshots.data()!);
      await getInstance<UserHelper>().saveUser(user: user);
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(RouteNames.chatboard);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        customSnackbar(context, e.message ?? "Some error occurred.");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      getInstance<LoadingProvider>().stopLoading();
    }
  }
}
