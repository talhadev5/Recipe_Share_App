import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/utils/colors.dart';

// ignore: must_be_immutable
class CustomFormField extends StatefulWidget {
  CustomFormField(
      {super.key,
      this.prefixIcon,
      required this.helperText,
      required this.validator,
      required this.textEditingController,
      required this.textInputType,
      // required this.hint,
      this.obscureText,
      this.onTap});
  final String helperText;
  // final String hint;
  final Function(String?)? validator;
  final TextInputType textInputType;
  bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController textEditingController;
  final VoidCallback? onTap;

  @override
  // ignore: no_logic_in_create_state
  State<CustomFormField> createState() => _CustomFormFieldState(prefixIcon);
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool hidePassword = true;

  final Widget? prefixIcon;

  _CustomFormFieldState(this.prefixIcon);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // autocorrect: true,
        // autofocus: true,
        style: const TextStyle(fontSize: 14, color: AppColors.customBlackColor),
        obscureText: widget.obscureText ?? false,
        controller: widget.textEditingController,
        keyboardType: widget.textInputType,
        validator: (value) => widget.validator!(value),
        cursorColor: AppColors.customThemeColor,
        decoration: InputDecoration(
            suffixIcon: widget.obscureText != null
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        // hidePassword = !hidePassword;
                        widget.obscureText = !widget.obscureText!;
                      });
                    },
                    child: Icon(
                      widget.obscureText!
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: widget.obscureText!
                          ? AppColors.customHintTextColor
                          : AppColors.customThemeColor,
                    ),
                  )
                : const SizedBox(),
            prefixIcon: prefixIcon,
            fillColor: AppColors.customWhiteColor,
            prefixIconColor: AppColors.customThemeColor,
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
                borderSide: const BorderSide(
                  color: AppColors.customThemeColor,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: AppColors.customThemeColor,
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
