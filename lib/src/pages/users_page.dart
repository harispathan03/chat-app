import 'package:chat_application/src/base/extension/scaffold_extension.dart';
import 'package:chat_application/src/base/routing/route_names.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:chat_application/src/models/last_message/last_message.dart';
import 'package:chat_application/src/pages/widgets/chat_row.dart';
import 'package:chat_application/src/pages/widgets/custom_app_bar.dart';
import 'package:chat_application/src/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late UsersProvider provider;

  @override
  void initState() {
    provider = context.read<UsersProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.fetchAllUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, provider, child) => provider.users.isEmpty
          ? Center(
              child: Text(
                "No users registered.",
                style: TextStyle(fontSize: 18.sp),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              itemCount: provider.users.length,
              itemBuilder: (context, index) {
                FirebaseUserModel user = provider.users[index];
                return ChatRow(
                  user: user,
                  message: LastMessageModel(
                      message: user.email,
                      dateTime: DateTime.now(),
                      senderEmail: "",
                      isRead: true),
                  function: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RouteNames.chat, arguments: user);
                  },
                );
              },
            ),
    ).scaffoldWithAppBar(
        context: context, appBar: customAppBar(context, title: "Users"));
  }
}
