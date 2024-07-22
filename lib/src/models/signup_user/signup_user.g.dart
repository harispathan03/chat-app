// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupUserModel _$SignupUserModelFromJson(Map<String, dynamic> json) =>
    SignupUserModel(
      userName: json['userName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$SignupUserModelToJson(SignupUserModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
