// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) =>
    LastMessageModel(
      message: json['message'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      senderEmail: json['senderEmail'] as String,
      isRead: json['isRead'] as bool,
    );

Map<String, dynamic> _$LastMessageModelToJson(LastMessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'dateTime': instance.dateTime.toIso8601String(),
      'senderEmail': instance.senderEmail,
      'isRead': instance.isRead,
    };
