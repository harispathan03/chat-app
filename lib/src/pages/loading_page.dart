import 'package:chat_application/src/base/extension/scaffold_extension.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/loading_provider.dart';
import '../base/constant/colors.dart';

class LoadingPage extends StatelessWidget {
  final Widget screen;
  const LoadingPage({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
      builder: (context, loadingProvider, _) {
        return Stack(
          children: [
            screen,
            if (loadingProvider.isLoading)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            if (loadingProvider.isLoading)
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 130.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration: BoxDecoration(
                      color: lightBackgroundColor,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black))),
                      SizedBox(height: 15.h),
                      Text(
                        "Please wait...",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.sp),
                      )
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    ).scaffoldWithoutAppBar(context: context);
  }
}
