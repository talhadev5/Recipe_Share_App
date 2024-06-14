import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/controller.dart';
import 'package:recipe_app/widgets/custom_bottombar.dart';
import 'package:recipe_app/widgets/custom_snackbar.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool dataloading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  void login() {
    const String adminEmail = "admin@gmail.com"; // Define your admin email

    if (!formKey.currentState!.validate()) {
      return;
    }
    dataloading = true;
    update();
    auth
        .signInWithEmailAndPassword(
            email: state.emailController!.text,
            password: state.passwordController!.text.toString())
        .then((value) {
      dataloading = false;
      showSnackBar('Message', 'Login Successful!');

      // Store user role in shared preferences
      Get.find<GeneralController>().storeUserRole(state.emailController!.text);
      update();
      String userRole = Get.find<GeneralController>().getUserRole();
      print("User role retrieved: $userRole");

      if (state.emailController!.text == adminEmail) {
        Get.offAll(
            () => const CustomAdminBottomBar()); // Navigate to Admin Bottom Bar
      } else {
        Get.offAll(
            () => const CustomBottomBar()); // Navigate to User Bottom Bar
      }
      update();
    }).onError((error, stackTrace) {
      // Utils().toastMessage(error.toString());
      showSnackBar('Message', 'Server Error');
      log(error.toString());
      dataloading = false;
      update();
    });
  }
}
