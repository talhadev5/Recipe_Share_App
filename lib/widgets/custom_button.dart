import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
    this.borderRadius,
    required this.labelStyle,
    this.child,
    this.dataloading = false,
  });

  final String? label;
  final Color? backgroundColor;
  final TextStyle labelStyle;
  final VoidCallback? onTap;
  final double? borderRadius;
  final Widget? child;
  final bool? dataloading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          color: backgroundColor,
        ),
        child: SizedBox(
          height: 45, // Adjust height as needed
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                visible: child == null, // Show child when null
                child: dataloading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.customWhiteColor,
                      ))
                    : Text(
                        label!,
                        style: labelStyle,
                      ),
              ),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
