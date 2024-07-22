import 'package:chat_application/src/base/extension/scaffold_extension.dart';
import 'package:chat_application/src/base/utils/size_helper/size_extension.dart';
import 'package:chat_application/src/models/signup_user/signup_user.dart';
import 'package:chat_application/src/pages/widgets/custom_app_bar.dart';
import 'package:chat_application/src/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base/constant/colors.dart';
import '../base/utils/validations.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late SignupProvider provider;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool passwordStatus = true;
  bool confirmPasswordStatus = true;

  @override
  void initState() {
    provider = context.read<SignupProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      children: [
        Image.asset(
          "assets/images/chat-logo-without-bg.png",
          height: 95.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Signup",
              style: TextStyle(fontSize: 32.sp),
            ),
            Text(
              "Fill the details and create your account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, color: greyColor),
            ),
          ],
        ),
        SizedBox(
          height: 45.h,
        ),
        _buildUserNameTextField(),
        SizedBox(
          height: 20.h,
        ),
        _buildEmailTextField(),
        SizedBox(
          height: 20.h,
        ),
        _buildPasswordTextField(),
        SizedBox(
          height: 20.h,
        ),
        _buildConfirmPasswordTextField(),
        SizedBox(
          height: 35.h,
        ),
        Consumer<SignupProvider>(
          builder: (context, provider, child) => CustomButton(
              function: () async {
                if (provider.userNameValidationState.status &&
                    provider.emailValidationState.status &&
                    provider.passwordValidationState.status &&
                    provider.confirmPasswordValidationState.status) {
                  await provider.registerUser(
                      context,
                      SignupUserModel(
                          userName: userNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text));
                }
              },
              buttonText: "Signup",
              isActive: (provider.userNameValidationState.status &&
                  provider.emailValidationState.status &&
                  provider.passwordValidationState.status &&
                  provider.confirmPasswordValidationState.status)),
        )
      ],
    ).scaffoldWithAppBar(context: context, appBar: customAppBar(context));
  }

  _buildUserNameTextField() {
    return Selector<SignupProvider, ValidationDetails>(
      selector: (_, provider) => provider.userNameValidationState,
      builder: (context, userNameValidationState, _) {
        return CustomTextField(
            keyboardType: TextInputType.name,
            controller: userNameController,
            hinttext: "Enter Username",
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
            errorText: userNameValidationState.status
                ? null
                : userNameValidationState.message,
            contentPadding: EdgeInsets.only(right: 10.w, top: 10.h),
            onChanged: (value) {
              provider.checkUserName(userName: userNameController.text);
            },
            textInputAction: TextInputAction.next);
      },
    );
  }

  _buildEmailTextField() {
    return Selector<SignupProvider, ValidationDetails>(
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
    return Selector<SignupProvider, ValidationDetails>(
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
                provider.checkConfirmPasswordPassword(
                    confirmPassword: confirmPasswordController.text,
                    matchingPassword: passwordController.text);
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
              textInputAction: TextInputAction.next);
        });
  }

  _buildConfirmPasswordTextField() {
    return Selector<SignupProvider, ValidationDetails>(
        selector: (_, provider) => provider.confirmPasswordValidationState,
        builder: (context, confirmPasswordValidationState, _) {
          return CustomTextField(
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordController,
              hinttext: "Enter Confirm Password",
              isObscureText: confirmPasswordStatus,
              maxLength: 10,
              onChanged: (value) {
                provider.checkConfirmPasswordPassword(
                    confirmPassword: confirmPasswordController.text,
                    matchingPassword: passwordController.text);
              },
              style: TextStyle(
                fontSize: 22.sp,
                color: greyColor,
              ),
              hintStyle: TextStyle(
                fontSize: 22.sp,
                color: greyColor.withOpacity(0.21),
              ),
              errorText: confirmPasswordValidationState.status
                  ? null
                  : confirmPasswordValidationState.message,
              contentPadding: EdgeInsets.only(right: 10.w, top: 10.h),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      confirmPasswordStatus = !confirmPasswordStatus;
                    });
                  },
                  child: Icon(
                    confirmPasswordStatus
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: greenColor,
                    size: 22.sp,
                  ),
                ),
              ),
              textInputAction: TextInputAction.done);
        });
  }
}
