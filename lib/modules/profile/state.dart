import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class ProfileState {
    TextStyle? titleTextStyle;
    TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
    TextStyle? nameTextStyle;
  TextStyle? emailTextStyle;
  TextStyle? headingsTextStyle;
  ProfileState() {
    ///Initialize variables
        nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
      titleTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.customBlackColor,
    );
  }
}
