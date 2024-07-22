import 'package:chat_application/src/base/constant/colors.dart';
import 'package:chat_application/src/base/extension/scaffold_extension.dart';
import 'package:chat_application/src/base/helper/string_helper.dart';
import 'package:chat_application/src/base/helper/user_helper.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:chat_application/src/di/get_it.dart';
import 'package:chat_application/src/models/chatboard_user/chatboard_user.dart';
import 'package:chat_application/src/pages/widgets/chat_row.dart';
import 'package:chat_application/src/provider/chatboard_provider.dart';
import 'package:chat_application/src/provider/loading_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base/routing/route_names.dart';
import 'widgets/custom_alert_dialogue.dart';

class ChatboardPage extends StatefulWidget {
  const ChatboardPage({super.key});

  @override
  State<ChatboardPage> createState() => _ChatboardPageState();
}

class _ChatboardPageState extends State<ChatboardPage> {
  late ChatboardProvider provider;

  @override
  void initState() {
    provider = context.read<ChatboardProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getInstance<LoadingProvider>().startLoading();
      await provider.getUsers();
      getInstance<LoadingProvider>().stopLoading();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: const Icon(Icons.menu)),
              Text(
                "Chatboard",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              Container()
            ],
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: Consumer<ChatboardProvider>(
              builder: (context, provider, child) => StreamBuilder(
                stream: provider.getFilteredChatsStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(color: greenColor),
                    );
                  }
                  return provider.chatUsersList.isEmpty
                      ? Center(
                          child: Text(
                            "No chats to display.",
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.chatUsersList.length,
                          itemBuilder: (context, index) {
                            ChatboardUserModel chatboardUser =
                                provider.chatUsersList[index];
                            // if (snapshot.data![index].id
                            //     .contains(chatboardUser.user.email)) {
                            //   chatboardUser = provider.setLastMessageOfUser(
                            //       chatboardUser,
                            //       snapshot.data![index].data()
                            //           as Map<String, dynamic>);
                            // }
                            return ChatRow(
                              user: chatboardUser.user,
                              message: chatboardUser.lastMessage,
                              function: () {
                                provider.markLastMessageAsRead(
                                    snapshot.data![index].id,
                                    chatboardUser.lastMessage!.senderEmail);
                                Navigator.of(context).pushNamed(RouteNames.chat,
                                    arguments: chatboardUser.user);
                              },
                            );
                          });
                },
              ),
            ),
          )
        ],
      ).scaffoldWithoutAppBarSafeArea(
          key: scaffoldKey,
          context: context,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                      getInstance<UserHelper>().getUser()?.userName ?? "NA"),
                  accountEmail:
                      Text(getInstance<UserHelper>().getUser()?.email ?? "NA"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      StringHelper.getTwoChars(
                          getInstance<UserHelper>().getUser()?.userName ??
                              "N A"),
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialogue(
                              message: "Are you sure you want to logout?",
                              function: () async {
                                await FirebaseAuth.instance.signOut();
                                if (context.mounted) {
                                  Navigator.of(context)
                                      .pushReplacementNamed(RouteNames.login);
                                }
                              });
                        });
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.users);
            },
            shape: const CircleBorder(),
            backgroundColor: lightGreenColor,
            child: const Icon(Icons.add),
          )),
    );
  }
}
