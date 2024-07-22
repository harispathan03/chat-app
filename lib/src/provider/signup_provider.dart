import 'package:chat_application/src/base/routing/route_names.dart';
import 'package:chat_application/src/base/utils/validations.dart';
import 'package:chat_application/src/di/get_it.dart';
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:chat_application/src/models/signup_user/signup_user.dart';
import 'package:chat_application/src/pages/widgets/custom_snackbar.dart';
import 'package:chat_application/src/provider/loading_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../base/helper/user_helper.dart';

class SignupProvider extends ChangeNotifier {
  ValidationDetails userNameValidationState = ValidationDetails(status: false);
  ValidationDetails emailValidationState = ValidationDetails(status: false);
  ValidationDetails passwordValidationState = ValidationDetails(status: false);
  ValidationDetails confirmPasswordValidationState =
      ValidationDetails(status: false);

  void checkUserName({required String userName}) {
    userNameValidationState = Validation.userNameValidator(userName);
    notifyListeners();
  }

  void checkEmail({required String email}) {
    emailValidationState = Validation.emailValidator(email);
    notifyListeners();
  }

  void checkPassword({required String password}) {
    passwordValidationState = Validation.passwordValidator(password);
    notifyListeners();
  }

  void checkConfirmPasswordPassword(
      {required String confirmPassword, required String matchingPassword}) {
    confirmPasswordValidationState =
        Validation.confirmPasswordValidator(confirmPassword, matchingPassword);
    notifyListeners();
  }

  Future<void> registerUser(
      BuildContext context, SignupUserModel signupUserModel) async {
    getInstance<LoadingProvider>().startLoading();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: signupUserModel.email, password: signupUserModel.password);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(signupUserModel.email)
          .set(FirebaseUserModel(
                  userName: signupUserModel.userName,
                  email: signupUserModel.email)
              .toJson());
      await getInstance<UserHelper>().saveUser(
          user: FirebaseUserModel(
              userName: signupUserModel.userName,
              email: signupUserModel.email));
      if (context.mounted) {
        Navigator.of(context).pushNamed(RouteNames.chatboard);
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
