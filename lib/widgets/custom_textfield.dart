import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/utils/colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      this.prefixIcon,
      required this.helperText,
      required this.validator,
      required this.textEditingController,
      required this.textInputType,
      this.maxline,
      // required this.hint,
      // this.obscureText,
      this.readonly,
      this.onTap});
  final String helperText;
  // final String hint;
  final Function(String?)? validator;
  final TextInputType textInputType;
  // bool? obscureText;
  int? maxline;
  bool? readonly;
  final Widget? prefixIcon;
  final TextEditingController textEditingController;
  final VoidCallback? onTap;

  @override
  // ignore: no_logic_in_create_state
  State<CustomTextField> createState() => _CustomTextFieldState(prefixIcon);
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = true;

  final Widget? prefixIcon;

  _CustomTextFieldState(this.prefixIcon);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: widget.readonly ?? false,
        // autocorrect: true,
        // autofocus: true,
        maxLines: widget.maxline,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.customBlackColor,
          fontWeight: FontWeight.bold,
        ),
        // obscureText: widget.obscureText ?? false,
        controller: widget.textEditingController,
        keyboardType: widget.textInputType,
        validator: (value) => widget.validator!(value),
        cursorColor: AppColors.customThemeColor,
        decoration: InputDecoration(
            // prefixIcon: prefixIcon,
            fillColor: AppColors.customWhiteColor,
            // prefixIconColor: AppColors.customThemeColor,
            filled: true,
            hintText: widget.helperText,
            hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.customHintTextColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            focusColor: AppColors.customThemeColor,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.customShadowColor,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.customShadowColor,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: AppColors.customRedColor,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: AppColors.customRedColor,
                ))));
  }
}
