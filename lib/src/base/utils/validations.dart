import 'package:chat_application/src/base/constant/text.dart';

class Validation {
  Validation._();

  static ValidationDetails userNameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return ValidationDetails(
          status: false, message: "User name can't be empty.");
    }
    if (name.length < 3) {
      return ValidationDetails(
          status: false, message: "Username is too short.");
    }
    return ValidationDetails(status: true);
  }

  static ValidationDetails emailValidator(String? value) {
    if (value == null ||
        !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return ValidationDetails(status: false, message: pleaseEnterValidEmail);
    }
    return ValidationDetails(status: true);
  }

  static ValidationDetails passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationDetails(
          status: false, message: "Password can't be empty.");
    }
    return ValidationDetails(status: true);
  }

  static ValidationDetails confirmPasswordValidator(
      String? password, String matchingPassword) {
    if (password != matchingPassword) {
      return ValidationDetails(
          status: false, message: "Confirm Password doesn't match.");
    }
    return ValidationDetails(status: true);
  }
}

class ValidationDetails {
  late final bool status;
  final String? message;

  ValidationDetails({required this.status, this.message});
}
