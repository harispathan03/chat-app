import 'package:chat_application/src/base/constant/colors.dart';
import 'package:chat_application/src/base/extension/scaffold_extension.dart';
import 'package:chat_application/src/base/routing/route_names.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:chat_application/src/models/login_user/login_user.dart';
import 'package:chat_application/src/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base/utils/validations.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginProvider provider;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordStatus = true;

  @override
  void initState() {
    provider = context.read<LoginProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      children: [
        SizedBox(
          height: 120.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 32.sp),
                ),
                Text(
                  "Sign in to continue",
                  style: TextStyle(fontSize: 18.sp, color: greyColor),
                ),
              ],
            ),
            Image.asset(
              "assets/images/chat-logo-without-bg.png",
              height: 88.h,
            ),
          ],
        ),
        SizedBox(
          height: 45.h,
        ),
        _buildEmailTextField(),
        SizedBox(
          height: 20.h,
        ),
        _buildPasswordTextField(),
        SizedBox(
          height: 35.h,
        ),
        Consumer<LoginProvider>(
          builder: (context, provider, child) => CustomButton(
              function: () async {
                if (provider.emailValidationState.status &&
                    provider.passwordValidationState.status) {
                  await provider.loginUser(
                      context,
                      LoginUser(
                          email: emailController.text,
                          password: passwordController.text));
                }
              },
              buttonText: "Login",
              isActive: (provider.emailValidationState.status &&
                  provider.passwordValidationState.status)),
        ),
        SizedBox(height: 10.h),
        CustomButton(
            buttonColor: lightGreenColor,
            buttonText: "Create Account",
            isActive: false,
            function: () {
              Navigator.of(context).pushNamed(RouteNames.signup);
            })
      ],
    ).scaffoldWithoutAppBar(context: context);
  }

  _buildEmailTextField() {
    return Selector<LoginProvider, ValidationDetails>(
      selector: (_, provider) => provider.emailValidationState,
      builder: (context, emailValidationState, _) {
        return CustomTextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            hinttext: "Enter Email",
            maxLength: 30,
            textCapitalization: TextCapitalization.none,
            style: TextStyle(
              fontSize: 22.sp,
              color: greyColor,
            ),
            hintStyle: TextStyle(
              fontSize: 22.sp,
              color: greyColor.withOpacity(0.21),
            ),
            errorText: emailValidationState.status
                ? null
                : emailValidationState.message,
            contentPadding: EdgeInsets.only(right: 10.w, top: 10.h),
            onChanged: (value) {
              provider.checkEmail(email: emailController.text);
            },
            textInputAction: TextInputAction.next);
      },
    );
  }

  _buildPasswordTextField() {
    return Selector<LoginProvider, ValidationDetails>(
        selector: (_, provider) => provider.passwordValidationState,
        builder: (context, passwordValidationState, _) {
          return CustomTextField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              hinttext: "Enter Password",
              isObscureText: passwordStatus,
              maxLength: 10,
              onChanged: (value) {
                provider.checkPassword(password: passwordController.text);
              },
              style: TextStyle(
                fontSize: 22.sp,
                color: greyColor,
              ),
              errorText: passwordValidationState.status
                  ? null
                  : passwordValidationState.message,
              hintStyle: TextStyle(
                fontSize: 22.sp,
                color: greyColor.withOpacity(0.21),
              ),
              contentPadding: EdgeInsets.only(right: 10.w, top: 10.h),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      passwordStatus = !passwordStatus;
                    });
                  },
                  child: Icon(
                    passwordStatus ? Icons.visibility_off : Icons.visibility,
                    color: greenColor,
                    size: 22.sp,
                  ),
                ),
              ),
              textInputAction: TextInputAction.done);
        });
  }
}
