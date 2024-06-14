import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_app/utils/colors.dart';

class LoginState {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  TextStyle? titleTextStyle;
  LoginState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    ///Initialize variables
    titleTextStyle = const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
  }
}
