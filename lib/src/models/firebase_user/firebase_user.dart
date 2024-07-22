// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'firebase_user.g.dart';

@JsonSerializable()
class FirebaseUserModel {
  String userName;
  String email;
  FirebaseUserModel({
    required this.userName,
    required this.email,
  });

  Map<String, dynamic> toJson() => _$FirebaseUserModelToJson(this);

  factory FirebaseUserModel.fromJson(Map<String, dynamic> source) =>
      _$FirebaseUserModelFromJson(source);

  @override
  String toString() => 'FirebaseUserModel(userName: $userName, email: $email)';
}
