import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/utils/colors.dart';

import 'logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final logic = Get.put(SplashLogic());
  final state = Get.find<SplashLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.customWhiteColor,
      child: Center(child: Image.asset('assets/recipe_logo.jpg')),
    );
  }
}
