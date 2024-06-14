import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class SignupState {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  TextStyle? titleTextStyle;
  SignupState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    ///Initialize variables
    titleTextStyle = const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
  }
}
