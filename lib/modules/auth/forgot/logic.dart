import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/modules/auth/login/view.dart';
import 'package:recipe_app/widgets/custom_snackbar.dart';

import 'state.dart';

class ForgotLogic extends GetxController {
  final ForgotState state = ForgotState();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool dataloading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get formKey => _formKey;
  void forgot() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    dataloading = true;
    update();
    auth
        .sendPasswordResetEmail(email: state.emailController!.text.toString())
        .then((value) {
      dataloading = false;
      update();
      showSnackBar('Message', 'Please Check your email!');
      Get.offAll(() => LoginPage());
    }).onError((error, stackTrace) {
      dataloading = false;
      update();

      showSnackBar('Message', 'Server Error!');
      log(error.toString());
    });
  }
}
