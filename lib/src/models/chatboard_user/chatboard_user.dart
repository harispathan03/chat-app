// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:chat_application/src/models/last_message/last_message.dart';

class ChatboardUserModel {
  FirebaseUserModel user;
  LastMessageModel? lastMessage;
  ChatboardUserModel({
    required this.user,
    this.lastMessage,
  });

  ChatboardUserModel copyWith({
    FirebaseUserModel? user,
    LastMessageModel? lastMessage,
  }) {
    return ChatboardUserModel(
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  @override
  String toString() =>
      'ChatboardUserModel(user: $user, lastMessage: $lastMessage)';
}
