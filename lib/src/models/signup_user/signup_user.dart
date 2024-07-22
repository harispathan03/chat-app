// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'signup_user.g.dart';

@JsonSerializable()
class SignupUserModel {
  String userName;
  String email;
  String password;
  String confirmPassword;
  SignupUserModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);

  factory SignupUserModel.fromJson(Map<String, dynamic> source) =>
      _$SignupUserModelFromJson(source);

  SignupUserModel copyWith({
    String? userName,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return SignupUserModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
