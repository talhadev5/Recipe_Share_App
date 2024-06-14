import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/controller/controller.dart';
import 'package:recipe_app/modules/auth/login/view.dart';
import 'package:recipe_app/widgets/custom_bottombar.dart';

import 'state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  Future<void> initializeApp() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      final role =
          Get.find<GeneralController>().getUserRole(); // await added here
      if (role == 'admin') {
        await Future.delayed(const Duration(seconds: 2));
        Get.offAll(() => const CustomAdminBottomBar());
      } else {
        await Future.delayed(const Duration(seconds: 2));
        Get.offAll(() => const CustomBottomBar());
      }
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Get.offAll(() => LoginPage());
    }
  }

  @override
  void onInit() {
    super.onInit();
    initializeApp();
  }
}
