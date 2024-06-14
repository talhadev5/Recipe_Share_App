import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

// ignore: must_be_immutable
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.text,
    required this.leading,
    this.icon,
    this.actions,
  });
  final Widget leading;
  // ignore: prefer_typing_uninitialized_variables
  final actions;
  final String text;
  final IconData? icon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      // shadowColor: AppColors.customShadowColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(
        style: BorderStyle.solid,
        color: AppColors.customShadowColor,
      )),
      backgroundColor: AppColors.customWhiteColor,
      leading: leading,
      title: Text(text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.customBlackColor,
          )),
      centerTitle: true,
      actions: actions,
    );
  }
}
