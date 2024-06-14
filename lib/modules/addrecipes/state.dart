import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class AddrecipesState {
  TextStyle? textTextStyle;
  TextStyle? titleTextStyle;
  TextEditingController? recipeNameController;
  TextEditingController? ingrediController;
  TextEditingController? instructionController;
  TextEditingController? categoryController;
  TextEditingController? countryController;
  AddrecipesState() {
    ///Initialize variables
    recipeNameController = TextEditingController();
    ingrediController = TextEditingController();
    instructionController = TextEditingController();
    categoryController = TextEditingController();
    countryController = TextEditingController();
    textTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.customBlackColor,
    );
    titleTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.customThemeColor,
    );
  }
}
