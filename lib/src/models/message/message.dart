// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class MessageModel {
  String message;
  DateTime dateTime;
  String senderEmail;
  MessageModel({
    required this.message,
    required this.dateTime,
    required this.senderEmail,
  });

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  factory MessageModel.fromJson(Map<String, dynamic> source) =>
      _$MessageModelFromJson(source);

  Map<String, dynamic> getLastMessage() {
    return {
      'message': message,
      'dateTime': dateTime.toIso8601String(),
      'senderEmail': senderEmail,
      'isRead': false
    };
  }
}
