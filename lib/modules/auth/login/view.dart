import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/modules/auth/forgot/view.dart';
import 'package:recipe_app/modules/auth/signup/view.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/constant.dart';
import 'package:recipe_app/widgets/app_progressbar.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';

import 'package:recipe_app/widgets/custom_button.dart';
import 'package:recipe_app/widgets/custom_formfield.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final logic = Get.put(LoginLogic());
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginLogic>(
      builder: (logic) {
        return AppLoadingWidget(
          inAsyncCall: logic.dataloading,
          child: Scaffold(
            appBar: const CustomAppbar(text: 'Login', leading: Icon(null)),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Builder(builder: (context) {
                  return Form(
                    key: logic.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        Text(
                          'Welcom Back!',
                          style: state.titleTextStyle,
                        ),
                        SizedBox(
                          height: Get.height * .04,
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
                            return null;
                          },
                          textEditingController: state.passwordController!,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(() => ForgotPage());
                                },
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(color: AppColors.customRedColor),
                                ))),
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        CustomButton(
                            label: 'Login',
                            backgroundColor: AppColors.customThemeColor,
                            onTap: () {
                              logic.login();
                              logic.update();
                              // Get.to(() => const CustomBottomBar());
                            },
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.customWhiteColor,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("You don't have an account"),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => SignupPage());
                                },
                                child: const Text(
                                  'SignUp',
                                  style:
                                      TextStyle(color: AppColors.customThemeColor),
                                ))
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      }
    );
  }
}
