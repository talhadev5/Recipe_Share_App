import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:recipe_app/utils/colors.dart';

class AppProgressbar extends StatelessWidget {
  const AppProgressbar({super.key});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Platform.isAndroid
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.customThemeColor,
              ),
            )
          : const Center(
              child: CupertinoActivityIndicator(
                color: AppColors.customThemeColor,
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class AppLoadingWidget extends StatelessWidget {
  bool inAsyncCall;
  Widget child;
  AppLoadingWidget({super.key, required this.child, required this.inAsyncCall});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.2,
      inAsyncCall: inAsyncCall,
      progressIndicator: Platform.isAndroid
          ? const CircularProgressIndicator(
              color: AppColors.customThemeColor,
            )
          : const CupertinoActivityIndicator(
              color: AppColors.customThemeColor,
            ),
      child: child,
    );
  }
}
