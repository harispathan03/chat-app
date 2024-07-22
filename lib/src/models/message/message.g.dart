// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      message: json['message'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      senderEmail: json['senderEmail'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'dateTime': instance.dateTime.toIso8601String(),
      'senderEmail': instance.senderEmail,
    };
