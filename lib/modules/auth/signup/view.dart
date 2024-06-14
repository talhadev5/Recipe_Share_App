import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/modules/auth/login/view.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/constant.dart';
import 'package:recipe_app/widgets/app_progressbar.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'package:recipe_app/widgets/custom_button.dart';
import 'package:recipe_app/widgets/custom_formfield.dart';

import 'logic.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final logic = Get.put(SignupLogic());
  final state = Get.find<SignupLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupLogic>(builder: (logic) {
      return AppLoadingWidget(
        inAsyncCall: logic.dataloading,
        child: Scaffold(
          appBar: const CustomAppbar(text: 'SignUp', leading: Icon(null)),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: logic.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Account!',
                      style: state.titleTextStyle,
                    ),
                    SizedBox(
                      height: Get.height * .08,
                    ),
                    CustomFormField(
                      prefixIcon: const Icon(Icons.person),
                      helperText: 'Name',
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return ErrorStrings.nameReq;
                        }
                        return null;
                      },
                      textEditingController: state.nameController!,
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    CustomFormField(
                      prefixIcon: const Icon(Icons.email),
                      helperText: 'Email',
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return ErrorStrings.emailReq;
                        } else if (!GetUtils.isEmail(value!)) {
                          return ErrorStrings.emailInvalid;
                        }
                        return null;
                      },
                      textEditingController: state.emailController!,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    CustomFormField(
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: true,
                      helperText: 'Password',
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return ErrorStrings.passwordReq;
                        }
                        if (value!.length < 8) {
                          return "Password must be at least 8 characters long.";
                        }
                        // Check for special characters
                        bool hasSpecialCharacters =
                            value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                        if (!hasSpecialCharacters) {
                          return "Password must contain at least one special character.";
                        }
                        return null;
                      },
                      textEditingController: state.passwordController!,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    CustomFormField(
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: true,
                      helperText: 'Confrim Password',
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return ErrorStrings.passwordReq;
                        }
                        if (value != state.passwordController!.text) {
                          return "Passwords do not match.";
                        }
                        return null;
                      },
                      textEditingController: state.confirmPasswordController!,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    CustomButton(
                        label: 'Signup',
                        backgroundColor: AppColors.customThemeColor,
                        onTap: () {
                          logic.signup();
                          logic.update();
                          // Get.to(() => LoginPage());
                        },
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customWhiteColor,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("You already have an account"),
                        TextButton(
                            onPressed: () {
                              Get.to(() => LoginPage());
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: AppColors.customThemeColor),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
