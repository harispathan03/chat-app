import 'package:chat_application/src/base/constant/colors.dart';
import 'package:flutter/material.dart';

extension ScaffoldExtension on Widget {
  Widget scaffoldWithAppBar(
      {required BuildContext context,
      required AppBar appBar,
      Widget? drawer,
      Widget? bottomNav,
      bool resizeToAvoidBottomInset = true}) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: bottomNav,
        appBar: appBar,
        backgroundColor: lightBackgroundColor,
        body: SafeArea(child: this),
        drawer: drawer,
      ),
    );
  }

  Widget scaffoldWithoutAppBar({required BuildContext context}) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: lightBackgroundColor,
        body: this,
      ),
    );
  }

  Widget scaffoldWithoutAppBarSafeArea(
      {required BuildContext context,
      Key? key,
      Widget? drawer,
      Widget? floatingActionButton,
      bool top = true,
      bool bottom = true,
      bool left = true,
      bool right = true}) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: key,
        backgroundColor: lightBackgroundColor,
        drawer: drawer,
        floatingActionButton: floatingActionButton,
        body: SafeArea(
            top: top, bottom: bottom, left: left, right: right, child: this),
      ),
    );
  }
}
