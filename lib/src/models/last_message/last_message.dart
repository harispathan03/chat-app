// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'last_message.g.dart';

@JsonSerializable()
class LastMessageModel {
  String message;
  DateTime dateTime;
  String senderEmail;
  bool isRead;
  LastMessageModel({
    required this.message,
    required this.dateTime,
    required this.senderEmail,
    required this.isRead,
  });

  Map<String, dynamic> toJson() => _$LastMessageModelToJson(this);

  factory LastMessageModel.fromJson(Map<String, dynamic> source) =>
      _$LastMessageModelFromJson(source);

  LastMessageModel copyWith({
    String? message,
    DateTime? dateTime,
    String? senderEmail,
    bool? isRead,
  }) {
    return LastMessageModel(
      message: message ?? this.message,
      dateTime: dateTime ?? this.dateTime,
      senderEmail: senderEmail ?? this.senderEmail,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  String toString() {
    return 'LastMessageModel(message: $message, dateTime: $dateTime, senderEmail: $senderEmail, isRead: $isRead)';
  }
}
