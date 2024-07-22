import 'package:chat_application/src/base/extension/scaffold_extension.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base/routing/route_names.dart';
import '../provider/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashProvider provider;
  @override
  void initState() {
    provider = Provider.of<SplashProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.checkUserAlreadyLoggedIn();
      provider.addListener(loginListener);
    });
    super.initState();
  }

  @override
  void dispose() {
    provider.removeListener(loginListener);
    super.dispose();
  }

  void loginListener() {
    if (provider.state == UserState.loggedIn) {
      //user already logged in go to home screen
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.chatboard,
        );
      });
    } else {
      Navigator.of(context).pushReplacementNamed(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/chat-logo-without-bg.png",
        height: 200.h,
      ),
    ).scaffoldWithoutAppBar(context: context);
  }
}
