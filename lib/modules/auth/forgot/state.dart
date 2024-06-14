import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class ForgotState {
  TextStyle? titleTextStyle;
  TextEditingController? emailController;

  ForgotState() {
      emailController = TextEditingController();
   

    ///Initialize variables
    titleTextStyle = const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.customThemeColor);
  
  }
}
