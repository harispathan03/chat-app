import 'package:chat_application/src/base/routing/route_names.dart';
import 'package:chat_application/src/models/firebase_user/firebase_user.dart';
import 'package:chat_application/src/pages/chat_page.dart';
import 'package:chat_application/src/pages/chatboard_page.dart';
import 'package:chat_application/src/pages/login_page.dart';
import 'package:chat_application/src/pages/signup_page.dart';
import 'package:chat_application/src/pages/splash_screen.dart';
import 'package:chat_application/src/pages/users_page.dart';
import 'package:chat_application/src/provider/chat_provider.dart';
import 'package:chat_application/src/provider/chatboard_provider.dart';
import 'package:chat_application/src/provider/login_provider.dart';
import 'package:chat_application/src/provider/signup_provider.dart';
import 'package:chat_application/src/provider/splash_provider.dart';
import 'package:chat_application/src/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween =
            Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0));
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        switch (settings.name) {
          case RouteNames.initialRoute:
            return ChangeNotifierProvider(
                create: (_) => SplashProvider(), child: const SplashScreen());
          case RouteNames.login:
            return ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const LoginPage());
          case RouteNames.signup:
            return ChangeNotifierProvider(
                create: (_) => SignupProvider(), child: const SignupPage());
          case RouteNames.users:
            return ChangeNotifierProvider(
                create: (_) => UsersProvider(), child: const UsersPage());
          case RouteNames.chatboard:
            return ChangeNotifierProvider(
                create: (_) => ChatboardProvider(),
                child: const ChatboardPage());
          case RouteNames.chat:
            final firebaseUserModel =
                ModalRoute.of(context)!.settings.arguments as FirebaseUserModel;
            return ChangeNotifierProvider(
                create: (_) => ChatProvider(),
                child: ChatPage(firebaseUserModel: firebaseUserModel));
          default:
            return _errorRoute(settings);
        }
      },
    );
  }

  static _errorRoute(RouteSettings settings) {
    return Center(
      child: Text("${RouteNames.noRouteFound}: ${settings.name}"),
    );
  }
}
