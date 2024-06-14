import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class DasboardState {
  TextStyle? textTextStyle;
  DasboardState() {
    ///Initialize variables
     textTextStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.customThemeColor,
    );
  }
}
